//
//  PreguntasViewController.m
//  Ranking Publico
//
//  Created by Alex Mejicanos on 12/07/15.
//  Copyright (c) 2015 Alex Mejicanos. All rights reserved.
//

#import "PreguntasViewController.h"

@interface PreguntasViewController ()
    @property (nonatomic, strong) NSMutableArray *arrayPreguntas;
    @property (strong, nonatomic) ODRefreshControl *refreshControlSet;
@end

@implementation PreguntasViewController
@synthesize tablaPreguntas, refreshControlSet, arrayPreguntas;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.ç
    self.title = @"Preguntas";
    
    tablaPreguntas.delegate = self;
    tablaPreguntas.dataSource = self;
    tablaPreguntas.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    refreshControlSet = [[ODRefreshControl alloc] initInScrollView:tablaPreguntas];
    [refreshControlSet addTarget:self action:@selector(dropViewDidBeginRefreshing:) forControlEvents:UIControlEventValueChanged];
    refreshControlSet.tintColor = [UIColor colorWithRed:74/255.0 green:144/255.0 blue:226/255.0 alpha:1];
    
    [self obtenerDatos];
}

- (void)dropViewDidBeginRefreshing:(ODRefreshControl *)refreshControl
{
    PreguntasWS *actWS = [[PreguntasWS alloc] init];
    [actWS requestWS:nil delegate:self];
    [actWS useManagerGETWithTagServer:@"wsPreguntas"];
}

-(void)obtenerDatos
{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.labelText = @"Cargando";
    HUD.delegate = self;
    [HUD show:YES];
    
    PreguntasWS *actWS = [[PreguntasWS alloc] init];
    [actWS requestWS:nil delegate:self];
    [actWS useManagerGETWithTagServer:@"wsPreguntas"];
}

-(void)webserviceRequestComplete:(ManagerWS *)callback
{
    [HUD hide:YES];
    if (callback.resultado)
    {
        if([callback.tagServer isEqualToString:@"wsPreguntas"])
        {
            [refreshControlSet endRefreshing];
            arrayPreguntas = [callback.respuesta objectForKey:@"registros"];
            [tablaPreguntas reloadData];
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
    return 100;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [arrayPreguntas count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"PreguntasCell";
    static NSString *CellNib = @"PreguntasCell";
    
    PreguntasCell *cell = (PreguntasCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellNib owner:self options:nil];
        cell = (PreguntasCell *)[nib objectAtIndex:0];
    }
    
    NSDictionary *dataVer = [arrayPreguntas objectAtIndex:indexPath.row];
    
    cell.lblTitulo.text = [dataVer valueForKey:@"titulo"];
    cell.lblPregunta.text = [dataVer valueForKey:@"descripcion"];
    
    
    return cell;
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
