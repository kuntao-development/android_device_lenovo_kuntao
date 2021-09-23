/*
* Copyright (C) 2021 Evolution X Project
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
* along with this program. If not, see <http://www.gnu.org/licenses/>.
*
*/
package com.lenovo.parts.tile;

import android.content.Intent;
import android.service.quicksettings.Tile;
import android.service.quicksettings.TileService;

import com.lenovo.parts.ambient.AmbientGesturePreferenceActivity;

import com.lenovo.parts.R;

public class DozeTileService extends TileService {

    @Override
    public void onDestroy() {
        super.onDestroy();
    }

    @Override
    public void onTileAdded() {
        super.onTileAdded();
    }

    @Override
    public void onTileRemoved() {
        super.onTileRemoved();
    }

    @Override
    public void onStartListening() {
        super.onStartListening();
    }

    @Override
    public void onStopListening() {
        super.onStopListening();
    }

    @Override
    public void onClick() {
        super.onClick();
        Intent AmbientGesture = new Intent(this, AmbientGesturePreferenceActivity.class);
        AmbientGesture.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        startActivityAndCollapse(AmbientGesture);
    }
}
