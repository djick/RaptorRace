//
//  AnyGameLevel.m
//  RaptorRace
//
//  Created by Martin Solheim on 16/03/14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import "AnyGameLevel.h"
#import "ScoreSingleton.h"
#import "Categories.h"
#import "AnyRaptor.h"
#import "BRaptor.h"
#import "RedRaptorObstacle.h"
#import "StoneObstacle.h"

@implementation AnyGameLevel{
    // An array of frames used for the ground animation
    NSArray *groundMovingFrames;
    NSTimeInterval nextDinosaurSpawn;
    
    SKSpriteNode *ground;
    SKSpriteNode *background;
    NSMutableArray *obstacleList;
    AnyObstacle *obstacle;
    AnyObstacle *stoneObstacle;
    AnyRaptor *raptor;
    
    ScoreSingleton * scoreLabel;
    
    NSTimer* timer;
}




-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        background = [[SKSpriteNode alloc] init];
        obstacleList = [[NSMutableArray alloc] init];
        [self makeGameLevel];
        //Physics of the world/scene
        //self.physicsWorld.contactDelegate = self;
        NSLog(@"GameLevel initialized");
        [self addChild:ground];
        [self addChild:background];
        [self addChild:scoreLabel];
//        obstacle = [[RedRaptorObstacle alloc] initWithGroundHeight:ground.texture.size.height];
//        [obstacle setPosition:CGPointMake(self.frame.size.width-obstacle.nodeWidth, ground.texture.size.height/4+obstacle.nodeHeight)];
//        [self addChild:obstacle];
//        [obstacle fireObstacle];
        //[self addChild:stoneObstacle];
        //[stoneObstacle fireObstacle];
        
        nextDinosaurSpawn = 0.0;


        
        
    }
    return self;
}

- (float)randomValueBetween:(float)low andValue:(float)high {
    return (((float) arc4random() / 0xFFFFFFFFu) * (high - low)) + low;
}

- (void)update:(NSTimeInterval)currentTime
{
    //If not the current score is shown
    CGFloat displayedScore = 0.0;
    if([scoreLabel getScore] != displayedScore) {
        displayedScore = [[ScoreSingleton getInstance] getScore];
    }
    
    // Raptor allowed to jump?
    [raptor updateAllowedToJump];
    
    float randSecs = [self randomValueBetween:2.0
                                     andValue:3.0];
    
    if(currentTime > nextDinosaurSpawn){
        NSLog(@"SOAWNING OBSTACLE");
        [self spawningObstacles];
        nextDinosaurSpawn = randSecs + currentTime;
    }
    
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [raptor jump];
}

- (void) makeGameLevel
{
    [self setGamePhysics];
    [self createGroundWithAtlasNamed:[self getGroundAtlasName]
                           AndFormat:[self getGroundPictureNameFormat]];
    [self createBackgroundWithImageNamed:[self getBackgroundPictureName]
                      AndBackgroundColor:[self getBackgroundColor]];
    [self addCloudsWithImageNamed:[self getCloudPictureName]];
    [self addScoreCounterWithColor:[self getScoreCounterColor]
                      AndFontNamed:[self getScoreCounterFontName]];
    [self addRaptor];
    //[self addObstacles];

    
}

