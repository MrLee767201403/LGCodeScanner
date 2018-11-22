//
//  LGScannerBorder.m
//  Trainee
//
//  Created by 李刚 on 2018/9/26.
//  Copyright © 2018年 Mr.Lee. All rights reserved.
//

#import "LGScannerBorder.h"

#define Image(name)             [UIImage imageNamed:name]

// 图片在Assets.xcassets里，可以自己替换
@implementation LGScannerBorder
{
    /// 冲击波图像
    UIImageView *_scannerLine;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpSubviews];
    }
    return self;
}

#pragma mark - 扫描动画方法
/**开始扫描动画*/
- (void)startScannerAnimating {

    [self stopScannerAnimating];

    [UIView animateWithDuration:3.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [UIView setAnimationRepeatCount:MAXFLOAT];

                         _scannerLine.center = CGPointMake(self.bounds.size.width * 0.5, self.height);
                     } completion:nil];
}

/**停止扫描动画*/
- (void)stopScannerAnimating {
    [_scannerLine.layer removeAllAnimations];
    _scannerLine.center = CGPointMake(self.width * 0.5, 0);
}

#pragma mark - 设置界面
- (void)setUpSubviews {
    self.clipsToBounds = YES;
    // 冲击波图像
    _scannerLine = [[UIImageView alloc] initWithImage:Image(@"scan_line")];
    _scannerLine.frame = CGRectMake(0, 0, self.bounds.size.width, _scannerLine.bounds.size.height);
    _scannerLine.center = CGPointMake(self.bounds.size.width * 0.5, 0);

    [self addSubview:_scannerLine];

    // 加载边框图像
    for (NSInteger i = 1; i < 5; i++) {
        NSString *imgName = [NSString stringWithFormat:@"scan_border_%zd", i];
        UIImageView *borderView = [[UIImageView alloc] initWithImage:Image(imgName)];

        [self addSubview:borderView];

        CGFloat offsetX = self.bounds.size.width - borderView.bounds.size.width;
        CGFloat offsetY = self.bounds.size.height - borderView.bounds.size.height;

        switch (i) {
            case 2:
                borderView.frame = CGRectOffset(borderView.frame, offsetX, 0);
                break;
            case 3:
                borderView.frame = CGRectOffset(borderView.frame, 0, offsetY);
                break;
            case 4:
                borderView.frame = CGRectOffset(borderView.frame, offsetX, offsetY);
                break;
            default:
                break;
        }
    }
}


@end





#pragma mark   -  ******************* 分割线 ******************
@implementation LGScannerMaskView

+ (instancetype)maskViewWithFrame:(CGRect)frame cropRect:(CGRect)cropRect {

    LGScannerMaskView *maskView = [[self alloc] initWithFrame:frame];
    maskView.backgroundColor = [UIColor clearColor];
    maskView.cropRect = cropRect;

    return maskView;
}

- (void)setCropRect:(CGRect)cropRect {
    _cropRect = cropRect;

    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {

    CGContextRef ctx = UIGraphicsGetCurrentContext();

    [[UIColor colorWithWhite:0.0 alpha:0.56] setFill];
    CGContextFillRect(ctx, rect);

    CGContextClearRect(ctx, self.cropRect);

    [[UIColor colorWithWhite:0 alpha:0] setStroke];
    CGContextStrokeRectWithWidth(ctx, CGRectInset(_cropRect, 1, 1), 1);
}

@end
