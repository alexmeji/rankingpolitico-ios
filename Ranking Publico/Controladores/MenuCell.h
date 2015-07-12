//
//  MenuCell.h
//  Pasalo
//
//  Created by Alex Mejicanos on 13/08/14.
//  Copyright (c) 2014 Alex Mejicanos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *nombre;
@property (nonatomic, weak) IBOutlet UILabel *badge;
@property (nonatomic, weak) IBOutlet UIImageView *icono;

@end
