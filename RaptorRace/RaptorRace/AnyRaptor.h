//
//  AnyRaptor.h
//  RaptorRace
//
//  Created by Martin Solheim on 12/03/14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface AnyRaptor : SKSpriteNode
@property (nonatomic, assign) BOOL allowedToJump;
@property (nonatomic, assign) BOOL inAir;

/**
 This methd runs all of the defined methods for an object of class AnyRaptor, creating the raptor.
 */
- (void) makeRaptor;

// Steps to make a raptor

/**
 Gets the name of the atlas that should be used for the animation of the sprite.
 
 @return Retruns a string with the name of the atlas that should be used for animation.
 */
- (NSString *) getAtlasName;

/**
 Gets the formate of the names of the pictures in the atlas.
 
 @return Returns the name format of the pictures in the atas.
 */
- (NSString* ) getPictureNameFormat;

/**
 Fixes the setup of the animation of the sprite with the given atlas and name formating.
 
 @param name A string with the name of the altas to use.
 @param format A string with the format of the name of the pictures in the atlas folder.
 */
- (void) setRaptorAnimationWithAtlasNamed:(NSString *)name
                     AndPictureNAmeFormat:(NSString *)format;

/**
 Sets the physical abilities of the raptor.
 */
- (void) setPhysicalAbilitiesOfRaptor;

/**
 Adds the running animation to the raptor.
 */
-(void)runningRaptor;

/**
 Applys a force to the raptor sprite to make it "jump".
 */
- (void) applyForce;

@end
