//
//  MenuViewController.m
//  Ranking Publico
//
//  Created by Alex Mejicanos on 12/07/15.
//  Copyright (c) 2015 Alex Mejicanos. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController
@synthesize tablaMenu;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    tablaMenu.dataSource = self;
    tablaMenu.delegate = self;
    
    tablaMenu.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MenuCell";
    static NSString *CellNib = @"MenuCell";
    
    MenuCell *cell = (MenuCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellNib owner:self options:nil];
        cell = (MenuCell *)[nib objectAtIndex:0];
    }
    
    switch (indexPath.row)
    {
        case 0:
            cell.nombre.text = @"Ranking";
            break;
        case 1:
            cell.nombre.text = @"Lista Partidos";
            break;
        case 2:
            cell.nombre.text = @"Preguntas Frecuentes";
            break;
        default:
            break;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            RankingViewController *__weak viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RankingView"];
            self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:viewController];
        }
            break;
        case 1:
        {
            ListadoPartidosViewController *__weak viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ListadoView"];
            self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:viewController];
        }
            break;
        case 2:
        {
            PreguntasViewController *__weak viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PreguntasView"];
            self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:viewController];
        }
            break;
        default:
            break;
    }
    
    [tablaMenu deselectRowAtIndexPath:indexPath animated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
