//
//  AnyRaptor.m
//  RaptorRace
//
//  Created by Martin Solheim on 12/03/14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import "AnyRaptor.h"

@implementation AnyRaptor

NSArray *raptorRunningFrames;
SKSpriteNode *raptor;

- (SKSpriteNode *) makeRaptor
{
    [self setRaptorAnimationWithAtlasNamed:[self getAtlasName]
                      AndPictureNAmeFormat:[self getPictureNameFormat]];
    [self setPhysicalAbilitiesOfRaptor];
    return raptor;
}

- (NSString *) getAtlasName
{
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    return NULL;
}

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
    [raptor runAction:[SKAction repeatActionForever:
                        [SKAction animateWithTextures:runningFrames
                                         timePerFrame:0.1f
                                               resize:NO
                                              restore:YES]] withKey:@"runningInPlaceRaptor"];
    
//    [self addChild:raptor];
//    [self runningRaptor];
}

- (void) setPhysicalAbilitiesOfRaptor
{
    raptor.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:raptor.frame.size];
}
@end
