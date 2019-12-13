//
//  ViewController.m
//  justEvent
//
//  Created by 魏勇城 on 2019/12/10.
//  Copyright © 2019 余谦. All rights reserved.
//

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

#define UIBUTTON_TAG 0x5521
#define UITEXTFIELD_TAG 0x66659
#define UITEXTFIELD_FRAME_TAG 0xaac542
#define STRETCHIMG_TAG 0x330

#import "ViewController.h"
#import "SDAutoLayout.h"
#import "DoraemonViewAlignManager.h"

@interface ViewController ()<UIGestureRecognizerDelegate,UITextFieldDelegate>

@property (nonatomic,strong) UIScrollView *graphicsView;
@property (nonatomic,strong) UILabel *thisLabel;
@property (nonatomic,strong) UIImageView *thisImg;
@property (nonatomic,strong) UIButton *thisBtn;
@property (nonatomic,strong) UIView *thisView;
@property (nonatomic,strong) UITextField *thisfield;
@property (nonatomic,strong) NSString *type;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[DoraemonViewAlignManager shareInstance] show];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    UIButton *backbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 28, 48, 25)];
    [backbtn setTitle:@"返回" forState:UIControlStateNormal];
    backbtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [backbtn setTitleColor:[UIColor blackColor
                            ] forState:UIControlStateNormal];
    backbtn.layer.borderColor = [UIColor blackColor].CGColor;
    backbtn.layer.borderWidth = 1;
    [backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backbtn];
    
    UIButton *createbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 28, 48, 25)];
    createbtn.right = FULL_SCREEN_WIDTH;
    [createbtn setTitle:@"生成" forState:UIControlStateNormal];
    createbtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [createbtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    createbtn.layer.borderColor = [UIColor redColor].CGColor;
    createbtn.layer.borderWidth = 1;
    [createbtn addTarget:self action:@selector(print) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:createbtn];
    
    [self create_graphicsView];
    
    [self initView];
}

