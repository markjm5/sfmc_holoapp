package com.example.sfmc_holoapp;
import com.evergage.android.Evergage;

import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService;

public class MyFirebaseMessagingService extends FlutterFirebaseMessagingService {

    @Override
    public void onNewToken(String token) {
        // Method not called on every app start, only when token actually refreshes.
        super.onNewToken(token);
        Evergage.getInstance().setFirebaseToken(token);
    }

}
