//
//  DetallePerfilViewController.m
//  Ranking Publico
//
//  Created by Alex Mejicanos on 12/07/15.
//  Copyright (c) 2015 Alex Mejicanos. All rights reserved.
//

#import "DetallePerfilViewController.h"

@interface DetallePerfilViewController ()

@end

@implementation DetallePerfilViewController
@synthesize tablaDatosVer, esLogro, tituloVer, candidatoVer;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = tituloVer;
    
    tablaDatosVer.delegate = self;
    tablaDatosVer.dataSource = self;
    tablaDatosVer.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
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
    if (esLogro)
    {
        return [[candidatoVer objectForKey:@"logros"] count];
    }
    else
    {
        return [[candidatoVer objectForKey:@"criterios"] count];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    static NSString *CellIdentifier = @"DetallePerfilCell";
    static NSString *CellNib = @"DetallePerfilCell";
    
    DetallePerfilCell *cell = (DetallePerfilCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellNib owner:self options:nil];
        cell = (DetallePerfilCell *)[nib objectAtIndex:0];
    }
    
    NSDictionary *dataVer;
    
    if (esLogro)
    {
        dataVer = [[candidatoVer objectForKey:@"logros"] objectAtIndex:indexPath.row];
        
        cell.lblTituloUno.text = [dataVer valueForKey:@"descripcion"];
        cell.lblTituloDos.text = [NSString stringWithFormat:@"Inicio: %@ - Fin: %@", [dataVer valueForKey:@"inicio"], [dataVer valueForKey:@"fin"]];
        cell.lblValor.text = @"";
    }
    else
    {
        dataVer = [[candidatoVer objectForKey:@"criterios"] objectAtIndex:indexPath.row];
        
        cell.lblTituloUno.text = [[dataVer objectForKey:@"criterio"] valueForKey:@"titulo"];
        cell.lblTituloDos.text = [dataVer valueForKey:@"descripcion"];
        cell.lblValor.text = [[dataVer valueForKey:@"criterio"] valueForKey:@"puntuacion"];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
