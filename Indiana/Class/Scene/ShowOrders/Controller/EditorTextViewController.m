//
//  EditorTextViewController.m
//  Indiana
//
//  Created by Tagcare on 16/8/18.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "EditorTextViewController.h"
#import "TZImagePickerController.h"

@interface EditorTextViewController ()<TZImagePickerControllerDelegate,UITextViewDelegate>
{
    UIImagePickerController *_imagePickerController;
    UIButton * deleteBtnOne;
    UIButton * deleteBtnTwo;
    UIButton * deleteBtnThree;
}

@end

@implementation EditorTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.addImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addImage:)];
    [self.addImageView addGestureRecognizer:tap];
    self.PicOneImageView.userInteractionEnabled = YES;
    self.PicTwoImageView.userInteractionEnabled = YES;
    self.PicThreeImageView.userInteractionEnabled = YES;
    self.moodTextView.delegate = self;
}

- (void)addImage:(id)sender{
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil                                                                             message: nil                                                                       preferredStyle:UIAlertControllerStyleActionSheet];
    //添加Button
    [alertController addAction: [UIAlertAction actionWithTitle: @"拍照" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //处理点击拍照
        //////录像或者拍照
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        //录制视频时长，默认10s
        _imagePickerController.videoMaximumDuration = 15;
        
        //相机类型（拍照、录像...）字符串需要做相应的类型转换
        _imagePickerController.mediaTypes = @[(NSString *)kUTTypeMovie,(NSString *)kUTTypeImage];
        
        //视频上传质量
        //UIImagePickerControllerQualityTypeHigh高清
        //UIImagePickerControllerQualityTypeMedium中等质量
        //UIImagePickerControllerQualityTypeLow低质量
        //UIImagePickerControllerQualityType640x480
        _imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
        
        //设置摄像头模式（拍照，录制视频）为录像模式
        _imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
        [self presentViewController:_imagePickerController animated:YES completion:nil];
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"从相册选取" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        //处理点击从相册选取
        int photoCount = 0;
        if (self.PicOneImageView.image) {
            photoCount = 1;
        }
        if (self.PicTwoImageView.image) {
            photoCount = 2;
        }
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:(3-photoCount) delegate:self];
        
        // You can get the photos by block, the same as by delegate.
        // 你可以通过block或者代理，来得到用户选择的照片.
        //    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets) {
        //
        //    }];
        
        [self presentViewController:imagePickerVc animated:YES completion:nil];
        
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:nil]];
    
    [self.navigationController presentViewController: alertController animated: YES completion: nil];
    
    if (self.PicOneImageView.image && self.PicTwoImageView.image && self.PicThreeImageView.image) {
        self.addImageView.hidden = YES;
    }
    
}

