QT += core gui \
      widgets \
      network

haiku|macx {
  TARGET = FeatherPad
}
else {
  TARGET = featherpad
}

TEMPLATE = app
CONFIG += c++11

SOURCES += main.cpp \
           singleton.cpp \
           fpwin.cpp \
           encoding.cpp \
           tabwidget.cpp \
           lineedit.cpp \
           textedit.cpp \
           tabbar.cpp \
           find.cpp \
           replace.cpp \
           pref.cpp \
           config.cpp \
           vscrollbar.cpp \
           loading.cpp \
           tabpage.cpp \
           searchbar.cpp \
           session.cpp \
           fontDialog.cpp

HEADERS += singleton.h \
           fpwin.h \
           encoding.h \
           tabwidget.h \
           lineedit.h \
           textedit.h \
           tabbar.h \
           vscrollbar.h \
           filedialog.h \
           config.h \
           pref.h \
           loading.h \
           messagebox.h \
           tabpage.h \
           searchbar.h \
           session.h \
           fontDialog.h \
           warningbar.h

FORMS += fp.ui \
         prefDialog.ui \
         sessionDialog.ui \
         fontDialog.ui

contains(WITHOUT_X11, YES) {
  message("Compiling without X11...")
}
else:unix:!macx:!haiku {
  QT += x11extras
  SOURCES += x11.cpp
  HEADERS += x11.h
  LIBS += -lX11
  DEFINES += HAS_X11
}

unix:!haiku:!macx {
  #VARIABLES
  isEmpty(PREFIX) {
    PREFIX = /usr/local
  }
  BINDIR = $$PREFIX/bin

  #MAKE INSTALL

  target.path =$$BINDIR

  # add the fpad symlink
  slink.path = $$BINDIR
  slink.extra += ln -sf $${TARGET} fpad && cp -P fpad $(INSTALL_ROOT)$$BINDIR

  INSTALLS += target slink
}
else:haiku {
  isEmpty(PREFIX) {
    PREFIX = /boot/home/config/non-packaged/apps/FeatherPad
  }
  BINDIR = $$PREFIX

  target.path =$$BINDIR

  INSTALLS += target
}
else:macx{
  #VARIABLES
  isEmpty(PREFIX) {
    PREFIX = /Applications
  }
  BINDIR = $$PREFIX

  #MAKE INSTALL

  target.path =$$BINDIR

  INSTALLS += target
}
