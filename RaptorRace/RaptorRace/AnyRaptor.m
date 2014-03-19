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
        NSLog(@"Raptor initialized");
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
    raptor.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:raptor.frame.size];
    raptor.physicsBody.allowsRotation = NO;
    raptor.physicsBody.restitution = 0.0;
    raptor.physicsBody.dynamic = YES;
    raptor.physicsBody.categoryBitMask = dinoCategory;
    raptor.physicsBody.collisionBitMask = worldCategory | obstacleCategory;
    raptor.physicsBody.contactTestBitMask = worldCategory | obstacleCategory;
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
    CGFloat velocity = raptor.physicsBody.velocity.dy;
    //Raptor allowed to jump?
    if ((self.allowedToJump && !self.inAir) || _jumpState == 0) {
        [self forceApplied:(CGVectorMake(0.0, 87.0))];
        self.inAir = YES;
        _jumpState = 1;
        NSLog(@"allowed to jump first");
    }
    else if (self.allowedToJump && self.inAir && _jumpState == 1) {
        [self forceApplied:(CGVectorMake(0.0, 30.0))];
        self.inAir = YES;
        self.allowedToJump = NO;
        _jumpState = 2;
    }
    if (_jumpState == 2) {
        if (velocity == 0) {
            self.inAir = NO;
            self.allowedToJump = YES;
        }
        [self forceApplied:CGVectorMake(0.0, 75.0)];
        _jumpState = 1;
        self.inAir = YES;
    }
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



@end
