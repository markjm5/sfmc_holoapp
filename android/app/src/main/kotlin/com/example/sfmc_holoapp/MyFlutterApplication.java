package com.example.sfmc_holoapp;
import com.evergage.android.CampaignHandler;
import com.evergage.android.Campaign;

import android.app.Application;
import android.os.Bundle;

import androidx.annotation.NonNull;

import io.flutter.app.FlutterActivity;
import io.flutter.app.FlutterApplication;

import com.evergage.android.ClientConfiguration;
import com.evergage.android.Evergage;
import com.evergage.android.EvergageActivity;
import com.evergage.android.Screen;

public class MyFlutterApplication extends FlutterApplication {
    public Evergage evergage;
    public Campaign returnCampaign;


    @Override
    public void onCreate() {
        super.onCreate();

        // Initialize Evergage:
        Evergage.initialize(this);
    }

    public Evergage startEvg(String account, String ds) {
        evergage = Evergage.getInstance();
        evergage.start(new ClientConfiguration.Builder().account(account).dataset(ds).usePushNotifications(true).build());

        //Screen screen = myEvg.getScreenForActivity(ea);

        return evergage;
    }

    public Screen refreshScreen(String event, Screen screen) {
        // Evergage track screen view
        //final Screen screen = myEvg.getScreenForActivity(fa);

        if (screen != null) {
            // If screen is viewing a product:
            //screen.viewItem(new Product("p123"));

            // If screen is viewing a category, like women's merchandise:
            //screen.viewCategory(new Category("Womens"));

            // Or if screen is viewing a tag, like some specific brand:
            //screen.viewTag(new Tag("SomeBrand", Tag.Type.Brand));

            // Or maybe screen isn't related to your catalog:
            screen.trackAction(event);

        }
        return screen;

    }
}
