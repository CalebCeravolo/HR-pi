#include <opencv2/core.hpp>
#include <opencv2/opencv.hpp>
#include <iostream>
#include <vector>
//g++ main.cpp -o main `pkg-config --cflags --libs opencv4`
// using namespace std;
int main() {
    cv::VideoCapture cap("/dev/video0", cv::CAP_V4L2);  // camera 
    cap.set(cv::CAP_PROP_FOURCC, cv::VideoWriter::fourcc('Y','U','Y','V'));
    cap.set(cv::CAP_PROP_FRAME_WIDTH, 1280);
    cap.set(cv::CAP_PROP_FRAME_HEIGHT, 720);
    cap.set(cv::CAP_PROP_FPS, 5);   // lower FPS if neededindex 0

    if (!cap.isOpened()) {
        std::cout << "Camera not opened\n";
        return -1;
    }

    cv::Mat frame;
    cap >> frame;
    if (frame.empty()) return 1;
    cv::imwrite("raw.png", frame);
    // cv::imshow("Camera", frame);
    std::cout << "Imwritten\n";
    std::cout << "Channels: " << frame.channels() << "\n";
    std::vector<int> column_data(frame.cols);
    for (int y = 0; y < frame.rows; y++) {

        cv::Vec3b* row = frame.ptr<cv::Vec3b>(y);

        for (int x = 0; x < frame.cols; x++) {

            for (int ii=0; ii<frame.channels(); ii++) {
                column_data[x]+=row[x][ii];
            }
            
        }
    }
    for (int ii=0; ii<frame.cols; ii++) {
        column_data[ii]/=frame.rows*frame.channels();
    }
    // cv::Mat output_im(frame.rows, frame.cols, CV_32FC1, );
    // std::vector<std::vector<int>> output_im(frame.rows, std::vector<int>(frame.cols));
    cv::Mat output_im(cv::Size(frame.cols, frame.rows),CV_8UC1);
    for (int y = 0; y < frame.rows; y++) {
        unsigned char* row = output_im.ptr<unsigned char>(y);
        for (int x = 0; x < frame.cols; x++) {
            row[x] = column_data[x];
        }
    }
    

    // cv::Mat img(100, 100, CV_32FC1, data);
    cv::imwrite("out.png", output_im);
    // cv::Mat output(frame.rows, frame.cols, CV_32FC1, output_im);
    printf("%i\n",column_data[1]);

    return 0;
}