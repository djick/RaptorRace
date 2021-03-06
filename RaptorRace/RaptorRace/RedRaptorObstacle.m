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

- (id)initWithGroundHeight:(CGFloat)groundHeight
{
    self = [super initWithGroundHeight:groundHeight];
    [super animateObstacle];
    return self;
}

-(NSString *)getAtlasName
{
    return @"obstacleRedRaptor";

}
    

- (NSString *)getPictureNameFormat
{
    return @"obstacleRaptor%d";
}


@end
