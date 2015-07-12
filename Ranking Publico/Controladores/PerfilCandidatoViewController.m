//
//  PerfilCandidatoViewController.m
//  Ranking Publico
//
//  Created by Alex Mejicanos on 12/07/15.
//  Copyright (c) 2015 Alex Mejicanos. All rights reserved.
//

#import "PerfilCandidatoViewController.h"

@interface PerfilCandidatoViewController ()
    
@end

@implementation PerfilCandidatoViewController
@synthesize tablaPerfil, candidatoVer, valorCriterios;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Perfil";
    
    valorCriterios = 0;
    
    tablaPerfil.delegate = self;
    tablaPerfil.dataSource = self;
    tablaPerfil.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self calcularValorCriterios];
}

-(void)calcularValorCriterios
{
    for (NSDictionary *criterioSee in [candidatoVer objectForKey:@"criterios"])
    {
        valorCriterios = valorCriterios + ( [[[criterioSee objectForKey:@"criterio"] valueForKey:@"puntuacion"] integerValue]);
    }
    
    [tablaPerfil reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        return 210;
    }
    else if( indexPath.row == 1 )
    {
        return 70;
    }
    else if( indexPath.row == 2 || indexPath.row == 3)
    {
        return 50;
    }
    else
    {
        return 85;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0)
    {
        static NSString *CellIdentifier = @"HeaderCell";
        static NSString *CellNib = @"HeaderCell";
        
        HeaderCell *cell = (HeaderCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellNib owner:self options:nil];
            cell = (HeaderCell *)[nib objectAtIndex:0];
        }
        
        cell.avatar.layer.cornerRadius = cell.avatar.layer.frame.size.height/2;
        cell.avatar.layer.borderWidth = 3;
        cell.avatar.layer.borderColor = [UIColor whiteColor].CGColor;
        cell.avatar.layer.masksToBounds = true;
        [cell.avatar setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://rankingpolitico.hackatoncivico.com/%@", [candidatoVer valueForKey:@"foto"]]] placeholderImage:[UIImage imageNamed:@"AvatarDemo"]];
        cell.lblNombre.text = [NSString stringWithFormat:@"%@ %@", [candidatoVer valueForKey:@"nombres"], [candidatoVer valueForKey:@"apellidos"]];
        cell.lblLikes.text = @"100";
        cell.lblLikes.text = @"200";
        
        return cell;
    }
    else if (indexPath.row == 1)
    {
        static NSString *CellIdentifier = @"DatosPerfilCell";
        static NSString *CellNib = @"DatosPerfilCell";
        
        DatosPerfilCell *cell = (DatosPerfilCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellNib owner:self options:nil];
            cell = (DatosPerfilCell *)[nib objectAtIndex:0];
        }
        
        cell.lblLogros.text = [NSString stringWithFormat:@"%lu", (unsigned long)[[candidatoVer objectForKey:@"logros"] count]];
        cell.lblCriterios.text = [NSString stringWithFormat:@"%ld", (long)valorCriterios];
        
        return cell;
    }
    else if( indexPath.row == 2 )
    {
        static NSString *CellIdentifier = @"InfoDetallePerfilCell";
        static NSString *CellNib = @"InfoDetallePerfilCell";
        
        InfoDetallePerfilCell *cell = (InfoDetallePerfilCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellNib owner:self options:nil];
            cell = (InfoDetallePerfilCell *)[nib objectAtIndex:0];
        }
        
        cell.lblTitulo.text = @"Ver Logros";
        
        return cell;
    }
    else if( indexPath.row == 3 )
    {
        static NSString *CellIdentifier = @"InfoDetallePerfilCell";
        static NSString *CellNib = @"InfoDetallePerfilCell";
        
        InfoDetallePerfilCell *cell = (InfoDetallePerfilCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellNib owner:self options:nil];
            cell = (InfoDetallePerfilCell *)[nib objectAtIndex:0];
        }
        
        cell.lblTitulo.text = @"Ver Criterios";
        
        return cell;
    }
    else
    {
        static NSString *CellIdentifier = @"Cell";
        
        UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( indexPath.row == 2)
    {
        DetallePerfilViewController *__weak vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetallePerfilView"];
        vc.esLogro = true;
        vc.tituloVer = @"Logros";
        vc.candidatoVer = candidatoVer;
        [self.navigationController pushViewController:vc animated:true];
    }
    else if ( indexPath.row == 3 )
    {
        DetallePerfilViewController *__weak vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetallePerfilView"];
        vc.esLogro = false;
        vc.tituloVer = @"Criterios";
        vc.candidatoVer = candidatoVer;
        [self.navigationController pushViewController:vc animated:true];
    }
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
