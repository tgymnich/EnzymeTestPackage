# EnzymeTestPackage

A description of this package.


```
docker pull ghcr.io/tgymnich/swift-5.4.2-plugin:latest
docker run -it ghcr.io/tgymnich/swift-5.4.2-plugin bash
git clone https://github.com/tgymnich/EnzymeTestPackage.git
cd EnzymeTestPackage
swift package build -Xswiftc -Xllvm -Xswiftc -load=/LLVMEnzyme-11.so -Xswiftc -Xllvm -Xswiftc -enzyme
```
