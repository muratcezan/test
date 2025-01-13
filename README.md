## RDP Kapat
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\' -Name fDenyTSConnections -Value 1

## RDP Ac
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\' -Name fDenyTSConnections -Value 0

## FFmpeg
./configure --enable-pic --enable-static --disable-shared --disable-x86asm --enable-lzma
make -j${nproj}
sudo make install

## FreeRDP
cmake  -DWITH_WAYLAND=ON -DWITH_PCSC=OFF -DWITH_OPENH264=ON -DWITH_OPENCL=ON -DWITH_GSM=ON -DWITH_LAME=ON -DWITH_FAAD2=ON -DWITH_FAAC=ON -DWITH_SOXR=ON -DWITH_OPENSSL=ON -DWITH_MBEDTLS=ON DCMAKE_POSITION_INDEPENDENT_CODE=ON -DBUILD_SHARED_LIBS=OFF -DCMAKE_BUILD_TYPE=Release ..

cmake  -DWITH_WAYLAND=OFF -DWITH_PCSC=OFF -DWITH_OPENH264=ON -DWITH_OPENCL=OFF -DWITH_GSM=OFF -DWITH_LAME=ON -DWITH_FAAD2=OFF -DWITH_FAAC=ON -DWITH_SOXR=OFF -DWITH_OPENSSL=ON -DWITH_MBEDTLS=ON -DCMAKE_POSITION_INDEPENDENT_CODE=ON -DBUILD_SHARED_LIBS=OFF  -DCMAKE_BUILD_TYPE=Release ..
