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
}

- (void) updateScore:(CGFloat) s{
    score += s;
    self.text = [NSString stringWithFormat:@"%05.0f", score];
}

- (CGFloat) getScore{
    return score;
}
- (void)countUp {
    //self.score += 5;
    [[ScoreSingleton getInstance] updateScore:5.0];
}

- (void) customSingletonWithColor:(SKColor *)color
                      AndFontName:(NSString *)fontName
{
    self.fontColor = color;
    self.fontName = fontName;
}

- (void) startTimer{
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(countUp) userInfo:nil repeats:YES];
}

- (void) pauseTimer{
    pauseStart = [NSDate dateWithTimeIntervalSinceNow:0];
    
    previousFireStart = [timer fireDate];
    
    [timer setFireDate:[NSDate distantFuture]];
}

- (void) resumeTimer{
    float pauseTime = -1*[pauseStart timeIntervalSinceNow];
    
    [timer setFireDate:[previousFireStart initWithTimeInterval:pauseTime sinceDate:previousFireStart]];
}

@end
