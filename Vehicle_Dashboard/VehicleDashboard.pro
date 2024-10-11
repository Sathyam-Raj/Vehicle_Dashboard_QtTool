QT += quick
QT += location
QT += multimedia

SOURCES += \
    main.cpp

# Add resources to include the main.qml file
RESOURCES += resources.qrc \
    resources.qrc

RESOURCES += qml.qrc

# Resource definition for including main.qml
resources.files = main.qml
resources.prefix = /

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
