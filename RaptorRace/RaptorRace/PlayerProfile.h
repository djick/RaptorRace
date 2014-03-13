//
//  PlayerProfile.h
//  RaptorRace
//
//  Created by Martin Solheim on 11/03/14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayerProfile : NSObject
@property(nonatomic,readonly) GLfloat highScore;
-(void)updateScore:(CGFloat)newScore;
@end
