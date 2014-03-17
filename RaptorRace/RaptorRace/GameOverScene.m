//
//  GameOverScene.m
//  RaptorRace
//
//  Created by Henrik Bøhler on 17.03.14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import "GameOverScene.h"
#import "GameScene.h"

@implementation GameOverScene

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        SKSpriteNode* sn = [SKSpriteNode spriteNodeWithImageNamed:@"RRbg"];
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
    SKSpriteNode *newGameButton = [SKSpriteNode spriteNodeWithImageNamed:@"newgame"];
    newGameButton.size = CGSizeMake(175, 38);
    newGameButton.position = CGPointMake(CGRectGetMidX(self.frame)-100,CGRectGetMidY(self.frame));
    newGameButton.name = @"newGameButton";
    return newGameButton;
    
}

- (SKSpriteNode *)highscoreButton
{
    SKSpriteNode *highscoreButton = [SKSpriteNode spriteNodeWithImageNamed:@"highscore"];
    highscoreButton.size = CGSizeMake(175, 38);
    highscoreButton.position = CGPointMake(CGRectGetMidX(self.frame)+100,CGRectGetMidY(self.frame));
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
        GameScene *game = [[GameScene alloc] initWithSize:self.size];
        [self.view presentScene:game transition:[SKTransition doorsOpenHorizontalWithDuration:0.5]];
    }
}

@end
