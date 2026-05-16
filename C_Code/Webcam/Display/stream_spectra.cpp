#include <opencv2/opencv.hpp>
// #include "/home/robot/HR-pi/C_Code/functions.h"
// #include <vector>
//g++ stream_spectra.cpp -o stream_spec `pkg-config --cflags --libs opencv4`
//v4l2-ctl -d /dev/video0 --list-ctrls
// v4l2-ctl -d /dev/video0 -c exposure_time_absolute=1000
#define SCREEN_WIDTH 2880
#define SCREEN_HEIGHT 1800

#include <fstream>
#include <sstream>
#include <vector>
#include <string>
#include <iostream>
#include <deque>
#include <numeric>
#include <cmath>
using namespace std;
vector<double> load_calibration(const string& filename) {
    vector<double> data;
    ifstream file(filename);

    if (!file.is_open()) {
        cerr << "Failed to open calibration file: " << filename << "\n";
        return data;
    }

    string line;
    if (getline(file, line)) {
        stringstream ss(line);
        string value;

        while (getline(ss, value, ',')) {
            try {
                data.push_back(stoi(value));
            } catch (...) {
                cerr << "Invalid number in calibration file\n";
            }
        }
    }

    return data;
}

int char_to_int(char * arg){
    double res = 0;
    uint8_t negative = *arg=='-';
    uint8_t base = 10;
    if (*(arg+negative)=='0'){
        if (*(arg+negative+1)=='b'){
            base=2;
        } else if (*(arg+negative+1)=='x'){
            base=16;
        }
    }
    int curr_num=0;
    for (int i=negative+2*(base!=10); *(arg+i)!='\0'; i++){
            curr_num=(int)(*(arg+i))-(int)'0';
            if (curr_num>9){
                curr_num-=39;
            }
            res*=base;
            res+=curr_num;
    }
    return (negative ? -1*res : res);
}
void intparse (int argc, char** args, int * output){
    for (int i=0; i<argc; i++){
        *(output+i)=char_to_int(*(args+i));
    }
}

