//
//  ListaCandidatosViewController.h
//  Ranking Publico
//
//  Created by Alex Mejicanos on 12/07/15.
//  Copyright (c) 2015 Alex Mejicanos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>
#import <TSMessages/TSMessage.h>
#import <TSMessages/TSMessageView.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <ODRefreshControl/ODRefreshControl.h>
#import "CandidatoRankingCell.h"
#import "PartidosWS.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "PerfilCandidatoViewController.h"

@interface ListaCandidatosViewController : UIViewController <MBProgressHUDDelegate, TSMessageViewProtocol, ManagerWSDelegate, UITableViewDataSource, UITableViewDelegate>
{
    MBProgressHUD *HUD;
}

//OUTLET
@property (nonatomic, strong) IBOutlet UITableView *tablaCandidatos;

//VARIABLES
@property (nonatomic, strong) NSString *tipocandidatura;
@property (nonatomic, strong) NSString *idorganizacion;

@end
