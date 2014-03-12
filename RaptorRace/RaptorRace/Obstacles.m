//
//  Obstacles.m
//  RaptorRace
//
//  Created by Martin Solheim on 11/03/14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import "Obstacles.h"
#include <stdlib.h>

@implementation Obstacles
//Categorybitmasks legges i gameview til slutt

-(id)init {
    if (self = [super init]) {
        
        [self makeDinosaur1];
        [self makeDinosaur2];
        [self makeSkeleton];
    }
    return self;
}

-(void)makeDinosaur1 {
    _dinosaur1= [SKSpriteNode spriteNodeWithImageNamed:@"obstacle1"];
    _dinosaur1.size=CGSizeMake(70, 50);
    _dinosaur1.position = CGPointMake(100, 100);
    _dinosaur1.physicsBody=[SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(40,40)];
    _dinosaur1.physicsBody.affectedByGravity=NO;
    _dinosaur1.physicsBody.mass=50000;
    _dinosaur1.physicsBody.allowsRotation=NO;
    _dinosaur1.physicsBody.dynamic=NO; //Making dem obstacles static
    [_dinosaur1.physicsBody setCollisionBitMask:0];
    _dinosaur1.xScale = 1;
    _dinosaur1.yScale = 1;
    [self addChild:_dinosaur1];
    
}


-(void)makeDinosaur2 {
    _dinosaur2= [SKSpriteNode spriteNodeWithImageNamed:@"obstacle2"];
    _dinosaur2.size=CGSizeMake(70, 50);
    _dinosaur2.position = CGPointMake(200, 100);
    _dinosaur2.physicsBody=[SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(40,40)];
    _dinosaur2.physicsBody.affectedByGravity=NO;
    _dinosaur2.physicsBody.mass=50000;
    _dinosaur2.physicsBody.allowsRotation=NO;
    _dinosaur2.physicsBody.dynamic=NO; //Making dem obstacles static
    [_dinosaur2.physicsBody setCollisionBitMask:0];
    _dinosaur2.xScale = 1;
    _dinosaur2.yScale = 1;
    [self addChild:_dinosaur2];
    
}

-(void)makeSkeleton {
    _skeleton= [SKSpriteNode spriteNodeWithImageNamed:@"skeletonpixel1.png"];
    _skeleton.size=CGSizeMake(50, 40);
    _skeleton.position = CGPointMake(300, 110);
    _skeleton.physicsBody=[SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(40,40)];
    _skeleton.physicsBody.affectedByGravity=NO;
    _skeleton.physicsBody.mass=50000;
    _skeleton.physicsBody.allowsRotation=NO;
    _skeleton.physicsBody.dynamic=NO; //Making dem obstacles static
    [_skeleton.physicsBody setCollisionBitMask:0];
    _skeleton.xScale = 2;
    _skeleton.yScale = 2;
    [self addChild:_skeleton];
    
}
@end
