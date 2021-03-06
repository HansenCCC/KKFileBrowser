//
//  KKFileBrowserCollectionViewCell.m
//  KKFileBrowser_Example
//
//  Created by shinemo on 2021/8/7.
//  Copyright © 2021 Hansen. All rights reserved.
//

#import "KKFileBrowserCollectionViewCell.h"
#import "NSString+KKFileBrowser.h"
#import "UIImage+KKFileBrowser.h"

@interface KKFileBrowserCollectionViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) UIImageView *rightImageView;

@end

@implementation KKFileBrowserCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    [self setupSubviews];
    return self;
}

- (void)setupSubviews{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.rightImageView];
    [self.contentView addSubview:self.rightLabel];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    CGRect f1 = bounds;
    f1.origin.x = 15.f;
    f1.size = [self.titleLabel sizeThatFits:CGSizeZero];
    f1.size.width = MIN(bounds.size.width - 2 * f1.origin.x - 100.f, f1.size.width);
    f1.origin.y = (bounds.size.height - f1.size.height)/2.0f;
    self.titleLabel.frame = f1;
    //
    CGRect f2 = bounds;
    f2.size.height = 1.f;
    f2.origin.y = bounds.size.height - f2.size.height;
    self.lineView.frame = f2;
    //
    CGRect f3 = bounds;
    f3.size = CGSizeMake(25.f, 25.f);
    f3.origin.y = (bounds.size.height - f3.size.height)/2.0;
    f3.origin.x = bounds.size.width - f3.size.width - 8.f;
    self.rightImageView.frame = f3;
    //
    CGRect f4 = bounds;
    f4.size = [self.rightLabel sizeThatFits:CGSizeZero];
    f4.origin.x = f3.origin.x - f4.size.width;
    f4.origin.y = (bounds.size.height - f4.size.height)/2.f;
    self.rightLabel.frame = f4;
}

#pragma mark - setters
- (void)setCellModel:(KKFileBrowserInfo *)cellModel{
    _cellModel = cellModel;
    self.titleLabel.text = cellModel.fileName?:@"";
    UIImage *rightImage = [UIImage kk_fileBrowserBundleImageNamed:@"kk_icon_right.png"];
    self.rightImageView.image = rightImage;
    self.rightLabel.text = cellModel.fileSize?:@"";
    //
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL isDir;
    [manager fileExistsAtPath:cellModel.filePath isDirectory:&isDir];
    if (isDir) {
        self.rightImageView.hidden = NO;
    } else {
        //判断文件是否是数据库
        NSArray *dbSuffix = [NSString fileDatabase];
        NSString *pathExtension = cellModel.filePath.pathExtension;
        if ([dbSuffix containsObject:pathExtension]) {
            self.rightImageView.hidden = NO;
        } else {
            self.rightImageView.hidden = YES;
        }
    }
    [self layoutSubviews];
}

#pragma mark - getters
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16.f];
        _titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _titleLabel;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _lineView;
}

- (UIImageView *)rightImageView{
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
    }
    return _rightImageView;
}

- (UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.font = [UIFont systemFontOfSize:14.f];
        _rightLabel.textColor = [UIColor colorWithWhite:0 alpha:0.5];
    }
    return _rightLabel;
}

@end

@interface KKFileBrowserWindowsCollectionViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *detailLabel;

@end

@implementation KKFileBrowserWindowsCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    [self setupSubviews];
    return self;
}

- (void)setupSubviews{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.detailLabel];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    //
    CGRect f1 = bounds;
    f1.size.height = f1.size.width;
    self.imageView.frame = f1;
    //
    CGRect f2 = bounds;
    f2.size = CGSizeMake(bounds.size.width, 40.f);
    f2.origin.y = CGRectGetMaxX(f1);
    self.titleLabel.frame = f2;
    //
    CGRect f3 = bounds;
    f3.origin.y = CGRectGetMaxY(f2);
    f3.size.height = bounds.size.height - f3.origin.y;
    self.detailLabel.frame = f3;
}

#pragma mark - setters
- (void)setCellModel:(KKFileBrowserInfo *)cellModel{
    _cellModel = cellModel;
    self.titleLabel.text = cellModel.fileName;
    self.detailLabel.text = cellModel.fileSize?:@"";
    UIImage *defaultImage = [UIImage kk_fileBrowserBundleImageNamed:@"kk_icon_fileDic.png"];
    if (cellModel.fileImageName.length > 0) {
        [self.imageView setImage:[UIImage kk_fileBrowserBundleImageNamed:cellModel.fileImageName]];
    }else{
        [self.imageView setImage:defaultImage];
    }
    [self layoutSubviews];
}

#pragma mark - getters
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15.f];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.font = [UIFont systemFontOfSize:12.f];
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.textColor = [UIColor blueColor];
    }
    return _detailLabel;
}

@end
