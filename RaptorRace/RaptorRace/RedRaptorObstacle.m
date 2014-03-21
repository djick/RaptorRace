//
//  RedRaptorObstacle.m
//  RaptorRace
//
//  Created by Nemanja Aksic on 3/19/14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import "RedRaptorObstacle.h"
#import "Categories.h"

@implementation RedRaptorObstacle{
    NSString *raptorType;
}

-(id) init{
    self = [super init];
    [super animateObstacle];
    return self;
}

- (id)initWithGroundHeight:(CGFloat)groundHeight
{
    self = [super initWithGroundHeight:groundHeight];
    [super animateObstacle];
    return self;
}

-(NSString *)getAtlasName
{
    NSLog(@"getAtlas");
    return @"obstacleGreenRaptor";
    
//
//    NSLog(@"name");
//    int index = arc4random() % 2;
//    if(index == 0)
//    {
//        NSLog(@"RED");
//        raptorType = @"obstacleRedRaptor";
//        return @"obstacleRedRaptor";
//    }
//    else
//    {
//        NSLog(@"GREEN");
//        raptorType = @"obstacleGreenRaptor";
//        return @"obstacleGreenRaptor";
//    }
}
    

- (NSString *)getPictureNameFormat
{
    return @"ObstacleRaptor%d";
    
    
    
//    if([raptorType isEqualToString:@"obstacleRedRaptor"]){
//        return @"obstacleRaptor%d";
//    }
//    else{
//        return @"ObstacleRaptor%d";
//    }
//
}

- (void)setPhysicsAbilitiesOfObstacle
{
    NSLog(@"SETS PHysical abilities");
    [super obstacle].physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:[super obstacle].frame.size];
    [super obstacle].physicsBody.allowsRotation = NO;
    [super obstacle].physicsBody.restitution = 0.0;
    [super obstacle].physicsBody.dynamic = NO;
    [super obstacle].physicsBody.categoryBitMask = obstacleCategory;
    [super obstacle].physicsBody.collisionBitMask = dinoCategory;
    [super obstacle].physicsBody.contactTestBitMask = dinoCategory;
    [super obstacle].xScale = 0.5;
    [super obstacle].yScale = 0.5;
}


@end
