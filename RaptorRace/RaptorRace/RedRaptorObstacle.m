//
//  RedRaptorObstacle.m
//  RaptorRace
//
//  Created by Nemanja Aksic on 3/19/14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import "RedRaptorObstacle.h"
#import "Categories.h"

@implementation RedRaptorObstacle

-(id) init{
    self = [super init];
    [super animateObstacle];
    return self;
}

-(NSString *)getAtlasName{
    NSLog(@"name");
    return @"obstacleRaptor";
}

- (NSString *)getPictureNameFormat{
    NSLog(@"nameFormat");
    return @"obstacleRaptor%d";
}

- (void)setPhysicsAbilitiesOfObstacle{
    NSLog(@"SETS PHysical abilities");
    [super obstacle].physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:[super obstacle].frame.size];
    [super obstacle].physicsBody.allowsRotation = NO;
    [super obstacle].physicsBody.restitution = 0.0;
    [super obstacle].physicsBody.dynamic = NO;
    [super obstacle].physicsBody.categoryBitMask = obstacleCategory;
    [super obstacle].physicsBody.collisionBitMask = dinoCategory;
    [super obstacle].physicsBody.contactTestBitMask = dinoCategory;
}
@end
