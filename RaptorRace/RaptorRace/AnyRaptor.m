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
}

NSArray *raptorRunningFrames;
SKSpriteNode *raptor;
int collisions;

-(id)init
{
    if (self = [super init])
    {
        collisions=0;
        [self makeRaptor];
        
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
    raptor.physicsBody.categoryBitMask = obstacleCategory;
}

- (void) applyForce
{
    CGFloat velocity = raptor.physicsBody.velocity.dy;
    if(velocity > 0)
    {
        [raptor.physicsBody applyImpulse:CGVectorMake(0, 25)];
        raptor.speed = 1.0;
    }
    else
    {
        [raptor.physicsBody setVelocity:CGVectorMake(0, 0)];
        [raptor.physicsBody applyImpulse:CGVectorMake(0, 60)];
        raptor.speed = 1.0;
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
-(void)didBeginContact:(SKPhysicsContact*)contact {
    if (contact.bodyA.categoryBitMask ==dinoCategory && contact.bodyB.categoryBitMask==obstacleCategory){
        NSLog(@"collison detected");
        if (collisions==2) {
            //gameover
        }
        else{
            collisions=collisions+1;
        }
    }
    if (contact.bodyA.categoryBitMask ==obstacleCategory && contact.bodyB.categoryBitMask==dinoCategory){
        NSLog(@"collison detected");
        if (collisions==2) {
            //gameover
        }
        else{
            collisions=collisions+1;
        }
    }
}
//hello

@end
