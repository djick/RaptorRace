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
    NSLog(@"name");
    int index = arc4random() % 2;
    if(index == 0)
    {
        NSLog(@"RED");
        raptorType = @"obstacleRedRaptor";
        return @"obstacleRedRaptor";
    }
    else
    {
        NSLog(@"GREEN");
        raptorType = @"obstacleGreenRaptor";
        return @"obstacleGreenRaptor";
    }
}
    

- (NSString *)getPictureNameFormat
{
    if([raptorType isEqualToString:@"obstacleRedRaptor"]){
        return @"obstacleRaptor%d";
    }
    else{
        return @"ObstacleRaptor%d";
    }

}


@end
