//
//  OSSHelper.m
//  FKGW
//
//  Created by song ce on 2017/3/28.
//  Copyright © 2017年 song ce. All rights reserved.
//


#import "OSSHelper.h"
#import "AppDelegate.h"

static NSString *const AccessKey = @"LTAI8nxqAwt2ldSW";
static NSString *const SecretKey = @"ZcV18JFSwuy782bySD1FdHaQolSehh";
static NSString *const Endpoint = @"oss-cn-beijing.aliyuncs.com";
static NSString *const Bucket = @"cfkjcommon1";

static OSSHelper * instance=nil;
@implementation OSSHelper

//单利获取帮助对象
+ (instancetype)sharedHelper {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

-(instancetype)init{
    if ((self = [super init])) {
        NSString *endpoint = [NSString stringWithFormat:@"https://%@",Endpoint];
        // 明文设置secret的方式建议只在测试时使用，更多鉴权模式参考后面链接给出的官网完整文档的`访问控制`章节
        id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:AccessKey secretKey:SecretKey];
        _client = [[OSSClient alloc] initWithEndpoint:endpoint credentialProvider:credential];
    }
    return self;
}

//异步上传图片
-(void)OSSUploadImageWithImage:(UIImage*)image path:(NSString*)path resultBlock:(resultBlock)resultBlock{
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    if(image.size.width>SCREEN_WIDTH){
        image = [self scaleImage:image toScale:(float)SCREEN_WIDTH/image.size.width];
    }
    put.bucketName = Bucket;
    
    //图片的类型
    NSData *imageData;
    NSString *objectKey;
         imageData = UIImageJPEGRepresentation(image, 1);
        objectKey = [NSString stringWithFormat:@"%@/%@%@.png",path,[self getUid],[self getTimeNow]];
    put.objectKey = objectKey;
    put.uploadingData = imageData;
    OSSTask * putTask = [_client putObject:put];
    [putTask continueWithBlock:^id(OSSTask *task) {
        NSLog(@"objectKey: %@", put.objectKey);
        if (!task.error) {
            resultBlock(objectKey);
            NSLog(@"--上传成功!");
        } else {
            NSLog(@"上传失败, error: %@" , task.error);
        }
        return nil;
    }];
}
//异步上传商品
-(void)OSSUploadGoodsImageWithImage:(UIImage*)image path:(NSString*)path resultBlock:(resultBlock)resultBlock{
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    put.bucketName = Bucket;
    //图片的类型
    NSData *imageData;
    NSString *objectKey;
    imageData = UIImageJPEGRepresentation(image, 1);

    objectKey = [NSString stringWithFormat:@"%@/%@.png",path,[self getTimeNow]];
    
    put.objectKey = objectKey;
    put.uploadingData = imageData;
    OSSTask * putTask = [_client putObject:put];
    [putTask continueWithBlock:^id(OSSTask *task) {
        NSLog(@"objectKey: %@", put.objectKey);
        if (!task.error) {
            resultBlock(objectKey);
            NSLog(@"--上传成功!");
        } else {
            NSLog(@"上传失败, error: %@" , task.error);
        }
        return nil;
    }];
}


//异步下载  
-(void)OSSDownLoadWithObjectKey:(NSString*)objectKey  downLoadBlock:(downLoadBlock)downLoadBlock{
    OSSGetObjectRequest * request = [OSSGetObjectRequest new];
    // required
    request.bucketName = Bucket;
    request.objectKey = objectKey;
     request.xOssProcess =nil;
     [self queryCashWithObjectKey:objectKey requst:request downLoadBlock:downLoadBlock];
}

//异步下载
-(void)OSSDownLoadWithObjectKey:(NSString*)objectKey xOssProcess:(NSString*)xOssProcess downLoadBlock:(downLoadBlock)downLoadBlock{
    OSSGetObjectRequest * request = [OSSGetObjectRequest new];
    request.bucketName = Bucket;
    request.objectKey = objectKey;
    request.xOssProcess =xOssProcess;
    //    @"image/resize,m_lfit,w_20,h_20";
    [self queryCashWithObjectKey:objectKey requst:request downLoadBlock:downLoadBlock];
}
//无缓存
-(void)OSSDownLoadNoCachesWithObjectKey:(NSString*)objectKey xOssProcess:(NSString*)xOssProcess downLoadBlock:(downLoadBlock)downLoadBlock{
    OSSGetObjectRequest * request = [OSSGetObjectRequest new];
    request.bucketName = Bucket;
    request.objectKey = objectKey;
    request.xOssProcess =xOssProcess;
    OSSTask * getTask = [_client getObject:request];
    [getTask continueWithBlock:^id(OSSTask *task) {
        if (!task.error) {
            OSSGetObjectResult * getResult = task.result;
            downLoadBlock(getResult.downloadedData);
        } else {
            NSLog(@"download object failed, error: %@" ,task.error);
        }
        return nil;
    }];
}

