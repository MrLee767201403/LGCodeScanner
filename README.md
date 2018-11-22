# 二维码扫码器
效果图

![image](https://github.com/MrLee767201403/LGCodeScanner/blob/master/pic.jpeg)

使用示例(建议隐藏导航栏 或者设置其半透明)

```
- (void)viewWillAppear:(BOOL)animated {
[super viewWillAppear:animated];
[self.scannerBorder startScannerAnimating];
[self.scanner startScan];
}

- (void)viewWillDisappear:(BOOL)animated {
[super viewWillDisappear:animated];
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

```
