package com.group66.attendancetracker;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.Bitmap.Config;
import android.os.Build;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.Display;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.WindowManager;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.Spinner;
import android.widget.TextView;
import com.google.android.gms.auth.api.signin.GoogleSignIn;
import com.google.android.gms.auth.api.signin.GoogleSignInAccount;
import com.google.android.gms.auth.api.signin.GoogleSignInClient;
import com.google.android.gms.auth.api.signin.GoogleSignInOptions;
import com.google.android.gms.auth.api.signin.GoogleSignInOptions.Builder;
import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;

import org.w3c.dom.Text;

public class MainActivity
        extends AppCompatActivity
{
    public MainActivity() {}

    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Toolbar toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        Spinner weekSpinner = findViewById(R.id.weekSpinner);
        String[] arraySpinner = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13" };

        ArrayAdapter<String> adapter = new ArrayAdapter(this, R.layout.support_simple_spinner_dropdown_item, arraySpinner);
        weekSpinner.setAdapter(adapter);

        Button qrButton = findViewById(R.id.qrButton);
        qrButton.setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View v)
            {
                GoogleSignInAccount account = GoogleSignIn.getLastSignedInAccount(MainActivity.this);
                String email = account.getEmail();
                Spinner spinner = findViewById(R.id.weekSpinner);
                String weekId = spinner.getSelectedItemPosition()+"";
                String restUrl = "http://attendancetracker-group66.appspot.com/attendance/student?email=" + email+"&weekNumber="+weekId;
                Log.d("REST URL",restUrl);

                new GetTask(restUrl, new RestTaskCallback()
                {
                    @Override
                    public void onTaskComplete(String result)
                    {
                        if(result.length() < 30)
                        {
                            TextView errorText = findViewById(R.id.errorText);
                            errorText.setText("Please register from the webpage first");
                        }
                        else
                        {
                            Log.d("REST URL","Time for bitmap:"+result);

                            try
                            {
                                Bitmap qrBitmap = encodeAsBitmap(result);
                                ImageView qrView = findViewById(R.id.qrView);
                                qrView.setImageBitmap(qrBitmap);
                            }
                            catch(Exception e)
                            {

                            }
                        }
                    }
                }).execute();
            }
        });


    }

    public boolean onCreateOptionsMenu(Menu menu)
    {
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    public boolean onOptionsItemSelected(MenuItem item)
    {
        int id = item.getItemId();

        if (id == R.id.action_showattendances)
        {
            GoogleSignInAccount account = GoogleSignIn.getLastSignedInAccount(this);
            String email = account.getEmail();
            String restUrl = "http://attendancetracker-group66.appspot.com/attendance/student?email=" + email;

            new GetTask(restUrl, new RestTaskCallback()
            {
                @Override
                public void onTaskComplete(String result)
                {
                    final ArrayAdapter<String> arrayAdapter = new ArrayAdapter<String>(MainActivity.this, android.R.layout.simple_list_item_1);

                    String resultArr[] = result.split("#");
                    for(String s:resultArr)
                    {
                        arrayAdapter.add(s+"\n");
                    }

                    AlertDialog.Builder builder1 = new AlertDialog.Builder(MainActivity.this);
                    builder1.setAdapter(arrayAdapter,null);
                    builder1.setTitle("Taken Attendances");
                    builder1.setCancelable(true);

                    builder1.setPositiveButton(
                            "Close",
                            new DialogInterface.OnClickListener() {
                                public void onClick(DialogInterface dialog, int id) {
                                    dialog.cancel();
                                }
                            });
                    AlertDialog alert11 = builder1.create();
                    alert11.show();
                }
            }).execute();

            return true;
        }
        else if (id == R.id.action_logout)
        {
            GoogleSignInOptions gso = new GoogleSignInOptions.Builder(GoogleSignInOptions.DEFAULT_SIGN_IN).requestEmail().build();
            GoogleSignInClient mGoogleSignInClient = GoogleSignIn.getClient(this, gso);
            mGoogleSignInClient.signOut()
                    .addOnCompleteListener(this, new OnCompleteListener<Void>() {
                        @Override
                        public void onComplete(@NonNull Task<Void> task) {
                            Intent myIntent = new Intent(MainActivity.this, LoginActivity.class);
                            startActivity(myIntent);
                        }
                    });
            return true;
        }

        return super.onOptionsItemSelected(item);
    }

    public void onStart()
    {
        super.onStart();
        GoogleSignInAccount account = GoogleSignIn.getLastSignedInAccount(this);

        if (account != null)
        {
            TextView textView = findViewById(R.id.helloText);
            textView.setText("Hello " + account.getDisplayName() + "!");
        }
    }

    Bitmap encodeAsBitmap(String str) throws WriterException
    {
        DisplayMetrics displayMetrics = new DisplayMetrics();
        getWindowManager().getDefaultDisplay().getMetrics(displayMetrics);
        int width = displayMetrics.widthPixels;
        int imgWidth = width * 8 / 10;
        BitMatrix result;
        try
        {
            result = new MultiFormatWriter().encode(str, BarcodeFormat.QR_CODE, imgWidth, imgWidth, null);
        }
        catch (IllegalArgumentException iae) {

            return null; }
        int w = result.getWidth();
        int h = result.getHeight();
        int[] pixels = new int[w * h];
        for (int y = 0; y < h; y++) {
            int offset = y * w;
            for (int x = 0; x < w; x++) {
                pixels[(offset + x)] = (result.get(x, y) ? -16777216 : -1);
            }
        }
        Bitmap bitmap = Bitmap.createBitmap(w, h, Bitmap.Config.ARGB_8888);
        bitmap.setPixels(pixels, 0, imgWidth, 0, 0, w, h);
        return bitmap;
    }
}