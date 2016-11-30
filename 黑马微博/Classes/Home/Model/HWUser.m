//
//  HWUser.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/11/28.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "HWUser.h"

@implementation HWUser
-(void)setMbtype:(int)mbtype{
    _mbtype = mbtype;
    
    self.vip = mbtype > 2;
}

//-(BOOL)isVip{
//    return self.mbtype > 2;
//}
@end
