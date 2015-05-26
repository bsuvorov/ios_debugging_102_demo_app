//
//  CustomWindowViewController.m
//  navigationBarHeight
//
//  Created by Boris Suvorov on 3/15/15.
//  Copyright (c) 2015 Boris Suvorov. All rights reserved.
//

#import "CustomWindowViewController.h"
#import "ViewController.h"

@interface CustomWindowViewController ()
@property (nonatomic) UIWindow *window;
@property (nonatomic, weak) UIWindow *oldKeyWindow;
@property (nonatomic) UINavigationController *embeddedNavVC;
@property (nonatomic) UIViewController *embeddedVC;
@property (nonatomic) UIImageView *imageView;
@end

@implementation CustomWindowViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.25];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
}

- (void)createAndPrepareCustomWindow
{
    self.oldKeyWindow = [[UIApplication sharedApplication] keyWindow];
    self.window = [[UIWindow alloc] init];
    self.window.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.window.opaque = NO;
    self.window.windowLevel = UIWindowLevelNormal;
    self.window.frame = [[UIScreen mainScreen] bounds];
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor clearColor];
}

- (UIColor *)customBackgroundColor {
    UIColor *result = [UIColor yellowColor];
    return result;
}

- (NSString *)customLabelText {
    // is it a good title?
    NSString *result = nil;
    if (self.embeddedVC.view.backgroundColor == [UIColor yellowColor]) {
        result = @"Yellow";
    } else if (self.embeddedVC.view.backgroundColor == [UIColor magentaColor]) {
        result = @"Magenta";
    } else {
        result = @"unknown color!";
    }
    return result;
}

- (void)close
{
    [self.oldKeyWindow makeKeyAndVisible];
    self.window = nil;
}

- (void)present {
    [self createAndPrepareCustomWindow];
    
    self.embeddedVC = [[UIViewController alloc] init];
    self.embeddedVC.view.backgroundColor = [self customBackgroundColor];
    self.embeddedVC.title = @"navbar that won't shrink on rotation";
    self.embeddedVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(close)];
    
    self.embeddedVC.toolbarItems = @[[[UIBarButtonItem alloc] initWithTitle:@"Toolbar button" style:UIBarButtonItemStylePlain target:nil action:nil]];
    
    self.embeddedVC.view.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
    
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1.png"]];
    [self.embeddedVC.view addSubview:self.imageView];
    
    self.embeddedNavVC = [[UINavigationController alloc] initWithRootViewController:self.embeddedVC];
    self.embeddedNavVC.view.backgroundColor = [UIColor yellowColor];
    
    self.embeddedNavVC.view.frame = CGRectMake(5, 100, 360, 200);
    self.embeddedNavVC.toolbarHidden = NO;
    self.embeddedNavVC.view.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;


    self.window.rootViewController = self;
    [self.view addSubview:self.embeddedNavVC.view];
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.imageView.frame = self.embeddedVC.view.bounds;
    
//    self.embeddedNavVC.view.frame = CGRectMake(5, 100, 360, 200); 


    
//    CGRect frame = self.embeddedNavVC.navigationBar.frame;
//    NSLog(@"Custom navbar frame: x = %f, y = %f, width = %f, height = %f", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    
//    NSLog(@"Custom navbar frame = %@",     NSStringFromCGRect(frame));
    
//    self.embeddedVC.title = [NSString stringWithFormat:@"navbar height is %lld. (second window)", (long long) self.embeddedNavVC.navigationBar.frame.size.height];
//    NSString *heightOfToolbar = [NSString stringWithFormat:@"height of toolbar = %lld", (long long)self.embeddedNavVC.toolbar.frame.size.height];
//    self.label.text = [NSString stringWithFormat:@"Navbar height must change on rotation, but it doesn't change when UINavigationController is presented through a second window.\n%@", heightOfToolbar];
}



@end
