//
//  CandidaturaWS.m
//  Ranking Publico
//
//  Created by Alex Mejicanos on 12/07/15.
//  Copyright (c) 2015 Alex Mejicanos. All rights reserved.
//

#import "CandidaturaWS.h"

@implementation CandidaturaWS
- (id)init
{
    if (self = [super init])
    {
        servicio = @"/ws/candidaturas";
    }
    return self;
}

-(void)requestWS:(NSMutableDictionary *)parametros delegate:(id<ManagerWSDelegate>)delegate
{
    [self setParametros:parametros];
    _parametros = parametros;
    _delegate = delegate;
}
@end
