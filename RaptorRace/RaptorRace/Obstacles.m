//
//  Obstacles.m
//  RaptorRace
//
//  Created by Martin Solheim on 11/03/14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import "Obstacles.h"
#import "Ground.h"
#import "Categories.h"
#include <stdlib.h>

#define kNumObstacles   17


@implementation Obstacles
//Categorybitmasks legges i gameview til slutt
{
double _nextDinosaurSpawn;
int _nextDinosaur;
NSMutableArray *dinosaurs;
NSMutableArray *obstacleList;
}


-(id)init {
    if (self = [super init]) {
    }
    
    return self;
}


-(SKSpriteNode*)makeDinosaur1 {
    SKSpriteNode* SKdinosaur1= [SKSpriteNode spriteNodeWithImageNamed:@"dinosaur1"];
    SKdinosaur1.size=CGSizeMake(40, 40);
    //_dinosaur1.position = CGPointMake(100, 100);
    SKdinosaur1.physicsBody=[SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(100,100)];
    //SKdinosaur1.position = CGPointMake(100, 100);
    SKdinosaur1.physicsBody.affectedByGravity=NO;
    SKdinosaur1.physicsBody.mass=1;
    SKdinosaur1.physicsBody.restitution = 0.0;
    SKdinosaur1.physicsBody.allowsRotation=NO;
    SKdinosaur1.physicsBody.dynamic=NO; //Making dem obstacles static
    SKdinosaur1.physicsBody.categoryBitMask = obstacleCategory;
    SKdinosaur1.physicsBody.collisionBitMask = dinoCategory;
    SKdinosaur1.physicsBody.contactTestBitMask = dinoCategory;
    SKdinosaur1.physicsBody.restitution = 0.0;
    //SKdinosaur1.xScale = 1;
    //SKdinosaur1.yScale = 1;

    return SKdinosaur1;
    
}

-(SKSpriteNode*)makeDinosaur2 {
    SKSpriteNode* SKdinosaur2= [SKSpriteNode spriteNodeWithImageNamed:@"dinosaur2"];
    SKdinosaur2.size=CGSizeMake(70, 50);
    //_dinosaur2.position = CGPointMake(200, 100);
    SKdinosaur2.physicsBody=[SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(70,50)];
    SKdinosaur2.physicsBody.affectedByGravity=NO;
    SKdinosaur2.physicsBody.mass=100;
    SKdinosaur2.physicsBody.allowsRotation=NO;
    SKdinosaur2.physicsBody.dynamic=NO; //Making dem obstacles static
    [SKdinosaur2.physicsBody setCollisionBitMask:0];
    SKdinosaur2.xScale = 1;
    SKdinosaur2.yScale = 1;
    
    return SKdinosaur2;
}

-(SKSpriteNode*)makeSkeleton {
    SKSpriteNode* SKskeleton= [SKSpriteNode spriteNodeWithImageNamed:@"newestSkeleton1"];
    SKskeleton.size=CGSizeMake(45, 35);
    SKskeleton.position = CGPointMake(300, 110);
    SKskeleton.physicsBody=[SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(50,40)];
    SKskeleton.physicsBody.affectedByGravity=NO;
    SKskeleton.physicsBody.mass=50000;
    SKskeleton.physicsBody.allowsRotation=NO;
    SKskeleton.physicsBody.dynamic=NO; //Making dem obstacles static
    [SKskeleton.physicsBody setCollisionBitMask:0];
    SKskeleton.xScale = 2;
    SKskeleton.yScale = 2;
    
    
    return SKskeleton;
    
}

// Generating skeletons that stand still, will slow the player down if it bumps into it
-(void)generateSkeletons {
    int obstacleinterval=1;
    for (int i=0; i<obstacleinterval; i++){
        [self makeSkeleton];
        if (i==0) {
            _skeleton.position=CGPointMake(400, 97);
        }
        else{
            _skeleton.position=CGPointMake(270, 97);
        }
    }
    
}

- (float)randomValueBetween:(float)low andValue:(float)high {
    return (((float) arc4random() / 0xFFFFFFFFu) * (high - low)) + low;
}

// Generating dinosaurs that go left, will slow the player down if they bump into each other,
/*-(void)generateDinosaurs {
    int obstacleinterval=2;
    for (int i=0; i<obstacleinterval; i++){
        [self makeDinosaur1];
        if (i==0) {
            [self movingDinosaurs];
        }
        else{
            [self movingDinosaurs];
        }
    }
    
}
 */
// must be called when game is started
- (void)addObstacles{
    //
    obstacleList= [[NSMutableArray alloc] initWithObjects:[self makeDinosaur1],[self makeDinosaur2], nil];
    
    dinosaurs = [[NSMutableArray alloc] initWithCapacity:kNumObstacles];
    int n = 0;
    for (int i = 0; i < kNumObstacles; ++i) {
        SKSpriteNode* dinosaur;
        if(n==0){
            dinosaur = [self makeDinosaur1];
        }
        else{
            dinosaur = [self makeDinosaur2];
        }
        NSLog(@"making obstacles");
        dinosaur.hidden = YES;
        
        [dinosaur setXScale:0.7];
        [dinosaur setYScale:0.7];
        [dinosaurs addObject:dinosaur];
        //[dinosaur.physicsBody setCollisionBitMask:obstacleCategory];
        [self addChild:dinosaur];
    }
    
}
// must be called in update
-(void)spawnObstacle:(CGFloat) height {
    double curTime = CACurrentMediaTime();
    if (curTime > _nextDinosaurSpawn) {
        NSLog(@"spawning new dinosaur");
        float randSecs = [self randomValueBetween:3.0
                                         andValue:10.0];
        _nextDinosaurSpawn = randSecs + curTime;
        SKSpriteNode *obstacle = [dinosaurs objectAtIndex:rand()%1];
        [obstacle removeAllActions];
    
        //float randDuration =[self randomValueBetween:3.0
                                             //andValue:8.0];
        //CGFloat height = 97;
        obstacle.position = CGPointMake(-self.frame.size.width+ 20, height);
        obstacle.hidden = NO;
        CGPoint location = CGPointMake(1, height);
        SKAction *moveAction = [SKAction moveTo:location
                                       duration: 4];
        SKAction *doneAction = [SKAction runBlock:(dispatch_block_t)^() {
        NSLog(@"Animation Completed");
        obstacle.hidden = YES;
        }];
        SKAction *moveDinosaurActionWithDone = [SKAction sequence:@[moveAction, doneAction ]];
        [obstacle runAction:moveDinosaurActionWithDone withKey:@"dinosaurMoving"];
    }
}

@end
