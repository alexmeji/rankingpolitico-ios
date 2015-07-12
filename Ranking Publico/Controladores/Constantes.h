//
//  Constantes.h
//  PasaloN
//
//  Created by Alex Mejicanos on 11/02/14.
//  Copyright (c) 2014 Alex Mejicanos. All rights reserved.
//

#ifndef PasaloN_Constantes_h
#define PasaloN_Constantes_h

#define app1 [GlobalData getInstance].app == 1
#define app2 [GlobalData getInstance].app == 2
#define app3 [GlobalData getInstance].app == 3

#define app1L [GlobalData getInstance].appLogica == 1
#define app2L [GlobalData getInstance].appLogica == 2
#define app3L [GlobalData getInstance].appLogica == 3

#define kHNormalRefresh CGRectMake(42, 0, 39, 50)
#define kHNormalDate CGRectMake(42, 58, 39, 63)
#define kHNormalComunidad CGRectMake(43, 124, 39, 56)
#define kHNormalTipo CGRectMake(42, 193, 39, 50)
#define kHNormalMiembro CGRectMake(42, 247, 39, 50)
#define kHNormalAbrir CGRectMake(7, 126, 28, 50)
#define kHNormalCorrelativo CGRectMake(42 ,300 ,39 ,40)

#define kHAsignaloRefresh CGRectMake(44, 8, 37, 34)
#define kHAsignaloDate CGRectMake(40, 106, 41, 44)
#define kHAsignaloComunidad CGRectMake(42, 162, 41, 37)
#define kHAsignaloTipo CGRectMake(41, 226, 41, 37)
#define kHAsignaloMiembro CGRectMake(42, 271, 41, 37)
#define kHAsignaloAbrir CGRectMake(5, 158, 33, 56)
#define kHAsignaloCorrelativo CGRectMake(42 ,320 ,39 ,40)

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#endif