- (void)create_graphicsView {
    UIView *drawView = [[UIView alloc] initWithFrame:CGRectMake(0, 80, FULL_SCREEN_WIDTH, 400)];
    drawView.backgroundColor = [UIColor whiteColor];
    drawView.layer.borderWidth = 1.0f;
    drawView.layer.borderColor = [[UIColor blackColor] colorWithAlphaComponent:0.5].CGColor;
    [self.view addSubview:drawView];
    
    _graphicsView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, FULL_SCREEN_WIDTH, 400)];
    _graphicsView.layer.borderWidth = 1.0f;
    _graphicsView.layer.borderColor = [UIColor blueColor].CGColor;
    _graphicsView.bounces = NO;
    [drawView addSubview:_graphicsView];
    _graphicsView.scrollEnabled = YES;
    _graphicsView.contentSize = CGSizeMake(FULL_SCREEN_WIDTH, 400);
    
    UITextField *widthfield = [[UITextField alloc] initWithFrame:CGRectMake(0, 28, 100, 40)];
    widthfield.text = [NSString stringWithFormat:@"%.0f",_graphicsView.width];
    widthfield.font = [UIFont systemFontOfSize:15];
    widthfield.textColor = [UIColor blackColor];
    widthfield.layer.borderWidth = 1.0f;
    widthfield.layer.borderColor = [UIColor grayColor].CGColor;
    widthfield.textAlignment = NSTextAlignmentCenter;
    widthfield.tag = UITEXTFIELD_TAG;
    widthfield.delegate = self;
    widthfield.keyboardType = UIKeyboardTypeDecimalPad;
    [widthfield addTarget:self action:@selector(textFieldTextDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:widthfield];
    widthfield.right = FULL_SCREEN_WIDTH/2;
    
    UITextField *heightfield = [[UITextField alloc] initWithFrame:CGRectMake(0, 28, 100, 40)];
    heightfield.text = [NSString stringWithFormat:@"%.0f",_graphicsView.height];
    heightfield.font = [UIFont systemFontOfSize:15];
    heightfield.textColor = [UIColor blackColor];
    heightfield.layer.borderWidth = 1.0f;
    heightfield.layer.borderColor = [UIColor grayColor].CGColor;
    heightfield.textAlignment = NSTextAlignmentCenter;
    heightfield.tag = UITEXTFIELD_TAG+1;
    heightfield.delegate = self;
    heightfield.keyboardType = UIKeyboardTypeDecimalPad;
    [heightfield addTarget:self action:@selector(textFieldTextDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:heightfield];
    heightfield.left = FULL_SCREEN_WIDTH/2;
}

//监听改变方法
- (void)textFieldTextDidChange:(UITextField *)textChange{
    NSLog(@"文字改变：%@",textChange.text);
    if (textChange.tag == UITEXTFIELD_TAG) {
        _graphicsView.width = textChange.text.floatValue;
        _graphicsView.contentSize = CGSizeMake(_graphicsView.width, _graphicsView.contentSize.height);
    }
    if (textChange.tag == UITEXTFIELD_TAG+1) {
        if (textChange.text.floatValue>400) {
            _graphicsView.height = 400.0f;
            _graphicsView.contentSize = CGSizeMake(_graphicsView.width, textChange.text.floatValue);
        }else{
            _graphicsView.height = textChange.text.floatValue;
            _graphicsView.contentSize = CGSizeMake(_graphicsView.width, _graphicsView.contentSize.height);
        }
    }
    
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)print {
    NSString *uiStr = @"";
    _graphicsView.showsVerticalScrollIndicator = NO;
    _graphicsView.showsHorizontalScrollIndicator = NO;
    for (UIView *view in _graphicsView.subviews) {
        NSString *x = [NSString stringWithFormat:@"G_GET_SCALE_LENTH(%.1f)",view.frame.origin.x];
        NSString *y = [NSString stringWithFormat:@"G_GET_SCALE_LENTH(%.1f)",view.frame.origin.y];
        NSString *width = [NSString stringWithFormat:@"G_GET_SCALE_LENTH(%.1f)",view.frame.size.width];
        NSString *height = [NSString stringWithFormat:@"G_GET_SCALE_LENTH(%.1f)",view.frame.size.height];
//        NSLog(@"CGRectMake(%@,%@,%@,%@);",x,y,width,height);
        if ([view isKindOfClass:[UILabel class]]) {
            uiStr = [uiStr stringByAppendingString:[NSString stringWithFormat:@"\nUILabel *myLB =  [[UILabel alloc] initWithFrame:CGRectMake(%@,%@,%@,%@)];",x,y,width,height]];
            continue;
        }
        if ([view isKindOfClass:[UIImageView class]]) {
            uiStr = [uiStr stringByAppendingString:[NSString stringWithFormat:@"\nUIImageView *myImg =  [[UIImageView alloc] initWithFrame:CGRectMake(%@,%@,%@,%@)];",x,y,width,height]];
            continue;
        }
        if ([view isKindOfClass:[UIButton class]]) {
            uiStr = [uiStr stringByAppendingString:[NSString stringWithFormat:@"\nUIButton *myBtn =  [[UIButton alloc] initWithFrame:CGRectMake(%@,%@,%@,%@)];",x,y,width,height]];
            continue;
        }
        if ([view isKindOfClass:[UITextField class]]) {
              uiStr = [uiStr stringByAppendingString:[NSString stringWithFormat:@"\nUITextField *myTextField =  [[UITextField alloc] initWithFrame:CGRectMake(%@,%@,%@,%@)];",x,y,width,height]];
              continue;
        }
        if ([view isKindOfClass:[UIView class]]) {
              uiStr = [uiStr stringByAppendingString:[NSString stringWithFormat:@"\nUIView *myView =  [[UIView alloc] initWithFrame:CGRectMake(%@,%@,%@,%@)];",x,y,width,height]];
              continue;
        }

    }
    NSLog(@"%@",uiStr);
    NSString* thepath = @"/Users/xmmac/Desktop/oldcode";
    NSLog(@"桌面目录：%@", thepath);
    
    thepath = [thepath stringByAppendingPathComponent:@"just.m"];
    
    NSError * error;

    BOOL isWriteSuccess = [uiStr writeToFile:thepath atomically:YES encoding:NSUTF8StringEncoding error:&error];
}

- (void)initView {
    NSArray *arr = @[@"UILabel",@"UIImageView",@"UIButton",@"UIView",@"UITextField"];
    for (int i = 0; i<arr.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i*70, 0, 70, 70)];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:10];
        btn.bottom = FULL_SCREEN_HEIGHT;
        btn.layer.borderColor = [UIColor blackColor].CGColor;
        btn.layer.borderWidth = 1;
        [btn addTarget:self action:@selector(createMoveView:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = UIBUTTON_TAG+i;
        [self.view addSubview:btn];
    }
    NSArray *frameArr = @[@"x",@"y",@"width",@"height"];
    for (int k = 0; k<frameArr.count; k++) {
        UITextField *framefield = [[UITextField alloc] initWithFrame:CGRectMake(k*80, 0, 80, 30)];
        framefield.placeholder = frameArr[k];
        framefield.font = [UIFont systemFontOfSize:13];
        framefield.textColor = [UIColor blackColor];
        framefield.layer.borderColor = [UIColor grayColor].CGColor;
        framefield.layer.borderWidth = 1;
        framefield.bottom = FULL_SCREEN_HEIGHT-70;
        framefield.tag = UITEXTFIELD_FRAME_TAG+k;
        framefield.textAlignment = NSTextAlignmentCenter;
        framefield.delegate = self;
        framefield.keyboardType = UIKeyboardTypeDecimalPad;
        [framefield addTarget:self action:@selector(textFrameChange:) forControlEvents:UIControlEventEditingChanged];
        [self.view addSubview:framefield];
    }
}

