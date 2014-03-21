//
//  MainGameScene.m
//  RaptorRace
//
//  Created by Nemanja Aksic on 3/21/14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import "MainGameScene.h"

@implementation MainGameScene {
    int collisions;
}

- (NSString *) getGroundAtlasName
{
    return @"ground";
}

- (NSString* ) getGroundPictureNameFormat
{
    return @"groun%d";
}

- (NSString *) getBackgroundPictureName
{
    return @"landscape";
}

- (NSString *) getCloudPictureName
{
    return @"cloud";
}

- (SKColor *) getBackgroundColor
{
    return [SKColor colorWithRed:113.0/255.0
                           green:197.0/255.0
                            blue:207.0/255.0
                           alpha:1.0];
}

- (SKColor *) getScoreCounterColor
{
    return [SKColor colorWithRed:251.0/255.0
                           green:127.0/255.0
                            blue:108.0/255.0
                           alpha:1.0];
}

- (NSString *) getScoreCounterFontName
{
    return @"Courier-Bold";
}


-(void)didBeginContact:(SKPhysicsContact*)contact {
    NSLog(@"CONTACT");
    if (contact.bodyA.categoryBitMask ==dinoCategory && contact.bodyB.categoryBitMask==obstacleCategory){
        NSLog(@"collison detected");
        if (collisions==2) {
            //gameover
            [[ScoreSingleton getInstance] stopTimer];
            [scoreLabel removeFromParent];
            [self.view presentScene:[[GameOverScene alloc] initWithSize:self.size] transition:SKTransitionDirectionUp];
            
        }
        if (raptor.undead == YES) {
            
        }
        else{
            collisions=collisions+1;
            [raptor looseLife];
        }
    }
    if (contact.bodyA.categoryBitMask ==obstacleCategory && contact.bodyB.categoryBitMask==dinoCategory){
        NSLog(@"collison detected");
        if (collisions==2) {
            //gameover
            [scoreLabel removeFromParent];
            [self.view presentScene:[[GameOverScene alloc] initWithSize:self.size]];
            [[ScoreSingleton getInstance] stopTimer];
        }
        if (raptor.undead == YES) {
            
        }
        else{
            collisions=collisions+1;
            [raptor looseLife];
        }
    }
}






@end
