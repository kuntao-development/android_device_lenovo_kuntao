package com.lenovo.parts;

import android.os.Bundle;

import com.android.settingslib.collapsingtoolbar.CollapsingToolbarBaseActivity;
import com.android.settingslib.collapsingtoolbar.R;

public class DeviceSettingsActivity extends CollapsingToolbarBaseActivity {

    private static final String TAG_DEVICEPARTS = "deviceparts";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        getFragmentManager().beginTransaction().replace(R.id.content_frame,
                new DeviceSettings(), TAG_DEVICEPARTS).commit();
    }
}
