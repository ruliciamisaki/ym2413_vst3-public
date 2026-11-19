# Installs the complete VST 3 SDK source tree so that consumers can use
# add_subdirectory() and the SDK's smtg_add_vst3plugin() helpers.
# Nothing is compiled here; the SDK is built as part of the consuming project.
set(VCPKG_BUILD_TYPE release)
set(VCPKG_POLICY_EMPTY_PACKAGE enabled)
set(VCPKG_POLICY_SKIP_ABSOLUTE_PATHS_CHECK enabled)

vcpkg_from_github(OUT_SOURCE_PATH SOURCE_PATH
    REPO steinbergmedia/vst3sdk REF ${VERSION}
    SHA512 f55c03aca2fb994e48e6e8ff0de5d58e512a0a67556cf6bd86c0f9ae429732fca3408e41692b9302a88f7db5be11d3864558762868d47e2def0175b87b9e0937
    HEAD_REF master)

function(smtg_submodule dir repo ref sha512)
    vcpkg_from_github(OUT_SOURCE_PATH SUB_PATH REPO ${repo} REF ${ref} SHA512 ${sha512} HEAD_REF master)
    file(REMOVE_RECURSE "${SOURCE_PATH}/${dir}")
    file(RENAME "${SUB_PATH}" "${SOURCE_PATH}/${dir}")
endfunction()

smtg_submodule(base           steinbergmedia/vst3_base           ${VERSION}
    12de902576171233e382e0544cdfc8a651d6f640038569eb760ae1d3fe0fd43360952d1dcac209dd4224a9d6a669ce2ff41f9ba5279c35b8cf9622acd74d0857)
smtg_submodule(cmake          steinbergmedia/vst3_cmake          ${VERSION}
    1e81e4a191220bd2750148338cdeedc119e8c20a221b56613ffa4d2491a1a27bd400fb6d0bb2a265ce3d280a1bf85dd18c56a5abacfebc7c268db70112edf8a3)
smtg_submodule(pluginterfaces steinbergmedia/vst3_pluginterfaces ${VERSION}
    fd2218c3e949133dd51b4834c6680131a520587c4449fa50f9b86cb3de3c3091e34ff15e21ba0e995f078b43890e7aa239a1beeb753eba1ce6822f9b44875b3c)
smtg_submodule(public.sdk     steinbergmedia/vst3_public_sdk     ${VERSION}
    d902a7b3f0d925e95d343df2378f4b701309d6460c970dfa064f0c2f24b0b4ca700ea15b3a4b63b3fc5f38cc5d6b2d55e5a3946fd10dd45960a86f948c868552)
# vstgui4 submodule commit pinned by vst3sdk v3.8.1_build_84
smtg_submodule(vstgui4        steinbergmedia/vstgui              5db272256172557818b6158cf0bb2c4410bddb25
    8ae311bd962a8a52a19ab6672e2c8066780a7818f4223b93ebf5d29ed6165366ba551dc2d3e3d1abd8071a2b7ffb90bb5267de51a66e1b1d16e8687f853b0e18)

file(COPY "${SOURCE_PATH}/" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}/sdk")
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")
