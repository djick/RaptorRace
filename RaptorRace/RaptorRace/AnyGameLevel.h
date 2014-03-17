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
 
 @param name The name of the image to be used as background.
 */
- (void) createBackgroundWithImageNamed:(NSString *)name
                     AndBackgroundColor:(SKColor *)color;

/**
 Adds clouds to the scene.
 
 @param name The name of the image to be used as cloud.
 */
- (void) addCloudsWithImageNamed:(NSString *)name;

/**
 Adds the scorecounter to the scene (or should this be somewhere else?)
 */
- (void) addScoreCounterWithColor:(SKColor *)color;

/**
 Creats the ground for the scene.
 
 @param name The name of the atlas that should be used for animating the ground.
 @param format The format of the picture names for the pictures in the specified atlas.
 */
- (void) createGroundWithAtlasNamed:(NSString *)name
                          AndFormat:(NSString *)format;
/**
 Adds obstacles to the scene.
 */
- (void) addObstacles;

/**
 Adds a raptor to the scene.
 */
- (void) addRaptor;

/**
 Gets the name of the atlas that should be used for the animation of the sprite.
 
 @return Retruns a string with the name of the atlas that should be used for animation.
 */
- (NSString *) getGroundAtlasName;

/**
 Gets the formate of the names of the pictures in the atlas.
 
 @return Returns the name format of the pictures in the atas.
 */
- (NSString* ) getGroundPictureNameFormat;

/**
 Gets the name of the picture that should be used for the animation of the sprite.
 
 @return Retruns a string with the name of the picture that should be used as background.
 */
- (NSString *) getBackgroundPictureName;

/**
Gets the name of the picture that should be used for the clouds.

@return Retruns a string with the name of the picture that should be used for the clouds.
*/
- (NSString *) getCloudPictureName;

/**
 Gets the color that should be used as background color.
 
 @return The color.
 */
- (SKColor *) getBackgroundColor;

@end
