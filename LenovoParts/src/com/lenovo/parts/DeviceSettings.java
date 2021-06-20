/*
* Copyright (C) 2016 The OmniROM Project
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 2 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program. If not, see <http://www.gnu.com/licenses/>.
*
*/
package com.lenovo.parts;

import android.app.AlertDialog;
import android.app.Dialog;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.res.Resources;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.os.SystemProperties;
import android.provider.Settings;
import android.text.TextUtils;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ListView;
import android.util.Log;

import androidx.preference.PreferenceFragment;
import androidx.preference.SwitchPreference;
import androidx.preference.ListPreference;
import androidx.preference.Preference;
import androidx.preference.Preference.OnPreferenceClickListener;
import androidx.preference.PreferenceCategory;
import androidx.preference.PreferenceScreen;
import androidx.preference.PreferenceManager;
import androidx.preference.TwoStatePreference;

import com.lenovo.parts.sound.SoundControlActivity;

public class DeviceSettings extends PreferenceFragment implements
        Preference.OnPreferenceChangeListener {

    public static final String S2S_KEY = "sweep2sleep";
    public static final String KEY_VIBSTRENGTH = "vib_strength";
    public static final String FILE_S2S_TYPE = "/sys/sweep2sleep/sweep2sleep";
    public static final String KEY_YELLOW_TORCH_BRIGHTNESS = "yellow_torch_brightness";
    public static final String KEY_WHITE_TORCH_BRIGHTNESS = "white_torch_brightness";
    public static final String KEY_GLOVE_MODE = "glove_mode";

    private static final String GLOVE_MODE_FILE = "/sys/board_properties/tpd_glove_status";
    private static final String KEY_CATEGORY_DISPLAY = "display";

    private ListPreference mS2S;
    private VibratorStrengthPreference mVibratorStrength;
    private YellowTorchBrightnessPreference mYellowTorchBrightness;
    private WhiteTorchBrightnessPreference mWhiteTorchBrightness;
    private TwoStatePreference mGloveMode;

    @Override
    public void onCreatePreferences(Bundle savedInstanceState, String rootKey) {
        setPreferencesFromResource(R.xml.main, rootKey);

        PreferenceScreen prefSet = getPreferenceScreen();

        PreferenceScreen mSoundControlPref = (PreferenceScreen) findPreference("sound_control");
        mSoundControlPref.setOnPreferenceClickListener(new Preference.OnPreferenceClickListener() {
             @Override
             public boolean onPreferenceClick(Preference preference) {
                 Intent intent = new Intent(getActivity().getApplicationContext(), SoundControlActivity.class);
                 startActivity(intent);
                 return true;
             }
        });

        PreferenceScreen mKcalPref = (PreferenceScreen) findPreference("kcal");
        mKcalPref.setOnPreferenceClickListener(new OnPreferenceClickListener() {
             @Override
             public boolean onPreferenceClick(Preference preference) {
                 Intent intent = new Intent(getActivity().getApplicationContext(), DisplayCalibration.class);
                 startActivity(intent);
                 return true;
             }
        });

        mS2S = (ListPreference) findPreference(S2S_KEY);
        mS2S.setValue(Utils.getFileValue(FILE_S2S_TYPE, "0"));
        mS2S.setOnPreferenceChangeListener(this);

        mVibratorStrength = (VibratorStrengthPreference) findPreference(KEY_VIBSTRENGTH);
        if (mVibratorStrength != null) {
            mVibratorStrength.setEnabled(VibratorStrengthPreference.isSupported());
        }

        mGloveMode = (TwoStatePreference) findPreference(KEY_GLOVE_MODE);
        mGloveMode.setChecked(PreferenceManager.getDefaultSharedPreferences(getContext()).getBoolean(DeviceSettings.KEY_GLOVE_MODE, false));
        mGloveMode.setOnPreferenceChangeListener(this);

        mYellowTorchBrightness = (YellowTorchBrightnessPreference) findPreference(KEY_YELLOW_TORCH_BRIGHTNESS);
        if (mYellowTorchBrightness != null) {
            mYellowTorchBrightness.setEnabled(YellowTorchBrightnessPreference.isSupported());
        }

        mWhiteTorchBrightness = (WhiteTorchBrightnessPreference) findPreference(KEY_WHITE_TORCH_BRIGHTNESS);
        if (mWhiteTorchBrightness != null) {
            mWhiteTorchBrightness.setEnabled(WhiteTorchBrightnessPreference.isSupported());
        }
    }

    public static void restore(Context context) {
        boolean gloveModeData = PreferenceManager.getDefaultSharedPreferences(context).getBoolean(DeviceSettings.KEY_GLOVE_MODE, false);
        Utils.writeValue(GLOVE_MODE_FILE, gloveModeData ? "1" : "0");
    }

    @Override
    public boolean onPreferenceTreeClick(Preference preference) {
        return super.onPreferenceTreeClick(preference);
    }

    @Override
    public boolean onPreferenceChange(Preference preference, Object newValue) {
        if (preference == mGloveMode) {
            Boolean enabled = (Boolean) newValue;
            SharedPreferences.Editor prefChange = PreferenceManager.getDefaultSharedPreferences(getContext()).edit();
            prefChange.putBoolean(KEY_GLOVE_MODE, enabled).commit();
            Utils.writeValue(GLOVE_MODE_FILE, enabled ? "1" : "0");
            return true;
        } else if (preference == mS2S) {
            String strvalue = (String) newValue;
            Utils.writeValue("/sys/sweep2sleep/sweep2sleep", strvalue);
            SharedPreferences.Editor editor = PreferenceManager.getDefaultSharedPreferences(getContext()).edit();
            editor.putString(S2S_KEY, strvalue);
            editor.apply();
            return true;
        }
        return false;
    }
}
