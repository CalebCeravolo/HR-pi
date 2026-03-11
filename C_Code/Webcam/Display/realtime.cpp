#include <opencv2/opencv.hpp>
#include <vector>
//g++ realtime.cpp -o plot `pkg-config --cflags --libs opencv4`
int main() {

    cv::VideoCapture cap("/dev/video0", cv::CAP_V4L2);
    cap.set(cv::CAP_PROP_CONVERT_RGB, 0);

    int width = cap.get(cv::CAP_PROP_FRAME_WIDTH);
    int height = cap.get(cv::CAP_PROP_FRAME_HEIGHT);

    std::vector<double> spectrum(width);

    while(true) {

        cv::Mat frame;
        cap >> frame;
        if(frame.empty()) break;

        std::fill(spectrum.begin(), spectrum.end(), 0.0);

        // extract Y values from YUYV
        for(int y=0;y<frame.rows;y++){
            const uchar* row = frame.ptr<uchar>(y);
            for(int x=0;x<width;x++){
                spectrum[x] += row[x*2];
            }
        }

        for(int x=0;x<width;x++)
            spectrum[x] /= frame.rows;

        int plot_h = 400;
        cv::Mat plot(plot_h, width, CV_8UC3, cv::Scalar(255,255,255));

        double max_val = *std::max_element(spectrum.begin(), spectrum.end());

        for(int x=1;x<width;x++) {

            int y1 = plot_h - (spectrum[x-1]/max_val)*plot_h;
            int y2 = plot_h - (spectrum[x]/max_val)*plot_h;

            cv::line(plot,
                     cv::Point(x-1,y1),
                     cv::Point(x,y2),
                     cv::Scalar(0,0,0),1);
        }

        cv::imshow("Spectrum", plot);

        if(cv::waitKey(1) == 'q')
            break;
    }
}