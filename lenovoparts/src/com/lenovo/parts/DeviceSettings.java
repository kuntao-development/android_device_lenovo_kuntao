package com.lenovo.parts;

import android.app.Activity;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.content.Context;
import android.os.Bundle;
import android.content.SharedPreferences;
import androidx.preference.Preference;
import androidx.preference.PreferenceCategory;
import androidx.preference.PreferenceFragment;
import androidx.preference.PreferenceManager;
import androidx.preference.SwitchPreference;

import com.lenovo.parts.kcal.KCalSettingsActivity;
import com.lenovo.parts.ambient.AmbientGesturePreferenceActivity;
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

    private static final String AMBIENT_DISPLAY = "ambient_display_gestures";

    public static final String PREF_VIBRATION_STRENGTH = "vibration_strength";
    public static final String VIBRATION_STRENGTH_PATH = "/sys/devices/virtual/timed_output/vibrator/vtg_level";

    public static final String PREF_KEY_FPS_INFO = "fps_info";

    // value of vtg_min and vtg_max
    public static final int MIN_VIBRATION = 116;
    public static final int MAX_VIBRATION = 3596;

    public static final  String PREF_HEADPHONE_GAIN = "headphone_gain";
    public static final  String PREF_MICROPHONE_GAIN = "microphone_gain";
    public static final  String PREF_SPEAKER_GAIN = "speaker_gain";
    public static final  String HEADPHONE_GAIN_PATH = "/sys/kernel/sound_control/headphone_gain";
    public static final  String MICROPHONE_GAIN_PATH = "/sys/kernel/sound_control/mic_gain";
    public static final  String SPEAKER_GAIN_PATH = "/sys/kernel/sound_control/speaker_gain";

    public static final String KEY_YELLOW_TORCH_BRIGHTNESS = "yellow_torch_brightness";
    public static final String KEY_WHITE_TORCH_BRIGHTNESS = "white_torch_brightness";
    private static final String TORCH_1_BRIGHTNESS_PATH = "/sys/devices/soc/qpnp-flash-led-22/leds/led:torch_0/max_brightness";
    private static final String TORCH_2_BRIGHTNESS_PATH = "/sys/devices/soc/qpnp-flash-led-22/leds/led:torch_1/max_brightness";

    public static final String PREF_GLOVE_MODE = "glove_mode";
    public static final String GLOVE_MODE_PATH = "/sys/board_properties/tpd_glove_status";

    @Override
    public void onCreatePreferences(Bundle savedInstanceState, String rootKey) {
        setPreferencesFromResource(R.xml.lenovo_main, rootKey);
        SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(this.getContext());

        VibrationSeekBarPreference vibrationStrength = (VibrationSeekBarPreference) findPreference(PREF_VIBRATION_STRENGTH);
        vibrationStrength.setEnabled(FileUtils.fileWritable(VIBRATION_STRENGTH_PATH));
        vibrationStrength.setOnPreferenceChangeListener(this);

        CustomSeekBarPreference headphone_gain = (CustomSeekBarPreference) findPreference(PREF_HEADPHONE_GAIN);
        headphone_gain.setEnabled(FileUtils.fileWritable(HEADPHONE_GAIN_PATH));
        headphone_gain.setOnPreferenceChangeListener(this);

        CustomSeekBarPreference microphone_gain = (CustomSeekBarPreference) findPreference(PREF_MICROPHONE_GAIN);
        microphone_gain.setEnabled(FileUtils.fileWritable(MICROPHONE_GAIN_PATH));
        microphone_gain.setOnPreferenceChangeListener(this);

        CustomSeekBarPreference speaker_gain = (CustomSeekBarPreference) findPreference(PREF_SPEAKER_GAIN);
        speaker_gain.setEnabled(FileUtils.fileWritable(SPEAKER_GAIN_PATH));
        speaker_gain.setOnPreferenceChangeListener(this);

        CustomSeekBarPreference white_torch_brightness = (CustomSeekBarPreference) findPreference(KEY_WHITE_TORCH_BRIGHTNESS);
        white_torch_brightness.setEnabled(FileUtils.fileWritable(TORCH_1_BRIGHTNESS_PATH));
        white_torch_brightness.setOnPreferenceChangeListener(this);

        CustomSeekBarPreference yellow_torch_brightness = (CustomSeekBarPreference) findPreference(KEY_YELLOW_TORCH_BRIGHTNESS);
        yellow_torch_brightness.setEnabled(FileUtils.fileWritable(TORCH_2_BRIGHTNESS_PATH));
        yellow_torch_brightness.setOnPreferenceChangeListener(this);

        PreferenceCategory displayCategory = (PreferenceCategory) findPreference(CATEGORY_DISPLAY);

        SwitchPreference fpsInfo = (SwitchPreference) findPreference(PREF_KEY_FPS_INFO);
        fpsInfo.setChecked(prefs.getBoolean(PREF_KEY_FPS_INFO, false));
        fpsInfo.setOnPreferenceChangeListener(this);

        SwitchPreference glovemode = (SecureSettingSwitchPreference) findPreference(PREF_GLOVE_MODE);
        glovemode.setEnabled(FileUtils.fileWritable(GLOVE_MODE_PATH));
        glovemode.setChecked(FileUtils.getFileValueAsBoolean(GLOVE_MODE_PATH, true));
        glovemode.setOnPreferenceChangeListener(this);

        Preference kcal = findPreference(PREF_DEVICE_KCAL);
        kcal.setOnPreferenceClickListener(preference -> {
            Intent intent = new Intent(getActivity().getApplicationContext(), KCalSettingsActivity.class);
            startActivity(intent);
            return true;
        });

        Preference ambientDisplay = findPreference(AMBIENT_DISPLAY);
        ambientDisplay.setOnPreferenceClickListener(preference -> {
            Intent intent = new Intent(getContext(), AmbientGesturePreferenceActivity.class);
            startActivity(intent);
            return true;
        });
    }

    @Override
    public boolean onPreferenceChange(Preference preference, Object value) {
        final String key = preference.getKey();
        switch (key) {
            case KEY_WHITE_TORCH_BRIGHTNESS:
                FileUtils.setValue(TORCH_1_BRIGHTNESS_PATH, (int) value);
                break;

            case KEY_YELLOW_TORCH_BRIGHTNESS:
                FileUtils.setValue(TORCH_2_BRIGHTNESS_PATH, (int) value);
                break;

            case PREF_VIBRATION_STRENGTH:
                double vibrationValue = (int) value / 100.0 * (MAX_VIBRATION - MIN_VIBRATION) + MIN_VIBRATION;
                FileUtils.setValue(VIBRATION_STRENGTH_PATH, vibrationValue);
                break;

            case PREF_HEADPHONE_GAIN:
                FileUtils.setValue(HEADPHONE_GAIN_PATH, value + " " + value);
                break;

            case PREF_MICROPHONE_GAIN:
                FileUtils.setValue(MICROPHONE_GAIN_PATH, (int) value);
                break;

            case PREF_SPEAKER_GAIN:
                FileUtils.setValue(SPEAKER_GAIN_PATH, (int) value);
                break;

            case PREF_KEY_FPS_INFO:
                boolean enabled = (Boolean) value;
                Intent fpsinfo = new Intent(this.getContext(), FPSInfoService.class);
                if (enabled) {
                    this.getContext().startService(fpsinfo);
                } else {
                    this.getContext().stopService(fpsinfo);
                }
                break;

            case PREF_GLOVE_MODE:
                FileUtils.setValue(GLOVE_MODE_PATH, (boolean) value);
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