//缓存
-(void)queryCashWithObjectKey:(NSString *)objectKey  requst:(OSSGetObjectRequest*)request  downLoadBlock:(downLoadBlock)downLoadBlock{
    NSString *key = request.xOssProcess == nil ? objectKey : [NSString stringWithFormat:@"%@%@",objectKey,request.xOssProcess];
    if(self.imageDic[key]){//内存中有
        downLoadBlock(self.imageDic[key]);
    }else{
        if(!self.operationDic[key]){
            @synchronized (self.operationDic) {
                 [self.operationDic setObject:request forKey:key];
            }
            //下载
            OSSTask * getTask = [_client getObject:request];
            __weak typeof(self) weakSelf = self;
            [getTask continueWithBlock:^id(OSSTask *task) {
                if (!task.error) {
                    @synchronized (weakSelf) {
                        [weakSelf.operationDic removeObjectForKey:key];
                        OSSGetObjectResult * getResult = task.result;
                        [weakSelf.imageDic setObject:getResult.downloadedData forKey:key];
                        downLoadBlock(getResult.downloadedData);
                        NSLog(@"当前总量---%zd",weakSelf.imageDic.allKeys.count);
                        if(weakSelf.imageDic.allKeys.count>600){
                            NSLog(@"-总大小--%zd",self.sumSize);
                            for(int i=0;i<50;i++){
                                NSString *key = weakSelf.imageDic.allKeys[300];
                                [weakSelf.imageDic removeObjectForKey:key];
                            }
                            NSLog(@"当前总量---%zd",weakSelf.imageDic.allKeys.count);
                        }
                    NSLog(@"download dota length: %zu", (unsigned long)[getResult.downloadedData length]);
                        weakSelf.sumSize +=[getResult.downloadedData length];
                    }
                } else {
                    NSLog(@"download object failed, error: %@" ,task.error);
                }
                return nil;
            }];
        }else{
//            downLoadBlock(nil);
            //加入到一个容器中，等下载完毕后，再去加载
        }
    }
}


//异步上传崩溃日志
-(void)OSSUploadCrashInfo:(NSString *)crash  resultBlock:(resultBlock)resultBlock{
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    put.bucketName = Bucket;
    //图片的类型
    NSData *imageData = [crash dataUsingEncoding:NSUTF8StringEncoding];
    NSString *objectKey;
    NSString *path = @"common/crashlogs/IOS";
    //获取系统时间
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYYMMddHHmmssSSS"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    objectKey = [NSString stringWithFormat:@"%@/%@.txt",path,locationString];
    
    put.objectKey = objectKey;
    put.uploadingData = imageData;
    OSSTask * putTask = [_client putObject:put];
    [putTask continueWithBlock:^id(OSSTask *task) {
        NSLog(@"objectKey: %@", put.objectKey);
        if (!task.error) {
            resultBlock(objectKey);
            NSLog(@"--崩溃信息上传成功!");
        } else {
            NSLog(@"__崩溃信息上传失败, error: %@" , task.error);
        }
        return nil;
    }];
}

-(NSString*)getUid{
    UserManager *manager = [UserManager shareUserManager];
    return manager.userInfo.cId;
}
- (NSString *)getTimeNow
{
    NSString* date;
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"YYYYMMddhhmmssSSS"];
    date = [formatter stringFromDate:[NSDate date]];
    //取出个随机数
    int last = arc4random() % 10000;
    NSString *timeNow = [[NSString alloc] initWithFormat:@"%@-%d", date,last];
    NSLog(@"当前时间%@", timeNow);
    return timeNow;
}

- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}


-(NSMutableDictionary *)operationDic{
    if(_operationDic==nil){
        _operationDic = [NSMutableDictionary dictionary];
    }
    return _operationDic;
}

-(NSMutableDictionary *)imageDic{
    if(_imageDic==nil){
        _imageDic = [NSMutableDictionary dictionary];
    }
    return _imageDic;
}


@end
