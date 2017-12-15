package com.group66.attendancetracker;

import android.os.AsyncTask;
import android.widget.TextView;
import org.restlet.representation.Representation;
import org.restlet.resource.ClientResource;

public class PostTask
        extends AsyncTask<String, String, String>
{
    private String mRestUrl;
    private String mRequestBody;
    TextView textView;

    public PostTask(String restUrl, String requestBody, TextView tView)
    {
        mRestUrl = restUrl;
        mRequestBody = requestBody;
        textView = tView;
    }

    protected String doInBackground(String... arg0)
    {
        String response = null;
        ClientResource cr = new ClientResource("http://jovial-acronym-186111.appspot.com/attendance/list");

        try
        {
            Representation rep = cr.post("naber");
            response = rep.getText();
        }
        catch (Exception localException) {}



        return response;
    }

    protected void onPostExecute(String result)
    {
        textView.setText(result);
    }
}