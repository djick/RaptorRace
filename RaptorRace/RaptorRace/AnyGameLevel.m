//
//  AnyGameLevel.m
//  RaptorRace
//
//  Created by Martin Solheim on 16/03/14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import "AnyGameLevel.h"

@implementation AnyGameLevel

// An array of frames used for the ground animation
NSArray *groundMovingFrames;


SKSpriteNode *ground;
SKSpriteNode *background;

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        background = [[SKSpriteNode alloc] init];
        [self makeGameLevel];
        NSLog(@"GameLevel initialized");
    }
    return self;
}

- (void)didMoveToView:(SKView *)view
{
    [self addChild:ground];
    ground.position = CGPointMake(0, ground.size.height/4);
    [self addChild:background];
    NSLog(@"%f", ground.position.x);
}

- (void) makeGameLevel
{
    [self createGroundWithAtlasNamed:[self getGroundAtlasName]
                           AndFormat:[self getGroundPictureNameFormat]];
    [self createBackgroundWithImageNamed:[self getBackgroundPictureName]
                      AndBackgroundColor:[self getBackgroundColor]];
    [self addCloudsWithImageNamed:[self getCloudPictureName]];
    
}

- (void) createBackgroundWithImageNamed:(NSString *)name
                     AndBackgroundColor:(SKColor *)color
{
    //Set up background color.
    [self setBackgroundColor:color];
    
    //Landscape
    SKTexture* skylineTexture = [SKTexture textureWithImageNamed:@"landscape"];
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

- (void) addScoreCounter
{
    
}

- (void) createGroundWithAtlasNamed:(NSString *)name
                          AndFormat:(NSString *)format
{
    NSMutableArray *groundFrames = [NSMutableArray array];
    SKTextureAtlas *groundAnimatedAtlas = [SKTextureAtlas atlasNamed:name];
    
    int numImages = groundAnimatedAtlas.textureNames.count;
    for (int i=1; i <= numImages; i++) {
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
                                        timePerFrame:0.1f
                                              resize:NO
                                             restore:YES]] withKey:@"movingGround"];
    
    [ground setScale:2.0];
    
    
}

- (void) addObstacles
{
    
}

- (void) addRaptor
{
    
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
    return @"ground%d";
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


@end
