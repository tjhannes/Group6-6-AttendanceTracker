package com.group66.attendancetracker;

public abstract class RestTaskCallback{
    /**
     * Called when the HTTP request completes.
     *
     * @param result The result of the HTTP request.
     */
    public abstract void onTaskComplete(String result);
}