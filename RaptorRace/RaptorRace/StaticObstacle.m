//
//  StaticObstacle.m
//  RaptorRace
//
//  Created by Martin Solheim on 17/03/14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import "StaticObstacle.h"

@implementation StaticObstacle

- (void)setPhysicsAbilitiesOfObstacle
{
    [super obstacle].physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:[super obstacle].frame.size];
    [super obstacle].physicsBody.allowsRotation = NO;
    [super obstacle].physicsBody.restitution = 0.0;
    [super obstacle].physicsBody.dynamic = NO;
    [super obstacle].physicsBody.categoryBitMask = obstacleCategory;
    [super obstacle].physicsBody.collisionBitMask = dinoCategory;
    [super obstacle].physicsBody.contactTestBitMask = dinoCategory;
    [super obstacle].xScale = 0.7;
    [super obstacle].yScale = 0.7;
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