int main(int argc, char** argv) {
    int vals[argc-1];
    intparse(argc-1, argv+1, vals);
    cv::VideoCapture cap(argv[1], cv::CAP_V4L2);  // camera 
    cv::namedWindow("Frame", cv::WINDOW_NORMAL);
    cap.set(cv::CAP_PROP_FOURCC, cv::VideoWriter::fourcc('Y','U','Y','V'));
    cap.set(cv::CAP_PROP_FRAME_WIDTH, 1280);
    cap.set(cv::CAP_PROP_FRAME_HEIGHT, 720);
    cap.set(cv::CAP_PROP_FPS, 5);   // lower FPS if needed
    cap.set(cv::CAP_PROP_CONVERT_RGB, 0);
    
    if (!cap.isOpened()) {
        cout << "Camera not opened\n";
        return -1;
    }
    cv::Mat frame;
    const uint32_t width = cap.get(cv::CAP_PROP_FRAME_WIDTH);
    const uint32_t height = cap.get(cv::CAP_PROP_FRAME_HEIGHT);
    vector<int> column_data(width, 0);
    uint8_t* row;
    int scale = 1;
    int plot_h = 540;
    cv::Mat output_im(cv::Size(width, height),CV_8UC1);
    cv::Mat plot(plot_h, width, CV_8UC1, cv::Scalar(255));
    cv::namedWindow("Frame", cv::WINDOW_NORMAL);
    const double horiz_scale = (SCREEN_WIDTH/width);
    const double vert_scale = (SCREEN_HEIGHT/height);
    const double window_scailing = horiz_scale>vert_scale ? vert_scale : horiz_scale;
    const uint32_t scaled_width = (uint32_t)(window_scailing*width);
    const uint32_t scaled_height = (uint32_t)(window_scailing*height);
    printf("%i, %i, %i, %i\n", scaled_width, scaled_height, width, height);
    cv::Mat resized_image(cv::Size(scaled_width, scaled_height),CV_8UC1);
    vector<double> dark_profile = load_calibration("dark_calibration.csv");
    vector<double> light_profile = load_calibration("light_calibration.csv");
    //Subtract out dark value from MAX value
    // for (int kk=0; kk<width; kk++) {
    //     light_profile[kk] -= dark_profile[kk];
    // }
    int margin_left = 60;
    int counter = 0;
    int offset = 30;
    while(true) {
        
        cap >> frame;
        // vector<int> avg = average(cap);
        // plot(avg);
        
        if(frame.empty()) break;
        cv::cvtColor(frame, frame, cv::COLOR_YUV2GRAY_YUYV);
        for (int y = 0; y < height; y++) {
            row = frame.ptr<uint8_t>(y);
            for (int x = 0; x < width; x++) {
                // for (int ii=0; ii<frame.channels(); ii++) {
                    column_data[x] += row[x]; // Y component
                // }
                
            }
        }
        
        for (int ii=0; ii<width; ii++) {
            //Avg sum of col values
            // double signal = column[ii];
            column_data[ii]/=height;
            //Subtract out dark value form avg value
            // column_data[ii] -= dark_profile[ii];
            
            
            // //Find avg / MAX fraction
            // column_data[ii] /= light_profile[ii];
            // column_data[ii] *= 100;
            // //offset
            // column_data[ii]+= 30;
        }


        // cv::Mat output_im(height, width, CV_32FC1, );
        // vector<vector<int>> output_im(height, vector<int>(width));
        // for (int y = 0; y < height; y++) {
        //     row = output_im.ptr<uint8_t>(y);
        //     for (int x = 0; x < width; x++) {
        //         row[x] = column_data[x];
        //     }
        // }

        // ticks
        for (int i = 0; i <= 5; i++) {
            // int percent = i * 20;
            int percent = i * 20;
            double y = (plot_h - offset) - (percent * (plot_h - 2*offset) / 100); //Set top/bottom bounds for y-axis tick marks //1.3 JUST WORKS 
            //double y = (plot_h - offset)()

            cv::line(plot,
                cv::Point(margin_left - 5, y),
                cv::Point(margin_left, y),
                cv::Scalar(0), 1);

            cv::putText(plot,
                to_string(percent),
                cv::Point(5, y + 5),
                cv::FONT_HERSHEY_SIMPLEX,
                0.4,
                cv::Scalar(0), 1);
        }
        
        int window = 10;
        deque<double> y1_buffer, y2_buffer;
        for(int x=1;x<width;x++) {

            // double y1 = (plot_h)-((column_data[x-1]-dark_profile[x-1])*(plot_h - 2* offset))/(light_profile[x-1]-dark_profile[x-1]); 
            // double y2 = (plot_h)-((column_data[x]-dark_profile[x])*(plot_h - 2*offset))/(light_profile[x]-dark_profile[x]);

            // if (counter % 10000 == 0){
            //     cout <<y1<< ": y1"<<'\n';
            //     cout <<column_data[x-1] << "columndata" <<'\n';
            //     // cout <<dark_profile[x-1] << "dark" <<'\n';
            //     cout <<light_profile[x-1]-dark_profile[x-1] << "light" <<'\n';
            //     cout << (column_data[x-1]-dark_profile[x-1]) << ": ratio" <<'\n';

            // }
            double y1 = (light_profile[x-1] - dark_profile[x-1])/(column_data[x-1]-dark_profile[x-1]); //Finding percentage of max light
            double y2 = (light_profile[x-1] - dark_profile[x-1])/(column_data[x-1]-dark_profile[x-1]); //Divide by ~255
            if ((isinf(y2)) || (y2 <= 0)) {
                y1 = 100;
            }
            if ((isinf(y2)) || (y2 <= 0)) {
                y2 = 100;
            }
            if (counter % 10000 == 0){
                //cout <<y1<< ": y1"<<'\n';
                //cout <<column_data[x-1] << "columndata" <<'\n';
                // cout <<dark_profile[x-1] << "dark" <<'\n';
                cout <<(light_profile[x-1]-dark_profile[x-1]) << " light" <<'\n';
                cout << (column_data[x-1]-dark_profile[x-1]) << ": current light" <<'\n';
                cout << y1 << ": ratio" <<'\n';

            }
            //add buffers
            y1_buffer.push_back(y1);
            y2_buffer.push_back(y2);
            if (y1_buffer.size() > window) y1_buffer.pop_front();
            if (y2_buffer.size() > window) y2_buffer.pop_front();


            //compute averages
            double y1_average = accumulate(y1_buffer.begin(), y1_buffer.end(), 0.0) / y1_buffer.size();
            double y2_average = accumulate(y2_buffer.begin(), y2_buffer.end(), 0.0) / y2_buffer.size();
            
            // if (counter % 10000 == 0){
            //     cout <<y1_average<< ": y1avg pre log"<<'\n';

            // }

            double absorb1 = log10(y1_average);
            double absorb2 = log10(y2_average);

            // if (counter % 10000 == 0){
            //      cout <<absorb1<< ": abs1"<<'\n';

            // }

            y1_average = plot_h - absorb1*(plot_h - 2*offset)/2;
            y2_average = plot_h - absorb1*(plot_h - 2*offset)/2;


            y1_average -= offset;
            y2_average -= offset;
            counter++;
            if (counter % 10000 == 0){
                cout <<y1_average<< ": y1avg post offset"<<'\n';

            }

            cv::line(plot,
                    cv::Point((x-1),(int)(y1_average)),
                    cv::Point((x),(int)(y2_average)),    
                    cv::Scalar(0,0,0),1);  


             }
        //     cv::line(plot,
        //             cv::Point((x-1),(int)(y1_average - offset)),
        //             cv::Point((x),(int)(y2_average - offset)),    
        //             cv::Scalar(0,0,0),1);      
        // }
        // cv::Mat img(100, 100, CV_32FC1, data);
        // cv::imwrite("out.tiff", output_im);
        // cv::imwrite("plot.png", plot);
            // cv::cvtColor(frame, frame, cv::COLOR_YUV2GRAY_YUYV);
            cv::resize(plot, resized_image, cv::Size(scaled_width, scaled_height));
            cv::imshow("Frame", resized_image);
            
            fill(column_data.begin(), column_data.end(), 0);
            plot.setTo(255);
            if(cv::waitKey(1) == 'q')
                break;
        }
    }
