//
//  OrganizacionesWS.h
//  Ranking Publico
//
//  Created by Alex Mejicanos on 12/07/15.
//  Copyright (c) 2015 Alex Mejicanos. All rights reserved.
//

#import "ManagerWS.h"

@interface OrganizacionesWS : ManagerWS
{
@protected NSMutableDictionary *_parametros;
@protected ManagerWS *_webservice; //Intefarz para ejecutar el WS
}

-(void)requestWS:(NSMutableDictionary *)parametros delegate:(id<ManagerWSDelegate>)delegate;
@end
