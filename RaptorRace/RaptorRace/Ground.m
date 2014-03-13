//
//  Ground.m
//  RaptorRace
//
//  Created by Martin Solheim on 11/03/14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import "Ground.h"
#import "Categories.h"

@implementation Ground

-(id)init{
    self = [super init];
    return self;
}

-(void) makeRandomHill{
    //Add Ground
    SKNode *moving = [SKNode node];
    [self addChild:moving];
    // Create ground
    
    self.groundTexture = [SKTexture textureWithImageNamed:@"ground2.png"];
    self.groundTexture.filteringMode = SKTextureFilteringNearest;
    
    //create actions for animation
    SKAction* moveGroundSprite = [SKAction moveByX:-self.groundTexture.size.width*2 y:0 duration:0.02 * self.groundTexture.size.width*2];
    SKAction* resetGroundSprite = [SKAction moveByX:self.groundTexture.size.width*2 y:0 duration:0];
    SKAction* moveGroundSpritesForever = [SKAction repeatActionForever:[SKAction sequence:@[moveGroundSprite, resetGroundSprite]]];
   
    for( int i = 0; i < 2 + self.parent.frame.size.width / ( self.groundTexture.size.width * 2 ); ++i ) {
        // Create the sprite
        NSLog(@"creates sprite");
        SKSpriteNode* sprite = [SKSpriteNode spriteNodeWithTexture:self.groundTexture];
        [sprite setScale:2.0];
        sprite.position = CGPointMake(i * sprite.size.width, sprite.size.height / 4);
        [sprite runAction:moveGroundSpritesForever];
        [self addChild:sprite];
    }
    
    
    //Setup Physics Body
    


}

- (void) setFrame:(CGRect) frame{
    parentFrame = frame;
}

@end
