//
//  PieViewController.m
//  DSAHQChartDemo
//
//  Created by JinYong on 15-1-12.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "PieViewController.h"
#define ARR_LEVEL  [NSArray arrayWithObjects:@"成交客户",@"战败客户",@"失控客户",@"临时客户",@"潜在客户", nil]
@interface PieViewController ()

@end

@implementation PieViewController
@synthesize pieChartLeft    = _pieChartLeft;
@synthesize pieChartRight   = _pieChartRight;
@synthesize slices          = _slices;
@synthesize sliceColors     = _sliceColors;
@synthesize coverView;

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
    
    self.title = @"饼状图";
    
    self.slices = [NSMutableArray arrayWithCapacity:10];

    for(int i = 0; i < [ARR_LEVEL count]; i ++)
    {
        NSNumber *one = [NSNumber numberWithInt:rand()%60+20];
        [_slices addObject:one];
    }
    
    self.sliceColors =[NSArray arrayWithObjects:
                       [UIColor colorWithRed:246/255.0 green:155/255.0 blue:0/255.0 alpha:1],
                       [UIColor colorWithRed:129/255.0 green:195/255.0 blue:29/255.0 alpha:1],
                       [UIColor colorWithRed:110/255.0 green:118/255.0 blue:132/255.0  alpha:1],
                       [UIColor colorWithRed:115/255.0 green:191/255.0 blue:103/255.0 alpha:1],
                       [UIColor colorWithRed:62/255.0 green:173/255.0 blue:219/255.0 alpha:1],
                       [UIColor colorWithRed:46/255.0 green:107/255.0 blue:190/255.0 alpha:1],
                       [UIColor colorWithRed:211/255.0 green:230/255.0 blue:254/255.0 alpha:1],
                       [UIColor colorWithRed:229/255.0 green:66/255.0 blue:115/255.0 alpha:1],
                       [UIColor colorWithRed:161/255.0 green:171/255.0 blue:188/255.0 alpha:1],
                       [UIColor colorWithRed:78/255.0 green:138/255.0 blue:219/255.0 alpha:1],
                       [UIColor colorWithRed:148/255.0 green:141/255.0 blue:139/255.0 alpha:1],
                       [UIColor colorWithRed:100/255.0 green:131/255.0 blue:169/255.0 alpha:1],
                       [UIColor colorWithRed:200/255.0 green:231/255.0 blue:199/255.0 alpha:1],
                       [UIColor colorWithRed:200/255.0 green:231/215.0 blue:199/235.0 alpha:1],
                       [UIColor colorWithRed:200/255.0 green:231/235.0 blue:199/215.0 alpha:1],
                       nil];
    
    [self.pieChartLeft setDataSource:self];
    [self.pieChartLeft setStartPieAngle:M_PI_2];
    [self.pieChartLeft setAnimationSpeed:1.0];
    [self.pieChartLeft setLabelFont:[UIFont fontWithName:@"DBLCDTempBlack" size:24]];
    [self.pieChartLeft setLabelRadius:self.pieChartLeft.frame.size.width/3];
    [self.pieChartLeft setShowPercentage:NO];
    [self.pieChartLeft setPieBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
    [self.pieChartLeft setPieCenter:CGPointMake(self.pieChartLeft.frame.size.width/2, self.pieChartLeft.frame.size.height/2)];
    [self.pieChartLeft setUserInteractionEnabled:NO];
    [self.pieChartLeft setLabelShadowColor:[UIColor blackColor]];
    
    UIView *cornerView = [[UIView alloc] initWithFrame:CGRectMake(150, 150, 100, 100)];
    [cornerView.layer setCornerRadius:cornerView.frame.size.width/2];
    [cornerView setBackgroundColor:[UIColor whiteColor]];
    [self.pieChartLeft addSubview:cornerView];
    [cornerView release];
    
    [self.pieChartRight setDelegate:self];
    [self.pieChartRight setDataSource:self];
    [self.pieChartRight setShowPercentage:YES];
    [self.pieChartRight setLabelRadius:self.pieChartRight.frame.size.width/3];
    [self.pieChartRight setPieCenter:CGPointMake(self.pieChartRight.frame.size.width/2, self.pieChartRight.frame.size.width/2)];
    [self.pieChartRight setLabelColor:[UIColor blackColor]];
    
    [self initAllCaptionUI:ARR_LEVEL];
    
    [self.pieChartLeft reloadData];
    [self.pieChartRight reloadData];
    
    [self.pieChartRight notifyDelegateOfSelectionChangeFrom:self.pieChartRight._selectedSliceIndex to:0];
    [self.coverView setHidden:NO];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
- (IBAction)updateSlices
{
    for(int i = 0; i < _slices.count; i ++)
    {
        [_slices replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:rand()%60+20]];
    }
    [self.pieChartLeft reloadData];
    [self.pieChartRight reloadData];
}

