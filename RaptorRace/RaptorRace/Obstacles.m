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
    _rock= [SKSpriteNode spriteNodeWithImageNamed:@"rock.png"];
    _rock.size=CGSizeMake(40, 40);
    _rock.position = CGPointMake(200, 300);
    _rock.physicsBody=[SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(40,40)];
    _rock.physicsBody.affectedByGravity=NO;
    _rock.physicsBody.mass=50000;
    _rock.physicsBody.allowsRotation=NO;
    _rock.physicsBody.dynamic=NO; //Making dem obstacles static
    _rock.xScale = 1;
    _rock.yScale = 1;
    [self addChild:_rock];

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
