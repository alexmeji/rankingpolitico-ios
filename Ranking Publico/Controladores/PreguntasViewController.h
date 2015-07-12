//
//  PreguntasViewController.h
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
#import "PreguntasWS.h"
#import "PreguntasCell.h"

@interface PreguntasViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MBProgressHUDDelegate, TSMessageViewProtocol, ManagerWSDelegate>
{
    MBProgressHUD *HUD;
}

//OUTLET
@property (nonatomic, weak) IBOutlet UITableView *tablaPreguntas;

@end