//监听改变方法
- (void)textFrameChange:(UITextField *)textChange{
    NSLog(@"文字改变：%@",textChange.text);
    long k = textChange.tag - UITEXTFIELD_FRAME_TAG;
    if (k == 0) {
        if (_type.intValue == 1) {
            _thisLabel.left = textChange.text.floatValue;
            [self stretchImgFrameChange:_thisLabel];
        }
        if (_type.intValue == 2) {
            _thisImg.left = textChange.text.floatValue;
            [self stretchImgFrameChange:_thisImg];
        }
        if (_type.intValue == 3) {
            _thisBtn.left = textChange.text.floatValue;
            [self stretchImgFrameChange:_thisBtn];
        }
        if (_type.intValue == 4) {
            _thisView.left = textChange.text.floatValue;
            [self stretchImgFrameChange:_thisView];
        }
        if (_type.intValue == 5) {
            _thisfield.left = textChange.text.floatValue;
            [self stretchImgFrameChange:_thisfield];
        }
    }
    if (k == 1) {
        if (_type.intValue == 1) {
            _thisLabel.top = textChange.text.floatValue;
            [self stretchImgFrameChange:_thisLabel];
        }
        if (_type.intValue == 2) {
            _thisImg.top = textChange.text.floatValue;
            [self stretchImgFrameChange:_thisImg];
        }
        if (_type.intValue == 3) {
            _thisBtn.top = textChange.text.floatValue;
            [self stretchImgFrameChange:_thisBtn];
        }
        if (_type.intValue == 4) {
            _thisView.top = textChange.text.floatValue;
            [self stretchImgFrameChange:_thisView];
        }
        if (_type.intValue == 5) {
            _thisfield.top = textChange.text.floatValue;
            [self stretchImgFrameChange:_thisfield];
        }
    }
    if (k == 2) {
        if (_type.intValue == 1) {
            _thisLabel.width = textChange.text.floatValue;
            [self stretchImgFrameChange:_thisLabel];
        }
        if (_type.intValue == 2) {
            _thisImg.width = textChange.text.floatValue;
            [self stretchImgFrameChange:_thisImg];
        }
        if (_type.intValue == 3) {
            _thisBtn.width = textChange.text.floatValue;
            [self stretchImgFrameChange:_thisBtn];
        }
        if (_type.intValue == 4) {
            _thisView.width = textChange.text.floatValue;
            [self stretchImgFrameChange:_thisView];
        }
        if (_type.intValue == 5) {
            _thisfield.width = textChange.text.floatValue;
            [self stretchImgFrameChange:_thisfield];
        }
    }
    if (k == 3) {
        if (_type.intValue == 1) {
            _thisLabel.height = textChange.text.floatValue;
            [self stretchImgFrameChange:_thisLabel];
        }
        if (_type.intValue == 2) {
            _thisImg.height = textChange.text.floatValue;
            [self stretchImgFrameChange:_thisImg];
        }
        if (_type.intValue == 3) {
            _thisBtn.height = textChange.text.floatValue;
            [self stretchImgFrameChange:_thisBtn];
        }
        if (_type.intValue == 4) {
            _thisView.height = textChange.text.floatValue;
            [self stretchImgFrameChange:_thisView];
        }
        if (_type.intValue == 5) {
            _thisfield.height = textChange.text.floatValue;
            [self stretchImgFrameChange:_thisfield];
        }
    }
}

