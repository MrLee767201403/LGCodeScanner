//
//  ViewController.m
//  LGCodeScanner
//
//  Created by 李刚 on 2018/11/22.
//  Copyright © 2018 Mr.Lee. All rights reserved.
//

#import "ViewController.h"
#import "ScannerController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"LGCodeScannerDemo";
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    button.center = self.view.center;
    [button setTitle:@"开始扫码" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(startScan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

}

- (void)startScan{
    ScannerController *VC = [[ScannerController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}
@end
