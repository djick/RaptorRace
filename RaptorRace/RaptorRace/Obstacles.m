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
        _dinosaur1= [SKSpriteNode spriteNodeWithImageNamed:@"rock.png"];
        _dinosaur1.size=CGSizeMake(40, 40);
        _dinosaur1.position = CGPointMake(200, 40);
        _dinosaur1.physicsBody=[SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(40,40)];
        _dinosaur1.physicsBody.affectedByGravity=NO;
        _dinosaur1.physicsBody.mass=50000;
        _dinosaur1.physicsBody.allowsRotation=NO;
        _dinosaur1.physicsBody.dynamic=NO; //Making dem obstacles static
        [self addChild:_dinosaur1];

    }
    
    return self;
}


@end
