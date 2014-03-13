//
//  MenuScene.m
//  RaptorRace
//
//  Created by Henrik Bøhler on 13.03.14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import "MenuScene.h"
#import "GameScene.h"

@implementation MenuScene
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        SKSpriteNode* sn = [SKSpriteNode spriteNodeWithImageNamed:@"mainMenyBG"];
        sn.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        sn.size = self.size;
        
        [self addChild:sn];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // Create and configure the scene.
    SKScene* scene = [[GameScene alloc] initWithSize:self.size];
    SKTransition* transititon = [SKTransition doorsOpenVerticalWithDuration:0.5];
    [self.view presentScene:scene transition:transititon];
}

@end
