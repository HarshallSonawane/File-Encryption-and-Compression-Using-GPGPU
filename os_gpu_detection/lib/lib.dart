import "dart:ffi";
import "package:ffi/ffi.dart";

// Typedefs
typedef DartFunc = Double Function(
    Pointer<Utf8> inputPath, Pointer<Utf8> outputPath, Pointer<Utf8> password);
typedef NativeFunc = double Function(
    Pointer<Utf8> inputPath, Pointer<Utf8> outputPath, Pointer<Utf8> password);

typedef RunGPUScriptFunc = Void Function();
typedef RunGPUScript = void Function();

late String gpuInfoLibPath, cpuLibPath, oclLibPath, cudaLibPath;
late DynamicLibrary gpuInfoDynamicLib,
    cpuDynamicLib,
    oclDynamicLib,
    cudaDynamicLib;

// CPU
late double Function(Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>) aesCPUEncrypt,
    aesCPUDecrypt,
    aesCPUHuffmanEncrypt,
    aesCPUHuffmanDecrypt;

late double aesCPUEncryptTime,
    aesCPUDecryptTime,
    aesCPUHuffmanEncryptTime,
    aesCPUHuffmanDecryptTime;

// CUDA
late double Function(Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>)
    aesCUDAEncrypt,
    aesCUDADecrypt,
    aesCUDAHuffmanEncrypt,
    aesCUDAHuffmanDecrypt;

late double aesCUDAEncryptTime,
    aesCUDADecryptTime,
    aesCUDAHuffmanEncryptTime,
    aesCUDAHuffmanDecryptTime;

// OpenCL
late double Function(Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>)
    aesOpenCLEncrypt,
    aesOpenCLDecrypt,
    aesOpenCLHuffmanEncrypt,
    aesOpenCLHuffmanDecrypt;

late double aesOpenCLEncryptTime,
    aesOpenCLDecryptTime,
    aesOpenCLHuffmanEncryptTime,
    aesOpenCLHuffmanDecryptTime;

late int fileMode;
