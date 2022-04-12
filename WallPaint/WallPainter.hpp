//
//  WallPainter.hpp
//  WallPaint
//
//  Created by devstar on 4/12/22.
//

#ifndef WallPainter_hpp
#define WallPainter_hpp
#endif /* WallPainter_hpp */
#include <opencv2/opencv.hpp>

class WallPainter {
public:
    /*
    Returns image with paint overlay
    */
    cv::Mat paint_wall(cv::Mat image,cv::Point p, cv::Size imageSize,cv::Scalar chosenColor);
    cv::Mat apply_texture(cv::Mat image,cv::Mat texture,cv::Point p, cv::Size imageSize);
};
