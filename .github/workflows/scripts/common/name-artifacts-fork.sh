#!/bin/bash

# Artifact Naming Scheme:
# PCSX2-<OS>-<GUI>-[ARCH]-[SIMD]-[pr\[PR_NUM\]]-[title|sha\[SHA|PR_TITLE\]
# -- limited to 200 chars
# Outputs:
# - artifact-name

# Inputs as env-vars
# OS
# BUILD_SYSTEM
# GUI_FRAMEWORK
# ARCH
# SIMD
# EVENT_NAME
# PR_TITLE
# PR_NUM
# PR_SHA

NAME=""

if [ "${OS}" == "macos" ]; then
  NAME="PCSX2-${OS}-${GUI_FRAMEWORK}"
elif [[ ("${OS}" == "windows" && "$BUILD_SYSTEM" != "cmake") || ("$OS" == "linux" && "$GUI_FRAMEWORK" == "QT") ]]; then
  NAME="PCSX2-${OS}-${GUI_FRAMEWORK}-${ARCH}-${SIMD}"
else
  NAME="PCSX2-${OS}-${GUI_FRAMEWORK}-${ARCH}"
fi

# Add cmake if used to differentate it from msbuild builds
# Else the two artifacts will have the same name and the files will be merged
if [[ ! -z "${BUILD_SYSTEM}" ]]; then
  if [ "${BUILD_SYSTEM}" == "cmake" ]; then
    NAME="${NAME}-${BUILD_SYSTEM}"
  fi
fi

# Trim the Name
echo "${NAME}"
echo "##[set-output name=artifact-name;]${NAME}"
