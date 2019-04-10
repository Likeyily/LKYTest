//
//  UIView+XMGExtension.m
//  5期-百思不得姐
//
//  Created by xiaomage on 15/11/6.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import "UIView+XMGExtension.h"

@implementation UIView (XMGExtension)

- (CGSize)size
{
    return self.frame.size;
}

-(void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

-(CGPoint)origin{
    return self.frame.origin;
}

-(void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

-(void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

-(void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;

}

- (CGFloat)x
{
    return self.frame.origin.x;
}

-(void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;

}
- (CGFloat)y
{
    return self.frame.origin.y;
}

-(void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;

}

- (CGFloat)centerX
{
    return self.center.x;
}
-(void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

-(void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)right
{
//    return self.xmg_x + self.xmg_width;
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)bottom
{
//    return self.xmg_y + self.xmg_height;
    return CGRectGetMaxY(self.frame);
}

-(void)setRight:(CGFloat)right{
    self.x = right - self.width;
}
-(void)setBottom:(CGFloat)bottom{
    self.y = bottom - self.height;
}

@end
