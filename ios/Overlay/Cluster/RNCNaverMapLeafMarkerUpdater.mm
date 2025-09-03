//
//  RNCNaverMapLeafMarkerUpdater.m
//  mj-studio-react-native-naver-map
//
//  Created by mj on 4/18/24.
//

#import "RNCNaverMapLeafMarkerUpdater.h"

@implementation RNCNaverMapLeafMarkerUpdater {
  __weak NSMutableDictionary<NSString*, void (^)()>* _markerImageRequestCanceler;
}

- (id)init:(nonnull NSMutableDictionary<NSString*, void (^)()>*)markerImageRequestCanceler {
  if (self = [super init]) {
    _markerImageRequestCanceler = markerImageRequestCanceler;
  }
  return self;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wmissing-selector-name"
- (void)updateLeafMarker:(NMCLeafMarkerInfo* _Nonnull)info:(NMFMarker* _Nonnull)marker {
  [super updateLeafMarker:info:marker];

  RNCNaverMapClusterKey* key = (RNCNaverMapClusterKey*)info.key;

  NSString* identifier = key.identifier;
  NSDictionary* image = key.image;

  __weak NMFMarker* weakMarker = marker;

  if (key.width > 0 && isValidNumber(key.width)) {
    marker.width = key.width;
  }
  if (key.height > 0 && isValidNumber(key.height)) {
    marker.height = key.height;
  }

  auto caption = key.caption;
  if (caption[@"text"]) {
    marker.captionText = caption[@"text"];
    marker.captionRequestedWidth = [caption[@"requestedWidth"] floatValue];
    marker.captionAligns = @[ [RCTConvert NMFAlignType:caption[@"align"]] ];
    marker.captionOffset = [caption[@"offset"] floatValue];
    marker.captionColor = [Utils hexToColor: caption[@"color"]];
    marker.captionHaloColor = [Utils hexToColor:caption[@"haloColor"]];
    marker.captionTextSize = [caption[@"textSize"] floatValue];
    marker.captionMinZoom = [caption[@"minZoom"] doubleValue];
    marker.captionMaxZoom = [caption[@"maxZoom"] doubleValue];
  }

  if (key.bridge) {
    marker.alpha = 0;
    if (_markerImageRequestCanceler[identifier]) {
      _markerImageRequestCanceler[identifier]();
      _markerImageRequestCanceler[identifier] = nil;
    }
    _markerImageRequestCanceler[identifier] =
        [Utils getImage:key.bridge
                   json:image
               callback:^(NMFOverlayImage* overlayImage) {
                 dispatch_async(dispatch_get_main_queue(), ^() {
                   if (weakMarker) {
                     weakMarker.alpha = 1;
                     weakMarker.iconImage = !overlayImage ? NMF_MARKER_IMAGE_GREEN : overlayImage;
                   }
                   [_markerImageRequestCanceler removeObjectForKey:identifier];
                 });
               }];
  }
  [marker setTouchHandler:^BOOL(NMFOverlay* __weak overlay) {
    if (key.onTapLeafMarker) {
      key.onTapLeafMarker();
      return YES;
    }
  return NO;
  }];
}
#pragma clang diagnostic pop

@end
