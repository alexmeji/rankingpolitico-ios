//
//  HomeViewController.m
//  NPasalo
//
//  Created by IOSDeveloper on 29/11/13.
//  Copyright (c) 2013 IOSDeveloper. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

-(void)awakeFromNib
{
    [self setLeftPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"LeftView"]];
    [self setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"CenterView"]];
    //[self setRightPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"rightViewController"]];
    self.leftFixedWidth=260;
    self.leftGapPercentage=260;
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(BOOL)prefersStatusBarHidden
{
    return NO;
}

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
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
