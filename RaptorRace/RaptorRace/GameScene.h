//
//  GameScene.h
//  RaptorRace
//
//  Created by Martin Solheim on 11/03/14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "AnyObstacle.h"

@interface GameScene : SKScene <SKPhysicsContactDelegate> 
@property(nonatomic,readonly) SKLabelNode *scoreLabel;
//@property(nonatomic) CGFloat score;
@property (nonatomic) AnyObstacle* obs;
@end
