//
//  HWLoadFooterView.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/11/29.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "HWLoadFooterView.h"

@implementation HWLoadFooterView

+(instancetype)footer{
    return [[[NSBundle mainBundle] loadNibNamed:@"HWLoadFooterView" owner:nil options:nil] lastObject];
}

@end
