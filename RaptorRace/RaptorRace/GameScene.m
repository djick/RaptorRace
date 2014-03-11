//
//  GameScene.m
//  RaptorRace
//
//  Created by Martin Solheim on 11/03/14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import "GameScene.h"
#import "Raptor.h"

@implementation GameScene


-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        
        //Physics of the world/scene
        self.backgroundColor = [SKColor colorWithRed:0.1 green:0.5 blue:0.95 alpha:1.0];
        self.physicsWorld.contactDelegate = self;
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
        [self.physicsWorld setGravity:CGVectorMake(0, -9.81)];
        
        
        //Add char
        Raptor* raptor = [[Raptor alloc] init];
        raptor.position = CGPointMake(self.frame.size.width/2, self.frame.size.height-30);
        raptor.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(100, 100)];
        [raptor.physicsBody setAffectedByGravity:YES];
        //[raptor.physicsBody setFriction:0];
        [self addChild:raptor];
        
        
        
        
    }
    
    return self;
}


@end
