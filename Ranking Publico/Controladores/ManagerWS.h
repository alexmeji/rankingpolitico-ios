//
//  ManagerWS.h
//  NewManager
//
//  Created by Alex Mejicanos on 22/07/14.
//  Copyright (c) 2014 Alex Mejicanos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPRequestOperation.h"

typedef NS_ENUM(NSInteger, MMultiPartFileType)
{
    //FOTO
    MMultiPartTypePicture = 0,
    //VIDEO
    MMultiPartTypeVideo,
    //SONIDO
    MMultiPartTypeSound
};

@class ManagerWS;
@protocol ManagerWSDelegate <NSObject>
@required
-(void)webserviceRequestComplete:(ManagerWS *)callback;
@end

@interface ManagerWS : NSObject
{
    //DELEGADO PARA EL PROTOCOLO
    id <ManagerWSDelegate> _delegate;
    //VARIABLE PARA EL NOMBRE DEL SERVICIO
    NSString *servicio;
    //Multipar
    MMultiPartFileType *MMultiPartType;
}

//VARIABLE PARA NUESTRA URL DEL SERVIDOR
@property (nonatomic, strong) NSString *servidor;
//VARIABLE PARA LA RESPUESTA DEL SERVICIO
@property (nonatomic, strong, readonly) id respuesta;
//VARIABLE PARA EL RESULTADO DEL SERVICIO
@property (nonatomic, readonly) BOOL resultado;
//VARIABLE PARA IDENTIFICAR EL SERVICIO EN EL DELEGADO
@property (nonatomic, strong, readonly) NSString *tagServer;
//VARIABLE PARA EL MENSAJE DEL RESULTADO
@property (nonatomic, strong) NSString *mensaje;
//DICCIONARIO DE PARAMETROS
@property (nonatomic, strong) NSMutableDictionary *parametros;
//TIPO MULTIMEDIA
@property int tipoMultimedia;
//MMultiPartType
@property (nonatomic, readonly) MMultiPartFileType *MMultiPartType;
//String JSON
@property NSString *stringJSON;

//METODOS PARA AGREGAR UN PARAMETRO
-(void)setValor:(id <NSObject>)valor parametro:(NSString *)parametro;
//METODO PARA AGREGAR CONJUNTO PARAMETROS
-(void)setParametros:(NSMutableDictionary *)parametrosCome;

//METODOS CON GET
//METODO PARA EJECUTAR EL MANAGER IDENTIFICADO
-(void)useManagerGETWithTagServer:(NSString *)tag;


//METODOS CON POST
//METODO PARA EJECUTAR EL MANAGER IDENTIFICADO
-(void)useManagerPOSTWithTagServer:(NSString *)tag;
//METODO PARA EJECUTAR EL MANAGER MULTIPART IDENTIFICADO
-(void)useManagerPOSTWithTagServerMultipart:(NSString *)tag multiPartType:(int )multiPartType;;


@end
