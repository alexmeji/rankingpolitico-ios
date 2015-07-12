//
//  ListadoPartidosViewController.h
//  Ranking Publico
//
//  Created by Alex Mejicanos on 12/07/15.
//  Copyright (c) 2015 Alex Mejicanos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TSMessages/TSMessage.h>
#import <TSMessages/TSMessageView.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <ODRefreshControl/ODRefreshControl.h>
#import "CandidaturasCell.h"
#import "CandidaturaWS.h"
#import "CollPArtidosViewController.h"

@interface ListadoPartidosViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, TSMessageViewProtocol, MBProgressHUDDelegate, ManagerWSDelegate>
{
    MBProgressHUD *HUD;
}

//OUTLET
@property (nonatomic, weak) IBOutlet UITableView *tablaCandidaturas;

@end