- (void) createBackgroundWithImageNamed:(NSString *)name
                     AndBackgroundColor:(SKColor *)color
{
    //Set up background color.
    [self setBackgroundColor:color];
    
    //Landscape
    SKTexture* skylineTexture = [SKTexture textureWithImageNamed:@"LargeLandscape"];
    skylineTexture.filteringMode = SKTextureFilteringNearest;
    
    SKAction* moveSkylineSprite = [SKAction moveByX:-skylineTexture.size.width*2
                                                  y:0
                                           duration:0.1 * skylineTexture.size.width*2];
    SKAction* resetSkylineSprite = [SKAction moveByX:skylineTexture.size.width*2
                                                   y:0
                                            duration:0];
    SKAction* moveSkylineSpritesForever = [SKAction repeatActionForever:[SKAction sequence:@[moveSkylineSprite, resetSkylineSprite]]];
    
    
    for( int i = 0; i < 2 + self.frame.size.width / ( skylineTexture.size.width * 2 ); ++i ) {
        SKSpriteNode* sprite = [SKSpriteNode spriteNodeWithTexture:skylineTexture];
        [sprite setScale:2.0];
        sprite.zPosition = -20;
        sprite.position = CGPointMake(i * sprite.size.width, sprite.size.height / 2 + 25 * 2);
        [sprite runAction:moveSkylineSpritesForever];
        [background addChild:sprite];
    }
}

- (void) addCloudsWithImageNamed:(NSString *)name
{
    SKTexture* cloudTexture = [SKTexture textureWithImageNamed:name];
    cloudTexture.filteringMode=SKTextureFilteringNearest;
    
    SKAction* moveCloudSprite = [SKAction moveByX:-cloudTexture.size.width*2 y:0 duration:0.3 * cloudTexture.size.width*2];
    SKAction* moveCloudeSpriteForever = [SKAction repeatActionForever:[SKAction sequence:@[moveCloudSprite]]]; //resetCloudSprite
    
    for( int i = 0; i < 2 + self.frame.size.width / ( cloudTexture.size.width * 2 ); ++i ) {
        SKSpriteNode* sprite = [SKSpriteNode spriteNodeWithTexture:cloudTexture];
        [sprite setScale:2.0];
        sprite.zPosition = -20;
        if(i > 10){
            sprite.position = CGPointMake((i/10) * sprite.size.width*(arc4random_uniform(2) + 1), sprite.size.height / 2 + cloudTexture.size.height*(arc4random_uniform(3) + 3));
        }
        else if (i > 100) {
            sprite.position = CGPointMake((i/100) * sprite.size.width*(arc4random_uniform(2) + 1), sprite.size.height / 2 + cloudTexture.size.height*(arc4random_uniform(3) + 3));
        }
        else {
            sprite.position = CGPointMake(i * sprite.size.width*(arc4random_uniform(2) + 1), sprite.size.height / 2 + cloudTexture.size.height*(arc4random_uniform(3) + 3));
        }
        [sprite runAction:moveCloudeSpriteForever];
        [background addChild:sprite];
    }
}

/**
 A helper-method for addScoreCounter... increments the timer.
 */
- (void)countUp
{
    [[ScoreSingleton getInstance] updateScore:5];
}


- (void) addScoreCounterWithColor:(UIColor *)color
                     AndFontNamed:(NSString *)fontName
{
    scoreLabel = [ScoreSingleton getInstance];
    [scoreLabel customSingletonWithColor:color
                             AndFontName:fontName];
    scoreLabel.position = CGPointMake(CGRectGetWidth(self.frame)-(CGRectGetMidX(self.frame)/3), CGRectGetHeight(self.frame)- (CGRectGetMidY(self.frame)/4));
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(countUp) userInfo:nil repeats:YES];
}

- (void) createGroundWithAtlasNamed:(NSString *)name
                          AndFormat:(NSString *)format
{
    NSMutableArray *groundFrames = [NSMutableArray array];
    SKTextureAtlas *groundAnimatedAtlas = [SKTextureAtlas atlasNamed:name];
    
    int numImages = groundAnimatedAtlas.textureNames.count;
    for (int i=1; i < numImages; i++) {
        NSString *textureName = [NSString stringWithFormat:format, i];
        SKTexture *temp = [groundAnimatedAtlas textureNamed:textureName];
        temp.filteringMode = SKTextureFilteringNearest;
        [groundFrames addObject:temp];
    }
    
    groundMovingFrames = groundFrames;
    SKTexture *temp = groundMovingFrames[0];
    ground = [SKSpriteNode spriteNodeWithTexture:temp];
    
    // Run the animation.
    [ground runAction:[SKAction repeatActionForever:
                       [SKAction animateWithTextures:groundMovingFrames
                                        timePerFrame:0.03f
                                              resize:NO
                                             restore:YES]] withKey:@"movingGround"];
    
    [ground setScale:2.0];
    ground.position = CGPointMake(0, ground.size.height/4);
    
    ground.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.frame.size.width, ground.size.height)];
    ground.physicsBody.dynamic = NO;
    ground.physicsBody.categoryBitMask = worldCategory;
    ground.physicsBody.restitution = 0.0;
}


