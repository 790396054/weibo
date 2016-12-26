//
//  HWEmotion.h
//  黑马微博
//
//  Created by 弓苗苗 on 2016/12/26.
//  Copyright © 2016年 弓苗苗. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWEmotion : NSObject
/** 表情的文字描述 */
@property (nonatomic, copy) NSString *chs;
/** 表情的png 图片名 */
@property (nonatomic, copy) NSString *png;
/** emoji 表情的编码 */
@property (nonatomic, copy) NSString *code;
@end
