//
//  RankingViewController.h
//  Ranking Publico
//
//  Created by Alex Mejicanos on 12/07/15.
//  Copyright (c) 2015 Alex Mejicanos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TSMessages/TSMessage.h>
#import <TSMessages/TSMessageView.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "RankingWS.h"
#import "CandidatoRankingCell.h"
#import <ODRefreshControl/ODRefreshControl.h>
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "PerfilCandidatoViewController.h"

@interface RankingViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, ManagerWSDelegate, TSMessageViewProtocol, MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
}

//OUTLETS
@property (nonatomic, weak) IBOutlet UITableView *tablaRanking;
@property (nonatomic, weak) IBOutlet UIButton *btnLikes;
@property (nonatomic, weak) IBOutlet UIButton *btnRanking;

@end
