cmake_minimum_required(VERSION 3.20)
project(gemm VERSION 0.1.0 LANGUAGES CXX)

option(GEMM_ENABLE_NEON "Enable the explicit AArch64 NEON 4x4 kernel when supported" ON)
option(GEMM_NATIVE_ARCH "Tune generated code for the build machine" OFF)
option(GEMM_VECTORIZATION_REPORTS "Emit compiler optimization remarks for kernels" OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_library(gemm STATIC src/matrix.cpp src/gemm_reference.cpp src/gemm_naive.cpp src/gemm_loop_order.cpp src/gemm_blocked.cpp src/gemm_microkernel.cpp src/microkernel_tiles.cpp src/microkernel_unrolled.cpp src/gemm_parallel.cpp src/microkernel_neon.cpp src/microkernel_driver.cpp)
find_package(Threads REQUIRED)
target_link_libraries(gemm PUBLIC Threads::Threads)
target_include_directories(gemm PUBLIC include)
target_compile_features(gemm PUBLIC cxx_std_17)
set_target_properties(gemm PROPERTIES CXX_EXTENSIONS OFF)

if(GEMM_ENABLE_NEON)
    include(CheckCXXSourceCompiles)
    check_cxx_source_compiles("
        #if !defined(__aarch64__)
        #error AArch64 is required
        #endif
        #include <arm_neon.h>
        int main() {
            float32x4_t x = vdupq_n_f32(1.0f);
            x = vfmaq_n_f32(x, x, 2.0f);
            return vgetq_lane_f32(x, 0) == 3.0f ? 0 : 1;
        }" GEMM_COMPILER_HAS_NEON)
endif()
if(GEMM_ENABLE_NEON AND GEMM_COMPILER_HAS_NEON)
    target_compile_definitions(gemm PRIVATE GEMM_HAS_NEON=1)
else()
    target_compile_definitions(gemm PRIVATE GEMM_HAS_NEON=0)
endif()


# BENCHMARK-IMPORTANT: Diagnostics are opt-in and do not enable fast-math or
# change the optimization level. They apply to the kernel library only.
if(GEMM_VECTORIZATION_REPORTS)
    if(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
        target_compile_options(gemm PRIVATE
            "-Rpass=(loop-vectorize|slp-vectorizer|loop-unroll)"
            "-Rpass-missed=(loop-vectorize|slp-vectorizer|loop-unroll)"
            "-Rpass-analysis=(loop-vectorize|slp-vectorizer|loop-unroll)")
    elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        target_compile_options(gemm PRIVATE -fopt-info-vec-all)
    else()
        message(FATAL_ERROR "Vectorization reports require GCC or Clang; disable GEMM_VECTORIZATION_REPORTS")
    endif()
endif()

if(GEMM_NATIVE_ARCH)
    include(CheckCXXCompilerFlag)
    if(CMAKE_SYSTEM_PROCESSOR MATCHES "^(arm64|aarch64|ARM64)$")
        set(GEMM_ARCH_FLAG "-mcpu=native")
    else()
        set(GEMM_ARCH_FLAG "-march=native")
    endif()
    check_cxx_compiler_flag("${GEMM_ARCH_FLAG}" GEMM_HAS_NATIVE_FLAG)
    if(NOT GEMM_HAS_NATIVE_FLAG)
        message(FATAL_ERROR "GEMM_NATIVE_ARCH is unsupported by this compiler; disable it")
    endif()
    target_compile_options(gemm PRIVATE "${GEMM_ARCH_FLAG}")
endif()

add_executable(gemm_benchmark benchmarks/benchmark_main.cpp)
target_link_libraries(gemm_benchmark PRIVATE gemm)

include(CTest)
if(BUILD_TESTING)
    add_executable(gemm_parallel_tests tests/test_parallel.cpp)
    target_link_libraries(gemm_parallel_tests PRIVATE gemm)
    add_test(NAME gemm_parallel_correctness COMMAND gemm_parallel_tests)
    add_executable(gemm_tests tests/test_gemm.cpp)
    target_link_libraries(gemm_tests PRIVATE gemm)
    add_test(NAME gemm_correctness COMMAND gemm_tests)
    add_executable(gemm_blocked_tests tests/test_blocked.cpp)
    target_link_libraries(gemm_blocked_tests PRIVATE gemm)
    add_test(NAME gemm_blocked_correctness COMMAND gemm_blocked_tests)
    add_executable(gemm_microkernel_tests tests/test_microkernel.cpp)
    target_link_libraries(gemm_microkernel_tests PRIVATE gemm)
    add_test(NAME gemm_microkernel_correctness COMMAND gemm_microkernel_tests)
endif()
