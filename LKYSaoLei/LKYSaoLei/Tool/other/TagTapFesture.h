//
//  TagTapFesture.h
//  ChlErpNormal
//
//  Created by Mac01 on 2018/3/10.
//  Copyright © 2018年 Chuanglian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagTapFesture : UITapGestureRecognizer

@property(nonatomic,assign)int Tag;

@property(nonatomic,strong)UIView * motherView;

@property(nonatomic,strong)UIImage *contentImage;

@end
