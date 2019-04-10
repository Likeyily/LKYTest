//
//  UIImageView+SDW.m
//  项目框架结构
//
//  Created by song ce on 2018/11/19.
//  Copyright © 2018年 song ce. All rights reserved.
//

#import "UIImageView+SDW.h"
#import "UIImageView+WebCache.h"


@implementation UIImageView (SDW)

- (void)sdTool_setImageWithURLStr:(NSString *)URLStr;
{
    NSURL *url = [NSURL URLWithString:URLStr];
    [self sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"noPic"]];
}
- (void)sdTool_setImageWithURLStr:(NSString *)URLStr placeholderImageStr:(NSString *)imageStr
{
    NSURL *url = [NSURL URLWithString:URLStr];
    [self sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:imageStr]];
}

@end
