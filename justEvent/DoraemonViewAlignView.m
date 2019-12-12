//
//  DoraemonViewAlignView.m
//  DoraemonKit-DoraemonKit
//
//  Created by yixiang on 2018/6/16.
//

#import "DoraemonViewAlignView.h"
#import "DoraemonDefine.h"
#import "DoraemonVisualInfoWindow.h"
#import "UIColor+HexColor.h"
#import "SDAutoLayout.h"

#define ALIGN_COLOR @"#FF0000"

static CGFloat const kViewCheckSize = 62;

@interface DoraemonViewAlignView()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *horizontalLine;//水平线
@property (nonatomic, strong) UIView *verticalLine;//垂直线
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) UILabel *bottomLabel;
@property (nonatomic, strong) DoraemonVisualInfoWindow *infoWindow; 

@end



@implementation DoraemonViewAlignView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, DoraemonScreenWidth, DoraemonScreenHeight);
        self.backgroundColor = [UIColor clearColor];
        self.layer.zPosition = FLT_MAX;
        //self.userInteractionEnabled = NO;
        
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(DoraemonScreenWidth/2-kViewCheckSize/2, DoraemonScreenHeight/2-kViewCheckSize/2, kViewCheckSize, kViewCheckSize)];
        imageView.image = [UIImage imageNamed:@"doraemon_visual"];
        [self addSubview:imageView];
        _imageView = imageView;
        
        imageView.userInteractionEnabled = YES;
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [imageView addGestureRecognizer:pan];
        
        _horizontalLine = [[UIView alloc] initWithFrame:CGRectMake(0, imageView.centerY-0.25, self.width, 0.5)];
        _horizontalLine.backgroundColor = [UIColor colorWithHexString:ALIGN_COLOR];
        [self addSubview:_horizontalLine];
        
        _verticalLine = [[UIView alloc] initWithFrame:CGRectMake(imageView.centerX-0.25, 0, 0.5, self.height)];
        _verticalLine.backgroundColor = [UIColor colorWithHexString:ALIGN_COLOR];
        [self addSubview:_verticalLine];
        
        [self bringSubviewToFront:_imageView];
        
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.font = [UIFont systemFontOfSize:12];
        _leftLabel.textColor = [UIColor colorWithHexString:ALIGN_COLOR];
        _leftLabel.text = [NSString stringWithFormat:@"%.1f",imageView.centerX];
        [self addSubview:_leftLabel];
        [_leftLabel sizeToFit];
        _leftLabel.frame = CGRectMake(imageView.centerX/2, imageView.centerY-_leftLabel.height, _leftLabel.width, _leftLabel.height);
        
        _topLabel = [[UILabel alloc] init];
        _topLabel.font = [UIFont systemFontOfSize:12];
        _topLabel.textColor = [UIColor colorWithHexString:ALIGN_COLOR];
        _topLabel.text = [NSString stringWithFormat:@"%.1f",imageView.centerY];
        [self addSubview:_topLabel];
        [_topLabel sizeToFit];
        _topLabel.frame = CGRectMake(imageView.centerX-_topLabel.width, imageView.centerY/2, _topLabel.width, _topLabel.height);
        
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.font = [UIFont systemFontOfSize:12];
        _rightLabel.textColor = [UIColor colorWithHexString:ALIGN_COLOR];
        _rightLabel.text = [NSString stringWithFormat:@"%.1f",self.width-imageView.centerX];
        [self addSubview:_rightLabel];
        [_rightLabel sizeToFit];
        _rightLabel.frame = CGRectMake(imageView.centerX+(self.width-imageView.centerX)/2, imageView.centerY-_rightLabel.height, _rightLabel.width, _rightLabel.height);
        
        _bottomLabel = [[UILabel alloc] init];
        _bottomLabel.font = [UIFont systemFontOfSize:12];
        _bottomLabel.textColor = [UIColor colorWithHexString:ALIGN_COLOR];
        _bottomLabel.text = [NSString stringWithFormat:@"%.1f",self.height - imageView.centerY];
        [self addSubview:_bottomLabel];
        [_bottomLabel sizeToFit];
        _bottomLabel.frame = CGRectMake(imageView.centerX-_bottomLabel.width, imageView.centerY+(self.height - imageView.centerY)/2, _bottomLabel.width, _bottomLabel.height);
        
        CGRect infoWindowFrame = CGRectZero;
        if (kInterfaceOrientationPortrait) {
            infoWindowFrame = CGRectMake(kDoraemonSizeFrom750_Landscape(30), DoraemonScreenHeight - kDoraemonSizeFrom750_Landscape(100) - kDoraemonSizeFrom750_Landscape(30), DoraemonScreenWidth - 2*kDoraemonSizeFrom750_Landscape(30), kDoraemonSizeFrom750_Landscape(100));
        } else {
            infoWindowFrame = CGRectMake(kDoraemonSizeFrom750_Landscape(30), DoraemonScreenHeight - kDoraemonSizeFrom750_Landscape(100) - kDoraemonSizeFrom750_Landscape(30), DoraemonScreenHeight - 2*kDoraemonSizeFrom750_Landscape(30), kDoraemonSizeFrom750_Landscape(100));
        } 
        _infoWindow = [[DoraemonVisualInfoWindow alloc] initWithFrame:infoWindowFrame];
        
        
         [self configInfoLblText];
    }
    return self;
}

