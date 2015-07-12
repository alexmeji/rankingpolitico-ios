//
//  HeaderCell.h
//  Ranking Publico
//
//  Created by Alex Mejicanos on 12/07/15.
//  Copyright (c) 2015 Alex Mejicanos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *avatar;
@property (nonatomic, weak) IBOutlet UILabel *lblNombre;
@property (nonatomic, weak) IBOutlet UILabel *lblLikes;
@property (nonatomic, weak) IBOutlet UILabel *lblUnLikes;

@end
