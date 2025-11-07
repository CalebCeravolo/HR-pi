for i in {0..2000}; do
    SPI 1 $i
    echo $i
    sleep .001
done