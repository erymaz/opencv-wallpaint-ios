//
//  WallPainterBridge.h
//  WallPaint
//
//  Created by devstar on 4/12/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WallPainterBridge : NSObject

- (UIImage *) paintWallOf: (UIImage *) image touchPointX: (double) pointX touchPointY: (double) pointY imageWidth: (double) width imageHeight: (double) height colorToapply: (UIColor *) color;

- (UIImage *) applyTextureTo: (UIImage *) image textureToApply: (UIImage *) texture touchPointX: (double) pointX touchPointY: (double) pointY imageWidth: (double) width imageHeight: (double) height;

@end
