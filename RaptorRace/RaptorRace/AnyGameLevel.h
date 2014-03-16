//
//  AnyGameLevel.h
//  RaptorRace
//
//  Created by Martin Solheim on 16/03/14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface AnyGameLevel : SKScene

/**
 Makes the gamelevel with the defined game level methods.
 */
- (void) makeGameLevel;

/**
 Creates the background for the scene.
 */
- (void) createBackground;

/**
 Adds the scorecounter to the scene (or should this be somewhere else?
 */
- (void) addScoreCounter;

/**
 Creats the ground for the scene.
 */
- (void) createGround;

/**
 Adds obstacles to the scene.
 */
- (void) addObstacles;

/**
 Adds a raptor to the scene.
 */
- (void) addRaptor;
 

@end
