//
//  AnyObstacle.m
//  RaptorRace
//
//  Created by Martin Solheim on 17/03/14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import "AnyObstacle.h"

@implementation AnyObstacle{
    SKSpriteNode * obstacle;
    CGFloat height;
}



-(id)init
{
    if (self = [super init])
    {
        [self makeObstacle];
        NSLog(@"Obstacle(s) initialized");
    }
    
    return self;
}

- (id) initWithGroundHeight:(CGFloat)groundHeight{
    self = [self init];
    height = groundHeight;
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

- (void) fireObstacle {
    //    [NSException raise:NSInternalInconsistencyException
    //                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    [obstacle removeAllActions];
    SKAction *moveAction = [SKAction moveTo:CGPointMake(0, height) duration: 8];
    SKAction *doneAction = [SKAction runBlock:(dispatch_block_t)^() {
        NSLog(@"Animation Completed");
        obstacle.hidden = YES;
    }];
    SKAction *moveDinosaurActionWithDone = [SKAction sequence:@[moveAction, doneAction ]];
    [obstacle runAction:moveDinosaurActionWithDone withKey:@"dinosaurMoving"];
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
