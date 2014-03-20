//
//  StoneObstacle.m
//  RaptorRace
//
//  Created by Martin Solheim on 20/03/14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import "StoneObstacle.h"

@implementation StoneObstacle

- (id)initWithGroundHeight:(CGFloat)groundHeight{
    self = [super initWithGroundHeight:groundHeight];
    return self;
}
- (NSString* ) getPictureName
{
    return @"stone_obstacle";
}

@end
