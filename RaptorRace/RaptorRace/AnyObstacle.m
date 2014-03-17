//
//  AnyObstacle.m
//  RaptorRace
//
//  Created by Martin Solheim on 17/03/14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import "AnyObstacle.h"

@implementation AnyObstacle

SKSpriteNode * obstacle;

-(id)init
{
    if (self = [super init])
    {
        NSLog(@"Obstacle(s) initialized");
    }
    
    return self;
}

- (void) makeObstacle
{
    [self addTexture:[self getTexture]];
    [self setPhysicsAbilitiesOfObstacle];
}

- (void) addTexture:(SKTexture *)texture
{
    obstacle = [SKSpriteNode spriteNodeWithTexture:texture];
}

- (void) setPhysicsAbilitiesOfObstacle
{
    //    [NSException raise:NSInternalInconsistencyException
    //                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];

}

- (SKTexture *)getTexture
{
    //    [NSException raise:NSInternalInconsistencyException
    //                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    return NULL;
}

@end
