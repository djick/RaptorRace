//
//  TemplateTestRaptor.m
//  RaptorRace
//
//  Created by Martin Solheim on 13/03/14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import "TemplateTestRaptor.h"

@implementation TemplateTestRaptor

- (NSString *) getAtlasName
{
    return [self getTemplateTestRaptorAtlasName];
}

- (NSString* ) getPictureNameFormat
{
    return [self getTemplateTestRaptorPictureNameFormat];
}

#pragma mark -
#pragma mark TemplateTestRaptor specific methods

- (NSString *) getTemplateTestRaptorAtlasName
{
    return @"sillyRaptor";
}
- (NSString* ) getTemplateTestRaptorPictureNameFormat
{
    return @"RaptorRunning%d";
}

@end
