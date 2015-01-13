//
//  RootViewController.m
//  DSAHQChartDemo
//
//  Created by JinYong on 15-1-12.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "RootViewController.h"
#import "PieViewController.h"
#import "NTChartViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"图表数据展示";

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (IBAction)actionClick:(id)sender{
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag - 100) {
        case 1:
            {
                PieViewController *pievc = [[PieViewController alloc] init];
                [self.navigationController pushViewController:pievc animated:YES];
                [pievc release];
            }
            
            break;
        case 2:
            {
                NTChartViewController *chart = [[NTChartViewController alloc] init];
                [self.navigationController pushViewController:chart animated:YES];
                [chart release];
            }
            break;
        default:
            break;
    }
}
@end
