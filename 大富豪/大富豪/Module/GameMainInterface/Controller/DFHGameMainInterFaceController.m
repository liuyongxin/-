//
//  DFHGameMainInterFaceController.m
//  大富豪
//
//  Created by Louis on 2016/10/28.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "DFHGameMainInterFaceController.h"
#import "VideoDisplayView.h"
#import "ScoreStatisticsView.h"
#import "RoundInningView.h"
#import "MachineStatusView.h"
#import "LotteryView.h"
#import "RecordView.h"
#import "SingleView.h"
#import "SettingView.h"
#import "BetPointsView.h"

@interface DFHGameMainInterFaceController ()
{
    DFHHttpRequest *_httpRequest;
}
@property(nonatomic,retain)UIImageView *mainBGImageView;
@property(nonatomic,retain)UILabel *timingLabel;
@property(nonatomic,retain)VideoDisplayView *videoDisplayView;
@property(nonatomic,retain)ScoreStatisticsView *scoreStatisticsView;
@property(nonatomic,retain)RoundInningView *roundInningView;
@property(nonatomic,retain)UIButton *settingButton;
@property(nonatomic,retain)SettingView *settingView;
@property(nonatomic,retain)MachineStatusView *machineStatusView;
@property(nonatomic,retain)LotteryView *lotteryView;
@property(nonatomic,retain)RecordView *recordView;
@property(nonatomic,retain)SingleView *singleView;
@property(nonatomic,retain)BetPointsView *betPointsView;

@property(nonatomic,copy)NSString *rounds;
@property(nonatomic,copy)NSString *bouts;
@property(nonatomic,copy)NSString *status;

@end

@implementation DFHGameMainInterFaceController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareData];
    [self configUI];
}

- (void)prepareData
{
    _httpRequest = [[DFHHttpRequest alloc]init];
}

