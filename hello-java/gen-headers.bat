@echo off

cd bin
javah -d "../../output-jni/include" net.cryp7.range.hello.NativeOutput
cd ../
