#include <opencv2/opencv.hpp>
// #include "/home/robot/HR-pi/C_Code/functions.h"
// #include <vector>
//g++ stream_spectra.cpp -o stream_spec `pkg-config --cflags --libs opencv4`
//v4l2-ctl -d /dev/video2 --list-ctrls
// v4l2-ctl -d /dev/video2 -c zoom_absolute=60
int char_to_int(char * arg){
    float res = 0;
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
    int width = cap.get(cv::CAP_PROP_FRAME_WIDTH);
    int height = cap.get(cv::CAP_PROP_FRAME_HEIGHT);
    std::vector<int> column_data(width, 0);
    uint8_t* row;
    int scale = 1;
    int plot_h = 540;
    cv::Mat output_im(cv::Size(width, height),CV_8UC1);
    cv::Mat plot(plot_h, width, CV_8UC1, cv::Scalar(255));
    cv::namedWindow("Frame", cv::WINDOW_NORMAL);
    while(true) {
        
        cap >> frame;
        
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
            column_data[ii]/=height;
        }
        // cv::Mat output_im(height, width, CV_32FC1, );
        // std::vector<std::vector<int>> output_im(height, std::vector<int>(width));
        for (int y = 0; y < height; y++) {
            row = output_im.ptr<uint8_t>(y);
            for (int x = 0; x < width; x++) {
                row[x] = column_data[x];
            }
        }
        
        for(int x=1;x<width;x++) {

            int y1 = plot_h-(column_data[x-1]*plot_h)>>8; //Divide by ~255
            int y2 = plot_h-(column_data[x]*plot_h)>>8;

            cv::line(plot,
                    cv::Point((x-1),y1),
                    cv::Point((x),y2),
                    cv::Scalar(0,0,0),4);
        }
        // cv::Mat img(100, 100, CV_32FC1, data);
        // cv::imwrite("out.tiff", output_im);
        // cv::imwrite("plot.png", plot);
            // cv::cvtColor(frame, frame, cv::COLOR_YUV2GRAY_YUYV);
            cv::imshow("Frame", plot);
            std::fill(column_data.begin(), column_data.end(), 0);
            plot.setTo(255);
            if(cv::waitKey(1) == 'q')
                break;
        }
}