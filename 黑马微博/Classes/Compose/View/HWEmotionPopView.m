//
//  HWEmotionPopView.m
//  黑马微博
//
//  Created by 弓苗苗 on 2016/12/27.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import "HWEmotionPopView.h"
#import "HWEmotionButton.h"

@interface HWEmotionPopView()
@property (weak, nonatomic) IBOutlet HWEmotionButton *emotionBtn;
@end

@implementation HWEmotionPopView

+(instancetype)popView{
    return [[[NSBundle mainBundle] loadNibNamed:@"HWEmotionPopView" owner:nil options:nil] lastObject];
}

-(void)setEmotion:(HWEmotion *)emotion{
    _emotion = emotion;
    
    self.emotionBtn.emotion = emotion;
}
@end
