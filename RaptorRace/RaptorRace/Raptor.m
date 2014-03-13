//
//  Raptor.m
//  RaptorRun
//
//  Created by Siri Holtnæs on 10.03.14.
//  Copyright (c) 2014 Siri Holtnaes. All rights reserved.
//

#import "Raptor.h"
#import "Categories.h"

@implementation Raptor

NSArray *_raptorRunningFrames;

-(id)init {
    if (self = [super init]) {
        NSMutableArray *runningFrames = [NSMutableArray array];
        SKTextureAtlas *raptorAnimatedAtlas = [SKTextureAtlas atlasNamed:@"raptor"];
        
        int numImages = raptorAnimatedAtlas.textureNames.count;
        for (int i=1; i <= numImages/2; i++) {
            NSString *textureName = [NSString stringWithFormat:@"rapto%d", i];
            SKTexture *temp = [raptorAnimatedAtlas textureNamed:textureName];
            [runningFrames addObject:temp];
        }
        _raptorRunningFrames = runningFrames;
        SKTexture *temp = _raptorRunningFrames[0];
        _raptor = [SKSpriteNode spriteNodeWithTexture:temp];
        [self addChild:_raptor];
        _raptor.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
        [self runningRaptor];
    }
    
    return self;
}

-(void)runningRaptor
{
    [_raptor runAction:[SKAction repeatActionForever:
                        [SKAction animateWithTextures:_raptorRunningFrames
                                         timePerFrame:0.1f
                                               resize:NO
                                              restore:YES]] withKey:@"runningInPlaceRaptor"];
    return;
}
@end