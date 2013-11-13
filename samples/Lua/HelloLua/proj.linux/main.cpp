#include "../Classes/AppDelegate.h"
#include "cocos2d.h"
<<<<<<< HEAD
=======
#include "CCEGLView.h"
>>>>>>> origin/dsfd

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <string>

USING_NS_CC;

int main(int argc, char **argv)
{
    // create the application instance
    AppDelegate app;
    CCEGLView* eglView = CCEGLView::sharedOpenGLView();
<<<<<<< HEAD
    eglView->setFrameSize(960, 640);
=======
    eglView->setFrameSize(800, 480);
>>>>>>> origin/dsfd
    return CCApplication::sharedApplication()->run();
}
