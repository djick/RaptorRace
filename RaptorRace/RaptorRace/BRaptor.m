//
//  BRaptor.m
//  RaptorRace
//
//  Created by Nemanja Aksic on 3/13/14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import "BRaptor.h"

@implementation BRaptor

-(id) init{
    if(self = [super init]){
        self.raptor = [super makeRaptor];
        NSLog(@"makes");
        [self addChild:self.raptor];
    }
    return self;
    
}

- (NSString *) getAtlasName
{
    return @"raptor";
}

- (NSString* ) getPictureNameFormat
{
    return @"rapto%d";
}

@end
