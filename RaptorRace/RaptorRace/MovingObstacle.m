//
//  MovingObstacle.m
//  RaptorRace
//
//  Created by Martin Solheim on 17/03/14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import "MovingObstacle.h"
#import "Categories.h"

@implementation MovingObstacle

SKSpriteNode * obstacle;

- (void) setPhysicsAbilitiesOfObstacle
{
    
}

- (SKTexture *) getTexture
{
    return NULL;
}

- (SKTexture *) createAnimationTextureWithAtlasNamed:(NSString *)name
                                AndPictureNameFormat:(NSString *)format
{
    NSArray *obstacleMovingFrames;
    NSMutableArray *movingFrames = [NSMutableArray array];
    SKTextureAtlas *obstacleAnimatedAtlas = [SKTextureAtlas atlasNamed:name];
    
    int numImages = obstacleAnimatedAtlas.textureNames.count;
    for (int i=1; i <= numImages; i++) {
        NSString *textureName = [NSString stringWithFormat:format, i];
        SKTexture *temp = [obstacleAnimatedAtlas textureNamed:textureName];
        [movingFrames addObject:temp];
    }
    
    obstacleMovingFrames = movingFrames;
    SKTexture *temp = obstacleMovingFrames[0];
    
    return temp;
}


- (void) animateObstacle
{
//    [obstacle runAction:[SKAction repeatActionForever:
//                       [SKAction animateWithTextures:raptorRunningFrames
//                                        timePerFrame:0.1f
//                                              resize:NO
//                                             restore:YES]] withKey:@"runningInPlaceRaptor"];
//    return;
}

- (SKAction *) makeMovementAction
{
    return NULL;
}

// Has to be implemented by sub-class, or it wil raise exception.
- (NSString *) getAtlasName
{
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    return NULL;
}

// Has to be implemented by sub-class, or it wil raise exception.
- (NSString* ) getPictureNameFormat
{
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    return NULL;
}

-(void)didBeginContact:(SKPhysicsContact*)contact {
    if (contact.bodyA.categoryBitMask ==dinoCategory && contact.bodyB.categoryBitMask==obstacleCategory){
        NSLog(@"collison detected");
        if (collisions==2) {
            //gameover
        }
        else{
            collisions=collisions+1;
        }
    }
    if (contact.bodyA.categoryBitMask ==obstacleCategory && contact.bodyB.categoryBitMask==dinoCategory){
        NSLog(@"collison detected");
        if (collisions==2) {
            //gameover
        }
        else{
            collisions=collisions+1;
        }
    }
}

@end
