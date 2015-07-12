//
//  ListaCandidatosViewController.m
//  Ranking Publico
//
//  Created by Alex Mejicanos on 12/07/15.
//  Copyright (c) 2015 Alex Mejicanos. All rights reserved.
//

#import "ListaCandidatosViewController.h"

@interface ListaCandidatosViewController ()
    @property (nonatomic, strong) NSMutableArray *arrayCandidatos;
    @property (strong, nonatomic) ODRefreshControl *refreshControlSet;
@end

@implementation ListaCandidatosViewController
@synthesize idorganizacion, tipocandidatura, tablaCandidatos, arrayCandidatos, refreshControlSet;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Candidatos";
    arrayCandidatos = [[NSMutableArray alloc] init];
    
    tablaCandidatos.delegate = self;
    tablaCandidatos.dataSource = self;
    
    tablaCandidatos.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    refreshControlSet = [[ODRefreshControl alloc] initInScrollView:tablaCandidatos];
    [refreshControlSet addTarget:self action:@selector(dropViewDidBeginRefreshing:) forControlEvents:UIControlEventValueChanged];
    refreshControlSet.tintColor = [UIColor colorWithRed:74/255.0 green:144/255.0 blue:226/255.0 alpha:1];
    
    [self obtenerDatos];
}
- (void)dropViewDidBeginRefreshing:(ODRefreshControl *)refreshControl
{
    NSMutableDictionary *dataSend = [[NSMutableDictionary alloc] init];
    [dataSend setValue:idorganizacion forKey:@"idorganizacion"];
    [dataSend setValue:tipocandidatura forKey:@"idcandidatura"];
    
    PartidosWS *actWS = [[PartidosWS alloc] init];
    [actWS requestWS:dataSend delegate:self];
    [actWS useManagerGETWithTagServer:@"wsCandidatos"];
}

-(void)obtenerDatos
{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.labelText = @"Cargando";
    HUD.delegate = self;
    [HUD show:YES];
    
    NSMutableDictionary *dataSend = [[NSMutableDictionary alloc] init];
    [dataSend setValue:idorganizacion forKey:@"idorganizacion"];
    [dataSend setValue:tipocandidatura forKey:@"idcandidatura"];

    PartidosWS *actWS = [[PartidosWS alloc] init];
    [actWS requestWS:dataSend delegate:self];
    [actWS useManagerGETWithTagServer:@"wsCandidatos"];
}

-(void)webserviceRequestComplete:(ManagerWS *)callback
{
    [HUD hide:YES];
    if (callback.resultado)
    {
        if([callback.tagServer isEqualToString:@"wsCandidatos"])
        {
            [refreshControlSet endRefreshing];
            arrayCandidatos = [callback.respuesta objectForKey:@"registros"];
            [tablaCandidatos reloadData];
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
    return 85;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayCandidatos count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CandidatoRankingCell";
    static NSString *CellNib = @"CandidatoRankingCell";
    
    CandidatoRankingCell *cell = (CandidatoRankingCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellNib owner:self options:nil];
        cell = (CandidatoRankingCell *)[nib objectAtIndex:0];
    }
    
    NSMutableDictionary *candidatoVer = [arrayCandidatos objectAtIndex:indexPath.row];
    
    cell.avatar.layer.cornerRadius = cell.avatar.layer.frame.size.height/2;
    cell.avatar.layer.masksToBounds = true;
    [cell.avatar setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://rankingpolitico.hackatoncivico.com/%@", [candidatoVer valueForKey:@"foto"]]] placeholderImage:[UIImage imageNamed:@"AvatarDemo"]];
    
    cell.lblTituloUno.text = [NSString stringWithFormat:@"%@ %@", [candidatoVer valueForKey:@"nombres"], [candidatoVer valueForKey:@"apellidos"]];
    cell.lblTituloDos.text = [[candidatoVer objectForKey:@"puesto"] valueForKey:@"titulo"];
    cell.lblTituloTres.text = [[candidatoVer objectForKey:@"organizacion"] valueForKey:@"nombre"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PerfilCandidatoViewController *__weak vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PerfilView"];
    vc.candidatoVer = [[arrayCandidatos objectAtIndex:indexPath.row] mutableCopy];
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
