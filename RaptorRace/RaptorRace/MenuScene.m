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
-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        SKSpriteNode* sn = [SKSpriteNode spriteNodeWithImageNamed:@"raptorracebg"];
        sn.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        sn.size = self.size;
        
        [self addChild:sn];
        [self addChild: [self fireButtonNode]];
    }
    return self;
}

- (SKSpriteNode *)fireButtonNode
{
    SKSpriteNode *fireNode = [SKSpriteNode spriteNodeWithImageNamed:@"newgame"];
    fireNode.size = CGSizeMake(175, 38);
    fireNode.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
    fireNode.name = @"fireButtonNode";
    return fireNode;
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];

    if ([node.name isEqualToString:@"fireButtonNode"]) {
        NSLog(@"New game pressed");
        GameScene *game = [[GameScene alloc] initWithSize:self.size];
        [self.view presentScene:game transition:[SKTransition doorsOpenHorizontalWithDuration:0.5]];
    }
}

@end
