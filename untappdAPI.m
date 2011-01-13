//
//  untappd.m
//  BeerAdvocate
//
//  Created by Chris Blazek on 1/10/11.
//  Copyright 2011 KinGBin Productions. All rights reserved.
//

#import "untappdAPI.h"

@implementation untappdAPI

@synthesize username, password, api_Key, request;

/*************************************/

static NSString *untappdURL = nil;

- (id)initConnection:(NSString *)uname : (NSString *)pword : (NSString *)api_key;{
	
	if (self = [super init]) {
		
		untappdURL = @"http://api.untappd.com/v1/";
		
		[self setUsername:uname];
		[self setPassword:pword];
		[self setApi_Key:api_key];
	}
	
	return self;
}


- (void)dealloc {
	NSLog(@"Deallocating Untappd API");
	
	[username release];
	[password release];
	[api_Key release];
	[request release];
	
	[super dealloc];
}



// Setter/Getter Functions
-(void)setRequest:(ASIHTTPRequest *)req{ 
	request = req;
}

//-(void)getRequest:{
//}

-(void)setUsername:(NSString *)newuser{
	if(newuser != username){
		username = newuser;
	}
}

-(void)setPassword:(NSString *)newpass{
	//password = [[untappdAPI md5HexDigest:newpass ] retain];

	[password release];
    password = [[untappdAPI md5HexDigest: newpass] copy];
}

-(void)setApi_Key:(NSString *)newkey{
	if(newkey != api_Key){
		api_Key	= newkey;
	}
}


/* Class Instance Methods
*************************************/
- (NSString *)queryActivity_On_You{
	NSString *queryReturn = @"";
	
	request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat: @"%@activity_on_you?key=%@", untappdURL, api_Key]]];
	//[request setUseSessionPersistence:YES];
	[request setUsername:self.username];
	[request setPassword:self.password];
	
	[request addRequestHeader:@"Accept" value:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"];
	[request addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
	
	[request startSynchronous];
	NSError *error = [request error];
	if (!error) {
		queryReturn = [request responseString];
	}
	
	NSLog(@"%@",queryReturn);
	
	return queryReturn;
}

- (NSString *)queryFeed{
	NSString *queryReturn = @"";
	
	request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat: @"%@feed?key=%@", untappdURL, api_Key]]];
	//[request setUseSessionPersistence:YES];
	[request setUsername:self.username];
	[request setPassword:self.password];
	
	[request addRequestHeader:@"Accept" value:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"];
	[request addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
	
	[request startSynchronous];
	NSError *error = [request error];
	if (!error) {
		queryReturn = [request responseString];
	}
	
	NSLog(@"%@",queryReturn);
	
	return queryReturn;					
}

- (NSString *)queryUser_Feed: (NSString *)friend {
	
	NSString *queryReturn = @"";

	request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat: @"%@user_feed/%@?key=%@", untappdURL, friend , api_Key]]];

	//[request setUseSessionPersistence:YES];
	[request setUsername:self.username];
	[request setPassword:self.password];
	
	[request addRequestHeader:@"Accept" value:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"];
	[request addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
	
	
	[request startSynchronous];
	NSError *error = [request error];
	if (!error) {
		queryReturn = [request responseString];
	}
	
	NSLog(@"%@",queryReturn);
	
	return queryReturn;
}

- (NSString *)queryThePub{
	NSString *queryReturn = @"";
	
	request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat: @"%@thepub?key=%@", untappdURL, api_Key]]];
	//[request setUseSessionPersistence:YES];
	[request setUsername:self.username];
	[request setPassword:self.password];
	
	[request addRequestHeader:@"Accept" value:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"];
	[request addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
	
	[request startSynchronous];
	NSError *error = [request error];
	if (!error) {
		queryReturn = [request responseString];
	}
	
	NSLog(@"%@",queryReturn);
	
	return queryReturn;	
}


/* Class Static Methods
*************************************/

+ (NSString*)md5HexDigest:(NSString*)input {
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
	
	
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
	
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
		[ret appendFormat:@"%02x",result[i]];
    }

	return ret;
}

@end
