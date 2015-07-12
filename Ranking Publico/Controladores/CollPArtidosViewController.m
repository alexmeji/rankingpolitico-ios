//
//  CollPArtidosViewController.m
//  Ranking Publico
//
//  Created by Alex Mejicanos on 12/07/15.
//  Copyright (c) 2015 Alex Mejicanos. All rights reserved.
//

#import "CollPArtidosViewController.h"

@interface CollPArtidosViewController ()
    @property (nonatomic, strong) NSMutableArray *arrayPartidos;
    @property (strong, nonatomic) ODRefreshControl *refreshControlSet;
@end

@implementation CollPArtidosViewController
@synthesize collPartidos, arrayPartidos, refreshControlSet, scrollCollection, tipocandidatura;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Organizaciones";
    
    arrayPartidos = [[NSMutableArray alloc] init];
    
    [self.collPartidos registerNib:[UINib nibWithNibName:@"PartidoCollCell" bundle:nil] forCellWithReuseIdentifier:@"CELL"];
    collPartidos.dataSource = self;
    collPartidos.delegate = self;
    
    refreshControlSet = [[ODRefreshControl alloc] initInScrollView:scrollCollection];
    [refreshControlSet addTarget:self action:@selector(dropViewDidBeginRefreshing:) forControlEvents:UIControlEventValueChanged];
    refreshControlSet.tintColor = [UIColor colorWithRed:74/255.0 green:144/255.0 blue:226/255.0 alpha:1];
    
    [self obtenerDatos];
}

- (void)dropViewDidBeginRefreshing:(ODRefreshControl *)refreshControl
{
    OrganizacionesWS *actWS = [[OrganizacionesWS alloc] init];
    [actWS requestWS:nil delegate:self];
    [actWS useManagerGETWithTagServer:@"wsOrganizaciones"];
}

-(void)obtenerDatos
{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.labelText = @"Cargando";
    HUD.delegate = self;
    [HUD show:YES];
    
    OrganizacionesWS *actWS = [[OrganizacionesWS alloc] init];
    [actWS requestWS:nil delegate:self];
    [actWS useManagerGETWithTagServer:@"wsOrganizaciones"];
}

-(void)webserviceRequestComplete:(ManagerWS *)callback
{
    [HUD hide:YES];
    if (callback.resultado)
    {
        if([callback.tagServer isEqualToString:@"wsOrganizaciones"])
        {
            [refreshControlSet endRefreshing];
            arrayPartidos = [callback.respuesta objectForKey:@"registros"];
            [collPartidos reloadData];
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

#pragma Collection View Delegates

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [arrayPartidos count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(135, 135);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PartidoCollCell *cell = [self.collPartidos dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    
    NSDictionary *dataVer = [arrayPartidos objectAtIndex:indexPath.row];
    
    [cell.foto setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://rankingpolitico.hackatoncivico.com/%@", [dataVer valueForKey:@"logo"]]] placeholderImage:[UIImage imageNamed:@"AvatarDemo"]];
    
    
    cell.layer.cornerRadius = 10.f;
    cell.layer.masksToBounds = true;
    
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 15, 5, 15);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ListaCandidatosViewController *__weak vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ListaCandidatosView"];
    vc.tipocandidatura = tipocandidatura;
    vc.idorganizacion = [[arrayPartidos objectAtIndex:indexPath.row] valueForKey:@"id"];
    [self.navigationController pushViewController:vc animated:true];
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
