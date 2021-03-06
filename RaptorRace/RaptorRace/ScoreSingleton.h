//
//  ScoreSingleton.h
//  RaptorRace
//
//  Created by Nemanja Aksic on 3/17/14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ScoreSingleton : SKLabelNode{
    CGFloat score;
    NSTimer* timer;
    NSDate* pauseStart;
    NSDate* previousFireStart;
}
+(ScoreSingleton* ) getInstance;
- (void) updateScore:(CGFloat) s;
- (CGFloat) getScore;
- (void) startTimer;
- (void) resumeTimer;
- (void) pauseTimer;
- (void) stopTimer;


/**
 Customises the score counter.
 
 @param color The custom color for the score counter.
 @param fontName The name of the font to use on the score counter.
 */
- (void) customSingletonWithColor:(SKColor *)color
                      AndFontName:(NSString *)fontName;

@end
