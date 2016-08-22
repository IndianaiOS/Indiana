//
//  PersonalViewController.m
//  Indiana
//
//  Created by Tagcare on 16/6/17.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "PersonalViewController.h"
#import "PersonalCell.h"
#import "PersonalHeaderView.h"
#import "LoginRootViewController.h"
#import "RechargeRecordViewController.h"
#import "OrdersListViewController.h"

static NSString *const personalCellIdentifier = @"personalCell";
static NSString *const personalHeaderViewIdentifier = @"personalHeaderView";

@interface PersonalViewController ()<PersonalHeaderViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIImagePickerController *_imagePickerController;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self tableViewRegister];
    
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    _imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    _imagePickerController.allowsEditing = YES;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = NO;

}

- (void)tableViewRegister {
    [self.tableView registerNib:[UINib nibWithNibName:@"PersonalCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:personalCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"PersonalHeaderView" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:personalHeaderViewIdentifier];
    self.tableView.tableFooterView = [[UIView alloc]init];

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 0;
    }
    return 210;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UserInfoModel *user = [LocaldData achieveListDataType];
        PersonalHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:personalHeaderViewIdentifier];
        [headerView personalheaderView:headerView model:user];
        [headerView.loginBtn addTarget:self
                                action:@selector(headerViewLoginBtnAction:)
                      forControlEvents:UIControlEventTouchUpInside];
        headerView.delegate = self;
        return headerView;
    }
    return nil;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonalCell *cell = [tableView dequeueReusableCellWithIdentifier:personalCellIdentifier];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                cell.titleLabel.text = NSLocalizedString(@"积分", nil);
                break;
            case 1:
                cell.titleLabel.text = NSLocalizedString(@"优惠券", nil);
                break;
            case 2:
                cell.titleLabel.text = NSLocalizedString(@"管理收货地址", nil);
                break;
            default:
                break;
        }

    }else {
        switch (indexPath.row) {
            case 0:
                cell.titleLabel.text = NSLocalizedString(@"订单记录", nil);
                break;
            case 1:
                cell.titleLabel.text = NSLocalizedString(@"充值记录", nil);
                break;
            case 2:
                cell.titleLabel.text = NSLocalizedString(@"绑定银行卡", nil);
                break;
            default:
                break;
        }
    }
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:

                break;
            case 1:
                break;
            case 2:
                break;
            default:
                break;
        }
        
    }else {
        switch (indexPath.row) {
            case 0:{
                UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Orders" bundle:[NSBundle mainBundle]];
                OrdersListViewController *ordersVC = (OrdersListViewController *)[storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(OrdersListViewController.class)];                [self.navigationController showViewController:ordersVC sender:nil];
                
            }
                break;
            case 1:{
                RechargeRecordViewController * rechargeRecordVC = [[RechargeRecordViewController alloc] initWithNibName:@"RechargeRecordViewController" bundle:nil];
                [self.navigationController showViewController:rechargeRecordVC sender:nil];
            }
                break;
            case 2:{
                UIImage *image = [UIImage imageNamed:@"icon"];
                NSString * imageData = [Tools imageChangeBase64:image];
                NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"imageData":imageData}];
                [UserInfoModel uploadUserIconParameters:parameters
                                                  block:^(NSString *code, NSError *error) {
                                                      
                                                  }];
            }
                break;
            default:
                break;
        }
    }


}

#define mark - button Action
- (void)headerViewLoginBtnAction:(UIButton *)btn {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]];
    
    LoginRootViewController *loginRootVC = (LoginRootViewController *)[storyboard instantiateViewControllerWithIdentifier:@"loginRootViewController"];
    UINavigationController *loginRootNC = [[UINavigationController alloc] initWithRootViewController:loginRootVC];
    [self presentViewController:loginRootNC animated:YES completion:nil];
}

- (void)changeUserIconTap {
    
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
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:_imagePickerController animated:YES completion:nil];
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController: alertController animated: YES completion: nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    //判断资源类型
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]){
        NSString * imageData = [Tools imageChangeBase64:info[UIImagePickerControllerEditedImage]];
        NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"imageData":imageData}];
        [UserInfoModel uploadUserIconParameters:parameters
                                          block:^(NSString *code, NSError *error) {
                                              [self.tableView reloadData];
                                          }];
        
    }else{
        
    }
    [self dismissViewControllerAnimated:YES completion:nil];
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
