cmake_minimum_required(VERSION 3.25)

# Use vcpkg (manifest mode) automatically when VCPKG_ROOT is set and no
# toolchain was given explicitly.
if (NOT DEFINED CMAKE_TOOLCHAIN_FILE AND DEFINED ENV{VCPKG_ROOT})
    set(CMAKE_TOOLCHAIN_FILE "$ENV{VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake" CACHE FILEPATH "")
endif()

project(vst2413_vst3 VERSION 1.0.0 LANGUAGES C CXX)
if (APPLE)
    # VSTGUI's macOS backend contains Objective-C++ sources.
    enable_language(OBJC OBJCXX)
endif()

# The VST 3 SDK (MIT licensed) is provided by the overlay port
# ports/vst3sdk-source, which installs the full source tree including VSTGUI.
# VST3_SDK_ROOT can still be overridden to point at a local checkout.
set(_vst3_sdk_default "")
if (DEFINED VCPKG_INSTALLED_DIR AND DEFINED VCPKG_TARGET_TRIPLET)
    set(_vst3_sdk_default "${VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/share/vst3sdk-source/sdk")
endif()
set(VST3_SDK_ROOT "${_vst3_sdk_default}" CACHE PATH "Path to the Steinberg VST 3 SDK source tree")
if (NOT EXISTS "${VST3_SDK_ROOT}/CMakeLists.txt")
    message(FATAL_ERROR
        "VST 3 SDK was not found at '${VST3_SDK_ROOT}'. Configure with the vcpkg toolchain "
        "(set VCPKG_ROOT or pass -DCMAKE_TOOLCHAIN_FILE=<vcpkg>/scripts/buildsystems/vcpkg.cmake). See docs/BUILD.md.")
endif()

# Keep SDK examples out of the product build.
set(SMTG_ENABLE_VST3_PLUGIN_EXAMPLES OFF CACHE BOOL "" FORCE)
set(SMTG_ENABLE_VST3_HOSTING_EXAMPLES OFF CACHE BOOL "" FORCE)
set(SMTG_ENABLE_VSTGUI_SUPPORT ON CACHE BOOL "" FORCE)
set(SMTG_CREATE_PLUGIN_LINK OFF CACHE BOOL "" FORCE)
add_subdirectory("${VST3_SDK_ROOT}" "${CMAKE_BINARY_DIR}/vst3sdk")
add_subdirectory(vst3)
