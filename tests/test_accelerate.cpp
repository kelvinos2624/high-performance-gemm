#include "accelerate_adapter.hpp"
#include "gemm/gemm.hpp"
#include "gemm/matrix.hpp"
#include <algorithm>
#include <cmath>
#include <iostream>
#include <limits>
#include <stdexcept>
#include <vector>

void require(bool ok) { if (!ok) throw std::runtime_error("Accelerate contract failed"); }
int main() {
    try {
        if (!benchmark_support::accelerate_available()) {
            float c = 19;
            bool rejected = false;
            try { benchmark_support::accelerate(nullptr,nullptr,&c,1,1,0); }
            catch (const std::runtime_error&) { rejected = true; }
            require(rejected && c == 19);
            return 0;
        }
        for (auto shape : {gemm::BlockSize{1,1,1},{2,3,4},{7,9,11},{65,63,67},
                           {1,33,17},{33,1,17},{9,7,0},{0,3,4},{3,0,4}}) {
            const auto M=shape.m, N=shape.n, K=shape.k;
            gemm::Matrix A(M,K), B(K,N), ref(M,N);
            gemm::fill_random(A,42); gemm::fill_random(B,43);
            const auto saved_A=A, saved_B=B;
            gemm::reference(A.data(),B.data(),ref.data(),M,N,K);
            std::vector<float> C(M*N+2,12345);
            for (int repeat=0; repeat<2; ++repeat) {
                std::fill(C.begin()+1,C.end()-1,std::numeric_limits<float>::quiet_NaN());
                benchmark_support::accelerate(K ? A.data() : nullptr,K ? B.data() : nullptr,C.data()+1,M,N,K);
                require(C.front()==12345 && C.back()==12345);
                for(std::size_t i=0;i<M*N;++i)
                    require(std::isfinite(C[i+1]) && std::abs(C[i+1]-ref.data()[i])<=1e-4f+1e-4f*std::abs(ref.data()[i]));
            }
            for(std::size_t i=0;i<M*K;++i) require(A.data()[i]==saved_A.data()[i]);
            for(std::size_t i=0;i<K*N;++i) require(B.data()[i]==saved_B.data()[i]);
        }
        benchmark_support::accelerate(nullptr,nullptr,nullptr,0,7,3);
        float c=19;
        bool rejected=false;
        try { benchmark_support::accelerate(nullptr,nullptr,&c,static_cast<std::size_t>(std::numeric_limits<int>::max())+1,1,1); }
        catch(const std::invalid_argument&) { rejected=true; }
        require(rejected && c==19);
        std::cout << "Accelerate contract passed\n";
    } catch(const std::exception& e) { std::cerr << e.what() << '\n'; return 1; }
}