- (void)configUI
{
    _mainBGImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DFHScreenW, DFHScreenH)];
    _mainBGImageView.userInteractionEnabled = YES;
    _mainBGImageView.image = [UIImage imageNamed:@"MainBg.png" bundle:DFHImageResourceBundle_Main];
    [self.view addSubview:_mainBGImageView];
    
    CGFloat VideoDisplayViewWidth = 105*DFHSizeWidthRatio;
    CGFloat VideoDisplayViewHeight = 125*DFHSizeHeightRatio;
    CGFloat ScoreStatisticsViewWidth = 105*DFHSizeWidthRatio;
    CGFloat ScoreStatisticsViewHeight = 85*DFHSizeHeightRatio;
    CGFloat RoundInningViewWidth = 70*DFHSizeWidthRatio;
    CGFloat RoundInningViewHeight = 60*DFHSizeHeightRatio;
    CGFloat TimingLabelHeight = 20*DFHSizeHeightRatio;

    CGFloat MachineStatusViewWidth = 315*DFHSizeWidthRatio;
    CGFloat  MachineStatusViewHeight = 40*DFHSizeHeightRatio;
    CGFloat LotteryViewWidth = 115*DFHSizeWidthRatio;
    CGFloat  LotteryViewHeight = 185*DFHSizeHeightRatio;
    CGFloat RecordViewWidth = 195*DFHSizeWidthRatio;
    CGFloat  RecordViewHeight = 185*DFHSizeHeightRatio;
    CGFloat SingleViewWidth = 30*DFHSizeWidthRatio;
    CGFloat  SingleViewHeight = 185*DFHSizeHeightRatio;
    
    CGFloat  BetPointsViewWidth = 390*DFHSizeWidthRatio;
    CGFloat  BetPointsViewHeight = 75*DFHSizeHeightRatio;
    
    CGFloat xSpace = 5 *DFHSizeWidthRatio;
    CGFloat ySpace = 5*DFHSizeHeightRatio;

    CGFloat startX = 2 * xSpace;//(DFHScreenW - VideoDisplayViewWidth - MachineStatusViewWidth - SingleViewWidth)/2;
    CGFloat startY = 2 * ySpace;//(DFHScreenH - VideoDisplayViewHeight -ScoreStatisticsViewHeight - RoundInningViewHeight - TimingLabelHeight)/2;
    CGFloat xAxis = startX;
    CGFloat yAxis = startY;
    
    _videoDisplayView = [[VideoDisplayView alloc]initWithFrame:CGRectMake(xAxis, yAxis, VideoDisplayViewWidth, VideoDisplayViewHeight)];
    [_mainBGImageView addSubview:_videoDisplayView];
    yAxis += VideoDisplayViewHeight;
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(xAxis, yAxis, VideoDisplayViewWidth/2, TimingLabelHeight)];
    titleLabel.text = @"计时";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.textColor = [UIColor whiteColor];
    [_mainBGImageView addSubview:titleLabel];
    _timingLabel = [[UILabel alloc]initWithFrame:CGRectMake(xAxis+VideoDisplayViewWidth/2, yAxis,VideoDisplayViewWidth/2 , TimingLabelHeight)];
    _timingLabel.adjustsFontSizeToFitWidth = YES;
    _timingLabel.textAlignment = NSTextAlignmentCenter;
    _timingLabel.text = @"0";
    _timingLabel.textColor = [UIColor whiteColor];
    [_mainBGImageView addSubview:_timingLabel];
    yAxis += TimingLabelHeight;
    
    _scoreStatisticsView = [[ScoreStatisticsView alloc]initWithFrame:CGRectMake(xAxis, yAxis, ScoreStatisticsViewWidth, ScoreStatisticsViewHeight)];
    [_mainBGImageView addSubview:_scoreStatisticsView];
    yAxis += ScoreStatisticsViewHeight + ySpace;
    _roundInningView = [[RoundInningView alloc]initWithFrame:CGRectMake(xAxis, yAxis, RoundInningViewWidth, RoundInningViewHeight)];
    [_mainBGImageView addSubview:_roundInningView];
    
    yAxis = startY;
    xAxis += VideoDisplayViewWidth;
    _machineStatusView = [[MachineStatusView alloc]initWithFrame:CGRectMake(xAxis, yAxis, MachineStatusViewWidth + xSpace, MachineStatusViewHeight)];
    [_mainBGImageView addSubview:_machineStatusView];
    
    _settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _settingButton.frame = CGRectMake(DFHScreenW - 35*DFHSizeMinRatio - 8*DFHSizeWidthRatio, 1, 35*DFHSizeMinRatio, 35*DFHSizeMinRatio);
    [_settingButton setBackgroundImage:[UIImage imageNamed:@"Main_Setting_Normal.png" bundle:DFHImageResourceBundle_Main_Setting] forState:UIControlStateNormal];
    [_settingButton setBackgroundImage:[UIImage imageNamed:@"Main_Setting_Selected.png" bundle:DFHImageResourceBundle_Main_Setting] forState:UIControlStateSelected];
    [_mainBGImageView addSubview:_settingButton];
    [_settingButton addTarget:self action:@selector(settingButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _settingView = [[SettingView alloc]initWithFrame:self.view.bounds];
    
    yAxis += MachineStatusViewHeight;
    _lotteryView = [[LotteryView alloc]initWithFrame:CGRectMake(xAxis, yAxis, LotteryViewWidth, LotteryViewHeight)];
    [_mainBGImageView addSubview:_lotteryView];
    
    xAxis +=  LotteryViewWidth +xSpace;
    _recordView = [[RecordView alloc]initWithFrame:CGRectMake(xAxis, yAxis, RecordViewWidth, RecordViewHeight)];
    [_mainBGImageView addSubview:_recordView];
    
     xAxis +=  RecordViewWidth + xSpace;
    _singleView = [[SingleView alloc]initWithFrame:CGRectMake(xAxis, yAxis, SingleViewWidth, SingleViewHeight)];
    [_mainBGImageView addSubview:_singleView];
    
    yAxis +=  SingleViewHeight + ySpace;
    xAxis = startX + RoundInningViewWidth;
    _betPointsView = [[BetPointsView alloc]initWithFrame:CGRectMake(xAxis, yAxis, BetPointsViewWidth, BetPointsViewHeight)];
    [_mainBGImageView addSubview:_betPointsView];
}

- (void)settingButtonAction:(UIButton *)btn
{
    [_settingView showInSuperView:self.view targetView:nil animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestHistoryBrandRoad:self.machineId];
}

#pragma mark - request
//根据机器 id 获取机器设置接口
 - (void)requestMachineSeting:(NSString *)machineId
{
    NSString *urlStr = [DFHRequestDataInterface makeRequestMachineSeting:machineId];
    [_httpRequest postWithURLString:urlStr parameters:nil success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}

//修改押分接口(手游版)
- (void)requestModifyPoints:(NSString *)memberId score:(NSString *)score machineId:(NSString *)machineId rounds:(NSString *)rounds bouts:(NSString *)bounts color:(NSString *)color
{
    NSString *urlStr = [DFHRequestDataInterface makeRequestModifyPoints:memberId score:score machineId:machineId rounds:rounds bouts:bounts color:color];
    [_httpRequest postWithURLString:urlStr parameters:nil success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}

//修改盈利接口(手游版)<每局结束时调用>
 - (void)requestModifyProfit:(NSString *)memberId profit:(NSString *)profit machineId:(NSString *)machineId
{
    NSString *urlStr = [DFHRequestDataInterface makeRequestModifyProfit:memberId profit:profit machineId:machineId];
    [_httpRequest postWithURLString:urlStr parameters:nil success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}

//获取单个牌路(请求返回为 aes 加密字符串)
- (void)requestObtainSingleCard:(NSString *)machineId rounds:(NSString *)rounds bouts:(NSString *)bouts
{
    NSString *urlStr = [DFHRequestDataInterface makeRequestObtainSingleCard:machineId rounds:rounds bouts:bouts];
    [_httpRequest postWithURLString:urlStr parameters:nil success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}

//修改某局状态接口(请求返回为 aes 加密字符串)
 - (void)requestModifyBureauState:(NSString *)machineId rounds:(NSString *)rounds bouts:(NSString *)bouts status:(NSString *)status
{
    NSString *urlStr = [DFHRequestDataInterface makeRequestModifyBureauState:machineId rounds:rounds bouts:bouts status:status];
    [_httpRequest postWithURLString:urlStr parameters:nil success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}

//获取历史牌路接口(请求返回为 aes 加密字符串)
- (void)requestHistoryBrandRoad:(NSString *)machineId
{
    __weak typeof(self) weakSelf = self;
    NSString *urlStr = [DFHRequestDataInterface makeRequestHistoryBrandRoad:machineId];
    [_httpRequest getWithURLString:urlStr parameters:nil success:^(id responseObject) {
        if ([responseObject isKindOfClass:[NSData class]]) {
         NSString *str = ((NSData *)responseObject).description;
         NSString *jsonStr =  [AES AES128Decrypt:str key:Decryption_AESSecretKey];
         NSDictionary *dataDic = [JSONFormatFunc parseToDict:jsonStr];
         NSArray *dataArray = [JSONFormatFunc arrayValueForKey:@"historyList" ofDict:dataDic];
            if ([dataArray isValidArray]) {
                [weakSelf.recordView refreshRecordData:dataArray];
            }
        }
    } failure:^(NSError *error) {
        
    }];
}

//生成牌路接口
 - (void)requestGenerateBrandRoad:(NSString *)machineId
{
    NSString *urlStr = [DFHRequestDataInterface makeRequestGenerateBrandRoad:machineId];
    [_httpRequest postWithURLString:urlStr parameters:nil success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}
@end