- (void)stretchImgFrameChange:(UIView *)view {
    UIImageView *stretchingImage = [view viewWithTag:STRETCHIMG_TAG];
    stretchingImage.right = view.width;
    stretchingImage.bottom = view.height;
}

- (void)createMoveView:(UIButton *)btn {
    long k = btn.tag - UIBUTTON_TAG;
    switch (k) {
        case 0: [self createLabel];
            break;
        case 1: [self createImg];
            break;
        case 2: [self createBtn];
            break;
        case 3: [self createView];
            break;
        case 4: [self createTextFiled];
            break;
    }
}

- (void)createLabel {
    UILabel *moveLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 150, 40)];
    moveLB.text = @"Label";
    moveLB.font = [UIFont systemFontOfSize:12];
    moveLB.layer.borderColor = [UIColor blackColor].CGColor;
    moveLB.layer.borderWidth = 2.0f;
    moveLB.textAlignment = NSTextAlignmentCenter;
    moveLB.userInteractionEnabled = YES;
    [_graphicsView addSubview:moveLB];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap:)];
    [moveLB addGestureRecognizer:tap];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];//初始化一个长按手势
    [longPress setMinimumPressDuration:1];//设置按多久之后触发事件
    [moveLB addGestureRecognizer:longPress];//把长按手势添加给按钮
    
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    [moveLB addGestureRecognizer:pinchGestureRecognizer];
    
    UIPanGestureRecognizer* singleSixTap = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(touchesMoved:)];
    singleSixTap.delegate = self;
    singleSixTap.cancelsTouchesInView = NO;
    [moveLB addGestureRecognizer:singleSixTap];
    
    UIImageView *stretchingImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stretching"]];
    stretchingImage.width = G_GET_SCALE_HEIGHT(13);
    stretchingImage.height = G_GET_SCALE_HEIGHT(13);
    stretchingImage.right = moveLB.width;
    stretchingImage.bottom = moveLB.height;
    stretchingImage.userInteractionEnabled = YES;
    stretchingImage.tag = STRETCHIMG_TAG;
    [moveLB addSubview:stretchingImage];
    
    UIPanGestureRecognizer* singlefourTap = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(touchesStrectchMoved:)];
    singlefourTap.delegate = self;
    singlefourTap.cancelsTouchesInView = NO;
    [stretchingImage addGestureRecognizer:singlefourTap];
}

- (void)createImg {
    UIImageView *moveImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, 150, 40)];
    moveImg.backgroundColor = [UIColor redColor];
    moveImg.userInteractionEnabled = YES;
    [_graphicsView addSubview:moveImg];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap:)];
    [moveImg addGestureRecognizer:tap];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];//初始化一个长按手势
    [longPress setMinimumPressDuration:1];//设置按多久之后触发事件
    [moveImg addGestureRecognizer:longPress];//把长按手势添加给按钮
    
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    [moveImg addGestureRecognizer:pinchGestureRecognizer];
     
     UIPanGestureRecognizer* singleSixTap = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(touchesMoved:)];
     singleSixTap.delegate = self;
     singleSixTap.cancelsTouchesInView = NO;
     [moveImg addGestureRecognizer:singleSixTap];
    
    UIImageView *stretchingImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stretching"]];
    stretchingImage.width = G_GET_SCALE_HEIGHT(13);
    stretchingImage.height = G_GET_SCALE_HEIGHT(13);
    stretchingImage.right = moveImg.width;
    stretchingImage.bottom = moveImg.height;
    stretchingImage.userInteractionEnabled = YES;
    stretchingImage.tag = STRETCHIMG_TAG;
    [moveImg addSubview:stretchingImage];
    
    UIPanGestureRecognizer* singlefourTap = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(touchesStrectchMoved:)];
    singlefourTap.delegate = self;
    singlefourTap.cancelsTouchesInView = NO;
    [stretchingImage addGestureRecognizer:singlefourTap];
}