- (AnyObstacle*) addObstacles
{
    int x = arc4random() % 2;
    if(x==0){
        NSLog(@"MAKES A RAPTOR");
        AnyObstacle *obstacleRand = [[RedRaptorObstacle alloc] initWithGroundHeight:ground.texture.size.height];
        [obstacleRand setPosition:CGPointMake(self.frame.size.width-obstacleRand.nodeWidth, ground.texture.size.height/4+obstacleRand.nodeHeight)];
        return obstacleRand;
    }
    else{
        AnyObstacle *stoneObs = [[StoneObstacle alloc] initWithGroundHeight:ground.texture.size.height];
        [stoneObs setPosition:CGPointMake(self.frame.size.width-stoneObs.nodeWidth*1.5, ground.texture.size.height + stoneObs.height*0.90)];
        return stoneObs;
    }
    return  nil;
 
    //[obstacleList addObject:stoneObstacle];
}


- (void) addRaptor
{
    raptor = [[BRaptor alloc] init];
    raptor.position = CGPointMake(self.frame.size.width / 2, CGRectGetMidY(self.frame));
    //raptor.physicsBody.dynamic = YES;
    //raptor.physicsBody.allowsRotation = NO;
    /*raptor.physicsBody.categoryBitMask = dinoCategory;
    raptor.physicsBody.collisionBitMask = worldCategory | obstacleCategory;
    raptor.physicsBody.contactTestBitMask = worldCategory | obstacleCategory;*/
    [self addChild:raptor];
}

- (void) setGamePhysics
{
    //Physics of the world/scene
    [self.physicsWorld setContactDelegate:self];
    [self.physicsWorld setGravity:CGVectorMake(0, -7.0)];
}

// The following methods has to be implemented by sub-class, or exception will be raised.

- (NSString *) getGroundAtlasName
{
//    [NSException raise:NSInternalInconsistencyException
//                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    return @"ground";
}

- (NSString* ) getGroundPictureNameFormat
{
//    [NSException raise:NSInternalInconsistencyException
//                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    return @"groun%d";
}

- (NSString *) getBackgroundPictureName
{
    //    [NSException raise:NSInternalInconsistencyException
    //                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    return @"landscape";
}

- (NSString *) getCloudPictureName
{
    //    [NSException raise:NSInternalInconsistencyException
    //                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    return @"cloud";
}

- (SKColor *) getBackgroundColor
{
    //    [NSException raise:NSInternalInconsistencyException
    //                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    return [SKColor colorWithRed:113.0/255.0
                           green:197.0/255.0
                            blue:207.0/255.0
                           alpha:1.0];
}

- (SKColor *) getScoreCounterColor
{
    //    [NSException raise:NSInternalInconsistencyException
    //                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    return [SKColor colorWithRed:251.0/255.0
                           green:127.0/255.0
                            blue:108.0/255.0
                           alpha:1.0];
}

- (NSString *) getScoreCounterFontName
{
    //    [NSException raise:NSInternalInconsistencyException
    //                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    return @"Courier-Bold";
}

- (void) spawningObstacles{
    obstacle = [self addObstacles];
    [self addChild:obstacle];
    [obstacle fireObstacle];
//    obs.hidden = NO;
    
    
    
}

@end
