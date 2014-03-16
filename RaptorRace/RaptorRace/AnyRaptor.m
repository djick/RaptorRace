//
//  AnyRaptor.m
//  RaptorRace
//
//  Created by Martin Solheim on 12/03/14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import "AnyRaptor.h"
#import "Categories.h"

@implementation AnyRaptor

NSArray *raptorRunningFrames;
SKSpriteNode *raptor;

-(id)init
{
    if (self = [super init])
    {
        [self makeRaptor];
        [self addChild:raptor];
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
    for (int i=1; i <= numImages/2; i++) {
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
    raptor.physicsBody.categoryBitMask = obstacleCategory;
}

- (void) applyForce{
    CGFloat velocity = raptor.physicsBody.velocity.dy;
    if(velocity >0){
        [raptor.physicsBody applyImpulse:CGVectorMake(0, 25)];
        raptor.speed = 1.0;
    }
    else{
        [raptor.physicsBody setVelocity:CGVectorMake(0, 0)];
        [raptor.physicsBody applyImpulse:CGVectorMake(0, 60)];
        raptor.speed = 1.0;
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
