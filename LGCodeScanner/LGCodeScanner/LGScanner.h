//
//  LGScanner.h
//  Trainee
//
//  Created by 李刚 on 2018/9/26.
//  Copyright © 2018年 Mr.Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "UIView+Extension.h"

NS_ASSUME_NONNULL_BEGIN

@interface LGScanner : NSObject

/** 使用视图实例化扫描器，扫描预览窗口会添加到指定视图中
 *
 * @param view       指定的视图
 * @param scanFrame  扫描范围
 * @param completion 完成回调
 *
 * @return 扫描器
 */
+ (instancetype)scanerWithView:(UIView *)view scanFrame:(CGRect)scanFrame completion:(void (^)(NSString *stringValue))completion;



/** 扫描图像
 *
 * @param image 包含二维码的图像
 * @remark 目前只支持 64 位的 iOS 设备
 */
+ (void)scaneImage:(UIImage *)image completion:(void (^)(NSArray *values))completion;



/**开始扫描*/
- (void)startScan;


/**停止扫描*/
- (void)stopScan;

@end

NS_ASSUME_NONNULL_END
