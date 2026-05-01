#include <opencv2/opencv.hpp>
#include <iostream>
#include <fstream>
#include <vector>

#include <thread>
#include <chrono>
//g++ fluorescent.cpp -o calib `pkg-config --cflags --libs opencv4`
// For fluorescent light use input video20 (/dev/video20)


int main(int argc, char** argv) {
    cv::VideoCapture cap(argv[1], cv::CAP_V4L2);  // camera 
    cv::namedWindow("Frame", cv::WINDOW_NORMAL);
    cap.set(cv::CAP_PROP_FOURCC, cv::VideoWriter::fourcc('Y','U','Y','V'));
    cap.set(cv::CAP_PROP_FRAME_WIDTH, 1280);
    cap.set(cv::CAP_PROP_FRAME_HEIGHT, 720);
    cap.set(cv::CAP_PROP_FPS, 5);   // lower FPS if needed
    cap.set(cv::CAP_PROP_CONVERT_RGB, 0);

    if (!cap.isOpened()) {
        std::cout << "Camera not opened\n";
        return -1;
    }
    cv::Mat frame;

    const char* device = (argc > 1) ? argv[1] : "0";
    //cv::VideoCapture cap;

    if (!cap.isOpened()) {
        std::cerr << "Camera not opened\n";
        return -1;
    }
    // static_cast<int>(
    int width = cap.get(cv::CAP_PROP_FRAME_WIDTH);
    int height = cap.get(cv::CAP_PROP_FRAME_HEIGHT); 
    //int pixels = width * height; 
    
    long long sumY = 0;
    // num pixels
    long long count = 0;
    for (int y = 0; y < height; y++) {
        uchar* row = frame.ptr<uchar>(y);

        for (int x = 0; x < width; x += 2) {
            // cv::Vec3b pixel = frame.at<cv::Vec3b>(i, j);
            // blue += pixel[0];
            // green += pixel[1];
            // red += pixel[2];
            
            // pixel 1 intensity (x)
            uchar Y0 = row[x * 2];
            // uchar U = row[i  +1];
            // pixel 2 intensity (x+1)
            uchar Y1 = row[x * 2 + 2];
            // uchar V = row[i + 3];

            sumY += Y0 + Y1;
            count += 2;
        }
    }

    double avgIntensity = (double)sumY / count;
    // then save avgIntensity to a csv file
}