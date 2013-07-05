//
//  ViewController.h
//  find.it
//
//  Created by dudu on 13-6-22.
//  Copyright (c) 2013年 dudu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet UISegmentedControl *segControl;


- (IBAction)segmentDidChange:(id)sender;
- (IBAction)searchButtonClicked:(id)sender;

@end
