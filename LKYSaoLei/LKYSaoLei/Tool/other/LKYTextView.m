//
//  LKYTextView.m
//  timeshare
//
//  Created by song ce on 2018/9/19.
//  Copyright © 2018年 song ce. All rights reserved.
//

#import "LKYTextView.h"
#import "UIImageView+WebCache.h"
#import "TregularexpressionNSObjec.h"

@interface LKYTextView()<UITextViewDelegate>

@property(nonatomic,strong)NSMutableArray *imageurlArray;

@property(nonatomic,strong)NSMutableArray *rangeArr;

@property(nonatomic,strong)UIView *backView;

/**记录上一步编辑后的内容*/
@property(nonatomic,strong)NSString *oldStr;

@end

@implementation LKYTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */
- (void)drawRect:(CGRect)rect {
    // Drawing code
    if (!_isHiddenComplete) {
        UIToolbar *bar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,44)];
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 7,50, 30)];
        [button setTitle:@"完成"forState:UIControlStateNormal];
        [button setTitleColor:Themecolor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(print) forControlEvents:UIControlEventTouchUpInside];
        //
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
        UIBarButtonItem *flexibleitem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemFlexibleSpace) target:self action:nil];
        NSArray *items = @[flexibleitem,flexibleitem,item];
        [bar setItems:items animated:YES];
        self.inputAccessoryView= bar;
        
        self.oldStr = self.text;
        
        [self addObserver];

    }
    
}

/**加通知
  */

-(void)addObserver

{
    
    //正在进行编辑
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeediting:) name:UITextViewTextDidChangeNotification object:self];
    
    //停止编辑
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endediting:) name:UITextViewTextDidEndEditingNotification object:self];
    
}



-(void)changeediting:(NSNotification *)notification

{
    LKYTextView *textView = notification.object;
    
    if ([TregularexpressionNSObjec stringContainsEmoji:textView.text]) {
        textView.text = self.oldStr;
    }
    else
    {
        self.oldStr = textView.text;
    }
    
}

-(void)endediting:(NSNotification *)notification

{
    
    NSLog(@"停止编辑");
    
}



//记得释放通知

-(void)dealloc

