//
//  AnyGameLevel.h
//  RaptorRace
//
//  Created by Martin Solheim on 16/03/14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "AnyObstacle.h"

#import "ScoreSingleton.h"
#import "Categories.h"
#import "AnyRaptor.h"
#import "BRaptor.h"
#import "RedRaptorObstacle.h"
#import "GreenRaptorObstacle.h"
#import "StoneObstacle.h"
#import "Pause.h"

@interface AnyGameLevel : SKScene <SKPhysicsContactDelegate>{
    // An array of frames used for the ground animation
    NSArray *groundMovingFrames;
    NSTimeInterval nextDinosaurSpawn;
    int collisions;
    //int livesGiven;
    CGFloat collisionHappenedAt;
    bool didGetLife;
    SKSpriteNode *ground;
    SKSpriteNode *background;
    NSMutableArray *obstacleList;
    AnyObstacle *obstacle;
    AnyObstacle *stoneObstacle;
    AnyRaptor *raptor;
    Pause* pausebtn;
    NSTimeInterval pausedAtTime;
    
    ScoreSingleton * scoreLabel;
    SKLabelNode * highscore;
    SKLabelNode* lifeLabel;
    
    NSTimer* timer;
}

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
- (void) addScoreCounterWithColor:(SKColor *)color
                     AndFontNamed:(NSString *)fontName;

/**
 Adds the life label to scene
 */
- (void) addLifeCounterWithColor:(UIColor *)color
                    AndFontNamed:(NSString *)fontName;

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
 Sets the physicks for the game world.
 */

- (void) setGamePhysics;
/**
 Gets the name of the atlas that should be used for the animation of the sprite.
 
 @return Retruns a string with the name of the atlas that should be used for animation.
 */
- (NSString *) getGroundAtlasName;

/**
 Gets the vector of gravity used for the physics engine
 @return Returns a vector which represents the gravity applied to the objects
 */
- (CGVector) getGravityVector;
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
 
 @return The color thet should be used.
 */
- (SKColor *) getBackgroundColor;

/**
 Gets the color that should be used as the color for the score counter color.
 
  @return The color thet should be used.
 */
- (SKColor *) getScoreCounterColor;

/**
 Gets the name of font thet should be used for the score counter.
 
 @return Retruns a string with the name of the font to be used.
 */
- (NSString *) getScoreCounterFontName;

/**
 Gets the image name of the pause button
 
 @return Returns string with image name of pause button to be used
 */
-(NSString*) getPauseButton;

/**
 Gets the time of last collision
 */



@end
