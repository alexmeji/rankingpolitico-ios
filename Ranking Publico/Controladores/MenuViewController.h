//
//  MenuViewController.h
//  Ranking Publico
//
//  Created by Alex Mejicanos on 12/07/15.
//  Copyright (c) 2015 Alex Mejicanos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuCell.h"
#import "RankingViewController.h"
#import "ListadoPartidosViewController.h"
#import <JASidePanels/JASidePanelController.h>
#import <JASidePanels/UIViewController+JASidePanel.h>
#import "PreguntasViewController.h"

@interface MenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

//OUTLETS
@property (nonatomic, weak) IBOutlet UITableView *tablaMenu;

@end
