//
//  AnyRaptor.m
//  RaptorRace
//
//  Created by Martin Solheim on 12/03/14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import "AnyRaptor.h"
#import "Categories.h"

@implementation AnyRaptor {
    int _jumpState;
    NSArray *raptorRunningFrames;
    SKSpriteNode *raptor;
    int collisions;
    SKAction* jumpSound;
    int _lifes;
    CGMutablePathRef path;
}


-(id)init
{
    if (self = [super init])
    {
        collisions=0;
        [self makeRaptor];
        raptor.name = @"raptor";
        [self addChild:raptor];
        self.allowedToJump = YES;
        self.inAir = NO;
        _jumpState = 0;
        _lifes = 2;
        self.undead = NO;
        NSLog(@"Raptor initialized");
        jumpSound = [SKAction playSoundFileNamed:@"jump.wav" waitForCompletion:NO];
    }
    
    return self;
}

- (void) makeRaptor
{
    [self setRaptorAnimationWithAtlasNamed:[self getAtlasName]
                      AndPictureNAmeFormat:[self getPictureNameFormat]];
    [self setPhysicalAbilitiesOfRaptor];
    [self runningRaptor];
}

// Has to be implemented by sub-class, or it wil raise exception.
- (NSString *) getAtlasName
{
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    return NULL;
}

// Has to be implemented by sub-class, or it wil raise exception.
- (NSString* ) getPictureNameFormat
{
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    return NULL;
}

- (void) setRaptorAnimationWithAtlasNamed:(NSString *)name
                     AndPictureNAmeFormat:(NSString *)format
{
    NSMutableArray *runningFrames = [NSMutableArray array];
    SKTextureAtlas *raptorAnimatedAtlas = [SKTextureAtlas atlasNamed:name];
    
    int numImages = raptorAnimatedAtlas.textureNames.count;
    for (int i=1; i <= numImages; i++) {
        NSString *textureName = [NSString stringWithFormat:format, i];
        SKTexture *temp = [raptorAnimatedAtlas textureNamed:textureName];
        [runningFrames addObject:temp];
    }
    
    raptorRunningFrames = runningFrames;
    SKTexture *temp = raptorRunningFrames[0];
    raptor = [SKSpriteNode spriteNodeWithTexture:temp];
}

- (void) setPhysicalAbilitiesOfRaptor
{
    raptor.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(raptor.frame.size.width*0.7, raptor.frame.size.height)];
//    raptor.anchorPoint = CGPointMake(0.0, 1.0);
//    
//    path = CGPathCreateMutable();
//    CGPathMoveToPoint(path, NULL, 0, 5);
//    CGPathAddLineToPoint(path, NULL, 75, 0);
//    CGPathAddLineToPoint(path, NULL, 81, 0);
//    CGPathAddLineToPoint(path, NULL, 88, 7);
//    CGPathAddLineToPoint(path, NULL, 88, 8);
//    CGPathAddLineToPoint(path, NULL, 68, 26);
//    CGPathAddLineToPoint(path, NULL, 48, 33);
//    CGPathAddLineToPoint(path, NULL, 31, 44);
//    CGPathCloseSubpath(path);
//    
//    
//    raptor.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:path];
    raptor.physicsBody.allowsRotation = NO;
    raptor.physicsBody.restitution = 0.0;
    raptor.physicsBody.dynamic = YES;
    raptor.physicsBody.categoryBitMask = dinoCategory;
    raptor.physicsBody.collisionBitMask = worldCategory | obstacleCategory;
    raptor.physicsBody.contactTestBitMask = worldCategory | obstacleCategory;
    raptor.xScale = 0.8;
    raptor.yScale = 0.8;
}

- (void) forceApplied:(CGVector) force {
    //CGFloat velocity = raptor.physicsBody.velocity.dy;
    //    NSLog(@"velocity: %f", velocity);
    //    NSLog(@"allowedToJump: %d",self.allowedToJump);
    //    NSLog(@"inAir: %d",self.inAir);
    [raptor.physicsBody setVelocity:CGVectorMake(0, 0)];
    [raptor.physicsBody applyImpulse:force];
    raptor.speed = 1.0;
}

