{ lib, buildRosPackage, SDL, binutils, camera-info-manager, catkin, daemontools, git, gtk2, image-transport, libxml2, message-generation, message-runtime, nav-msgs, roscpp, roslint, sensor-msgs, std-srvs, tf, udev, wirelesstools, which, ffmpeg, fetchFromGitHub, ardronelib }:
let
  ardrone-autonomy = buildRosPackage {
    pname = "ros-noetic-ardrone-autonomy";
    version = "1.4.1";

    # src = fetchFromGitHub {
    #   owner = "AutonomyLab";
    #   repo = "ardrone_autonomy";
    #   rev = "d35607beb211f56d8ce4aafa45115a1be34c97c2";
    #   sha256 = "sha256-W7OPE32YXjA4Z1qlescPFW3EQzl0eTnQ7wCYxpp2XwQ=";
    # };
    src = ./.;

    buildType = "catkin";
    buildInputs = [ SDL binutils catkin daemontools git gtk2 libxml2 message-generation roslint udev wirelesstools ffmpeg ];
    propagatedBuildInputs = [ camera-info-manager image-transport message-runtime nav-msgs roscpp sensor-msgs std-srvs tf ];
    nativeBuildInputs = [ catkin which ];

    meta = {
      description = "ardrone_autonomy is a ROS driver for Parrot AR-Drone 1.0 and 2.0 quadrocopters. This driver is based on official AR-Drone SDK version 2.0.1.";
      license = with lib.licenses; [ bsdOriginal ];
    };
  };
in
ardrone-autonomy.overrideAttrs (final: prev: {
  cmakeFlags = (prev.cmakeFlags or []) ++ [
    "-DARDRONELIB_INCLUDE_DIR=${ardronelib}/include"
    "-DARDRONELIB_LIBRARY_DIR=${ardronelib}/lib"
  ];
  makeFlags = (prev.makeFlags or []) ++ [ "VERBOSE=1" ];
  # enableParallelBuilding = false;
})
  # lib.patchExternalProjectGit ardrone-autonomy (
  # {
  #   url = localArdronelib;
  #   rev = "local";
  #   originalUrl = "git://github.com/AutonomyLab/ardronelib.git";
  #   originalRev = "2f987029c55531e4c0119c3600f9c57f935851ed";
  #   fetchgitArgs = {};
  # })
  # if localArdronelib != null then {
  #   url = localArdronelib;
  #   rev = "local";
  #   originalUrl = "git://github.com/AutonomyLab/ardronelib.git";
  #   originalRev = "2f987029c55531e4c0119c3600f9c57f935851ed";
  #   fetchgitArgs = {};
  # } else {
  #   url = "https://github.com/SCOTT-HAMILTON/ardronelib.git";
  #   rev = "e0a6156c4e8fe40f12cd31869ae6c4015a784427";
  #   originalUrl = "git://github.com/AutonomyLab/ardronelib.git";
  #   originalRev = "2f987029c55531e4c0119c3600f9c57f935851ed";
  #   fetchgitArgs.hash = "sha256-Z2xyRRoKt9bJ9Tk6aGv8+AhpFNS0U6TX7UIRZ2R9LHM=";
  # }
# )
# lib.patchExternalProjectGit ardrone-autonomy {
#   url = "https://github.com/SCOTT-HAMILTON/ardronelib.git";
#   originalUrl = "git://github.com/AutonomyLab/ardronelib.git";
#   originalRev = "2f987029c55531e4c0119c3600f9c57f935851ed";
#   rev = "e0a6156c4e8fe40f12cd31869ae6c4015a784427";
#   fetchgitArgs.hash = "sha256-Z2xyRRoKt9bJ9Tk6aGv8+AhpFNS0U6TX7UIRZ2R9LHM=";
# }
