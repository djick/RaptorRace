//
//  Ground.m
//  RaptorRace
//
//  Created by Martin Solheim on 11/03/14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import "Ground.h"

@implementation Ground

-(id)init{
    if(self == [super init]){
        [self makeRandomHill];
    }
    return self;
}

-(void) makeRandomHill{
    //Add Ground
    SKNode *moving = [SKNode node];
    [self addChild:moving];
    // Create ground
    
    SKTexture* groundTexture = [SKTexture textureWithImageNamed:@"Ground.png"];
    groundTexture.filteringMode = SKTextureFilteringNearest;
    
    SKAction* moveGroundSprite = [SKAction moveByX:-groundTexture.size.width*2 y:0 duration:0.02 * groundTexture.size.width*2];
    SKAction* resetGroundSprite = [SKAction moveByX:groundTexture.size.width*2 y:0 duration:0];
    SKAction* moveGroundSpritesForever = [SKAction repeatActionForever:[SKAction sequence:@[moveGroundSprite, resetGroundSprite]]];
    
    for( int i = 0; i < 2 + self.frame.size.width / ( groundTexture.size.width * 2 ); ++i ) {
        // Create the sprite
        NSLog(@"creates sprite");
        SKSpriteNode* sprite = [SKSpriteNode spriteNodeWithTexture:groundTexture];
        [sprite setScale:2.0];
        sprite.position = CGPointMake(i * sprite.size.width, sprite.size.height / 2 + 120);
        [sprite runAction:moveGroundSpritesForever];
        [moving addChild:sprite];
    }
    SKNode* dummy = [SKNode node];
    dummy.position = CGPointMake(100, groundTexture.size.height*10);
    dummy.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.frame.size.width, groundTexture.size.height * 2)];
    dummy.physicsBody.dynamic = NO;
    //dummy.physicsBody.categoryBitMask = worldCategory;
    [self addChild:dummy];
    
}

@end
