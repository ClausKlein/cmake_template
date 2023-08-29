include(cmake/CPM.cmake)

# Done as a function so that updates to variables like
# CMAKE_CXX_FLAGS don't propagate out to other
# targets
function(myproject_setup_dependencies)

  # For each dependency, see if it's
  # already been provided to us by a parent project

  if(NOT TARGET fmtlib::fmtlib)
    cpmaddpackage("gh:fmtlib/fmt#9.1.0")
    # TODO(CK) this does not work?
    # cpmfindpackage(
    #   NAME
    #   fmtlib
    #   GIT_TAG
    #   9.1.0
    #   VERSION
    #   9.1.0
    #   GITHUB_REPOSITORY
    #   "fmtlib/fmt")
  endif()

  cpmfindpackage(
    NAME
    spdlog
    VERSION
    1.12.0
    GITHUB_REPOSITORY
    "gabime/spdlog"
    OPTIONS
    "SPDLOG_FMT_EXTERNAL ON")

  if(NOT TARGET Catch2::Catch2WithMain)
    cpmaddpackage("gh:catchorg/Catch2@3.4.0")
  endif()

  if(NOT TARGET CLI11::CLI11)
    cpmaddpackage("gh:CLIUtils/CLI11@2.3.2")
  endif()

  cpmfindpackage(
    NAME
    FTXUI
    VERSION
    5.0.0
    GIT_TAG
    dd6a5d371fd7a3e2937bb579955003c54b727233
    GITHUB_REPOSITORY
    "ArthurSonzogni/FTXUI"
    OPTIONS
    "FTXUI_BUILD_EXAMPLES OFF; FTXUI_BUILD_DOCS OFF")

  if(NOT TARGET tools::tools)
    cpmaddpackage("gh:lefticus/tools#update_build_system")
  endif()

endfunction()
