cmake_minimum_required(VERSION 3.16)
project(plasma-todo-widget)

# Find ECM
find_package(ECM REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH})

include(KDEInstallDirs)
include(KDECMakeSettings)

# Only find what we actually need
find_package(KF6 REQUIRED COMPONENTS Package)

# Manual installation - no Qt6 needed for QML-only widgets
install(DIRECTORY package/ DESTINATION ${KDE_INSTALL_DATADIR}/plasma/plasmoids/org.kde.plasma.todowidget)
