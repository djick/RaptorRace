//
//  MenuScene.h
//  RaptorRace
//
//  Created by Henrik Bøhler on 13.03.14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MenuScene : SKScene

- (SKSpriteNode *)onePlayerButton;
- (SKSpriteNode *)twoPlayerButton;
- (SKSpriteNode *)highscoreButton;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
@end
