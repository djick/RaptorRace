//
//  AnyRaptor.m
//  RaptorRace
//
//  Created by Martin Solheim on 11/03/14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import "AnyRaptor.h"

@implementation AnyRaptor

- (void) makeRaptorWithAtlasNamed:(NSString *)name
                  AndStringFormat:(NSString *)format
{
    [self setUpAnimationWithAtlasNamed:name
                       AndStringFormat:format];
    [self setUpRaptorPhysicsBody];
}

NSArray *raptorRunningFrames;

- (void) setUpAnimationWithAtlasNamed:(NSString *)name
                      AndStringFormat:(NSString *)format
{
    NSMutableArray *runningFrames = [NSMutableArray array];
    SKTextureAtlas *raptorAnimatedAtlas = [SKTextureAtlas atlasNamed:name];
    
    int numImages = (int)raptorAnimatedAtlas.textureNames.count;
    for (int i=1; i <= numImages/2; i++) {
        NSString *textureName = [NSString stringWithFormat:format, i];
        SKTexture *temp = [raptorAnimatedAtlas textureNamed:textureName];
        [runningFrames addObject:temp];
    }
    raptorRunningFrames = runningFrames;
    SKTexture *temp = raptorRunningFrames[0];
    self.raptor = [SKSpriteNode spriteNodeWithTexture:temp];
}

- (void) setUpRaptorPhysicsBody
{
    self.raptor.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height)];
    
}
@end
