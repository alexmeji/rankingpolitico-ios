//
//  ManagerWS.m
//  NewManager
//
//  Created by Alex Mejicanos on 22/07/14.
//  Copyright (c) 2014 Alex Mejicanos. All rights reserved.
//

#import "ManagerWS.h"

@implementation ManagerWS

@synthesize servidor;
@synthesize parametros;
@synthesize respuesta;
@synthesize resultado;
@synthesize tagServer;
@synthesize mensaje;
@synthesize MMultiPartType;
@synthesize stringJSON;

-(id)init
{
    if (self = [super init])
    {
        servidor = @"http://rankingpolitico.hackatoncivico.com";
        parametros = [[NSMutableDictionary alloc] init];
    }
    return self;
}

//METODOS PARA SETEAR LOS PARAMETROS
-(void)setValor:(id<NSObject>)valor parametro:(NSString *)parametro
{
    [parametros setObject:valor forKey:parametro];
}

-(void)setParametros:(NSMutableDictionary *)parametrosCome
{
    parametros = parametrosCome;
}

-(void)useManagerGETWithTagServer:(NSString *)tag
{
    @try
    {
        tagServer = tag;
        NSString *urlString = [NSString stringWithFormat:@"%@%@",servidor,servicio];
        NSURL *url = [NSURL URLWithString:urlString];
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.stringEncoding = NSASCIIStringEncoding;
        [manager.requestSerializer setTimeoutInterval:60];
        [manager GET:urlString parameters:parametros success:^(AFHTTPRequestOperation *operation, id responseObject) {
            resultado = [[responseObject objectForKey:@"resultado"] boolValue];
            respuesta = (NSDictionary *)responseObject;
            mensaje = [responseObject objectForKey:@"mensaje"];
            [_delegate webserviceRequestComplete:self];
            
            /*
            NSLog(@"HTML: %@", [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
            NSDictionary *jsonObject = [ NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];

            resultado = [[jsonObject objectForKey:@"resultado"] boolValue];
            respuesta = jsonObject;
            mensaje = [jsonObject objectForKey:@"mensaje"];
            
            [_delegate webserviceRequestComplete:self];
            
            
            //NSLog(@"JSON: %@", respuesta);
            
            jsonObject = nil;*/
            /*NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSASCIIStringEncoding];
             NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
             id JSON = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];*/
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            resultado = FALSE;
            respuesta = nil;
            NSLog(@"ERROR ACCEDER: %@", error.description);
            mensaje = @"Error al acceder al servicio";
            
            [_delegate webserviceRequestComplete:self];
        }];
    }
    @catch (NSException *exception)
    {
        resultado = FALSE;
        respuesta = nil;
        mensaje = @"Error interno";
        NSLog(@"ERROR ACCEDER: %@", exception.description);
        [_delegate webserviceRequestComplete:self];
    }
}

-(void)useManagerPOSTWithTagServer:(NSString *)tag
{
    @try
    {
        tagServer = tag;
        NSString *urlString = [NSString stringWithFormat:@"%@%@",servidor,servicio];
        NSURL *url = [NSURL URLWithString:urlString];
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.stringEncoding = NSASCIIStringEncoding;
        [manager POST:urlString parameters:parametros success:^(AFHTTPRequestOperation *operation, id responseObject) {
            stringJSON = responseObject;
            resultado = [[responseObject objectForKey:@"resultado"] boolValue];
            respuesta = (NSDictionary *)responseObject;
            mensaje = [responseObject objectForKey:@"mensaje"];
            [_delegate webserviceRequestComplete:self];
    
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            resultado = FALSE;
            respuesta = nil;
            mensaje = @"Error al acceder al servicio";
            
            [_delegate webserviceRequestComplete:self];
        }];
    }
    @catch (NSException *exception)
    {
        resultado = FALSE;
        respuesta = nil;
        mensaje = @"Error al acceder al servicio";
        
        [_delegate webserviceRequestComplete:self];
    }
    
}

-(void)useManagerPOSTWithTagServerMultipart:(NSString *)tag multiPartType:(int )multiPartType;
{
    @try
    {
        tagServer = tag;
        //MMultiPartType = multiPartType;
        NSString *urlString = [NSString stringWithFormat:@"%@%@",servidor,servicio];
        NSURL *url = [NSURL URLWithString:urlString];
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.stringEncoding = NSASCIIStringEncoding;
        [manager.requestSerializer setTimeoutInterval:40];
        [manager POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            
            if (multiPartType == 1)
            {
                [formData appendPartWithFileData:[parametros valueForKey:@"Filedata"] name:@"Filedata" fileName:@"Filedata.jpg" mimeType:@"image/jpeg"];
            }
            else if (multiPartType == 2)
            {
                [formData appendPartWithFileData:[parametros valueForKey:@"FileDataVideo"] name:@"Filedata" fileName:@"iPhoneVideo.mov" mimeType:@"video/quicktime"];
            }
            else if (multiPartType == 3)
            {
                [formData appendPartWithFileData:[parametros valueForKey:@"FileDataSonido"] name:@"Filedata" fileName:@"iPhoneSonido.wav" mimeType:@"audio/x-wav"];
            }
            
            for (NSString *key in parametros)
            {
                if (![key isEqualToString:@"Filedata"] && ![key isEqualToString:@"FileDataVideo"] && ![key isEqualToString:@"FileDataSonido"])
                {
                    [formData appendPartWithFormData:[[parametros objectForKey:key] dataUsingEncoding:NSUTF8StringEncoding] name:key];
                }
            }
            
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            resultado = [[responseObject objectForKey:@"resultado"] boolValue];
            respuesta = (NSDictionary *)responseObject;
            mensaje = [responseObject objectForKey:@"mensaje"];
            [_delegate webserviceRequestComplete:self];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            resultado = FALSE;
            respuesta = nil;
            mensaje = @"Error al acceder al servicio";
            
            [_delegate webserviceRequestComplete:self];
        }];
    }
    @catch (NSException *exception)
    {
        resultado = FALSE;
        respuesta = nil;
        mensaje = @"Error al acceder al servicio";
        
        [_delegate webserviceRequestComplete:self];
    }
    
    
    

}


@end
