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
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"INSIDE PAUSE");
    if(self.scene.paused){
        //self.view.scene.paused = NO;
        self.scene.paused = NO;

    }
    else{
        self.scene.paused = YES;
    }
}

@end
