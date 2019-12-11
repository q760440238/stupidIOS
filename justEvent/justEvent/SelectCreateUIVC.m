//
//  SelectCreateUIVC.m
//  justEvent
//
//  Created by 魏勇城 on 2019/12/11.
//  Copyright © 2019 余谦. All rights reserved.
//

#import "SelectCreateUIVC.h"
#import "UIColor+HexColor.h"
#import "ViewController.h"

#define FULL_SCREEN_HEIGHT      [UIScreen mainScreen].bounds.size.height
#define FULL_SCREEN_WIDTH       [UIScreen mainScreen].bounds.size.width

#define getTabbarHeight (self.tabBarController.tabBar.bounds.size.height)


//UI左侧起始位置
#define G_UI_START_X ((FULL_SCREEN_WIDTH < 414)?15:20)
//UI宽度
#define G_UI_WIDTH (FULL_SCREEN_WIDTH - 2 * G_UI_START_X)
//宽度比例适配
#define G_GET_SCALE_LENTH(a)  a/750.0f*FULL_SCREEN_WIDTH*2.0
//高度比例适配
#define G_GET_SCALE_HEIGHT(a)  a/1334.0f*FULL_SCREEN_HEIGHT*2.0

@interface SelectCreateUIVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *arr;

@end

@implementation SelectCreateUIVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _arr = @[@"在view中绘制",@"在viewcontroller中绘制",@"在scrollView中绘制",@"在tableviewcell中绘制"];
    [self initTableView];
}

- (void)initTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, FULL_SCREEN_WIDTH, FULL_SCREEN_HEIGHT-40) style:UITableViewStyleGrouped];
    tableView.delegate        = self;
    tableView.dataSource      = self;
    tableView.backgroundColor = [UIColor clearColor];
    [tableView  setSeparatorColor:[UIColor clearColor]];
    _tableView = tableView;
    _tableView.showsVerticalScrollIndicator = NO;
    
    _tableView.estimatedRowHeight = 60;
    _tableView.estimatedSectionHeaderHeight = 30;
    _tableView.estimatedSectionFooterHeight = 0;
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.view addSubview:_tableView];
    
}

#pragma mark - tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HeaderViewID"];
    if (headerView == nil) {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"HeaderViewID"];
        UILabel *selectBoard = [[UILabel alloc] initWithFrame:CGRectMake(G_GET_SCALE_LENTH(17), 0, G_GET_SCALE_LENTH(200), 32)];
        selectBoard.font = [UIFont systemFontOfSize:14];
        selectBoard.textColor = [UIColor colorWithHexString:@"A6A6A6"];
        selectBoard.text = @"选择布局创建";
        [headerView addSubview:selectBoard];
    }
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 32;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.001;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CreateUICell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CreateUICell"];
        cell.textLabel.text = _arr[indexPath.row];
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ViewController *vc = [ViewController new];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
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
