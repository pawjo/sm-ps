package com.smps.zad6;

import androidx.fragment.app.Fragment;

public class MainActivity extends SingleFragmentActivity {

    private int arraySize = 10;
    private Task[] tasks = new Task[arraySize];


    @Override
    protected Fragment createFragment() {
        return new TaskFragment();
    }
}