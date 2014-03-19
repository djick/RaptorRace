//
//  StaticObstacle.m
//  RaptorRace
//
//  Created by Martin Solheim on 17/03/14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import "StaticObstacle.h"

@implementation StaticObstacle

- (void) setPhysicsAbilitiesOfObstacle
{
    
}

- (SKTexture *) getTexture
{
    return [self createTextureWithImageNamed:[self getPictureName]];
}

#pragma mark -
#pragma StaticObstacle Specific Methods

- (SKTexture *) createTextureWithImageNamed:(NSString *)name
{
    return [SKTexture textureWithImageNamed:name];
}


// Has to be implemented by sub-class, or it wil raise exception.
- (NSString* ) getPictureName
{
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    return NULL;
}

@end
