//
//  EditorTextViewController.h
//  Indiana
//
//  Created by Tagcare on 16/8/18.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditorTextViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *PicOneImageView;
@property (weak, nonatomic) IBOutlet UIImageView *PicTwoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *PicThreeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *addImageView;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;
@property (weak, nonatomic) IBOutlet UITextView *moodTextView;

@end
