//
//  TregularexpressionNSObjec.h
//  newchannel
//
//  Created by iOS on 2017/2/23.
//  Copyright © 2017年 Chuanglian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TregularexpressionNSObjec : NSObject
/**正则表达式 
 *
 *  判断手机号
 *
 **/
+ (BOOL)isMobileNumber:(NSString *)mobileNum;


/**正则表达式
 *
 *  判断去除特殊符号 符合规定的YES 否则 为NO
 *
 **/
+(BOOL)RegularExpressionForSpecialSymbolFiltering:(NSString *)str;

/**正则表达式
 *
 *  用于判断备注
 *
 **/
+(BOOL)RegularExpressionForRemarks:(NSString *)str;

/**正则表达式
 *
 *  判断字符串是否是中文汉字+英文+数字+下划线 (特别针对iOS的九宫格修改过)
 *
 **/
+(BOOL)isChineseCharacterAndLettersAndNumbersAndUnderScore:(NSString *)string;
/**判断身份证号格式是否正确*/
+ (BOOL)judgeIdentityStringValid:(NSString *)identityString;
/**
 *
 *颜色转化成Image
 *
 **/
+(UIImage*) createImageWithColor:(UIColor*) color;
//过滤表情
+(BOOL)stringContainsEmoji:(NSString *)string;
@end
