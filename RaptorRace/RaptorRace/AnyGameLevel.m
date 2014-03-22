//
//  AnyGameLevel.m
//  RaptorRace
//
//  Created by Martin Solheim on 16/03/14.
//  Copyright (c) 2014 iOne. All rights reserved.
//
#import "AnyGameLevel.h"


@implementation AnyGameLevel
-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        background = [[SKSpriteNode alloc] init];
        obstacleList = [[NSMutableArray alloc] init];
        [self makeGameLevel];
        NSLog(@"GameLevel initialized");
        [self addChild:ground];
        [self addChild:background];
        [self addChild:scoreLabel];
        [self addChild:pausebtn];
        [self addChild:highscore];
//        [self addChild:lifeLabel];
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
    
//    int displayedLifes = lifeLabel.text;
//    if (displayedLifes != [raptor getLifes]) {
//        lifeLabel.text = [NSString stringWithFormat:@"Lifes: %d", [raptor getLifes]];
//    }
//    else if (displayedLifes < 0) {
//        lifeLabel.text = @"Dead";
//    }
    
    // Raptor allowed to jump?
    [raptor updateAllowedToJump];
    
    float randSecs = [self randomValueBetween:1.0
                                     andValue:2.0];
    if(pausebtn.isPaused){
        pausedAtTime = currentTime + randSecs;
    }
    
    if(currentTime > nextDinosaurSpawn && !pausebtn.isPaused){
        if(pausedAtTime >0){
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(pausedAtTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSLog(@"SOAWNING OBSTACLE");
                [self addObstacles];
                nextDinosaurSpawn = randSecs + currentTime;
            });
            pausedAtTime = 0.0;
        }
        else{
            NSLog(@"SOAWNING OBSTACLE");
            [self addObstacles];
            nextDinosaurSpawn = randSecs + currentTime;
        }
        
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
//    [self addLifeCounterWithColor:[self getScoreCounterColor] AndFontNamed:[self getScoreCounterFontName]];
    [self addPauseButtonWithImageNamed:[self getPauseButton]];
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


- (void) addScoreCounterWithColor:(UIColor *)color
                     AndFontNamed:(NSString *)fontName
{
    scoreLabel = [ScoreSingleton getInstance];
    [scoreLabel customSingletonWithColor:color
                             AndFontName:fontName];
    scoreLabel.position = CGPointMake(CGRectGetWidth(self.frame)-(CGRectGetMidX(self.frame)/3), CGRectGetHeight(self.frame)- (CGRectGetMidY(self.frame)/4));
    
    highscore = [[SKLabelNode alloc] initWithFontNamed:fontName];
    highscore.position = CGPointMake(CGRectGetWidth(self.frame)-(CGRectGetMidX(self.frame)/3), CGRectGetHeight(self.frame)- (CGRectGetMidY(self.frame)/3));
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"highscore"] != nil){
        NSNumber *n =[[NSUserDefaults standardUserDefaults] objectForKey:@"highscore"];
        NSString *str = [NSString stringWithFormat:@"Highscore: %d",[n intValue]];
        [highscore setText:str];
        [highscore setFontName:@"Courier-Bold"];
        highscore.fontSize = 16;
        //highscore.fontColor = [SKColor colorWithRed:251.0/255.0 green:127.0/255.0 blue:108.0/255.0 alpha:1.0];

    }
    else{
        NSString *str = [NSString stringWithFormat:@"Highscore: 0"];
        [highscore setText:str];
        [highscore setFontName:@"Courier-Bold"];
        highscore.fontSize = 16;
        //highscore.fontColor = [SKColor colorWithRed:251.0/255.0 green:127.0/255.0 blue:108.0/255.0 alpha:1.0];

    }
    
    [[ScoreSingleton getInstance] startTimer];
}

- (void) addLifeCounterWithColor:(UIColor *)color
                     AndFontNamed:(NSString *)fontName
{
    lifeLabel = [SKLabelNode labelNodeWithFontNamed:fontName];
    lifeLabel.position = CGPointMake(CGRectGetWidth(self.frame)-(CGRectGetMidX(self.frame)/4), CGRectGetHeight(self.frame)- (CGRectGetMidY(self.frame)/2.8));
    lifeLabel.text = [NSString stringWithFormat:@"Lifes: %d", [raptor getLifes]];
    lifeLabel.fontSize = 20;
}


- (void) addPauseButtonWithImageNamed:(NSString*)name{
    pausebtn = [[Pause alloc] initWithImageNamed:name];
    [pausebtn setScale:0.7];
    pausebtn.position = CGPointMake(CGRectGetWidth(self.frame)-(CGRectGetMidX(self.frame)/5), CGRectGetHeight(self.frame)- (CGRectGetMidY(self.frame)*1.85));
    pausebtn.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:pausebtn
                            .size];
    pausebtn.physicsBody.dynamic = NO;
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


- (void) addObstacles
{
    int x = arc4random() % 3;
    if(x==0){
        AnyObstacle *obstacleRand = [[RedRaptorObstacle alloc] initWithGroundHeight:ground.texture.size.height];
        [obstacleRand setPosition:CGPointMake(self.frame.size.width-obstacleRand.size.width, ground.texture.size.height/4+obstacleRand.nodeHeight)];
        [self addChild:obstacleRand];
        [obstacleRand fireObstacle];
    }
    else if (x == 1){
        AnyObstacle *obstacleRand = [[GreenRaptorObstacle alloc] initWithGroundHeight:ground.texture.size.height];
        [obstacleRand setPosition:CGPointMake(self.frame.size.width-obstacleRand.size.width, ground.texture.size.height/4+obstacleRand.nodeHeight)];
        [self addChild:obstacleRand];
        [obstacleRand fireObstacle];
    }
    else{
        AnyObstacle *stoneObs = [[StoneObstacle alloc] initWithGroundHeight:ground.texture.size.height];
        [stoneObs setPosition:CGPointMake(self.frame.size.width-stoneObs.size.width, ground.texture.size.height + stoneObs.height*0.90)];
        [self addChild:stoneObs];
        [stoneObs fireObstacle];
        }
 
    //[obstacleList addObject:stoneObstacle];
}


- (void) addRaptor
{
    raptor = [[BRaptor alloc] init];
    raptor.position = CGPointMake(self.frame.size.width / 2, CGRectGetMidY(self.frame));
    [self addChild:raptor];
}

- (void) setGamePhysics
{
    //Physics of the world/scene
    [self.physicsWorld setContactDelegate:self];
    
    [self.physicsWorld setGravity:[self getGravityVector]];
}

// The following methods has to be implemented by sub-class, or exception will be raised.

- (NSString *) getGroundAtlasName
{
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    return NULL;
}

- (CGVector) getGravityVector
{
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    return CGVectorMake(0, 0);
}

- (NSString* ) getGroundPictureNameFormat
{
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    return NULL;
}

- (NSString *) getBackgroundPictureName
{
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    return NULL;
}

- (NSString *) getCloudPictureName
{
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    return NULL;
}

- (SKColor *) getBackgroundColor
{
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    return NULL;
}

- (SKColor *) getScoreCounterColor
{
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    return NULL;
}

- (NSString *) getScoreCounterFontName
{
    [NSException raise:NSInternalInconsistencyException
                    format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    return NULL;
}

- (NSString *) getPauseButton
{
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    return NULL;
}

- (void) spawningObstacles{
//    AnyObstacle *obs = [self addObstacles];
//    [self addChild:obs];
//    NSLog(@"added DINO");
//    
//    [obs fireObstacle];
////    obs.hidden = NO;
//    
    
    
}

@end
