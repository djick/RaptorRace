//
//  AnyObstacle.m
//  RaptorRace
//
//  Created by Martin Solheim on 17/03/14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import "AnyObstacle.h"
#import "Categories.h"

@implementation AnyObstacle
@synthesize obstacle = obstacle;
@synthesize height = height;
-(id)init
{
    if (self = [super init])
    {
        [self makeObstacle];
        obstacle.name = @"obs";
        self.nodeHeight = self.getTexture.size.height;
        self.nodeWidth = self.getTexture.size.width;
        [self addChild:obstacle];
        NSLog(@"Obstacle(s) initialized");
    }
    
    return self;
}

- (id) initWithGroundHeight:(CGFloat)groundHeight{
    if (self = [super init])
    {
        self.height = groundHeight;
        self.nodeHeight = self.getTexture.size.height;
        self.nodeWidth = self.getTexture.size.width;
        [self makeObstacle];
        [self addChild:obstacle];
        
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

- (void) fireObstacle {
    //    [NSException raise:NSInternalInconsistencyException
    //                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    //[obstacle removeAllActions];
    SKAction *moveAction = [SKAction moveTo:CGPointMake(-1000, 0) duration: 8];
    SKAction *doneAction = [SKAction runBlock:(dispatch_block_t)^() {
        NSLog(@"Animation Completed");
        obstacle.hidden = YES;
    }];
    SKAction *moveDinosaurActionWithDone = [SKAction sequence:@[moveAction, doneAction ]];
    [obstacle runAction:moveDinosaurActionWithDone withKey:@"dinosaurMoving"];
}



- (void) setPhysicsAbilitiesOfObstacle
{
        [NSException raise:NSInternalInconsistencyException
                    format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    

}

- (SKTexture *)getTexture
{
        [NSException raise:NSInternalInconsistencyException
                    format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    return NULL;
}

@end
