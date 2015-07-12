//
//  ListadoPartidosViewController.m
//  Ranking Publico
//
//  Created by Alex Mejicanos on 12/07/15.
//  Copyright (c) 2015 Alex Mejicanos. All rights reserved.
//

#import "ListadoPartidosViewController.h"

@interface ListadoPartidosViewController ()
    @property (nonatomic, strong) NSMutableArray *arrayCandidaturas;
    @property (strong, nonatomic) ODRefreshControl *refreshControlSet;
@end

@implementation ListadoPartidosViewController
@synthesize tablaCandidaturas, arrayCandidaturas, refreshControlSet;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Listado Partidos";
    
    tablaCandidaturas.delegate = self;
    tablaCandidaturas.dataSource = self;
    tablaCandidaturas.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    refreshControlSet = [[ODRefreshControl alloc] initInScrollView:tablaCandidaturas];
    [refreshControlSet addTarget:self action:@selector(dropViewDidBeginRefreshing:) forControlEvents:UIControlEventValueChanged];
    refreshControlSet.tintColor = [UIColor colorWithRed:74/255.0 green:144/255.0 blue:226/255.0 alpha:1];
    
    [self obtenerDatos];
}

- (void)dropViewDidBeginRefreshing:(ODRefreshControl *)refreshControl
{
    CandidaturaWS *actWS = [[CandidaturaWS alloc] init];
    [actWS requestWS:nil delegate:self];
    [actWS useManagerGETWithTagServer:@"wsCandidaturas"];
}

-(void)obtenerDatos
{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.labelText = @"Cargando";
    HUD.delegate = self;
    [HUD show:YES];
    
    CandidaturaWS *actWS = [[CandidaturaWS alloc] init];
    [actWS requestWS:nil delegate:self];
    [actWS useManagerGETWithTagServer:@"wsCandidaturas"];
}

-(void)webserviceRequestComplete:(ManagerWS *)callback
{
    [HUD hide:YES];
    if (callback.resultado)
    {
        if([callback.tagServer isEqualToString:@"wsCandidaturas"])
        {
            [refreshControlSet endRefreshing];
            arrayCandidaturas = [callback.respuesta objectForKey:@"registros"];
            [tablaCandidaturas reloadData];
        }
    }
    else
    {
        [TSMessage showNotificationInViewController:self
                                              title:@"Espera..!"
                                           subtitle:callback.mensaje
                                               type:TSMessageNotificationTypeError];
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [arrayCandidaturas count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"CandidaturasCell";
    static NSString *CellNib = @"CandidaturasCell";
    
    CandidaturasCell *cell = (CandidaturasCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellNib owner:self options:nil];
        cell = (CandidaturasCell *)[nib objectAtIndex:0];
    }
    
    NSDictionary *dataVer = [arrayCandidaturas objectAtIndex:indexPath.row];
    
    cell.lblTitulo.text = [dataVer valueForKey:@"titulo"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CollPArtidosViewController *__weak vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CollPartidosView"];
    vc.tipocandidatura = [[arrayCandidaturas objectAtIndex:indexPath.row] valueForKey:@"id"];
    [self.navigationController pushViewController:vc animated:true];
    [tableView deselectRowAtIndexPath:indexPath animated:true];
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