- (IBAction)showSlicePercentage:(id)sender {
    UISwitch *perSwitch = (UISwitch *)sender;
    [self.pieChartRight setShowPercentage:perSwitch.isOn];
}

-(void)initAllCaptionUI:(NSArray *)array{
    //这个View用于装载所有的意向button
    UIScrollView *levelView=[[UIScrollView alloc] initWithFrame:CGRectMake(820, 100, 250, 550)];
    [levelView  setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:levelView];
    
    NSMutableArray *segmentArray=[[NSMutableArray alloc] init];
    for (int i=0; i<array.count; i++) {
        
        UILabel *showLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 50*i+15, 150, 30)];
        [showLabel setBackgroundColor:[UIColor clearColor]];
        [showLabel setText:[ARR_LEVEL objectAtIndex:i]];
        [levelView addSubview:showLabel];
        [showLabel release];
        
        //button上面的色块
        UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(50, 50*i+15, 30, 30)];
        [colorView.layer setBorderWidth:2];
        [colorView.layer setBorderColor:UIColorFromRGB(696969).CGColor];
        [colorView.layer setCornerRadius:5];
        [colorView setBackgroundColor:[self.sliceColors objectAtIndex:(i % self.sliceColors.count)]];
        [levelView addSubview:colorView];
        [colorView release];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTag:300+i];
        [button setFrame:CGRectMake(0,50*i, 230, 55)];
        [button.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [button setTitle:@"" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor clearColor]];
        [button addTarget:self action:@selector(captionButtonClick:withCallback:) forControlEvents:UIControlEventTouchUpInside];
        
        [levelView addSubview:button];
    }
    if (array && array.count > 0) {
        float height = array.count * 50 + 30;
        levelView.contentSize = CGSizeMake(250, height);
    }else{
        levelView.contentSize = CGSizeMake(250, 550);
    }
    
    [segmentArray release];
    
    //这是一个Cover，用于覆盖在选中的button上面形成遮罩效果
    UIView *_tmpCoverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 136, 55)];
    [_tmpCoverView.layer setBorderWidth:2];
    [_tmpCoverView.layer setBorderColor:UIColorFromRGB(0x696969).CGColor];
    [_tmpCoverView setHidden:YES];
    self.coverView = _tmpCoverView;
    [levelView addSubview:self.coverView];
    [_tmpCoverView release];
    
    [levelView release];
    
}

//右侧button相应给左侧Chart
- (void)captionButtonClick:(id)sender withCallback:(BOOL)real{
    UIButton *button = sender;
    CGPoint center = button.center;
    
    [self.pieChartRight notifyDelegateOfSelectionChangeFrom:self.pieChartRight._selectedSliceIndex to:button.tag-300];
    [self.coverView setHidden:NO];
    [self coverAnimation:center];
}

//Cover的运动中心
- (void)coverAnimation:(CGPoint)point{
    [UIView beginAnimations:@"CoverView" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.3];
    [self.coverView setCenter:point];
    [UIView commitAnimations];
}
#pragma mark
#pragma mark - XYPieChart DataSource
- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart
{
    return [self.slices count];
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index
{
    return [[self.slices objectAtIndex:index] intValue];
}

- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index
{
    //    if (pieChart == self.pieChartRight) return nil;
    return [self.sliceColors objectAtIndex:(index % [self.sliceColors count])];
}

#pragma mark - XYPieChart Delegate
- (void)pieChart:(XYPieChart *)pieChart willSelectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"will select slice at index %d",index);
}

- (void)pieChart:(XYPieChart *)pieChart willDeselectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"will deselect slice at index %d",index);
}

- (void)pieChart:(XYPieChart *)pieChart didDeselectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"did deselect slice at index %d",index);
}

- (void)pieChart:(XYPieChart *)pieChart didSelectSliceAtIndex:(NSUInteger)index
{
    UIButton *button =(UIButton *) [self.view viewWithTag:300+index];
    CGPoint center = button.center;
    [self coverAnimation:center];
    [self.coverView setHidden:NO];

    NSLog(@"did select slice at index %d",index);
}
@end
