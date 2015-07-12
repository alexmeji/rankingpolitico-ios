//
//  PerfilCandidatoViewController.h
//  Ranking Publico
//
//  Created by Alex Mejicanos on 12/07/15.
//  Copyright (c) 2015 Alex Mejicanos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderCell.h"
#import "DatosPerfilCell.h"
#import "InfoDetallePerfilCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "DetallePerfilViewController.h"

@interface PerfilCandidatoViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

//VARIABLES
@property (nonatomic, strong) NSMutableDictionary *candidatoVer;
@property NSInteger valorCriterios;

//OUTLET
@property (nonatomic, weak) IBOutlet UITableView *tablaPerfil;

@end
