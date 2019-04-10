//
//  AdapterLabel.m
//  ChlErpNormal
//
//  Created by Mac01 on 2018/3/5.
//  Copyright © 2018年 Chuanglian. All rights reserved.
//

#import "AdapterLabel.h"

@interface AdapterLabel()

@end

@implementation AdapterLabel

@synthesize verticalAlignment = verticalAlignment_;

#pragma mark 设置自适应字体
- (void)setFitFont:(CGFloat)fitFont
{
    self.font = [UIFont systemFontOfSize:W(fitFont)];
}

-(void)labelAlightLeftAndRightWithWidth:(CGFloat)labelWidth
{
    //自适应高度
    CGSize textSize = [self.text boundingRectWithSize:CGSizeMake(labelWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine| NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName :self.font} context:nil].size;
    
    CGFloat margin = (labelWidth - textSize.width)/(self.text.length - 1);
    NSNumber *number = [NSNumber numberWithFloat:margin];
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc]initWithString:self.text];
    //字间距 :NSKernAttributeName
    [attribute addAttribute:NSKernAttributeName value:number range:NSMakeRange(0, self.text.length - 1)];
    self.attributedText = attribute;
    
}

-(CGSize)setAttributeWithStr:(NSString *)str andFontName:(UIFont *)font andFontColor:(UIColor *)color andIsCenter:(BOOL)isCenter{
 
    if(str.length > 0 ){
        
        
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
        
        
        
        self.attributedText = attrStr;//给内容赋值

        CGSize size = [attrStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        
        NSLog(@"%@===%g",attrStr.string,size.height);
        
        return size;
        
    }

    return CGSizeZero;
    
}
- (void)setVerticalAlignment:(VerticalAlignment)verticalAlignment {
    verticalAlignment_ = verticalAlignment;
    [self setNeedsDisplay];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    switch (self.verticalAlignment) {
        case VerticalAlignmentTop:
            textRect.origin.y = bounds.origin.y;
            break;
        case VerticalAlignmentBottom:
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
            break;
        case VerticalAlignmentMiddle:
            // Fall through.
        default:
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
    }
    return textRect;
}

-(void)drawTextInRect:(CGRect)requestedRect {
    CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}

-(void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing {
    if (!text || lineSpacing < 0.01) {
        self.text = text;
        return;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];        //设置行间距
    [paragraphStyle setLineBreakMode:self.lineBreakMode];
    [paragraphStyle setAlignment:self.textAlignment];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    self.attributedText = attributedString;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