- (void)createBtn {
    UIButton *movebtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 150, 40)];
    [movebtn setTitle:@"Btn" forState:UIControlStateNormal];
    [movebtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    movebtn.titleLabel.font = [UIFont systemFontOfSize:12];
    movebtn.layer.borderColor = [UIColor blueColor].CGColor;
    movebtn.layer.borderWidth = 2.0f;
    [_graphicsView addSubview:movebtn];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap:)];
    [movebtn addGestureRecognizer:tap];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];//初始化一个长按手势
    [longPress setMinimumPressDuration:1];//设置按多久之后触发事件
    [movebtn addGestureRecognizer:longPress];//把长按手势添加给按钮
    
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    [movebtn addGestureRecognizer:pinchGestureRecognizer];
    
    UIPanGestureRecognizer* singleSixTap = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(touchesMoved:)];
    singleSixTap.delegate = self;
    singleSixTap.cancelsTouchesInView = NO;
    [movebtn addGestureRecognizer:singleSixTap];
    
    UIImageView *stretchingImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stretching"]];
    stretchingImage.width = G_GET_SCALE_HEIGHT(13);
    stretchingImage.height = G_GET_SCALE_HEIGHT(13);
    stretchingImage.right = movebtn.width;
    stretchingImage.bottom = movebtn.height;
    stretchingImage.userInteractionEnabled = YES;
    stretchingImage.tag = STRETCHIMG_TAG;
    [movebtn addSubview:stretchingImage];
    
    UIPanGestureRecognizer* singlefourTap = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(touchesStrectchMoved:)];
    singlefourTap.delegate = self;
    singlefourTap.cancelsTouchesInView = NO;
    [stretchingImage addGestureRecognizer:singlefourTap];
    
}

- (void)createView {
    UIView *moveView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, 150, 40)];
    moveView.layer.borderColor = [UIColor yellowColor].CGColor;
    moveView.layer.borderWidth = 2.0f;
    [_graphicsView addSubview:moveView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap:)];
    [moveView addGestureRecognizer:tap];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];//初始化一个长按手势
    [longPress setMinimumPressDuration:1];//设置按多久之后触发事件
    [moveView addGestureRecognizer:longPress];//把长按手势添加给按钮
    
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    [moveView addGestureRecognizer:pinchGestureRecognizer];
    
    UIPanGestureRecognizer* singleSixTap = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(touchesMoved:)];
    singleSixTap.delegate = self;
    singleSixTap.cancelsTouchesInView = NO;
    [moveView addGestureRecognizer:singleSixTap];
    
    UIImageView *stretchingImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stretching"]];
    stretchingImage.width = G_GET_SCALE_HEIGHT(13);
    stretchingImage.height = G_GET_SCALE_HEIGHT(13);
    stretchingImage.right = moveView.width;
    stretchingImage.bottom = moveView.height;
    stretchingImage.userInteractionEnabled = YES;
    stretchingImage.tag = STRETCHIMG_TAG;
    [moveView addSubview:stretchingImage];
    
    UIPanGestureRecognizer* singlefourTap = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(touchesStrectchMoved:)];
    singlefourTap.delegate = self;
    singlefourTap.cancelsTouchesInView = NO;
    [stretchingImage addGestureRecognizer:singlefourTap];
}

