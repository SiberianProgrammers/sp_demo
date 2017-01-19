package com.sp.demo;

import sp.SpActivity;
import android.app.Activity;
import android.content.Context;
import android.os.Bundle;
import java.lang.System;

public class SpProjectPrototypeActivity extends SpActivity
{
     public boolean finishRenderingQML = false;
    Context context;

    //--------------------------------------------------------------------------
    @Override
    public void onCreate(Bundle savedInstanceState) {
        context = this.getApplicationContext();
        super.onCreate(savedInstanceState);
        logInfo("onCreate Activity ");
    }

    //--------------------------------------------------------------------------
    @Override
    public void onDestroy() {
        super.onDestroy();
        logInfo("onDestroy Activity ");
    }

    //--------------------------------------------------------------------------
    @Override
    public void onStop() {
        super.onStop();
        logInfo("onStop Activity ");
    }

    //--------------------------------------------------------------------------
    @Override
    public void onStart() {
        super.onStart();
    }

    //--------------------------------------------------------------------------
    @Override
    protected void onResume() {
        super.onResume();
    }

    //--------------------------------------------------------------------------
    @Override
    protected void onPause() {
        super.onPause();

        logInfo("onPause Activity finishRenderingQML = " + this.finishRenderingQML);
        if (!this.finishRenderingQML) {
            logInfo("завершаем приложение в onPause");
            System.exit(0);
        }
    }

    public void finishSplash() {
        this.finishRenderingQML = true;
        SplashActivity.splashScreen.finish();
    }

    public static native void logInfo(String text);
    public static native void logError(String text);
}

