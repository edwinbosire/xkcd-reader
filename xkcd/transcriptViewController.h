//
//  transcriptViewController.h
//  xkcd
//
//  Created by Edwin on 21/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface transcriptViewController : UIView{
    
    UIView *transcriptView;
    UITextView *transcript;
}

@property (nonatomic, weak) NSString *transcriptText;
@end
