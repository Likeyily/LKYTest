//
//  OSSHelper.h
//  FKGW
//
//  Created by song ce on 2017/3/28.
//  Copyright © 2017年 song ce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AliyunOSSiOS/OSSService.h>
typedef void(^resultBlock)(NSString *objectKey);
typedef void(^downLoadBlock)(NSData *data);
@interface OSSHelper : NSObject
@property(nonatomic,strong)OSSClient *client;

//缓存相关
@property(nonatomic,strong)NSMutableDictionary *operationDic;//objectKey:requset
@property(nonatomic,strong)NSMutableDictionary *imageDic;//objectkey:imageData

@property(nonatomic,assign)NSInteger   sumSize;

+ (instancetype)sharedHelper ;

//异步上传图片
-(void)OSSUploadImageWithImage:(UIImage*)image path:(NSString*)path resultBlock:(resultBlock)resultBlock;
//异步上传商品
-(void)OSSUploadGoodsImageWithImage:(UIImage*)image path:(NSString*)path resultBlock:(resultBlock)resultBlock;
//异步下载
-(void)OSSDownLoadWithObjectKey:(NSString*)objectKey  downLoadBlock:(downLoadBlock)downLoadBlock;

//异步下载指定宽高
-(void)OSSDownLoadWithObjectKey:(NSString*)objectKey xOssProcess:(NSString*)xOssProcess downLoadBlock:(downLoadBlock)downLoadBlock;

//无缓存聊天头像
-(void)OSSDownLoadNoCachesWithObjectKey:(NSString*)objectKey xOssProcess:(NSString*)xOssProcess downLoadBlock:(downLoadBlock)downLoadBlock;

//异步上传崩溃日志
-(void)OSSUploadCrashInfo:(NSString *)crash  resultBlock:(resultBlock)resultBlock;
@end
