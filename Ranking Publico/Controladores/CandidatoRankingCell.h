//
//  CandidatoRankingCell.h
//  Ranking Publico
//
//  Created by Alex Mejicanos on 12/07/15.
//  Copyright (c) 2015 Alex Mejicanos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CandidatoRankingCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *avatar;
@property (nonatomic, weak) IBOutlet UILabel *lblTituloUno;
@property (nonatomic, weak) IBOutlet UILabel *lblTituloDos;
@property (nonatomic, weak) IBOutlet UILabel *lblTituloTres;

@end
