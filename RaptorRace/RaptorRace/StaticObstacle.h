//
//  StaticObstacle.h
//  RaptorRace
//
//  Created by Martin Solheim on 17/03/14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import "AnyObstacle.h"
#import "Categories.h"

@interface StaticObstacle : AnyObstacle

- (void) setPhysicsAbilitiesOfObstacle;

- (SKTexture *) getTexture;

/**
 Creates a texture based on a given image.
 
 @param name The name of the picture that should be used as texture.
 */
- (SKTexture *) createTextureWithImageNamed:(NSString *)name;

@end