{
    
      [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

-(void)print
{
    [[self superview]endEditing:YES];
}
#pragma mark 设置自适应字体
- (void)setFitFont:(CGFloat)fitFont
{
    self.font = [UIFont systemFontOfSize:W(fitFont)];
}
-(CGSize)setAttributeWithStr:(NSString *)str andFontName:(UIFont *)font andFontColor:(UIColor *)color andIsCenter:(BOOL)isCenter{
    self.editable = NO;
    if(str.length > 0 ){
        
        [self getImageurlFromHtml:str];
        
        NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithData:[str dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        
        
        
        // 遍历富文本的附件
        [attrStr enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, attrStr.length) options:0 usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
            
            if (value) {
                NSTextAttachment *ment = value;
                
                if (ment.bounds.size.width > SCREEN_WIDTH-20) {// 假如图片宽度大于250，就设置为250，并且高度按照比例缩小
                    CGFloat scale = (SCREEN_WIDTH-20) / ment.bounds.size.width;
                    ment.bounds = CGRectMake(10, 0, scale * ment.bounds.size.width, scale * ment.bounds.size.height);
                    
                }
            }
        }];
        
        // 设置字体和设置字体的范围
        
        [attrStr addAttribute:NSFontAttributeName
         
                        value:font
         
                        range:NSMakeRange(0, attrStr.mutableString.length)];
        
        //添加文字颜色
        
        [attrStr addAttribute:NSForegroundColorAttributeName
         
                        value:color
         
                        range:NSMakeRange(0, attrStr.mutableString.length)];
        
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        
        paragraph.paragraphSpacing = W(10);
        
        
        //设置居中
        
        if (isCenter) {
            
            paragraph.alignment = NSTextAlignmentCenter;
            
        }
        
        //设置行间距
        
        paragraph.lineSpacing = 8;
        
        
        [attrStr addAttribute:NSParagraphStyleAttributeName
         
                        value:paragraph
         
                        range:NSMakeRange(0, attrStr.mutableString.length-1)];
        
        
        self.delegate = self;
        self.attributedText = attrStr;//给内容赋值
        
        CGSize size = [attrStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        
        NSLog(@"%@===%g",attrStr.string,size.height);
        
        return size;
        
    }
    
    return CGSizeZero;
    
}
- (NSArray *) getImageurlFromHtml:(NSString *) webString
{
    if (webString.length==0) {
        return nil;
    }
    NSString *text = webString;
    //NSLog(@"这是评论的内容%@",text);
    text = [text stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    text = [text stringByReplacingOccurrencesOfString:@"</p>" withString:@"\n"];
    text = [text stringByReplacingOccurrencesOfString:@"<u>" withString:@""];
    text = [text stringByReplacingOccurrencesOfString:@"</u>" withString:@""];
    text = [text stringByReplacingOccurrencesOfString:@"<strong>" withString:@""];
    text = [text stringByReplacingOccurrencesOfString:@"</strong>" withString:@""];
    text = [text stringByReplacingOccurrencesOfString:@"<em>" withString:@""];
    text = [text stringByReplacingOccurrencesOfString:@"</em>" withString:@""];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text];
    
    NSString *webStr  = [NSString stringWithFormat:@"%@",string];
    
    //标签匹配
    NSString *parten = @"<img(.*?)>";
    NSError* error = NULL;
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:parten options:0 error:&error];
    
    NSArray* match = [reg matchesInString:webStr options:0 range:NSMakeRange(0, [string length] - 1)];
    
    for (NSTextCheckingResult * result in match) {
        
        //过去数组中的标签
        NSRange range = [result range];
        [self.rangeArr addObject:NSStringFromRange(range)];
        NSString * subString = [webStr substringWithRange:range];
        
        
        //从图片中的标签中提取ImageURL
        NSRegularExpression *subReg = [NSRegularExpression regularExpressionWithPattern:@"http://(.*?)\"" options:0 error:NULL];
        NSArray* match = [subReg matchesInString:subString options:0 range:NSMakeRange(0, [subString length] - 1)];
        NSTextCheckingResult * subRes = match[0];
        NSRange subRange = [subRes range];
        subRange.length = subRange.length -1;
        NSString * imagekUrl = [subString substringWithRange:subRange];
        
        //将提取出的图片URL添加到图片数组中
        [self.imageurlArray addObject:imagekUrl];
    }
    
    return self.imageurlArray;
}
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange
{
    self.editable = NO;
    
    NSString *subChara = [textView.text substringWithRange:characterRange];
    
//    for (int i=0; i<self.imageurlArray.count; i++) {

        if (characterRange.location<self.imageurlArray.count) {
//            NSLog(@"%@",self.imageurlArray[i]);

            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            
            self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            self.backView.backgroundColor = [UIColor blackColor];
            [window addSubview:self.backView];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidden)];
            
            [self.backView addGestureRecognizer:tap];
   
            [imageV sd_setImageWithURL:[NSURL URLWithString:self.imageurlArray[characterRange.location]] placeholderImage:[UIImage imageNamed:@"noPic"]];
            imageV.height = SCREEN_WIDTH/imageV.image.size.width*imageV.image.size.height;

            imageV.centerY = SCREEN_HEIGHT/2;
            [self.backView addSubview:imageV];
         
            return NO;
        }
//    }
    return YES;
}
- (void)hidden
{
    [self.backView removeFromSuperview];
    self.backView = nil;
}
- (NSMutableArray *)imageurlArray
{
    if (!_imageurlArray) {
        _imageurlArray = [NSMutableArray array];
    }
    
    return _imageurlArray;
}
- (NSMutableArray *)rangeArr
{
    if (!_rangeArr) {
        _rangeArr = [NSMutableArray array];
    }
    return _rangeArr;
}
@end
