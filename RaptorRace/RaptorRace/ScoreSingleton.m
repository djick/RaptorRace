//
//  ScoreSingleton.m
//  RaptorRace
//
//  Created by Nemanja Aksic on 3/17/14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import "ScoreSingleton.h"

@implementation ScoreSingleton
static ScoreSingleton *_sharedInstance = nil;

+(ScoreSingleton* ) getInstance{
    //Setup CGD
    static dispatch_once_t oncePred;
    
    //Run dispatch once
    dispatch_once(&oncePred, ^{
        _sharedInstance = [[ScoreSingleton alloc] init];
        [_sharedInstance firstRun];
    });
    
    return _sharedInstance;
}

-(void) firstRun{
    [self setFontName:@"Courier-Bold"];
    self.fontSize = 20;
    self.fontColor = [SKColor colorWithRed:251.0/255.0 green:127.0/255.0 blue:108.0/255.0 alpha:1.0];
    self.text = @"000";
    
    //self.position = CGPointMake(CGRectGetWidth(self.frame)-(CGRectGetMidX(self.frame)/5), CGRectGetHeight(self.frame)- (CGRectGetMidY(self.frame)/4));
}

- (void) updateScore:(CGFloat) s{
    score += s;
    self.text = [NSString stringWithFormat:@"%05.0f", score];
}

- (CGFloat) getScore{
    return score;
}

@end
