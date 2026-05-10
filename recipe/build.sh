mkdir build
cd build

if [[ "${target_platform}" == "linux-ppc64le" ]]; then
  build_tests=OFF
else
  build_tests=ON
fi

cmake ${CMAKE_ARGS} .. \
      -G "Ninja" \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_PREFIX_PATH=$PREFIX -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_INSTALL_LIBDIR=lib \
      -DCMAKE_INSTALL_SYSTEM_RUNTIME_LIBS_SKIP=ON \
      -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
      -DFOONATHAN_MEMORY_BUILD_EXAMPLES=OFF \
      -DFOONATHAN_MEMORY_BUILD_TESTS=${build_tests} \
      -DFOONATHAN_MEMORY_BUILD_TOOLS=ON \
      -DBUILD_SHARED_LIBS=ON

cmake --build . --config Release -- -j$CPU_COUNT

if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" && "${build_tests}" == "ON" ]]; then
  ctest --test-dir . --output-on-failure
fi

cmake --build . --config Release --target install
