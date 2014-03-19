//
//  MovingObstacle.h
//  RaptorRace
//
//  Created by Martin Solheim on 17/03/14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import "AnyObstacle.h"

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
 Makes the action that moves the obstacle over the screen.
 */
- (SKAction *) makeMovmentAction;


@end
