//
//  ViewController.m
//  SActivityIndicatorView
//
//  Created by cpzx4 on 16/3/3.
//  Copyright © 2016年 Sgabg. All rights reserved.
//

#import "ViewController.h"
#import "SActivityView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect SActivityViewRect=CGRectMake(0, 50, 320, 20);
    SActivityView *ActivityView=[[SActivityView alloc] initWithFrame:SActivityViewRect];
    ActivityView.numberOfCircles = 5;
    ActivityView.radius = 8;
    ActivityView.internalSpacing = 5;
    [ActivityView startAnimating];
    [self.view addSubview:ActivityView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
