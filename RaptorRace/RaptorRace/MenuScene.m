//
//  MenuScene.m
//  RaptorRace
//
//  Created by Henrik Bøhler on 13.03.14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import "MenuScene.h"
#import "MainGameScene.h"
#import "BRaptor.h"

@implementation MenuScene
-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        SKSpriteNode* sn = [SKSpriteNode spriteNodeWithImageNamed:@"bg1"];
        sn.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        sn.size = self.size;
        
        [self addChild:sn];
        [self addChild: [self newGameButton]];
        [self addChild:[self highscoreButton]];
        
        AnyObstacle *obstacle = [[GreenRaptorObstacle alloc] init];
        obstacle.position = CGPointMake(self.frame.size.width / 2, CGRectGetMidY(self.frame)*0.55);
        obstacle.physicsBody.dynamic = NO;
        [self addChild:obstacle];
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
    highscoreButton.position = CGPointMake(CGRectGetMidX(self.frame)+100,CGRectGetMidY(self.frame)+20);
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
//    if ([node.name isEqualToString:@"highscoreButton"]) {
//        NSLog(@"Highscore button pressed");
//        Highscore *highscore = [[Highscore alloc] initWithSize:self.size];
//        [self.view presentScene:highscore transition:[SKTransition doorsOpenHorizontalWithDuration:0.5]];
//    }

}

@end
