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


-(id)init {                             //Prøvde aa faa til noe her, men de vil ikke bevege seg.
    int obstacleinterval=2;
    if (self = [super init]) {
        for (int i=0; i<obstacleinterval; i++){
            [self makeDinosaur1];
            //[self makeDinosaur2];
            //[self makeSkeleton];
            if (i==0) {
                _dinosaur1.position=CGPointMake(400, 100);
                [_dinosaur1.physicsBody applyForce:(CGVectorMake(500, 100))];
            }
            else{
                _dinosaur1.position=CGPointMake(500, 100);
                [_dinosaur1.physicsBody applyForce:(CGVectorMake(500, 100))]; //FAENDA! APPLY FORCE DIN JAEVEL
            }
        }
    }
    
    return self;
}

/*
  */

-(void)makeDinosaur1 {
    _dinosaur1= [SKSpriteNode spriteNodeWithImageNamed:@"dinosaur1"];
    _dinosaur1.size=CGSizeMake(70, 50);
    _dinosaur1.position = CGPointMake(100, 100);
    _dinosaur1.physicsBody=[SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(70,50)];
    _dinosaur1.physicsBody.affectedByGravity=NO;
    _dinosaur1.physicsBody.mass=50;
    _dinosaur1.physicsBody.allowsRotation=NO;
    _dinosaur1.physicsBody.dynamic=NO;
    _dinosaur1.xScale = 1;
    _dinosaur1.yScale = 1;
    [self addChild:_dinosaur1];
    
}

-(void)makeDinosaur2 {
    _dinosaur2= [SKSpriteNode spriteNodeWithImageNamed:@"dinosaur2"];
    _dinosaur2.size=CGSizeMake(70, 50);
    _dinosaur2.position = CGPointMake(200, 100);
    _dinosaur2.physicsBody=[SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(70,50)];
    _dinosaur2.physicsBody.affectedByGravity=NO;
    _dinosaur2.physicsBody.mass=50000;
    _dinosaur2.physicsBody.allowsRotation=NO;
    _dinosaur2.physicsBody.dynamic=NO; //Making dem obstacles static
    _dinosaur2.xScale = 1;
    _dinosaur2.yScale = 1;
    [self addChild:_dinosaur2];
    
}

-(void)makeSkeleton {
    _skeleton= [SKSpriteNode spriteNodeWithImageNamed:@"skeletonpixel1.png"];
    _skeleton.size=CGSizeMake(45, 35);
    _skeleton.position = CGPointMake(300, 110);
    _skeleton.physicsBody=[SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(50,40)];
    _skeleton.physicsBody.affectedByGravity=NO;
    _skeleton.physicsBody.mass=50000;
    _skeleton.physicsBody.allowsRotation=NO;
    _skeleton.physicsBody.dynamic=NO; //Making dem obstacles static
    _skeleton.xScale = 2;
    _skeleton.yScale = 2;
    [self addChild:_skeleton];
    
}


@end
