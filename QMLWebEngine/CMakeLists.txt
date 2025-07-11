set(TARGET_NAME QMLWebEngine)

find_package(Qt6 REQUIRED COMPONENTS Quick  Quick3D Core5Compat OpenGL  Graphs Svg WebSockets) 

qt_standard_project_setup()
qt_add_executable(${TARGET_NAME}  main.cpp)
qt_add_qml_module(${TARGET_NAME} 
								URI qrc
								VERSION 1.0
								QML_FILES MainView.qml BlankView.qml
								)
qt_import_qml_plugins(${TARGET_NAME} )

target_link_libraries(${TARGET_NAME} PRIVATE Qt6::Quick Qt6::Quick3D Qt6::Core5Compat Qt6::OpenGL Qt6::Graphs Qt6::Svg Qt6::WebSockets)

install(TARGETS ${TARGET_NAME}
    BUNDLE  DESTINATION .
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

qt_generate_deploy_qml_app_script(
    TARGET ${TARGET_NAME}
    OUTPUT_SCRIPT deploy_script
    MACOS_BUNDLE_POST_BUILD
    NO_UNSUPPORTED_PLATFORM_ERROR
    DEPLOY_USER_QML_MODULES_ON_UNSUPPORTED_PLATFORM
)
install(SCRIPT ${deploy_script})