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
}
+(ScoreSingleton* ) getInstance;
- (void) updateScore:(CGFloat) s;
- (CGFloat) getScore;

@end
