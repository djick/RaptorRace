//
//  GreenRaptorObstacle.m
//  RaptorRace
//
//  Created by Nemanja Aksic on 3/21/14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import "GreenRaptorObstacle.h"

@implementation GreenRaptorObstacle

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
    return @"obstacleGreenRaptor";
}


- (NSString *)getPictureNameFormat
{
    return @"ObstacleRaptor%d";
}



@end
