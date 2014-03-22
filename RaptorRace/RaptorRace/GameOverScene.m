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
        [self addChild: [self newGameButton]];
        [self addChild:[self highscoreButton]];
    }
    return self;
}

- (SKSpriteNode *)newGameButton
{
    SKSpriteNode *newGameButton = [SKSpriteNode spriteNodeWithImageNamed:@"ng"];
    newGameButton.size = CGSizeMake(175, 38);
    newGameButton.position = CGPointMake(CGRectGetMidX(self.frame)-100,CGRectGetMidY(self.frame)+20);
    newGameButton.name = @"newGameButton";
    return newGameButton;
    
}

- (SKSpriteNode *)highscoreButton
{
    SKSpriteNode *highscoreButton = [SKSpriteNode spriteNodeWithImageNamed:@"hs"];
    highscoreButton.size = CGSizeMake(175, 38);
    highscoreButton.position = CGPointMake(CGRectGetMidX(self.frame)+100,CGRectGetMidY(self.frame) +20);
    highscoreButton.name = @"highscoreButton";
    return highscoreButton;
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:@"newGameButton"]) {
        NSLog(@"New game button pressed");
        MainGameScene *game = [[MainGameScene alloc] initWithSize:self.size];
        [self.view presentScene:game transition:[SKTransition doorsOpenVerticalWithDuration:0.5]];
    }
}

@end
