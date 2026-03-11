#include <opencv2/opencv.hpp>
#include "httplib.h"
//g++ browser_cam.cpp -o browserCam `pkg-config --cflags --libs opencv4`
int main(int argc, char** argv) {

    cv::VideoCapture cap(argv[1], cv::CAP_V4L2);

    httplib::Server server;

    server.Get("/stream", [&](const httplib::Request&, httplib::Response& res) {

        res.set_header("Cache-Control", "no-cache");
        res.set_header("Connection", "close");

        res.set_chunked_content_provider(
            "multipart/x-mixed-replace; boundary=frame",
            [&](size_t, httplib::DataSink &sink) {

                while(true) {

                    cv::Mat frame;
                    cap >> frame;
                    if(frame.empty()) break;

                    std::vector<uchar> buffer;
                    cv::imencode(".jpg", frame, buffer);

                    std::string header =
                        "--frame\r\n"
                        "Content-Type: image/jpeg\r\n"
                        "Content-Length: " + std::to_string(buffer.size()) + "\r\n\r\n";

                    sink.write(header.c_str(), header.size());
                    sink.write((char*)buffer.data(), buffer.size());
                    sink.write("\r\n", 2);
                }

                sink.done();
                return true;
            }
        );
    });

    server.listen("0.0.0.0", 8080);
}