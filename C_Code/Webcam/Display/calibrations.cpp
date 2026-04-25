#include <opencv2/opencv.hpp>
#include <iostream>
#include <fstream>
#include <vector>

#include <thread>
#include <chrono>

//To Compile:
//g++ calibrations.cpp -o calib `pkg-config --cflags --libs opencv4`
//To get calibration values:
//./calib /dev/video0

// Save calibration to CSV
void save_calibration(const std::vector<int>& data, const std::string& filename) {
    std::ofstream file(filename);
    for (size_t i = 0; i < data.size(); i++) {
        file << data[i];
        if (i != data.size() - 1) file << ",";
    }
    file << "\n";
}

// Compute column averages
std::vector<int> compute_column_average(const cv::Mat& frame) {
    int width = frame.cols;
    int height = frame.rows;

    std::vector<int> column_data(width, 0);

    for (int y = 0; y < height; y++) {
        const uint8_t* row = frame.ptr<uint8_t>(y);
        for (int x = 0; x < width; x++) {
            column_data[x] += row[x];
        }
    }

    for (int x = 0; x < width; x++) {
        column_data[x] /= height;
    }

    return column_data;
}

// Capture dark calibration
std::vector<int> calibrate(cv::VideoCapture& cap, int frames) {
    cv::Mat frame;
    std::vector<int> avg;

    for (int i = 0; i < frames; i++) {
        cap >> frame;
        if (frame.empty()) continue;

        cv::cvtColor(frame, frame, cv::COLOR_YUV2GRAY_YUYV);

        std::vector<int> curr = compute_column_average(frame);

        if (avg.empty()) {
            avg = curr;
        } else {
            for (size_t j = 0; j < curr.size(); j++) {
                avg[j] += curr[j];
            }
        }
    }

    for (size_t j = 0; j < avg.size(); j++) {
        avg[j] /= frames;
    }

    return avg;
}



int main(int argc, char** argv) {
    // Allow camera path like your main file (e.g. /dev/video0)
    // For fluorescent light use input video20 (/dev/video20)
    const char* device = (argc > 1) ? argv[1] : "0";

    // 
    std::string arg1 = argv[1];

    cv::VideoCapture cap; 

    // Handle numeric vs string device
    if (std::isdigit(device[0])) {
        cap.open(std::stoi(device), cv::CAP_V4L2);
    } else {
        cap.open(device, cv::CAP_V4L2);
    }

    if (!cap.isOpened()) {
        std::cerr << "Camera not opened\n";
        return -1;
    }

    // MATCH YOUR MAIN FILE SETTINGS
    cap.set(cv::CAP_PROP_FOURCC, cv::VideoWriter::fourcc('Y','U','Y','V'));
    cap.set(cv::CAP_PROP_FRAME_WIDTH, 1280);
    cap.set(cv::CAP_PROP_FRAME_HEIGHT, 720);
    cap.set(cv::CAP_PROP_FPS, 5);
    cap.set(cv::CAP_PROP_CONVERT_RGB, 0);

    //Dark cali

    std::cout << "Cover the lens for dark calibration...\n";
    std::this_thread::sleep_for(std::chrono::seconds(5)); // give time to cover lens

    std::vector<int> dark = calibrate(cap, 10);

    // saves calibration data to different file name depending on camera input
    save_calibration(dark, "dark_calibration" + arg1 + ".csv");

    std::cout << "Saved dark_calibration.csv\n";

    //Light cali

    std::cout << "Expose the lens to light...\n";
    std::this_thread::sleep_for(std::chrono::seconds(5)); // give time to cover lens

    std::vector<int> light = calibrate(cap, 10);

    save_calibration(light, "light_calibration" + arg1 + ".csv");

    std::cout << "Saved light_calibration.csv\n";

    return 0;
}

int avg_fluorescent(int argc, char** argv) {

    const char* device = (argc > 1) ? argv[1] : "0";
    cv::VideoCapture cap;

    if (!cap.isOpened()) {
        std::cerr << "Camera not opened\n";
        return -1;
    }

    int width = <int>(cap.get(cv::CAP_PROP_FRAME_WIDTH));
    int height = <int>(cap.get(cv::))    
}