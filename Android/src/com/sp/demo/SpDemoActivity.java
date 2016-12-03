package com.sp.demo;

import sp.SpActivity;
import android.app.Activity;
import android.content.Context;
import android.os.Bundle;

public class SpDemoActivity extends SpActivity
{
    Context context;

    //--------------------------------------------------------------------------
    @Override
    public void onCreate(Bundle savedInstanceState) {
        context = this.getApplicationContext();
        super.onCreate(savedInstanceState);
    }

    //--------------------------------------------------------------------------
    @Override
    public void onDestroy() {
        super.onDestroy();
    }

    //--------------------------------------------------------------------------
    @Override
    public void onStop() {
        super.onStop();
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
    }

    //--------------------------------------------------------------------------
    // TODO Костыль для версий ниже 5. Разобраться почему JNI мозг колупает.
    public static native void keyboardVisibleChanged(boolean visible, int height);

    public static native void logInfo(String text);
    public static native void logError(String text);
}

