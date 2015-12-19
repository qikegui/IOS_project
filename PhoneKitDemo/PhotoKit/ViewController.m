//
//  ViewController.m
//  PhotoKit
//
//  Created by qkg on 15/12/18.
//  Copyright © 2015年 qkg. All rights reserved.
//

#import "ViewController.h"
#import "ImageCollectionViewCell.h"
#import "LoadImage.h"
#import "NSObject+CompressImage.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,LoadImageDelegate>

@property (nonatomic,strong) UIImageView * prictur;

@property (nonatomic,strong) NSMutableArray * imageArray;

@property (nonatomic,strong) NSMutableArray * imageUrl;

@property (nonatomic,strong) UICollectionView * mainView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"PhotoKit";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.prictur = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.prictur.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.prictur];
    
    self.imageArray = [NSMutableArray array];
    self.imageUrl = [NSMutableArray array];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width/2, 200);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 10, 0);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    self.mainView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-200, self.view.bounds.size.width, 200) collectionViewLayout:flowLayout];
    [self.mainView registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    _mainView.showsVerticalScrollIndicator = NO;
    _mainView.alwaysBounceVertical = false;
    _mainView.scrollsToTop = YES;
    _mainView.dataSource = self;
    _mainView.delegate = self;
    self.mainView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mainView];
    
    NSLog(@"i'm coming");
    
//    __weak typeof(self) weakSelf = self;
//    
//    // 获取所有资源的集合，并按资源的创建时间排序
//    PHFetchOptions *options = [[PHFetchOptions alloc] init];
//    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
//    PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
//    // 这时 assetsFetchResults 中包含的，应该就是各个资源（PHAsset）
//    for (NSInteger i = 0; i < assetsFetchResults.count; i++) {
//        // 获取一个资源（PHAsset）
//        PHAsset *asset = assetsFetchResults[i];
//        PHContentEditingInputRequestOptions *option = [[PHContentEditingInputRequestOptions alloc]init];
//        [asset requestContentEditingInputWithOptions:option completionHandler:^(PHContentEditingInput * _Nullable contentEditingInput, NSDictionary * _Nonnull info) {
//            if (contentEditingInput.displaySizeImage != nil) {
//                [weakSelf.imageArray addObject:contentEditingInput.displaySizeImage];
//            }
//            [weakSelf performSelectorInBackground:@selector(getImage) withObject:nil];
//        }];
//    }
    
    
    
    LoadImage * loading = [LoadImage LoadingImageFromPhoneMemory:0 len:20];
    loading.delegate = self;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.imageArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ImageCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    [cell imageWithImage:self.imageArray[indexPath.item]];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //CGRect rect = CGRectMake(0, 0, 500, 500);
    self.prictur.image = self.imageArray[indexPath.item];//[self getSubImage:self.imageArray[indexPath.item] mCGRect:rect centerBool:true];
}

-(void)getImage{
    [self.mainView reloadData];
    
}

-(void)getImageArray:(NSArray *)imageArray{
    
    self.imageArray = [NSMutableArray arrayWithArray:imageArray];
    [self.mainView reloadData];
}

-(void)loadingImageStatus:(NSString *)status currentIndexs:(NSInteger)index{
    NSLog(@"status ===%@",status);
    NSLog(@"index ==== %ld",(long)index);
}

-(void)loadingImageError:(NSString *)error{
    NSLog(@"error === %@",error);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
