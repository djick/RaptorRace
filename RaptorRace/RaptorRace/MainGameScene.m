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

-(CGVector)getGravityVector{
    return CGVectorMake(0, -10);
}

- (NSString *) getGroundAtlasName
{
    return @"gr";
}

- (NSString* ) getGroundPictureNameFormat
{
    return @"gr%d";
}

- (NSString *) getBackgroundPictureName
{
    return @"landscape";
}

- (NSString *) getCloudPictureName
{
    return @"dark_cloud";
}

- (SKColor *) getBackgroundColor
{
    return [SKColor colorWithRed:107.0/255.0
                           green:190.0/255.0
                            blue:242.0/255.0
                           alpha:1.0];
}

- (SKColor *) getScoreCounterColor
{
    return [SKColor colorWithRed:255.0/255.0
                           green:255.0/255.0
                            blue:255.0/255.0
                           alpha:1.0];
}

- (NSString *) getScoreCounterFontName
{
    return @"Courier-Bold";
}

- (NSString *)getPauseButton{
    return @"PauseButton";
}


-(void)didBeginContact:(SKPhysicsContact*)contact {
    NSLog(@"CONTACT");
    if (contact.bodyA.categoryBitMask ==dinoCategory && contact.bodyB.categoryBitMask==obstacleCategory){
        NSLog(@"collison detected");
        if (collisions==2) {
            //gameover
            NSNumber *high =[[NSNumber alloc] initWithFloat:[[ScoreSingleton getInstance] getScore]];
            [[NSUserDefaults standardUserDefaults] setObject:high forKey:@"highscore"];
            [[ScoreSingleton getInstance] stopTimer];
            [scoreLabel removeFromParent];
            SKTransition *reveal = [SKTransition doorsCloseVerticalWithDuration:1.0];
            GameOverScene *gameover = [[GameOverScene alloc] initWithSize:self.size];
            [self.view presentScene:gameover transition:reveal];
            
        }
        if (raptor.undead == YES) {
            
        }
        else{
            collisions=collisions+1;
            [raptor looseLife];
            if(collisions == 1){
                [self setBackgroundColor:[SKColor colorWithRed:255/255.0
                                                         green:87/255.0
                                                          blue:38/255.0
                                                         alpha:1.0]];
            }
            else{
                [self setBackgroundColor:[SKColor colorWithRed:((collisions*42.5)+107.0)/255.0
                                                         green:(190.0 - (collisions*62))/255.0
                                                          blue:(242.0- (collisions*94))/255.0
                                                         alpha:1.0]];
            }
            
        }
    }
    if (contact.bodyA.categoryBitMask ==obstacleCategory && contact.bodyB.categoryBitMask==dinoCategory){
        NSLog(@"collison detected");
        if (collisions==2) {
            //gameover
            NSNumber *high =[[NSNumber alloc] initWithFloat:[[ScoreSingleton getInstance] getScore]];
            [[NSUserDefaults standardUserDefaults] setObject:high forKey:@"highscore"];
            [[ScoreSingleton getInstance] stopTimer];
            [scoreLabel removeFromParent];
            SKTransition *reveal = [SKTransition doorsCloseVerticalWithDuration:1.0];
            GameOverScene *gameover = [[GameOverScene alloc] initWithSize:self.size];
            [self.view presentScene:gameover transition:reveal];
            
        }
        if (raptor.undead == YES) {
            
        }
        else{
            collisions=collisions+1;
            [raptor looseLife];
            [self setBackgroundColor:[SKColor colorWithRed:((collisions*80)+113.0)/255.0
                                                     green:(197.0 - (collisions*40))/255.0
                                                      blue:(207.0- (collisions*80))/255.0
                                                     alpha:1.0]];
            
        }
    }
}






@end
