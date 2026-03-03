#include <opencv2/core.hpp>
#include <opencv2/opencv.hpp>
#include <iostream>

int main() {
    cv::VideoCapture cap(0);  // camera index 0

    if (!cap.isOpened()) {
        std::cout << "Camera not opened\n";
        return -1;
    }

    cv::Mat frame;
    cap >> frame;
    if (frame.empty()) return 1;
    // cv::imwrite("frame.jpg", frame);
    cv::imshow("Camera", frame);
    std::cout << "Imwritten\n";
    return 0;
}