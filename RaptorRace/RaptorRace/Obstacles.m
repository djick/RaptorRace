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

        [self makeRock];
        [self makeSkeleton];
    }
    return self;
}


-(void)makeRock {
    _dinosaur2= [SKSpriteNode spriteNodeWithImageNamed:@"rock.png"];
    _dinosaur2.size=CGSizeMake(40, 40);
    _dinosaur2.position = CGPointMake(200, 300);
    _dinosaur2.physicsBody=[SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(40,40)];
    _dinosaur2.physicsBody.affectedByGravity=NO;
    _dinosaur2.physicsBody.mass=50000;
    _dinosaur2.physicsBody.allowsRotation=NO;
    _dinosaur2.physicsBody.dynamic=NO; //Making dem obstacles static
    _dinosaur2.xScale = 1;
    _dinosaur2.yScale = 1;
    [self addChild:_dinosaur2];

}

-(void)makeSkeleton {
    _skeleton= [SKSpriteNode spriteNodeWithImageNamed:@"skeleton1.png"];
    _skeleton.size=CGSizeMake(40, 40);
    _skeleton.position = CGPointMake(100, 300);
    _skeleton.physicsBody=[SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(40,40)];
    _skeleton.physicsBody.affectedByGravity=NO;
    _skeleton.physicsBody.mass=50000;
    _skeleton.physicsBody.allowsRotation=NO;
    _skeleton.physicsBody.dynamic=NO; //Making dem obstacles static
    _skeleton.xScale = 2;
    _skeleton.yScale = 2;
    [self addChild:_skeleton];

}
@end
