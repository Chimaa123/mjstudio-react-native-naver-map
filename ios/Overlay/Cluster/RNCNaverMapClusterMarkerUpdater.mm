//
//  RNCNaverMapClusterMarkerUpdater.m
//  mj-studio-react-native-naver-map
//
//  Created by mj on 4/18/24.
//
#import "RNCNaverMapClusterMarkerUpdater.h"
#import "RNCNaverMapClusterKey.h"
#import <NMapsMap/NMapsMap.h>


@implementation RNCNaverMapClusterMarkerUpdater {
  void (^_imgRequests)(void);
}

- (RCTBridge*)bridge {
  return [RCTBridge currentBridge];
}

- (instancetype)initWith:(double)width height:(double)height image: (NSDictionary*)image {
  if (self = [super init]) {
    _width = width;
    _height = height;
    _image = image;
  }
  return self;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wmissing-selector-name"
- (void)updateClusterMarker:(NMCClusterMarkerInfo*)info:(NMFMarker*)marker {
  [super updateClusterMarker:info:marker];
  marker.width = isValidNumber(_width) && _width ? _width : NMF_MARKER_SIZE_AUTO;
  marker.height = isValidNumber(_height) && _height ? _height : NMF_MARKER_SIZE_AUTO;

  NSLog(@"updateClusterMarker exist width: %f height: %f", _width, _height);
  NSDictionary* image = _image;
  __weak NMFMarker* weakMarker = marker;


  RCTBridge* bridge = [RCTBridge currentBridge];
  if (bridge) {
    marker.alpha = 0;
    _imgRequests = [Utils getImage:bridge
               json:image
           callback:^(NMFOverlayImage* overlayImage) {
              dispatch_async(dispatch_get_main_queue(), ^() {
                if (weakMarker) {
                  weakMarker.alpha = 1;
                  weakMarker.iconImage = !overlayImage ? NMF_MARKER_IMAGE_GREEN : overlayImage;
                }
                self->_imgRequests = nil;
              });
            }];
  }
}
#pragma clang diagnostic pop
@end
