//
//  TemplateTestRaptor.h
//  RaptorRace
//
//  Created by Martin Solheim on 13/03/14.
//  Copyright (c) 2014 iOne. All rights reserved.
//

#import "AnyRaptor.h"

@interface TemplateTestRaptor : AnyRaptor

@property SKSpriteNode * raptor;

- (NSString *) getAtlasName;
- (NSString* ) getPictureNameFormat;

// TemplateTestRaptor specific methods

- (NSString *) getTemplateTestRaptorAtlasName;
- (NSString* ) getTemplateTestRaptorPictureNameFormat;

@end

