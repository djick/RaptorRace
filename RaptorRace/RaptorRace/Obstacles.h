//
//  Obstacles.h
//  RaptorRace
//
//  Created by Martin Solheim on 11/03/14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Obstacles : SKNode
@property SKSpriteNode *skeleton;
@property SKSpriteNode *dinosaur1;
@property SKSpriteNode *dinosaur2;


-(void)makeDinosaur1;
-(void)makeDinosaur2;
-(void)makeSkeleton;
-(void)generateSkeletons;
-(void)generateDinosaurs;
-(void)movingDinosaurs;
-(void)spawnObstacle;
-(void)addObstacles;

@end
