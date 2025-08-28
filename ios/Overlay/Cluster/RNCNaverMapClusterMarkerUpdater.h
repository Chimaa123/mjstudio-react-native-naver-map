//
//  RNCNaverMapClusterMarkerUpdater.m
//  mj-studio-react-native-naver-map
//
//  Created by mj on 4/18/24.
//
#import "FnUtil.h"
#import "Utils.h"
#import "RNCNaverMapClusterKey.h"
#import <NMapsMap/NMapsMap.h>
#import <React/RCTBridge+Private.h>
#import <React/RCTBridge.h>

@interface RNCNaverMapClusterMarkerUpdater : NMCDefaultClusterMarkerUpdater
// invalid number means undefined in js
@property(nonatomic, assign) double width;
// invalid number means undefined in js
@property(nonatomic, assign) double height;
@property(nonatomic, strong) NSDictionary* _Nullable image;

- (instancetype _Nullable )initWith:(double)width height:(double)height
                   image:(nonnull NSDictionary*)image;
@end
