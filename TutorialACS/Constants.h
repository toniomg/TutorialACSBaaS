//
//  Constants.h
//  TutorialParse
//
//  Created by Antonio MG on 7/4/12.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constants : NSObject


//Login & Register
#define KEY_LOGIN_USER @"login"   
#define KEY_PASSWORD @"password"
#define KEY_USER @"user"
#define KEY_PASSWORD_CONFIRMATION @"password_confirmation"

#define URL_LOGIN @"users/login.json"
#define URL_CREATE_USER @"users/create.json"

//Wall
#define KEY_COMMENT @"comment"
#define KEY_IMAGE @"photo"
#define KEY_IMAGE_URL @"urls"
#define KEY_IMAGE_SIZE @"small_240"
#define KEY_USERNAME @"username"
#define KEY_GEOLOC @"location"
#define KEY_CREATION_DATE @"created_at"
#define KEY_ID @"id"
#define KEY_FIELDS @"fields"

#define WALL_OBJECT @"wallImage"

#define URL_WALLIMAGE_CREATE @"objects/"WALL_OBJECT"/create.json"
#define URL_WALLIMAGE_GET @"objects/"WALL_OBJECT"/query.json"
#define URL_WALLIMAGE_UPDATE @"objects/"WALL_OBJECT"/update.json"
#define URL_LOGOUT @"users/logout.json"

#define METHOD_NAME_QUERY @"queryCustomObjects"
#define METHOD_NAME_CREATE @"createObject"
#define METHOD_NAME_UPDATE @"updateObject"
#define METHOD_NAME_LOGOUT @"logoutUser"

@end
