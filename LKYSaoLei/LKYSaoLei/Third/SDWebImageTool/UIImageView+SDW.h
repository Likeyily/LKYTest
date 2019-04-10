//
//  UIImageView+SDW.h
//  项目框架结构
//
//  Created by song ce on 2018/11/19.
//  Copyright © 2018年 song ce. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (SDW)

- (void)sdTool_setImageWithURLStr:(NSString *)URLStr;

- (void)sdTool_setImageWithURLStr:(NSString *)URLStr placeholderImageStr:(NSString *)imageStr;

@end

NS_ASSUME_NONNULL_END
