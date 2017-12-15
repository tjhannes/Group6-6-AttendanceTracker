package com.group66.attendancetracker;

import android.os.AsyncTask;
import org.restlet.representation.Representation;
import org.restlet.resource.ClientResource;

public class GetTask
        extends AsyncTask<String, String, String>
{
    private RestTaskCallback mCallback;
    private String mRestUrl;

    public GetTask(String restUrl, RestTaskCallback callback)
    {
        mCallback = callback;
        mRestUrl = restUrl;
    }

    protected String doInBackground(String... args)
    {
        String response = null;
        ClientResource cr = new ClientResource(mRestUrl);

        try
        {
            response = cr.get().getText();
        }
        catch (Exception localException) {}

        return response;
    }

    protected void onPostExecute(String result)
    {
        mCallback.onTaskComplete(result);
        super.onPostExecute(result);
    }
}