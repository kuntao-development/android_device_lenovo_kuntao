package com.lenovo.parts;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import androidx.preference.PreferenceManager;
import android.provider.Settings;

import com.lenovo.parts.kcal.Utils;
import com.lenovo.parts.ambient.SensorsDozeService;

public class BootReceiver extends BroadcastReceiver implements Utils {

    public static final  String HEADPHONE_GAIN_PATH = "/sys/kernel/sound_control/headphone_gain";
    public static final  String MICROPHONE_GAIN_PATH = "/sys/kernel/sound_control/mic_gain";
    public static final  String SPEAKER_GAIN_PATH = "/sys/kernel/sound_control/speaker_gain";

    public static final String TORCH_1_BRIGHTNESS_PATH = "/sys/devices/soc/qpnp-flash-led-22/leds/led:torch_0/max_brightness";
    public static final String TORCH_2_BRIGHTNESS_PATH = "/sys/devices/soc/qpnp-flash-led-22/leds/led:torch_1/max_brightness";

    public void onReceive(Context context, Intent intent) {

        SharedPreferences sharedPrefs = PreferenceManager.getDefaultSharedPreferences(context);

        if (Settings.Secure.getInt(context.getContentResolver(), PREF_ENABLED, 0) == 1) {
            FileUtils.setValue(KCAL_ENABLE, Settings.Secure.getInt(context.getContentResolver(),
                    PREF_ENABLED, 0));

            String rgbValue = Settings.Secure.getInt(context.getContentResolver(),
                    PREF_RED, RED_DEFAULT) + " " +
                    Settings.Secure.getInt(context.getContentResolver(), PREF_GREEN,
                            GREEN_DEFAULT) + " " +
                    Settings.Secure.getInt(context.getContentResolver(), PREF_BLUE,
                            BLUE_DEFAULT);

            FileUtils.setValue(KCAL_RGB, rgbValue);
            FileUtils.setValue(KCAL_MIN, Settings.Secure.getInt(context.getContentResolver(),
                    PREF_MINIMUM, MINIMUM_DEFAULT));
            FileUtils.setValue(KCAL_SAT, Settings.Secure.getInt(context.getContentResolver(),
                    PREF_GRAYSCALE, 0) == 1 ? 128 :
                    Settings.Secure.getInt(context.getContentResolver(),
                            PREF_SATURATION, SATURATION_DEFAULT) + SATURATION_OFFSET);
            FileUtils.setValue(KCAL_VAL, Settings.Secure.getInt(context.getContentResolver(),
                    PREF_VALUE, VALUE_DEFAULT) + VALUE_OFFSET);
            FileUtils.setValue(KCAL_CONT, Settings.Secure.getInt(context.getContentResolver(),
                    PREF_CONTRAST, CONTRAST_DEFAULT) + CONTRAST_OFFSET);
            FileUtils.setValue(KCAL_HUE, Settings.Secure.getInt(context.getContentResolver(),
                    PREF_HUE, HUE_DEFAULT));
        }

        int gain = Settings.Secure.getInt(context.getContentResolver(),
                DeviceSettings.PREF_HEADPHONE_GAIN, 4);
        FileUtils.setValue(HEADPHONE_GAIN_PATH, gain + " " + gain);
        FileUtils.setValue(MICROPHONE_GAIN_PATH, Settings.Secure.getInt(context.getContentResolver(),
                DeviceSettings.PREF_MICROPHONE_GAIN, 0));
       FileUtils.setValue(SPEAKER_GAIN_PATH, Settings.Secure.getInt(context.getContentResolver(),
                DeviceSettings.PREF_SPEAKER_GAIN, 0));

        FileUtils.setValue(TORCH_1_BRIGHTNESS_PATH,
                Settings.Secure.getInt(context.getContentResolver(),
                        DeviceSettings.KEY_WHITE_TORCH_BRIGHTNESS, 200));
        FileUtils.setValue(TORCH_2_BRIGHTNESS_PATH,
                Settings.Secure.getInt(context.getContentResolver(),
                        DeviceSettings.KEY_YELLOW_TORCH_BRIGHTNESS, 200));

        FileUtils.setValue(DeviceSettings.VIBRATION_STRENGTH_PATH, Settings.Secure.getInt(
                context.getContentResolver(), DeviceSettings.PREF_VIBRATION_STRENGTH, 20) / 100.0 * (DeviceSettings.MAX_VIBRATION - DeviceSettings.MIN_VIBRATION) + DeviceSettings.MIN_VIBRATION);

        FileUtils.setValue(DeviceSettings.GLOVE_MODE_PATH, Settings.Secure.getInt(context.getContentResolver(),
                DeviceSettings.PREF_GLOVE_MODE, 0));

        //Ambient
        context.startService(new Intent(context, SensorsDozeService.class));

        boolean enabled = sharedPrefs.getBoolean(DeviceSettings.PREF_KEY_FPS_INFO, false);
        if (enabled) {
            context.startService(new Intent(context, FPSInfoService.class));
        }
    }
}

