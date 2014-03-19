//
//  AnyObstacle.h
//  RaptorRace
//
//  Created by Martin Solheim on 17/03/14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface AnyObstacle : SKSpriteNode
/**
 Initiate obstacle with the height of ground level
 **/
- (id) initWithGroundHeight:(CGFloat)groundHeight;

/**
 Makes the obstacle using the template methods.
 */
- (void) makeObstacle;

/**
 Adds a texture to the obstacle. This can be an animation or a picture.
 
 @param texture The texture thet should be added to the obstacle.
 */
- (void) addTexture:(SKTexture *)texture;

/**
 Sets the physical abilities of the obstacle to standard values.
 */
- (void) setPhysicsAbilitiesOfObstacle;

/**
 Gets the texture that should be used on the obstacle.
 */
- (SKTexture *)getTexture;

/**
 Fires the obstacles towards the player
 **/
- (void) fireObstacle;
@end
