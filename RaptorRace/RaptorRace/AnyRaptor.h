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
@property (nonatomic, assign) BOOL undead;

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
 Apply force to the raptor
 @param force A vector containing the force in x and y direction to apply
*/
-(void)forceApplied:(CGVector)force;

/**
 Is the raptor allowed to jump, if so calculate force to apply
*/
-(void)jump;

/**
 Update status of raptor
*/
-(void)updateAllowedToJump;

/**
 Checks for collision and keeps track of collision count. Inits gameover
*/
 //-(void)didBeginContact:(SKPhysicsContact*)contact;

/**
 Raptor looses life and moves backwards on screen
*/
-(void)looseLife;

/**
 Raptor looses life, but does not move backwards on screen
*/

-(void)makeInvisible;

 
 /**
 Return current lives
 */
-(int)getLifes;


@end
