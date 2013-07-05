//
//  DoubanDetailViewController.m
//  find.it
//
//  Created by dudu on 13-7-5.
//  Copyright (c) 2013年 dudu. All rights reserved.
//

#import "DoubanDetailViewController.h"
#import "AppDelegate.h"

#define NAV_TITLE_FONT [UIFont fontWithName:@"HelveticaNeue" size:18]
#define BG_COLOR [UIColor colorWithRed:240/256.0 green:240/256.0 blue:242/256.0 alpha:1]


@interface DoubanDetailViewController ()

@end

@implementation DoubanDetailViewController

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
	// Do any additional setup after loading the view.
    [self configureNavigationBar];
    [self adjustScrollViewFrame];
}

-(void) viewWillDisappear:(BOOL)animated {
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    UINavigationController *navigationController = appDelegate.navigationController;
    if ([navigationController.viewControllers indexOfObject:self] == NSNotFound)
    {
        // back button was pressed.  We know this is true because self is no longer
        // in the navigation stack.
        [navigationController setNavigationBarHidden:YES animated:YES];
        
    }
    [super viewWillDisappear:animated];
}


- (void)adjustScrollViewFrame
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    UINavigationController *nc = appDelegate.navigationController;
 
    self.scroller.reservedContentHeight = nc.navigationBar.frame.size.height;
}


- (void)configureNavigationBar
{
    // Do any additional setup after loading the view from its nib.
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    UINavigationController *nc = appDelegate.navigationController;
    [nc setNavigationBarHidden:NO animated:YES];
    // Border
    UIView *navBorder = [[UIView alloc] initWithFrame:CGRectMake(0,nc.navigationBar.frame.size.height-1,nc.navigationBar.frame.size.width, 1)];
    // Change the frame size to suit yours //
    [navBorder setBackgroundColor:BG_COLOR];//[UIColor colorWithWhite:200.0f/255.f alpha:0.8f]];
    [navBorder setOpaque:YES];
    [nc.navigationBar addSubview:navBorder];
    nc.navigationBar.tintColor =  BG_COLOR;//[UIColor clearColor];//[UIColor colorWithRed:.65625 green:.6953125 blue:.66796875 alpha:.1];
    //    nc.navigationBar.backgroundColor = BG_COLOR;//[UIColor clearColor];
    //   nc.navigationBar.alpha = 0.0;
    //    nc.navigationBar.translucent = YES;
    //    nc.navigationBar.opaque = YES;
    
}


- (void)configureNavigationBarTitle:(NSString *)title
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    // change navigation controller's title
    UINavigationController *nc = appDelegate.navigationController;
    nc.title = title;
    
    UILabel *navLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 302 - 80, 80)];
    navLabel.backgroundColor = [UIColor clearColor];
    navLabel.textColor = [UIColor blackColor];
    navLabel.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    navLabel.font = NAV_TITLE_FONT;
    navLabel.textAlignment = UITextAlignmentCenter;
    navLabel.center = nc.navigationItem.titleView.center;
    navLabel.text = title;
    
    self.navigationItem.titleView = navLabel;
    
}

@end
