if (WIN32)
    set(vst2413_plugin_main ${VST3_SDK_ROOT}/public.sdk/source/main/dllmain.cpp)
elseif (APPLE)
    set(vst2413_plugin_main ${VST3_SDK_ROOT}/public.sdk/source/main/macmain.cpp)
else()
    set(vst2413_plugin_main ${VST3_SDK_ROOT}/public.sdk/source/main/linuxmain.cpp)
endif()

set(vst2413p_sources
    Vst2413P.cpp
    Vst2413P.h
    Vst2413PController.cpp
    Vst2413PController.h
    Vst2413PFactory.cpp
    Vst2413PIds.h
    resource/VST2413P.uidesc
    ${vst2413_plugin_main}
    ../source/SynthDriver.cpp
    ../source/SynthDriver.h
    ../source/emu2413/emu2413.c
    ../source/emu2413/emu2413.h)

smtg_add_vst3plugin(vst2413p PACKAGE_NAME "VST2413P" SOURCES_LIST ${vst2413p_sources})
target_link_libraries(vst2413p PRIVATE sdk vstgui_support)
target_include_directories(vst2413p PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/../source)
target_compile_features(vst2413p PRIVATE cxx_std_17)

smtg_target_add_plugin_resources(vst2413p
    RESOURCES
        resource/VST2413P.uidesc
        resource/THIRD_PARTY_NOTICES.txt)

set(vst2413r_sources
    Vst2413R.cpp
    Vst2413R.h
    Vst2413RController.cpp
    Vst2413RController.h
    Vst2413RFactory.cpp
    Vst2413RIds.h
    resource/VST2413R.uidesc
    ${vst2413_plugin_main}
    ../source/RhythmDriver.cpp
    ../source/RhythmDriver.h
    ../source/emu2413/emu2413.c
    ../source/emu2413/emu2413.h)

smtg_add_vst3plugin(vst2413r PACKAGE_NAME "VST2413R" SOURCES_LIST ${vst2413r_sources})
target_link_libraries(vst2413r PRIVATE sdk vstgui_support)
target_include_directories(vst2413r PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/../source)
target_compile_features(vst2413r PRIVATE cxx_std_17)
smtg_target_add_plugin_resources(vst2413r
    RESOURCES
        resource/VST2413R.uidesc
        resource/THIRD_PARTY_NOTICES.txt)

set(vst2413s_sources
    Vst2413S.cpp
    Vst2413S.h
    Vst2413SController.cpp
    Vst2413SController.h
    Vst2413SFactory.cpp
    Vst2413SIds.h
    resource/VST2413S.uidesc
    ${vst2413_plugin_main}
    ../source/SynthDriver.cpp
    ../source/SynthDriver.h
    ../source/emu2413/emu2413.c
    ../source/emu2413/emu2413.h)

smtg_add_vst3plugin(vst2413s PACKAGE_NAME "VST2413S" SOURCES_LIST ${vst2413s_sources})
target_link_libraries(vst2413s PRIVATE sdk vstgui_support)
target_include_directories(vst2413s PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/../source)
target_compile_features(vst2413s PRIVATE cxx_std_17)
smtg_target_add_plugin_resources(vst2413s
    RESOURCES
        resource/VST2413S.uidesc
        resource/THIRD_PARTY_NOTICES.txt)
