//
//  AnyRaptor.h
//  RaptorRace
//
//  Created by Martin Solheim on 11/03/14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface AnyRaptor : SKNode

@property SKSpriteNode* raptor;

/**
 Runs all the methods needed to make a new raptor.
 
 @param name    A string with the name of the atlas file that should be used when setting up the animation.
 @param format  A string with the formating of the images in the atlas to be used when setting up the animation.
 */
- (void) makeRaptorWithAtlasNamed:(NSString *)name
                  AndStringFormat:(NSString *)format;

// Steps to set up a raptor
/**
 Sets up an animation and adds it to the raptor SpriteNode.
 
 @param name    A string with the name of the atlas file that should be used.
 @param format  A string with the formating of the images in the atlas.
 */
- (void) setUpAnimationWithAtlasNamed:(NSString *)name
                      AndStringFormat:(NSString *)format;

/**
 Sets the physicsBody properties for the raptor.
 */
- (void) setUpRaptorPhysicsBody;
@end
