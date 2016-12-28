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

-(void)popBtnFrom:(HWEmotionButton *)button{
    if(button == nil) return;
    
    // 赋值
    self.emotionBtn.emotion = button.emotion;
    
    // 取得最上面的 window
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    // 计算出被点击的按钮在 window 中的 frame(转换坐标系)
    CGRect btnFrame = [button convertRect:button.bounds toView:window];
    
    self.y = CGRectGetMidY(btnFrame) - self.height;
    self.centerX = CGRectGetMidX(btnFrame);
}
@end