//选取照片代理方法
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    if ([photos count] == 3) {
        self.PicOneImageView.image = photos[0];
        self.PicTwoImageView.image = photos[1];
        self.PicThreeImageView.image = photos[2];
    }
    if ([photos count] == 2) {
        if (self.PicOneImageView.image) {
            self.PicTwoImageView.image = photos[0];
            self.PicThreeImageView.image = photos[1];
        }else{
            self.PicOneImageView.image = photos[0];
            self.PicTwoImageView.image = photos[1];
        }
    }
    if ([photos count] == 1) {
        if (!self.PicOneImageView.image) {
            self.PicOneImageView.image = photos[0];
        }else if (!self.PicTwoImageView.image){
            self.PicTwoImageView.image = photos[0];
        }else{
            self.PicThreeImageView.image = photos[0];
        }
        
    }
    
    
    if (self.PicOneImageView.image) {
        deleteBtnOne = [UIButton buttonWithType:(UIButtonTypeCustom)];
        deleteBtnOne.frame = CGRectMake(self.PicOneImageView.frame.size.width-20, 0, 20, 20);
        [deleteBtnOne setImage:[UIImage imageNamed:@"deletePhoto"] forState:(UIControlStateNormal)];
        [deleteBtnOne addTarget:self action:@selector(deletePhotoOne:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.PicOneImageView addSubview:deleteBtnOne];
    }
    if (self.PicTwoImageView.image) {
        deleteBtnTwo = [UIButton buttonWithType:(UIButtonTypeCustom)];
        deleteBtnTwo.frame = CGRectMake(self.PicOneImageView.frame.size.width-20, 0, 20, 20);
        [deleteBtnTwo setImage:[UIImage imageNamed:@"deletePhoto"] forState:(UIControlStateNormal)];
        [deleteBtnTwo addTarget:self action:@selector(deletePhotoTwo:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.PicTwoImageView addSubview:deleteBtnTwo];
    }
    if (self.PicThreeImageView.image) {
        deleteBtnThree = [UIButton buttonWithType:(UIButtonTypeCustom)];
        deleteBtnThree.frame = CGRectMake(self.PicOneImageView.frame.size.width-20, 0, 20, 20);
        [deleteBtnThree setImage:[UIImage imageNamed:@"deletePhoto"] forState:(UIControlStateNormal)];
        [deleteBtnThree addTarget:self action:@selector(deletePhotoThree:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.PicThreeImageView addSubview:deleteBtnThree];
    }
    
    if (self.PicOneImageView.image && self.PicTwoImageView.image && self.PicThreeImageView.image) {
        self.addImageView.hidden = YES;
    }else{
        self.addImageView.hidden = NO;
    }
}

- (void)deletePhotoOne:(id)sender{
    if (self.PicOneImageView.image && self.PicTwoImageView.image && self.PicThreeImageView.image) {
        self.PicOneImageView.image = self.PicTwoImageView.image;
        self.PicTwoImageView.image = self.PicThreeImageView.image;
        self.PicThreeImageView.image = nil;
        [deleteBtnThree removeFromSuperview];
    }else if (self.PicOneImageView.image && self.PicTwoImageView.image){
        self.PicOneImageView.image = self.PicTwoImageView.image;
        self.PicTwoImageView.image = nil;
        [deleteBtnTwo removeFromSuperview];
    }else if (self.PicOneImageView.image){
        self.PicOneImageView.image = nil;
        [deleteBtnOne removeFromSuperview];
    }
    
    if (self.PicOneImageView.image && self.PicTwoImageView.image && self.PicThreeImageView.image) {
        self.addImageView.hidden = YES;
    }else{
        self.addImageView.hidden = NO;
    }
    
}
- (void)deletePhotoTwo:(id)sender{
    
    if (self.PicThreeImageView.image) {
        self.PicTwoImageView.image = self.PicThreeImageView.image;
        self.PicThreeImageView.image = nil;
        [deleteBtnThree removeFromSuperview];
    }else{
        self.PicTwoImageView.image = nil;
        [deleteBtnTwo removeFromSuperview];
    }
    
    if (self.PicOneImageView.image && self.PicTwoImageView.image && self.PicThreeImageView.image) {
        self.addImageView.hidden = YES;
    }else{
        self.addImageView.hidden = NO;
    }
    
}
- (void)deletePhotoThree:(id)sender{
    self.PicThreeImageView.image = nil;
    [deleteBtnThree removeFromSuperview];
    
    if (self.PicOneImageView.image && self.PicTwoImageView.image && self.PicThreeImageView.image) {
        self.addImageView.hidden = YES;
    }else{
        self.addImageView.hidden = NO;
    }
    
}

//照相代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    if (!self.PicOneImageView.image) {
        self.PicOneImageView.image = info[UIImagePickerControllerEditedImage];
    }else if (!self.PicTwoImageView.image){
        self.PicTwoImageView.image = info[UIImagePickerControllerEditedImage];
    }else{
        self.PicThreeImageView.image = info[UIImagePickerControllerEditedImage];
    }
    
    
//    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
//    //判断资源类型
//    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]){
//        NSString * imageData = [Tools imageChangeBase64:info[UIImagePickerControllerEditedImage]];
//        NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"imageData":imageData}];
////        [UserInfoModel uploadUserIconParameters:parameters
////                                          block:^(NSString *code, NSError *error) {
////                                              
////                                          }];
//        
//    }else{
//        
//    }
//    [self dismissViewControllerAnimated:YES completion:nil];
    if (self.PicOneImageView.image && self.PicTwoImageView.image && self.PicThreeImageView.image) {
        self.addImageView.hidden = YES;
    }
}

#pragma mark - Text View Delegate
-(void)textViewDidChange:(UITextView *)textView
{
    self.placeholderLabel.hidden = [self.moodTextView.text length];
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([@"\n" isEqualToString:text])
    {
        if ([self.moodTextView.text length]) {
            [self.moodTextView resignFirstResponder];
        }
        else
        {
            return NO;
        }
    }
    return YES;
}

- (IBAction)sendOrder:(id)sender {
    
    if ((!self.PicOneImageView.image) || (!self.placeholderLabel.hidden)) {
        NSLog(@"不能为空");
    }else{
        NSString *moodText = self.moodTextView.text;
        NSString *imageOne = [Tools imageChangeBase64:self.PicOneImageView.image];
        NSString *imageTwo = [Tools imageChangeBase64:self.PicTwoImageView.image];
        NSString *imageThree = [Tools imageChangeBase64:self.PicThreeImageView.image];
        //NSArray *imageArr = [NSArray arrayWithObjects:imageOne,imageTwo,imageThree, nil];
        NSSet *imageSet = [NSSet setWithObjects:imageOne,imageTwo,imageThree, nil];
        //NSString *url = [NSString stringWithFormat:@"http://192.168.0.133:8888/api/v1/orderShare?shcedule_id=A1&user_id=sdfsdf&moodText=%@&imageDataList=%@",moodText,imageArr];
        NSString *url = @"http://192.168.0.133:8888/api/v1/orderShare";
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"A1",@"schedule_id",@"sdfsfd",@"user_id",moodText,@"mood",imageSet,@"imageDataList", nil];
        [[DataService sharedClient] POST:url parameters:dic completion:^(id response, NSError *error) {
            if (response) {
                NSLog(@"success");
            }
        }];
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
