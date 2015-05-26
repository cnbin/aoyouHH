//
//  ImageScrollView.m
//  aoyouHH
//
//  Created by jinzelu on 15/5/25.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "ImageScrollView.h"
#import "UIImageView+WebCache.h"

@interface ImageScrollView ()<UIScrollViewDelegate>
{
    NSTimer *_timer;
}

@end

@implementation ImageScrollView

-(ImageScrollView *)initWithFrame:(CGRect)frame ImageArray:(NSArray *)imgArr{
    self = [super initWithFrame:frame];
    if (self) {
        //创建scrollview
        self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
        self.scrollView.contentSize = CGSizeMake(4*screen_width, frame.size.height);
        self.scrollView.pagingEnabled = YES;
        self.scrollView.delegate = self;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        //添加图片
        for(int i = 0 ; i < 4; i++){
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.frame = CGRectMake(i*screen_width, 0, screen_width, frame.size.height);
            imageView.tag = i+10;            
            [self.scrollView addSubview:imageView];
        }
        [self addSubview:self.scrollView];
        
        //
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(screen_width/2-40, frame.size.height-40, 80, 30)];
        self.pageControl.currentPage = 0;
        self.pageControl.numberOfPages = 4;
        [self addSubview:self.pageControl];
        
//        [self addTimer];
    }
    return self;
}


//-(ImageScrollView *)initWithFrame:(CGRect)frame{
//    self = [super init];
//    if (self) {
//        //创建scrollview
//        self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
//        self.scrollView.contentSize = CGSizeMake(screen_width, 0);
//        self.scrollView.pagingEnabled = YES;
//        self.scrollView.delegate = self;
//        self.scrollView.showsHorizontalScrollIndicator = NO;
//    }
//    return self;
//}
-(void)setImageArray:(NSArray *)imageArray{
    self.scrollView.contentSize = CGSizeMake(imageArray.count*screen_width, self.frame.size.height);
    //添加图片
    for(int i = 0 ; i < imageArray.count; i++){
        UIImageView *imageView = (UIImageView *)[self.scrollView viewWithTag:i+10];
        imageView.backgroundColor = [UIColor redColor];
//        imageView.frame = CGRectMake(i*screen_width, 0, screen_width, self.frame.size.height);
        NSString *imageName =[NSString stringWithFormat:@"%@",imageArray[i]];
        NSLog(@"%@",imageName);
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:[UIImage imageNamed:@"comment_empty_img"]];
        
//        [self.scrollView addSubview:imageView];
    }
}

-(void)addTimer{
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(netxPage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

-(void)removeTimer{
    [_timer invalidate];
}

-(void)netxPage{
    int page = self.pageControl.currentPage;
    if (page == 3) {
        page = 0;
    }else{
        page++;
    }
    //滚动scrollview
    CGFloat x = page*self.scrollView.frame.size.width;
    self.scrollView.contentOffset = CGPointMake(x, 0);
}

#pragma mark - UIScrollViewDelegate
//滑动时
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"滚动中");
    CGFloat scrollViewW = scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    int page = (x + scrollViewW/2)/scrollViewW;
    NSLog(@"x=%f",x);
    self.pageControl.currentPage = page;
}
//开始拖动时
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    [self removeTimer];
}
//结束拖动
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    [self addTimer];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end