-(void)jump {
    //CGFloat velocity = raptor.physicsBody.velocity.dy;
    //Raptor allowed to jump?
    if ((self.allowedToJump && !self.inAir) || _jumpState == 0) {
        [self forceApplied:(CGVectorMake(0.0, 100.0))];
        self.inAir = YES;
        _jumpState = 1;
        [self runAction:jumpSound];
    }
    else if (self.allowedToJump && self.inAir && _jumpState == 1) {
        [self forceApplied:(CGVectorMake(0.0, 50.0))];
        self.inAir = YES;
        self.allowedToJump = NO;
        _jumpState = 2;
        [self runAction:jumpSound];
    }
//    else if (_jumpState == 2) {
//        if (velocity == 0) {
//            self.inAir = NO;
//            self.allowedToJump = YES;
//        }
//        NSLog(@"Hello");
//        [self forceApplied:CGVectorMake(0.0, 20.0)];
//        [self runAction:jumpSound];
//        _jumpState = 1;
//        self.inAir = YES;
//    }
}

-(void)updateAllowedToJump {
    if (raptor.physicsBody.velocity.dy == 0) {
        self.allowedToJump = YES;
        self.inAir = NO;
    }
}


-(void)runningRaptor
{
    [raptor runAction:[SKAction repeatActionForever:
                       [SKAction animateWithTextures:raptorRunningFrames
                                        timePerFrame:0.1f
                                              resize:NO
                                             restore:YES]] withKey:@"runningInPlaceRaptor"];
    return;
}

-(void)looseLife {
    _lifes -= 1;
    SKAction* hurtSound = [SKAction playSoundFileNamed:@"hurt.wav" waitForCompletion:NO];
    SKAction* fadeOut = [SKAction fadeAlphaTo:0.5 duration:0.1];
    SKAction* fadeIn = [SKAction fadeAlphaTo:1 duration:0.1];
    self.undead = YES;
    raptor.physicsBody.categoryBitMask = invicibleCategory;
    raptor.physicsBody.collisionBitMask = worldCategory;
    raptor.physicsBody.contactTestBitMask = worldCategory;
    [raptor runAction:[SKAction moveByX:-80.0 y:0.0 duration:0.3]];
    [self runAction:hurtSound];
    [raptor runAction:[SKAction repeatAction:[SKAction sequence:@[fadeOut, fadeIn]] count:15] completion:^{
        raptor.physicsBody.categoryBitMask = dinoCategory;
        raptor.physicsBody.collisionBitMask = worldCategory | obstacleCategory;
        raptor.physicsBody.contactTestBitMask = worldCategory | obstacleCategory;
        self.undead = NO;

    }];
}

-(void)makeInvisible{
    _lifes -= 1;
    SKAction* hurtSound = [SKAction playSoundFileNamed:@"hurt.wav" waitForCompletion:NO];
    SKAction* fadeOut = [SKAction fadeAlphaTo:0.5 duration:0.1];
    SKAction* fadeIn = [SKAction fadeAlphaTo:1 duration:0.1];
    self.undead = YES;
    raptor.physicsBody.categoryBitMask = invicibleCategory;
    raptor.physicsBody.collisionBitMask = worldCategory;
    raptor.physicsBody.contactTestBitMask = worldCategory;
    [self runAction:hurtSound];
    [raptor runAction:[SKAction repeatAction:[SKAction sequence:@[fadeOut, fadeIn]] count:15] completion:^{
        raptor.physicsBody.categoryBitMask = dinoCategory;
        raptor.physicsBody.collisionBitMask = worldCategory | obstacleCategory;
        raptor.physicsBody.contactTestBitMask = worldCategory | obstacleCategory;
        self.undead = NO;
        
    }];}

-(int)getLifes {
    return _lifes;
}


@end
