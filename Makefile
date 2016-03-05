all : square

libsquare.so : square.cu
	nvcc --ptxas-options=-v --compiler-options '-fPIC' -o libsquare.so --shared square.cu

square : libsquare.so main.cc
	g++ -o square main.cc -L. -lsquare
