//
//  untappd.h
//  BeerAdvocate
//
//  Created by Chris Blazek on 1/10/11.
//  Copyright 2011 KinGBin Productions. All rights reserved.
//

//#import <Cocoa/Cocoa.h>
#import "ASIHTTPRequest.h"

#import <CommonCrypto/CommonDigest.h>



@interface untappdAPI : NSObject {
	
	@private NSString *username;
	@private NSString *password;
	@private NSString *api_Key;	

	@private ASIHTTPRequest *request;
}

//Properties
@property (assign) NSString *username;
@property (assign) NSString *password;
@property (assign) NSString *api_Key;
@property (readwrite,assign) ASIHTTPRequest *request;


//Functions
- (id)initConnection:(NSString *)uname : (NSString *)pword : (NSString *)api_key;
- (void)dealloc;

- (NSString *)queryActivity_On_You;

- (NSString *)queryFeed;

- (NSString *)queryUser_Feed: (NSString *)friend;

- (NSString *)queryThePub;

// Instances
+ (NSString*)md5HexDigest:(NSString*)input;
@end