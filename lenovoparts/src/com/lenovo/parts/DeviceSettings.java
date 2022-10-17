package com.lenovo.parts;

import android.app.Activity;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.content.Context;
import android.os.Bundle;
import androidx.preference.Preference;
import androidx.preference.PreferenceCategory;
import androidx.preference.PreferenceFragment;

import com.lenovo.parts.kcal.KCalSettingsActivity;
import com.lenovo.parts.preferences.SecureSettingListPreference;
import com.lenovo.parts.preferences.SecureSettingSwitchPreference;
import com.lenovo.parts.preferences.VibrationSeekBarPreference;
import com.lenovo.parts.preferences.CustomSeekBarPreference;

import com.lenovo.parts.R;

public class DeviceSettings extends PreferenceFragment implements
        Preference.OnPreferenceChangeListener {

    private static final String TAG = "LenovoParts";

    private static final String CATEGORY_DISPLAY = "display";
    private static final String PREF_DEVICE_KCAL = "device_kcal";

    public static final String PREF_VIBRATION_STRENGTH = "vibration_strength";
    public static final String VIBRATION_STRENGTH_PATH = "/sys/devices/virtual/timed_output/vibrator/vtg_level";

    // value of vtg_min and vtg_max
    public static final int MIN_VIBRATION = 116;
    public static final int MAX_VIBRATION = 3596;

    public static final  String PREF_HEADPHONE_GAIN = "headphone_gain";
    public static final  String HEADPHONE_GAIN_PATH = "/sys/kernel/sound_control/headphone_gain";

    public static final String USB_FASTCHARGE_KEY = "fastcharge";
    public static final String USB_FASTCHARGE_PATH = "/sys/kernel/fast_charge/force_fast_charge";

    public static final String PREF_GLOVE_MODE = "glove_mode";
    public static final String GLOVE_MODE_PATH = "/sys/board_properties/tpd_glove_status";

    @Override
    public void onCreatePreferences(Bundle savedInstanceState, String rootKey) {
        setPreferencesFromResource(R.xml.lenovo_main, rootKey);

        VibrationSeekBarPreference vibrationStrength = (VibrationSeekBarPreference) findPreference(PREF_VIBRATION_STRENGTH);
        vibrationStrength.setEnabled(FileUtils.fileWritable(VIBRATION_STRENGTH_PATH));
        vibrationStrength.setOnPreferenceChangeListener(this);

        CustomSeekBarPreference headphone_gain = (CustomSeekBarPreference) findPreference(PREF_HEADPHONE_GAIN);
        headphone_gain.setEnabled(FileUtils.fileWritable(HEADPHONE_GAIN_PATH));
        headphone_gain.setOnPreferenceChangeListener(this);

        PreferenceCategory displayCategory = (PreferenceCategory) findPreference(CATEGORY_DISPLAY);

        SecureSettingSwitchPreference glovemode = (SecureSettingSwitchPreference) findPreference(PREF_GLOVE_MODE);
        glovemode.setEnabled(FileUtils.fileWritable(GLOVE_MODE_PATH));
        glovemode.setChecked(FileUtils.getFileValueAsBoolean(GLOVE_MODE_PATH, true));
        glovemode.setOnPreferenceChangeListener(this);

        SecureSettingSwitchPreference usbfastcharge = (SecureSettingSwitchPreference) findPreference(USB_FASTCHARGE_KEY);
        usbfastcharge.setEnabled(FileUtils.fileWritable(USB_FASTCHARGE_PATH));
        usbfastcharge.setChecked(FileUtils.getFileValueAsBoolean(USB_FASTCHARGE_PATH, true));
        usbfastcharge.setOnPreferenceChangeListener(this);

        Preference kcal = findPreference(PREF_DEVICE_KCAL);
        kcal.setOnPreferenceClickListener(preference -> {
            Intent intent = new Intent(getActivity().getApplicationContext(), KCalSettingsActivity.class);
            startActivity(intent);
            return true;
        });
    }

    @Override
    public boolean onPreferenceChange(Preference preference, Object value) {
        final String key = preference.getKey();
        switch (key) {
            case PREF_VIBRATION_STRENGTH:
                double vibrationValue = (int) value / 100.0 * (MAX_VIBRATION - MIN_VIBRATION) + MIN_VIBRATION;
                FileUtils.setValue(VIBRATION_STRENGTH_PATH, vibrationValue);
                break;

            case PREF_HEADPHONE_GAIN:
                FileUtils.setValue(HEADPHONE_GAIN_PATH, value + " " + value);
                break;

            case PREF_GLOVE_MODE:
                FileUtils.setValue(GLOVE_MODE_PATH, (boolean) value);
                break;

            case USB_FASTCHARGE_KEY:
                FileUtils.setValue(USB_FASTCHARGE_PATH, (boolean) value);
                break;

            default:
                break;
        }
        return true;
    }

    private boolean isAppNotInstalled(String uri) {
        PackageManager packageManager = getContext().getPackageManager();
        try {
            packageManager.getPackageInfo(uri, PackageManager.GET_ACTIVITIES);
            return false;
        } catch (PackageManager.NameNotFoundException e) {
            return true;
        }
    }
}
