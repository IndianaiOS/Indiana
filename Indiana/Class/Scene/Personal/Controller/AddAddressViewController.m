//
//  AddAddressViewController.m
//  Indiana
//
//  Created by Tagcare on 16/8/26.
//  Copyright © 2016年 Tagcare. All rights reserved.
//

#import "AddAddressViewController.h"
#import "AddressTableViewCell.h"
#import "DefaultTableViewCell.h"
#import "WriteTableViewCell.h"

static NSString *addUrl = @"http://192.168.0.123:8888/api/v1/address/userAddresses?push_token=123456789";

@interface AddAddressViewController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>
@property(nonatomic,strong)UIPickerView *picker;
@property(nonatomic,strong)UIToolbar *toolbar;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *phone;
@property(nonatomic,copy)NSString *address;
@property(nonatomic,copy)NSString *province;
@property(nonatomic,copy)NSString *city;
@property(nonatomic,copy)NSString *district;
@property(nonatomic,copy)NSString *erea;
@property(nonatomic,strong)NSMutableDictionary *userDic;
@property(nonatomic,strong)NSMutableDictionary *proDic;

@end

@implementation AddAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"添加新地址";
    
    self.addressTableView.delegate = self;
    self.addressTableView.dataSource =self;
    self.addressTableView.tableFooterView = [[UIView alloc]init];
    [self.addressTableView registerNib:[UINib nibWithNibName:@"AddressTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"addressTableViewCell"];
    [self.addressTableView registerNib:[UINib nibWithNibName:@"DefaultTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"defaultTableViewCell"];
    
    [self.addressTableView registerNib:[UINib nibWithNibName:@"WriteTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"writeTableViewCell"];
    
    self.picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT-200, SCREENWIDTH, 200)];
    self.picker.delegate = self;
    self.picker.dataSource = self;
    self.toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT-240, SCREENWIDTH, 40)];
    UIBarButtonItem *firstButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(addAddressToTextField:)];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    self.toolbar.items = [[NSArray alloc] initWithObjects: flexSpace, firstButton,nil];
    
    self.userDic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"",@"userName",@"",@"tel",@"",@"province",@"",@"city",@"",@"district",@"1",@"isDefault",@"ggg",@"detailed", nil];
    
    self.proDic = [NSMutableDictionary dictionaryWithCapacity:5];
    NSArray *bjArr = [NSArray arrayWithObject:@"beijing"];
    [self.proDic setValue:bjArr forKey:@"BJ"];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 5) {
        return 64;
    }
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressTableViewCell *cellOne = [tableView dequeueReusableCellWithIdentifier:@"addressTableViewCell"];
    DefaultTableViewCell *cellTwo = [tableView dequeueReusableCellWithIdentifier:@"defaultTableViewCell"];
    WriteTableViewCell *cellThree = [tableView dequeueReusableCellWithIdentifier:@"writeTableViewCell"];
    [cellOne.detailText addTarget:self action:@selector(textFieldFinish:) forControlEvents:(UIControlEventEditingDidEnd)];
    if (indexPath.row<4) {
        switch (indexPath.row) {
            case 0:
                cellOne.nameLabel.text = @"收货人";
                cellOne.detailText.placeholder = @"请输入姓名";
                cellOne.detailText.tag = indexPath.row;
                break;
            case 1:
                cellOne.nameLabel.text = @"联系方式";
                cellOne.detailText.placeholder = @"请输入联系方式";
                cellOne.detailText.tag = indexPath.row;
                break;
            case 2:
                cellOne.nameLabel.text = @"地区";
                cellOne.detailText.placeholder =@"";
                cellOne.detailText.tag = indexPath.row;
                cellOne.detailText.text = self.erea;
                cellOne.detailText.userInteractionEnabled = NO;
                break;
            case 3:
                cellOne.nameLabel.text = @"详细地址";
                cellOne.detailText.placeholder = @"请输入详细地址";
                cellOne.detailText.tag = indexPath.row;
                break;
            default:
                break;
        }
        return cellOne;
    }else if (indexPath.row == 5){
        return cellThree;
    }
    else{
        cellTwo.defaultSwitch.on = YES;
        return cellTwo;
    }
    
}

- (void)textFieldFinish:(UITextField *)textField{
    switch (textField.tag) {
        case 0:
            self.name = textField.text;
            [self.userDic setValue:self.name forKey:@"userName"];
            break;
        case 1:
            self.phone = textField.text;
            [self.userDic setValue:self.phone forKey:@"tel"];
            break;
        case 3:
            self.address = textField.text;
            [self.userDic setValue:self.address forKey:@"detailed"];
            break;
        
        default:
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 5) {
        NSString *ggg = @"http://192.168.0.123:8888/api/v1/address/userAddresses?push_token=123456789";
        NSString *url = @"";
        //发送地址数据
        for (NSString *str in [self.userDic allKeys]) {
            if ([[self.userDic objectForKey:str] isEqualToString:@""]) {
                NSLog(@"请补全信息");
                return;
            }
            url = [NSString stringWithFormat:@"%@%@&%@=%@",url,ggg,str,[self.userDic objectForKey:str]];
            ggg = @"";
        }
        [[DataService sharedClient]POST:url parameters:@{} completion:^(id response, NSError *error) {
            NSLog(@"success");
        }];
        
    }
    if (indexPath.row == 2) {
        //地址选择器
        [self.view addSubview:self.toolbar];
        [self.view addSubview:self.picker];
        
    }
}

- (void)addAddressToTextField:(id)sender{
    self.erea = @"**省**市**区";
    [self.addressTableView reloadData];
    [self.toolbar removeFromSuperview];
    [self.picker removeFromSuperview];
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 9;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        return [NSString stringWithFormat:@"%ld",row];
    }else if (component == 1){
        return [NSString stringWithFormat:@"%ld",row];
    }else{
        return [NSString stringWithFormat:@"%ld",row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [self.userDic setValue:@"1" forKey:@"province"];
    [self.userDic setValue:@"2" forKey:@"city"];
    [self.userDic setValue:@"3" forKey:@"district"];
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
