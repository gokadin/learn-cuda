# Programming CUDA Using Go

This example demonstrates that we can programming CUDA using Go.  It
works with Amazon AWS GPU instances (64-bit AMD x64 system) and Nvidia
Jetson TK1 development board (32-bit ARM7l system).

The `cgo` tool in Go's toolchain enables calling C programs from Go
programs.  However, `cgo` assumes that the C/C++ compiler accepts
command line parameters that GCC accepts.  For example, Clang is
compatible with GCC.  However, NVCC isn't.

Thanks to the author of
[this Stackoverflow question](http://stackoverflow.com/questions/32589153/how-to-compile-cuda-source-with-go-languages-cgo),
who proposed a solution:

1. Build device code and its C wrapper into a shared library using NVCC.
2. Link the shared library with the Go program using CGO.

In our case, the "device code and its C wrapper" are in
`c++/square.cu`.  `c++/Makefile` shows how to build a shared library
using NVCC.

The Go program in our case is `square/square.go`.  After building the
shared library by typing `make -f` in directory `c++`, we can build
and run the Go program

    cd square
    go install -v && go test -v && go vet
    LD_LIBRARY_PATH=.:$LD_LIBRARY_PATH $GOPATH/bin/square

