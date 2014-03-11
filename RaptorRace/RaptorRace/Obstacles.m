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
        _rock= [SKSpriteNode spriteNodeWithImageNamed:@"rock.png"];
        _rock.size=CGSizeMake(40, 40);
        _rock.position = CGPointMake(200, 40);
        _rock.physicsBody=[SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(40,40)];
        _rock.physicsBody.affectedByGravity=NO;
        _rock.physicsBody.mass=50000;
        _rock.physicsBody.allowsRotation=NO;
        _rock.physicsBody.dynamic=NO; //Making dem obstacles static
        [self addChild:_rock];

    }
    
    return self;
}


@end