- (void)pan:(UIPanGestureRecognizer *)sender{
    //1、获得拖动位移
    CGPoint offsetPoint = [sender translationInView:sender.view];
    //2、清空拖动位移
    [sender setTranslation:CGPointZero inView:sender.view];
    //3、重新设置控件位置
    UIView *panView = sender.view;
    CGFloat newX = panView.centerX+offsetPoint.x;
    CGFloat newY = panView.centerY+offsetPoint.y;

    CGPoint centerPoint = CGPointMake(newX, newY);
    panView.center = centerPoint;
    
    _horizontalLine.frame = CGRectMake(0, _imageView.centerY-0.25, self.width, 0.5);
    _verticalLine.frame = CGRectMake(_imageView.centerX-0.25, 0, 0.5, self.height);
    
    _leftLabel.text = [NSString stringWithFormat:@"%.1f",_imageView.centerX];
    [_leftLabel sizeToFit];
    _leftLabel.frame = CGRectMake(_imageView.centerX/2, _imageView.centerY-_leftLabel.height, _leftLabel.width, _leftLabel.height);
    
    _topLabel.text = [NSString stringWithFormat:@"%.1f",_imageView.centerY];
    [_topLabel sizeToFit];
    _topLabel.frame = CGRectMake(_imageView.centerX-_topLabel.width, _imageView.centerY/2, _topLabel.width, _topLabel.height);
    
    _rightLabel.text = [NSString stringWithFormat:@"%.1f",self.width-_imageView.centerX];
    [_rightLabel sizeToFit];
    _rightLabel.frame = CGRectMake(_imageView.centerX+(self.width-_imageView.centerX)/2, _imageView.centerY-_rightLabel.height, _rightLabel.width, _rightLabel.height);
    
    _bottomLabel.text = [NSString stringWithFormat:@"%.1f",self.height - _imageView.centerY];
    [_bottomLabel sizeToFit];
    _bottomLabel.frame = CGRectMake(_imageView.centerX-_bottomLabel.width, _imageView.centerY+(self.height - _imageView.centerY)/2, _bottomLabel.width, _bottomLabel.height);
    
    [self configInfoLblText];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    if(CGRectContainsPoint(_imageView.frame, point)){
        return YES;
    }
    return NO;
}

- (void)configInfoLblText {
    _infoWindow.infoText = [NSString stringWithFormat:@"位置：左%@  右%@  上%@  下%@", _leftLabel.text, _rightLabel.text, _topLabel.text, _bottomLabel.text];
}
 

- (void)show {
    _infoWindow.hidden = NO;
    self.hidden = NO;
}

- (void)hide {
    _infoWindow.hidden = YES;
    self.hidden = YES;
}

@end
