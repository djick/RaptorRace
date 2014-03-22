//
//  MovingObstacle.m
//  RaptorRace
//
//  Created by Martin Solheim on 17/03/14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import "MovingObstacle.h"

@implementation MovingObstacle{
    NSArray *objectAnimatedFrames;
}

- (void)setPhysicsAbilitiesOfObstacle{
    [super obstacle].physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:[super obstacle].frame.size];
    [super obstacle].physicsBody.allowsRotation = NO;
    [super obstacle].physicsBody.restitution = 0.0;
    [super obstacle].physicsBody.dynamic = NO;
    [super obstacle].physicsBody.categoryBitMask = obstacleCategory;
    [super obstacle].physicsBody.collisionBitMask = dinoCategory;
    [super obstacle].physicsBody.contactTestBitMask = dinoCategory;
    [super obstacle].xScale = 0.5;
    [super obstacle].yScale = 0.5;
}

- (SKTexture *) getTexture
{
    return [self createAnimationTextureWithAtlasNamed:[self getAtlasName]
                                 AndPictureNameFormat:[self getPictureNameFormat]];
}

- (SKTexture *) createAnimationTextureWithAtlasNamed:(NSString *)name
                                AndPictureNameFormat:(NSString *)format
{
    //NSArray *obstacleMovingFrames;
    NSMutableArray *movingFrames = [NSMutableArray array];
    SKTextureAtlas *obstacleAnimatedAtlas = [SKTextureAtlas atlasNamed:name];
    
    int numImages = obstacleAnimatedAtlas.textureNames.count;
    for (int i=1; i <= numImages; i++) {
        NSString *textureName = [NSString stringWithFormat:format, i];
        SKTexture *temp = [obstacleAnimatedAtlas textureNamed:textureName];
        [movingFrames addObject:temp];
    }
    objectAnimatedFrames= movingFrames;
    SKTexture *temp = objectAnimatedFrames[0];
    return temp;
}


- (void) animateObstacle
{
    [[super obstacle] runAction:[SKAction repeatActionForever:
                       [SKAction animateWithTextures:objectAnimatedFrames
                                        timePerFrame:0.1f
                                              resize:NO
                                             restore:YES]] withKey:@"runningInPlaceObstacleRaptor"];
}


// Has to be implemented by sub-class, or it wil raise exception.
- (NSString *) getAtlasName
{
        NSLog(@"in here");
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    return NULL;
}

// Has to be implemented by sub-class, or it wil raise exception.
- (NSString* ) getPictureNameFormat
{
        NSLog(@"in here pnf");
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    return NULL;
}

@end
