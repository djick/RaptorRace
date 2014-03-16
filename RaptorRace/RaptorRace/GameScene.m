//
//  GameScene.m
//  RaptorRace
//
//  Created by Martin Solheim on 11/03/14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import "GameScene.h"
#import "BRaptor.h"
#import "Obstacles.h"
#import "Ground.h"
#import "Categories.h"


@interface GameScene () <UIGestureRecognizerDelegate>
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapit;

-(IBAction)handleTap:(id)sender;

@end


@implementation GameScene {
    CGFloat _displayedScore;
    NSTimer* timer;
    SKColor* _skyColor;
    SKNode* moving;
    AnyRaptor *raptor;
    int collisions;
}

-(void) didMoveToView:(SKView *)view{
    UITapGestureRecognizer *rec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [[self view] addGestureRecognizer:rec];
}


-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        //resets the number of raptor-obstacle crashes
        collisions=0;
        
        //Physics of the world/scene
        //self.backgroundColor = [SKColor colorWithRed:0.1 green:0.5 blue:0.95 alpha:1.0];
        self.physicsWorld.contactDelegate = self;
        //self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
        [self.physicsWorld setGravity:CGVectorMake(0, -1)];
        
        moving = [SKNode node];
        [self addChild:moving];
        
        //Set up background
        _skyColor = [SKColor colorWithRed:113.0/255.0 green:197.0/255.0 blue:207.0/255.0 alpha:1.0];
        [self setBackgroundColor:_skyColor];
        
        //Landscape
        SKTexture* skylineTexture = [SKTexture textureWithImageNamed:@"landscape"];
        skylineTexture.filteringMode = SKTextureFilteringNearest;
        
        SKAction* moveSkylineSprite = [SKAction moveByX:-skylineTexture.size.width*2 y:0 duration:0.1 * skylineTexture.size.width*2];
        SKAction* resetSkylineSprite = [SKAction moveByX:skylineTexture.size.width*2 y:0 duration:0];
        SKAction* moveSkylineSpritesForever = [SKAction repeatActionForever:[SKAction sequence:@[moveSkylineSprite, resetSkylineSprite]]];
        
        
        for( int i = 0; i < 2 + self.frame.size.width / ( skylineTexture.size.width * 2 ); ++i ) {
            SKSpriteNode* sprite = [SKSpriteNode spriteNodeWithTexture:skylineTexture];
            [sprite setScale:2.0];
            sprite.zPosition = -20;
            sprite.position = CGPointMake(i * sprite.size.width, sprite.size.height / 2 + 25 * 2);
            [sprite runAction:moveSkylineSpritesForever];
            [moving addChild:sprite];
        }
        
        
        //Add char
        raptor = [[BRaptor alloc] init];
        raptor.position = CGPointMake(self.frame.size.width / 2, CGRectGetMidY(self.frame));
        raptor.physicsBody.dynamic = YES;
        raptor.physicsBody.allowsRotation = NO;
        raptor.physicsBody.categoryBitMask = dinoCategory;
        raptor.physicsBody.collisionBitMask = worldCategory | obstacleCategory;
        raptor.physicsBody.contactTestBitMask = worldCategory | obstacleCategory;
        
        [self addChild:raptor];
        
        
        // Create ground
        SKTexture* groundTexture = [SKTexture textureWithImageNamed:@"Ground"];
        groundTexture.filteringMode = SKTextureFilteringNearest;
        
        SKAction* moveGroundSprite = [SKAction moveByX:-groundTexture.size.width*2 y:0 duration:0.02 * groundTexture.size.width*2];
        SKAction* resetGroundSprite = [SKAction moveByX:groundTexture.size.width*2 y:0 duration:0];
        SKAction* moveGroundSpritesForever = [SKAction repeatActionForever:[SKAction sequence:@[moveGroundSprite, resetGroundSprite]]];
        
        for( int i = 0; i < 2 + self.frame.size.width / ( groundTexture.size.width * 2 ); ++i ) {
            // Create the sprite
            SKSpriteNode* sprite = [SKSpriteNode spriteNodeWithTexture:groundTexture];
            [sprite setScale:2.0];
            sprite.position = CGPointMake(i * sprite.size.width, sprite.size.height / 4);
            [sprite runAction:moveGroundSpritesForever];
            [moving addChild:sprite];
        }
        
        SKNode* dummy = [SKNode node];
        dummy.position = CGPointMake(0, groundTexture.size.height/2);
        dummy.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.frame.size.width, groundTexture.size.height * 2)];
        dummy.physicsBody.dynamic = NO;
        dummy.physicsBody.categoryBitMask = worldCategory;
        [self addChild:dummy];
        
        
        //Add rock
       /* Obstacles* rock = [[Obstacles alloc] init];
        [rock.physicsBody setContactTestBitMask:0];
        [self addChild:rock];*/
        
        //Add score label
        _scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Courier-Bold"];
        _scoreLabel.fontSize = 20;
        _scoreLabel.position = CGPointMake(CGRectGetWidth(self.frame)-(CGRectGetMidX(self.frame)/5), CGRectGetHeight(self.frame)- (CGRectGetMidY(self.frame)/4));
        _scoreLabel.fontColor = [SKColor colorWithRed:251.0/255.0 green:127.0/255.0 blue:108.0/255.0 alpha:1.0];
        _scoreLabel.text = @"000";
        
        [self addChild:_scoreLabel];

        //Start timer
        timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(countUp) userInfo:nil repeats:YES];
        
        //Clouds
        SKTexture* cloudTexture = [SKTexture textureWithImageNamed:@"cloud"];
        cloudTexture.filteringMode=SKTextureFilteringNearest;
        
        SKAction* moveCloudSprite = [SKAction moveByX:-cloudTexture.size.width*2 y:0 duration:0.3 * cloudTexture.size.width*2];
        //SKAction* resetCloudSprite = [SKAction moveByX:cloudTexture.size.width*2 y:0 duration:0];
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
            [moving addChild:sprite];
        }
        
        self.obs = [[Obstacles alloc]init];
        [self addChild:self.obs];
        [self.obs addObstacles];
        
    }
    
    return self;
}


-(IBAction)handleTap:(UITapGestureRecognizer *)tap{
    NSLog(@"recognizes tap");
    if(tap.state == UIGestureRecognizerStateEnded){
        [raptor applyForce];
    }
}
//Increase score
- (void)countUp {
    self.score += 5;
}

- (void)update:(NSTimeInterval)currentTime {
    //If not the current score is shown
    if(self.score != _displayedScore) {
        self.scoreLabel.text = [NSString stringWithFormat:@"%05.0f", self.score];
        _displayedScore = self.score;
    }
    //Trying to do da spawning
    [self.obs spawnObstacle];
}
/*-(void)didBeginContact:(SKPhysicsContact*)contact {
    if (contact.bodyA.categoryBitMask ==dinoCategory && contact.bodyB.categoryBitMask==obstacleCategory){
        NSLog(@"collison detected");
        if (collisions==2) {
            //gameover
        }
        else{
            collisions=collisions+1;
        }
    }
}
 */




@end
