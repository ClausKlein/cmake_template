include(cmake/CPM.cmake)

cpmusepackagelock(package-lock.cmake)

# Done as a function so that updates to variables like
# CMAKE_CXX_FLAGS don't propagate out to other
# targets
function(myproject_setup_dependencies)

  # For each dependency, see if it's
  # already been provided to us by a parent project
  # NOTE: The order is also important! CK
  # i.e.: spdlog may use catch2 and fmtlib too

  # NOTE: needed in test/CMakelinst.txt: include(${Catch2_SOURCE_DIR}/extras/Catch.cmake)
  cpmaddpackage("gh:catchorg/Catch2@3.4.0")

  if(NOT TARGET fmtlib::fmtlib)
    # A git package with both version and tag provided
    cpmaddpackage("gh:fmtlib/fmt@9.1.0#9.1.0")
    # FIXME(CK): this does not work! No idea why?
    # cpmfindpackage("gh:fmtlib/fmt@9.1.0#9.1.0")
  endif()

  if(NOT TARGET spdlog::spdlog)
    # NOTE: you may find an installed version compiled with differrent options!
    # TODO(CK) this does not work! cpmfindpackage(
    cpmaddpackage(
      NAME
      spdlog
      VERSION
      1.12.0
      GITHUB_REPOSITORY
      "gabime/spdlog"
      OPTIONS
      "SPDLOG_FMT_EXTERNAL ON")
  endif()

  if(NOT TARGET CLI11::CLI11)
    cpmaddpackage("gh:CLIUtils/CLI11@2.3.2")
  endif()

  if(NOT TARGET ftxui::screen)
    # A git package with both version and tag provided
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
      "FTXUI_BUILD_EXAMPLES OFF;FTXUI_BUILD_DOCS OFF")
  endif()

  if(NOT TARGET tools::tools)
    cpmaddpackage("gh:lefticus/tools#update_build_system")
  endif()

endfunction()
