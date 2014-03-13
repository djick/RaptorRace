//
//  Obstacles.m
//  RaptorRace
//
//  Created by Martin Solheim on 11/03/14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import "Obstacles.h"
#import "Ground.h"
#include <stdlib.h>

@implementation Obstacles
//Categorybitmasks legges i gameview til slutt


-(id)init {
    if (self = [super init]) {
        [self generateDinosaurs];
    }
    
    return self;
}


-(void)makeDinosaur1 {
    _dinosaur1= [SKSpriteNode spriteNodeWithImageNamed:@"dinosaur1"];
    _dinosaur1.size=CGSizeMake(70, 50);
    //_dinosaur1.position = CGPointMake(100, 100);
    _dinosaur1.physicsBody=[SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(40,40)];
    _dinosaur1.position = CGPointMake(100, 100);
    _dinosaur1.physicsBody.affectedByGravity=NO;
    _dinosaur1.physicsBody.mass=1;
    _dinosaur1.physicsBody.allowsRotation=NO;
    _dinosaur1.physicsBody.dynamic = NO;
    _dinosaur1.xScale = 1;
    _dinosaur1.yScale = 1;
    [self addChild:_dinosaur1];
    
}

-(void)makeDinosaur2 {
    _dinosaur2= [SKSpriteNode spriteNodeWithImageNamed:@"dinosaur2"];
    _dinosaur2.size=CGSizeMake(70, 50);
    //_dinosaur2.position = CGPointMake(200, 100);
    _dinosaur2.physicsBody=[SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(70,50)];
    _dinosaur2.physicsBody.affectedByGravity=NO;
    _dinosaur2.physicsBody.mass=100;
    _dinosaur2.physicsBody.allowsRotation=NO;
    _dinosaur2.physicsBody.dynamic = YES;
    _dinosaur2.xScale = 1;
    _dinosaur2.yScale = 1;
    [self addChild:_dinosaur2];
}

-(void)makeSkeleton {
    _skeleton= [SKSpriteNode spriteNodeWithImageNamed:@"newestSkeleton1"];
    _skeleton.size=CGSizeMake(45, 35);
    //_skeleton.position = CGPointMake(300, 110);
    _skeleton.physicsBody=[SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(50,40)];
    _skeleton.physicsBody.affectedByGravity=NO;
    _skeleton.physicsBody.mass=50000;
    _skeleton.physicsBody.allowsRotation=NO;
    _skeleton.physicsBody.dynamic=NO; //Making dem obstacles static
    _skeleton.xScale = 2;
    _skeleton.yScale = 2;
    [self addChild:_skeleton];
    
}

// Generating skeletons that stand still, will slow the player down if it bumps into it
-(void)generateSkeletons {
    int obstacleinterval=2;
    for (int i=0; i<obstacleinterval; i++){
        [self makeSkeleton];
        if (i==0) {
            _skeleton.position=CGPointMake(200, 97);
        }
        else{
            _skeleton.position=CGPointMake(270, 97);
        }
    }
    
}

- (float)randomValueBetween:(float)low andValue:(float)high {
    return (((float) arc4random() / 0xFFFFFFFFu) * (high - low)) + low;
}

// Generating dinosaurs that go left, will slow the player down if they bump into each other,
-(void)generateDinosaurs {
    int obstacleinterval=2;
    for (int i=0; i<obstacleinterval; i++){
        [self makeDinosaur1];
        if (i==0) {
            [self movingDinosaurs];
        }
        else{
            [self movingDinosaurs];
        }
    }
    
}

-(void)movingDinosaurs {
    float randDuration = [self randomValueBetween:2.0 andValue:6.0];
    CGFloat height = 97;
    _dinosaur1.position = CGPointMake(500, height);
    _dinosaur1.hidden = NO;
    CGPoint location = CGPointMake(-self.frame.size.width-_dinosaur1.size.width, height);
    SKAction *moveAction = [SKAction moveTo:location duration:randDuration];
    SKAction *doneAction = [SKAction runBlock:(dispatch_block_t)^() {
        NSLog(@"Animation Completed");
        _dinosaur1.hidden = YES;
    }];
    SKAction *moveDinosaurActionWithDone = [SKAction sequence:@[moveAction, doneAction ]];
    [_dinosaur1 runAction:moveDinosaurActionWithDone withKey:@"dinosaurMoving"];
 
}

@end
