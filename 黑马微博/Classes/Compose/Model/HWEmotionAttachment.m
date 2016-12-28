//
//  HWEmotionAttachment.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/12/28.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "HWEmotionAttachment.h"
#import "HWEmotion.h"

@implementation HWEmotionAttachment

-(void)setEmotion:(HWEmotion *)emotion{
    _emotion = emotion;
    
    self.image = [UIImage imageNamed:emotion.png];
}
@end