- (void)createTextFiled {
    UITextField *movefield = [[UITextField alloc] initWithFrame:CGRectMake(0, 50, 150, 40)];
    movefield.layer.borderColor = [UIColor grayColor].CGColor;
    movefield.layer.borderWidth = 2.0f;
    movefield.userInteractionEnabled = YES;
    [_graphicsView addSubview:movefield];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap:)];
    [movefield addGestureRecognizer:tap];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];//初始化一个长按手势
    [longPress setMinimumPressDuration:1];//设置按多久之后触发事件
    [movefield addGestureRecognizer:longPress];//把长按手势添加给按钮
    
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    [movefield addGestureRecognizer:pinchGestureRecognizer];
    
    UIPanGestureRecognizer* singleSixTap = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(touchesMoved:)];
    singleSixTap.delegate = self;
    singleSixTap.cancelsTouchesInView = NO;
    [movefield addGestureRecognizer:singleSixTap];
    
    UIImageView *stretchingImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stretching"]];
    stretchingImage.width = G_GET_SCALE_HEIGHT(13);
    stretchingImage.height = G_GET_SCALE_HEIGHT(13);
    stretchingImage.right = movefield.width;
    stretchingImage.bottom = movefield.height;
    stretchingImage.userInteractionEnabled = YES;
    stretchingImage.tag = STRETCHIMG_TAG;
    [movefield addSubview:stretchingImage];
    
    UIPanGestureRecognizer* singlefourTap = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(touchesStrectchMoved:)];
    singlefourTap.delegate = self;
    singlefourTap.cancelsTouchesInView = NO;
    [stretchingImage addGestureRecognizer:singlefourTap];
}

- (void)touchesMoved:(UIPanGestureRecognizer *)touches {
    UIView *view = touches.view;
//    if (touches.state == UIGestureRecognizerStateBegan || touches.state == UIGestureRecognizerStateChanged) {
    CGPoint translation = [touches translationInView:view.superview];
    [view setCenter:(CGPoint){view.center.x + translation.x, view.center.y  + translation.y}];
    [touches setTranslation:CGPointZero inView:view.superview];
    if ([touches.view isKindOfClass:[UILabel class]]) {
        _type = @"1";
        _thisLabel = (UILabel *)touches.view;
        [self changeText];
    }else if ([touches.view isKindOfClass:[UIImageView class]]) {
        _type = @"2";
        _thisImg = (UIImageView *)touches.view;
        [self changeText];
    }else if ([touches.view isKindOfClass:[UIButton class]]) {
        _type = @"3";
        _thisBtn = (UIButton *)touches.view;
        [self changeText];
    }else if ([touches.view isKindOfClass:[UITextField class]]) {
        _type = @"4";
        _thisfield = (UITextField *)touches.view;
        [self changeText];
    }else if([touches.view isKindOfClass:[UIView class]]) {
        _type = @"5";
        _thisView = (UIView *)touches.view;
        [self changeText];
    }
        
//    }
//
//    if (touches.state == UIGestureRecognizerStateEnded) {
//
//    }
    
}

//事件处理方法参数一般有一个, 参数类型是事件源
-(void)viewTap:(UITapGestureRecognizer *)tap
{
    
    if ([tap.view isKindOfClass:[UILabel class]]) {
        _type = @"1";
        _thisLabel = (UILabel *)tap.view;
        [self changeText];
        return;
    }
    if ([tap.view isKindOfClass:[UIImageView class]]) {
        _type = @"2";
        _thisImg = (UIImageView *)tap.view;
        [self changeText];
        return;
    }
    if ([tap.view isKindOfClass:[UIButton class]]) {
        _type = @"3";
        _thisBtn = (UIButton *)tap.view;
        [self changeText];
        return;
    }
    if ([tap.view isKindOfClass:[UITextField class]]) {
        _type = @"4";
        _thisfield = (UITextField *)tap.view;
        [self changeText];
        return;
    }
    if ([tap.view isKindOfClass:[UIView class]]) {
        _type = @"5";
        _thisView = (UIView *)tap.view;
        [self changeText];
        return;
    }
    
}

