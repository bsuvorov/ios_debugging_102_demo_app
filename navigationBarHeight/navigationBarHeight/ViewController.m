//
//  ViewController.m
//  navigationBarHeight
//
//  Created by Boris Suvorov on 3/15/15.
//  Copyright (c) 2015 Boris Suvorov. All rights reserved.
//

#import "ViewController.h"
#import "CustomWindowViewController.h"

@interface ViewController ()
@property (nonatomic) UINavigationController *embeddedNavVC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"navbar that will shrink on rotation";
    UIBarButtonItem *newVCBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewVC)];
    UIBarButtonItem *presentVCBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(presentVC)];
    
    self.navigationItem.rightBarButtonItems = @[newVCBtn, presentVCBtn];
    

}

- (void)addNewVC
{
    ViewController *vc = [[ViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)presentVC
{
    CustomWindowViewController *customWindowController = [[CustomWindowViewController alloc] init];
    
    [customWindowController present];
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
//    self.title = [NSString stringWithFormat:@"navbar height is %lld (first window)",
//                  (long long) self.navigationController.navigationBar.frame.size.height];
}

@end
