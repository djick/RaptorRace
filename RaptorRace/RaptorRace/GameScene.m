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
#import "Categories.h"



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
        
        //Set up background
        _skyColor = [SKColor colorWithRed:113.0/255.0 green:197.0/255.0 blue:207.0/255.0 alpha:1.0];
        [self setBackgroundColor:_skyColor];
        
        //Landscape
        SKTexture* skylineTexture = [SKTexture textureWithImageNamed:@"landscape"];
        skylineTexture.filteringMode = SKTextureFilteringNearest;
        
        SKAction* moveSkylineSprite = [SKAction moveByX:-skylineTexture.size.width*2 y:0 duration:0.1 * skylineTexture.size.width*2];
        SKAction* resetSkylineSprite = [SKAction moveByX:skylineTexture.size.width*2 y:0 duration:0];
        SKAction* moveSkylineSpritesForever = [SKAction repeatActionForever:[SKAction sequence:@[moveSkylineSprite, resetSkylineSprite]]];
        
        
        for( int i = 0; i < 2 + self.frame.size.width / ( skylineTexture.size.width * 2 ); ++i ) {
            SKSpriteNode* sprite = [SKSpriteNode spriteNodeWithTexture:skylineTexture];
            [sprite setScale:2.0];
            sprite.zPosition = -20;
            sprite.position = CGPointMake(i * sprite.size.width, sprite.size.height / 2 + 25 * 2);
            [sprite runAction:moveSkylineSpritesForever];
            [self addChild:sprite];
        }
        
        
        //Add char
        Raptor* raptor = [[Raptor alloc] init];
        raptor.position = CGPointMake(self.frame.size.width/2, self.frame.size.height-30);
        raptor.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(100, 100)];
        //[raptor.physicsBody setAffectedByGravity:YES];
        [raptor.physicsBody setAllowsRotation:NO];
        [raptor.physicsBody setCategoryBitMask:dinoCategory];
        [raptor.physicsBody setContactTestBitMask:worldCategory];
        [raptor.physicsBody setCollisionBitMask:0];
        //[raptor.physicsBody setFriction:0];
        [self addChild:raptor];
        
        //Add rock
       /* Obstacles* rock = [[Obstacles alloc] init];
        [rock.physicsBody setContactTestBitMask:0];
        [self addChild:rock];*/
        
        //Add ground
        Ground *ground = [[Ground alloc] init];
        ground.position = CGPointMake(0, ground.groundTexture.size.height*2);
        [self addChild:ground];
        [ground makeRandomHill];
        NSLog(@"%f", ground.groundTexture.size.height*2);
        ground.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.frame.size.width, ground.groundTexture.size.height * 2)];
        ground.physicsBody.dynamic = NO;
        ground.physicsBody.categoryBitMask = worldCategory;
        [ground.physicsBody setContactTestBitMask:dinoCategory];
        [ground.physicsBody setCollisionBitMask:0];
        
        //Add score label
        _scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Courier-Bold"];
        _scoreLabel.fontSize = 20;
        _scoreLabel.position = CGPointMake(CGRectGetWidth(self.frame)-(CGRectGetMidX(self.frame)/5), CGRectGetHeight(self.frame)- (CGRectGetMidY(self.frame)/4));
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