- (void)changeText {
    if (_type.intValue == 1) {
        for (int i = 0; i<4; i++) {
            UITextField *frameField = [self.view viewWithTag:UITEXTFIELD_FRAME_TAG+i];
            if (i == 0) {
                frameField.text = [NSString stringWithFormat:@"%.1f",_thisLabel.left];
            }
            if (i == 1) {
                frameField.text = [NSString stringWithFormat:@"%.1f",_thisLabel.top];
            }
            if (i == 2) {
                frameField.text = [NSString stringWithFormat:@"%.1f",_thisLabel.width];
            }
            if (i == 3) {
                frameField.text = [NSString stringWithFormat:@"%.1f",_thisLabel.height];
            }
        }
    }
    if (_type.intValue == 2) {
        for (int i = 0; i<4; i++) {
            UITextField *frameField = [self.view viewWithTag:UITEXTFIELD_FRAME_TAG+i];
            if (i == 0) {
                frameField.text = [NSString stringWithFormat:@"%.1f",_thisImg.left];
            }
            if (i == 1) {
                frameField.text = [NSString stringWithFormat:@"%.1f",_thisImg.top];
            }
            if (i == 2) {
                frameField.text = [NSString stringWithFormat:@"%.1f",_thisImg.width];
            }
            if (i == 3) {
                frameField.text = [NSString stringWithFormat:@"%.1f",_thisImg.height];
            }
        }
    }
    if (_type.intValue == 3) {
        for (int i = 0; i<4; i++) {
            UITextField *frameField = [self.view viewWithTag:UITEXTFIELD_FRAME_TAG+i];
            if (i == 0) {
                frameField.text = [NSString stringWithFormat:@"%.1f",_thisBtn.left];
            }
            if (i == 1) {
                frameField.text = [NSString stringWithFormat:@"%.1f",_thisBtn.top];
            }
            if (i == 2) {
                frameField.text = [NSString stringWithFormat:@"%.1f",_thisBtn.width];
            }
            if (i == 3) {
                frameField.text = [NSString stringWithFormat:@"%.1f",_thisBtn.height];
            }
        }
    }
    if (_type.intValue == 4) {
        for (int i = 0; i<4; i++) {
            UITextField *frameField = [self.view viewWithTag:UITEXTFIELD_FRAME_TAG+i];
            if (i == 0) {
                frameField.text = [NSString stringWithFormat:@"%.1f",_thisfield.left];
            }
            if (i == 1) {
                frameField.text = [NSString stringWithFormat:@"%.1f",_thisfield.top];
            }
            if (i == 2) {
                frameField.text = [NSString stringWithFormat:@"%.1f",_thisfield.width];
            }
            if (i == 3) {
                frameField.text = [NSString stringWithFormat:@"%.1f",_thisfield.height];
            }
        }
    }
    if (_type.intValue == 5) {
        for (int i = 0; i<4; i++) {
            UITextField *frameField = [self.view viewWithTag:UITEXTFIELD_FRAME_TAG+i];
            if (i == 0) {
                frameField.text = [NSString stringWithFormat:@"%.1f",_thisView.left];
            }
            if (i == 1) {
                frameField.text = [NSString stringWithFormat:@"%.1f",_thisView.top];
            }
            if (i == 2) {
                frameField.text = [NSString stringWithFormat:@"%.1f",_thisView.width];
            }
            if (i == 3) {
                frameField.text = [NSString stringWithFormat:@"%.1f",_thisView.height];
            }
        }
    }
}

