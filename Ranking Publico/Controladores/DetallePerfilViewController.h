//
//  DetallePerfilViewController.h
//  Ranking Publico
//
//  Created by Alex Mejicanos on 12/07/15.
//  Copyright (c) 2015 Alex Mejicanos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetallePerfilCell.h"

@interface DetallePerfilViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

//OUTLETS
@property (nonatomic, weak) IBOutlet UITableView *tablaDatosVer;

//VARIABLES
@property (nonatomic, strong) NSMutableDictionary *candidatoVer;
@property (nonatomic, strong) NSString *tituloVer;
@property BOOL esLogro;

@end
