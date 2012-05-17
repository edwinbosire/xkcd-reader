//
//  transcriptViewController.m
//  xkcd
//
//  Created by Edwin on 21/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "transcriptViewController.h"

@implementation transcriptViewController

@synthesize transcriptText;

- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

-(void)setTranscriptText:(NSString *)newTranscriptText{
    
    if (transcriptText) {
        transcriptText = nil;
    }
    
    
    transcript.text = newTranscriptText;
}

#pragma mark - View lifecycle


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        transcriptView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
        transcriptView.backgroundColor = [UIColor clearColor];
        
        UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"transcript.png"]];
        backgroundImage.frame = CGRectMake(0,0,320,self.frame.size.height);
        
        [transcriptView addSubview:backgroundImage];
        
        transcript = [[UITextView alloc] initWithFrame:CGRectMake(0, 19, 320, 60)];
        transcript.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.8];
        transcript.backgroundColor = [UIColor clearColor];
        transcript.textColor = [UIColor whiteColor];
        transcript.text =transcriptText;
        transcript.editable = NO;
        
        transcript.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        NSLog(@"transcript %@", transcriptText);
        
        [transcriptView addSubview:transcript];
        [self addSubview:transcriptView];
        
    }
        
    return self;
}





@end
