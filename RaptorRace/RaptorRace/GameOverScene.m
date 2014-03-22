//
//  GameOverScene.m
//  RaptorRace
//
//  Created by Henrik Bøhler on 17.03.14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import "GameOverScene.h"
#import "MainGameScene.h"

@implementation GameOverScene

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        SKSpriteNode* sn = [SKSpriteNode spriteNodeWithImageNamed:@"go"];
        sn.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        sn.size = self.size;
        
        [self addChild:sn];
        [self addChild: [self onePlayerButton]];
        [self addChild: [self twoPlayerButton]];
        [self addChild:[self highscoreButton]];
    }
    return self;
}

- (SKSpriteNode *)onePlayerButton
{
    SKSpriteNode *onePlayerButton = [SKSpriteNode spriteNodeWithImageNamed:@"1p"];
    onePlayerButton.size = CGSizeMake(175, 38);
    onePlayerButton.position = CGPointMake(CGRectGetMidX(self.frame)-70,CGRectGetMidY(self.frame)+30);
    onePlayerButton.name = @"onePlayerButton";
    onePlayerButton.xScale*=0.8;
    onePlayerButton.yScale*=0.8;
    return onePlayerButton;
    
}

- (SKSpriteNode *)twoPlayerButton
{
    SKSpriteNode *twoPlayerButton = [SKSpriteNode spriteNodeWithImageNamed:@"2p"];
    twoPlayerButton.size = CGSizeMake(175, 38);
    twoPlayerButton.position = CGPointMake(CGRectGetMidX(self.frame)+70,CGRectGetMidY(self.frame)+30);
    twoPlayerButton.name = @"twoPlayerButton";
    twoPlayerButton.xScale*=0.8;
    twoPlayerButton.yScale*=0.8;
    return twoPlayerButton;
    
}

- (SKSpriteNode *)highscoreButton
{
    SKSpriteNode *highscoreButton = [SKSpriteNode spriteNodeWithImageNamed:@"hs1"];
    highscoreButton.size = CGSizeMake(175, 38);
    highscoreButton.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame)-10);
    highscoreButton.name = @"highscoreButton";
    highscoreButton.xScale*=0.8;
    highscoreButton.yScale*=0.8;
    return highscoreButton;
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:@"onePlayerButton"]) {
        NSLog(@"One player button pressed");
        MainGameScene *game = [[MainGameScene alloc] initWithSize:self.size];
        [self.view presentScene:game transition:[SKTransition doorsOpenVerticalWithDuration:0.5]];
    }
    if ([node.name isEqualToString:@"twoPlayerButton"]) {
        NSLog(@"Two player button pressed");
        MainGameScene *game = [[MainGameScene alloc] initWithSize:self.size];
        [self.view presentScene:game transition:[SKTransition doorsOpenVerticalWithDuration:0.5]];
    }
}

@end
