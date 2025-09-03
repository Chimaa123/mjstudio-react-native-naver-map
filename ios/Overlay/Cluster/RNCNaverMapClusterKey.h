//
//  RNCNaverMapClusterKey.h
//  DoubleConversion
//
//  Created by mj on 4/18/24.
//

#import <Foundation/Foundation.h>
#import <NMapsGeometry/NMapsGeometry.h>
#import <NMapsMap/NMapsMap.h>
#import <React/RCTBridge.h>

typedef void (^OnTapLeafMarker)();

NS_ASSUME_NONNULL_BEGIN

@interface RNCNaverMapClusterKey : NSObject <NMCClusteringKey>

@property(nonatomic, strong) NSString* identifier;
@property(nonatomic, strong) NMGLatLng* position;
@property(nonatomic, weak) RCTBridge* bridge;
@property(nonatomic, strong) NSDictionary* image;
@property(nonatomic, assign) double width;
@property(nonatomic, assign) double height;
@property(nonatomic, strong) NSDictionary* caption;
@property(nonatomic, nullable) OnTapLeafMarker onTapLeafMarker;

+ (instancetype)markerKeyWithIdentifier:(nonnull NSString*)identifier
                               position:(nonnull NMGLatLng*)position
                                 bridge:(RCTBridge*)bridge
                                  image:(nonnull NSDictionary*)image
                                  width:(double)width
                                 height:(double)height
                                caption:(nonnull NSDictionary*)caption
                        onTapLeafMarker:(OnTapLeafMarker _Nullable)onTapLeafMarker;

@end

NS_ASSUME_NONNULL_END
