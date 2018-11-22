//
//  LGScannerBorder.h
//  Trainee
//
//  Created by 李刚 on 2018/9/26.
//  Copyright © 2018年 Mr.Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGScanner.h"

NS_ASSUME_NONNULL_BEGIN

@interface LGScannerBorder : UIView
/** 开始扫描动画*/
- (void)startScannerAnimating;

/** 停止扫描动画*/
- (void)stopScannerAnimating;

@end



/// 扫描遮罩视图
@interface LGScannerMaskView : UIView

/** 使用裁切区域实例化遮罩视图
 *
 * @param frame    视图区域
 * @param cropRect 裁切区域
 *
 * @return 遮罩视图
 */
+ (instancetype)maskViewWithFrame:(CGRect)frame cropRect:(CGRect)cropRect;

/**裁切区域*/
@property (nonatomic) CGRect cropRect;

@end

NS_ASSUME_NONNULL_END
