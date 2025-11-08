for i in {0..2000}; do
    SPI 1 $i
    # echo $i
    #sleep .001
done
sleep 1
for i in {2000..0}; do
    SPI 1 $i
    # echo $i
    #sleep .001
done
sleep 1
SPI 1 0

for i in {0..2000}; do
    SPI 0 $i
    # echo $i
    #sleep .001
done
sleep 1
for i in {2000..0}; do
    SPI 0 $i
    # echo $i
    #sleep .001
done
SPI 0 0