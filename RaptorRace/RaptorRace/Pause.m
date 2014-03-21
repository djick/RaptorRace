//
//  Pause.m
//  RaptorRace
//
//  Created by Nemanja Aksic on 3/17/14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import "Pause.h"

@implementation Pause
-(instancetype)initWithImageNamed:(NSString *)name{
    self = [super initWithImageNamed:name];
    self.userInteractionEnabled = YES;
    self.isPaused = NO;
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"INSIDE PAUSE");
    if(self.scene.paused){
        //self.view.scene.paused = NO;
        self.isPaused = NO;
        self.scene.paused = NO;
        self.parent.scene.paused = NO;
        [self setTexture:[SKTexture textureWithImageNamed:@"PauseButton"]];
        [[ScoreSingleton getInstance] resumeTimer];
    }
    else{
        self.isPaused = YES;
        self.scene.paused = YES;
        self.parent.scene.paused = YES;
        [self setTexture:[SKTexture textureWithImageNamed:@"PlayButton"]];
        [[ScoreSingleton getInstance] pauseTimer];
    }
}

@end
