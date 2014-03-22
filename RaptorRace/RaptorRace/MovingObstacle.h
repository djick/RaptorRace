//
//  MovingObstacle.h
//  RaptorRace
//
//  Created by Martin Solheim on 17/03/14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import "AnyObstacle.h"
#import "Categories.h"

@interface MovingObstacle : AnyObstacle

- (void) setPhysicsAbilitiesOfObstacle;

- (SKTexture *) getTexture;

/**
 Creates the animation texture that should be returned by getTexture.
 
 @param name The name of the atlas to be used for the animation.
 @param format The format of the names of the pictures in the animation atlas.
 */
- (SKTexture *) createAnimationTextureWithAtlasNamed:(NSString *)name
                               AndPictureNameFormat:(NSString *)format;

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

- (void) animateObstacle;

@end
