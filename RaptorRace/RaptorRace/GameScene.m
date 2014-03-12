//
//  GameScene.m
//  RaptorRace
//
//  Created by Martin Solheim on 11/03/14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import "GameScene.h"
#import "Raptor.h"
#import "Obstacles.h"
#import "Ground.h"

@implementation GameScene {
    CGFloat _displayedScore;
    NSTimer* timer;
    SKColor* _skyColor;
}


-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        
        //Physics of the world/scene
        //self.backgroundColor = [SKColor colorWithRed:0.1 green:0.5 blue:0.95 alpha:1.0];
        self.physicsWorld.contactDelegate = self;
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
        [self.physicsWorld setGravity:CGVectorMake(0, -1)];
        
        
        //Add char
        Raptor* raptor = [[Raptor alloc] init];
        raptor.position = CGPointMake(self.frame.size.width/2, self.frame.size.height-30);
        raptor.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(100, 100)];
        [raptor.physicsBody setAffectedByGravity:YES];
        //[raptor.physicsBody setFriction:0];
        [self addChild:raptor];
        
        //Add rock
        Obstacles* rock = [[Obstacles alloc] init];
        [self addChild:rock];
        
        //Add score label
        _scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Courier-Bold"];
        _scoreLabel.fontSize = 10;
        _scoreLabel.position = CGPointMake(CGRectGetWidth(self.frame)-(CGRectGetMidX(self.frame)/5), CGRectGetMidY(self.frame));
        _scoreLabel.fontColor = [SKColor colorWithRed:251.0/255.0 green:127.0/255.0 blue:108.0/255.0 alpha:1.0];
        _scoreLabel.text = @"000";
        
        [self addChild:_scoreLabel];

        //Start timer
        timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(countUp) userInfo:nil repeats:YES];
        
    }
    
    return self;
}

//Increase score
- (void)countUp {
    self.score += 5;
}

- (void)update:(NSTimeInterval)currentTime {
    //If not the current score is shown
    if(self.score != _displayedScore) {
        self.scoreLabel.text = [NSString stringWithFormat:@"%05.0f", self.score];
        _displayedScore = self.score;
    }
}


@end
