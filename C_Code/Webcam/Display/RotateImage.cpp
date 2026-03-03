#include <stdio.h>
#include <opencv2/opencv.hpp>
// cmake -S . -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
// g++ capture.cpp -o look `pkg-config --cflags --libs opencv4`
// cmake . ; make
using namespace cv;

int main(int argc, char** argv)
{
    if (argc != 2)
    {
        printf("usage: rotate.out <Image_Path>\n");
        return -1;
    }

    Mat image = imread(argv[1], IMREAD_COLOR);

    if (image.empty())
    {
        printf("No image data\n");
        return -1;
    }

    Mat rotated;

    // Rotate 180 degrees
    rotate(image, rotated, ROTATE_180);

    // Save result
    if (!imwrite(argv[1], rotated))
    {
        printf("Failed to save image\n");
        return -1;
    }

    return 0;
}