- (void)pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    UIView *view = pinchGestureRecognizer.view;
    
    CGFloat scale = pinchGestureRecognizer.scale;
    //    //放大情况

    
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
        
        if ([pinchGestureRecognizer.view.superview isKindOfClass:[UILabel class]]) {
            _type = @"1";
            _thisLabel = (UILabel *)pinchGestureRecognizer.view.superview;
            [self changeText];
            return;
        }
        if ([pinchGestureRecognizer.view.superview isKindOfClass:[UIImageView class]]) {
            _type = @"2";
            _thisImg = (UIImageView *)pinchGestureRecognizer.view.superview;
            [self changeText];
            return;
        }
        if ([pinchGestureRecognizer.view.superview isKindOfClass:[UIButton class]]) {
            _type = @"3";
            _thisBtn = (UIButton *)pinchGestureRecognizer.view.superview;
            [self changeText];
            return;
        }
        if ([pinchGestureRecognizer.view.superview isKindOfClass:[UITextField class]]) {
            _type = @"4";
            _thisfield = (UITextField *)pinchGestureRecognizer.view.superview;
            [self changeText];
            return;
        }
        if ([pinchGestureRecognizer.view.superview isKindOfClass:[UIView class]]) {
            _type = @"5";
            _thisView = (UIView *)pinchGestureRecognizer.view.superview;
            [self changeText];
            return;
        }
    }

}

- (void)touchesStrectchMoved:(UIPanGestureRecognizer *)touches {
    UIView *view = touches.view;
    if (touches.state == UIGestureRecognizerStateBegan || touches.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [touches translationInView:view.superview];
        
        CGFloat width =  touches.view.superview.width;
        if (width+translation.x<G_GET_SCALE_LENTH(15) || touches.view.superview.right+translation.x>FULL_SCREEN_WIDTH) {
            return;
        }
        touches.view.superview.width+=translation.x;
        touches.view.right = touches.view.superview.width;
        touches.view.bottom = touches.view.superview.height;
        
        if ([touches.view.superview isKindOfClass:[UILabel class]]) {
            _type = @"1";
            _thisLabel = (UILabel *)touches.view.superview;
            [self changeText];
        }else if ([touches.view.superview  isKindOfClass:[UIImageView class]]) {
            _type = @"2";
            _thisImg = (UIImageView *)touches.view.superview;
            [self changeText];
        }else if ([touches.view.superview  isKindOfClass:[UIButton class]]) {
            _type = @"3";
            _thisBtn = (UIButton *)touches.view.superview;
            [self changeText];
        }else if ([touches.view.superview  isKindOfClass:[UITextField class]]) {
            _type = @"4";
            _thisfield = (UITextField *)touches.view.superview;
            [self changeText];
        }else if([touches.view.superview  isKindOfClass:[UIView class]]) {
            _type = @"5";
            _thisView = (UIView *)touches.view.superview;
            [self changeText];
        }
        
        CGFloat height =  touches.view.superview.height;
        if (height+translation.y<G_GET_SCALE_HEIGHT(15)|| touches.view.superview.bottom+translation.y>FULL_SCREEN_HEIGHT) {
            return;
        }
        touches.view.superview.height+=translation.y;
        
        
        [view setCenter:(CGPoint){view.center.x + translation.x, view.center.y  + translation.y}];
        [touches setTranslation:CGPointZero inView:view.superview];
        
        touches.view.right = touches.view.superview.width;
        touches.view.bottom = touches.view.superview.height;
        
        if ([touches.view.superview isKindOfClass:[UILabel class]]) {
            _type = @"1";
            _thisLabel = (UILabel *)touches.view.superview;
            [self changeText];
        }else if ([touches.view.superview  isKindOfClass:[UIImageView class]]) {
            _type = @"2";
            _thisImg = (UIImageView *)touches.view.superview;
            [self changeText];
        }else if ([touches.view.superview  isKindOfClass:[UIButton class]]) {
            _type = @"3";
            _thisBtn = (UIButton *)touches.view.superview;
            [self changeText];
        }else if ([touches.view.superview  isKindOfClass:[UITextField class]]) {
            _type = @"4";
            _thisfield = (UITextField *)touches.view.superview;
            [self changeText];
        }else if([touches.view.superview  isKindOfClass:[UIView class]]) {
            _type = @"5";
            _thisView = (UIView *)touches.view.superview;
            [self changeText];
        }
        //            UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, _deptView.frame.size.width, _deptView.frame.size.height) cornerRadius:G_GET_SCALE_HEIGHT(2)];
        //            _deptlayer.path = bezierPath.CGPath;
    }
    
    
}

-(void)longPressAction:(UILongPressGestureRecognizer*)sender{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"是否删除该控件" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [sender.view removeFromSuperview];
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:okAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

@end
