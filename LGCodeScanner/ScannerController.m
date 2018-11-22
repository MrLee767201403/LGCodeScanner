//
//  ScannerController.m
//  LGCodeScanner
//
//  Created by 李刚 on 2018/11/22.
//  Copyright © 2018 Mr.Lee. All rights reserved.
//

#import "ScannerController.h"
#import "LGScannerBorder.h"
// 获得屏幕宽高
#define kScreenWidth            [UIScreen mainScreen].bounds.size.width
#define kScreenHeight           [UIScreen mainScreen].bounds.size.height


@interface ScannerController ()
@property (nonatomic, strong) LGScanner *scanner;
@property (nonatomic, strong) LGScannerBorder *scannerBorder;
@end

@implementation ScannerController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeTop;
    self.title = @"扫一扫";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    [self setUpSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self resetNavigationBar:YES];
    [self.scannerBorder startScannerAnimating];
    [self.scanner startScan];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self resetNavigationBar:NO];
    [self.scannerBorder stopScannerAnimating];
    [self.scanner stopScan];
}

- (void)setUpSubviews{

    // 扫码
    CGFloat width = kScreenWidth - 180;
    self.scannerBorder = [[LGScannerBorder alloc] initWithFrame:CGRectMake(0, 0, width, width)];
    self.scannerBorder.center = self.view.center;
    self.scannerBorder.tintColor = self.navigationController.navigationBar.tintColor;
    LGScannerMaskView *maskView = [LGScannerMaskView maskViewWithFrame:self.view.bounds cropRect:self.scannerBorder.frame];

    [self.view addSubview:self.scannerBorder];
    [self.view insertSubview:maskView atIndex:0];


    // 实例化扫描器
    __weak typeof(self) weakSelf = self;
    self.scanner = [LGScanner scanerWithView:self.view scanFrame:self.scannerBorder.frame completion:^(NSString *stringValue) {

        NSString *result = [NSString stringWithFormat:@"扫描结果：%@",stringValue];
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"扫描成功" message:result preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf.scanner startScan];
        }];
        [alertVC addAction:cancel];
        [self presentViewController:alertVC animated:YES completion:nil];

    }];

}


// 设置导航栏
- (void)resetNavigationBar:(BOOL)black {

    if (black) {
        [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor colorWithWhite:0 alpha:0.3]] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.translucent = YES;
        self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        NSMutableDictionary *textAtt = self.navigationController.navigationBar.titleTextAttributes.mutableCopy;
        [textAtt setValue:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
        self.navigationController.navigationBar.titleTextAttributes = textAtt;
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    }else{
        UIColor *darkColor = [UIColor colorWithRed:44/255.0 green:44/255.0 blue:44/255.0 alpha:1];
        [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.translucent = NO;
        self.navigationController.navigationBar.shadowImage = nil;
        self.navigationController.navigationBar.tintColor = darkColor;
        NSMutableDictionary *textAtt = self.navigationController.navigationBar.titleTextAttributes.mutableCopy;
        [textAtt setValue:darkColor forKey:NSForegroundColorAttributeName];
        self.navigationController.navigationBar.titleTextAttributes = textAtt;
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
}




- (UIImage *) imageWithColor:(UIColor *)color{

    CGSize size = CGSizeMake(1, 1);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
