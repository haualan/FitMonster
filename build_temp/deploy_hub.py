# -*- coding: utf-8 -*-
#
# (C) 2001-2012 Marmalade. All Rights Reserved.
#
# This document is protected by copyright, and contains information
# proprietary to Marmalade.
#
# This file consists of source code released by Marmalade under
# the terms of the accompanying End User License Agreement (EULA).
# Please do not use this program/source code before you have read the
# EULA and have agreed to be bound by its terms.
#
import deploy_config

config = deploy_config.config
cmdline = deploy_config.cmdline
mkb = deploy_config.mkb
mkf = deploy_config.mkf

assets = deploy_config.assets

class HubConfig(deploy_config.DefaultConfig):
    android_icon_group = {}
    android_external_res = [ur"/Users/ahau/Documents/marmaladetest/FitMonster/../../../../../Applications/Marmalade.app/Contents/extensions/s3eFacebook/third-party/facebook-android-sdk/facebook/res", ur"/Users/ahau/Documents/marmaladetest/FitMonster/../../../../../Applications/Marmalade.app/Contents/extensions/s3eAndroidGooglePlayBilling/source/android/res", ur"/Users/ahau/Documents/marmaladetest/FitMonster/../../../../../Applications/Marmalade.app/Contents/extensions/s3eSamsungInAppPurchasing/source/android/res"]
    android_install_location = 1
    android_pkgname = r"com.ahau.FitMonster"
    icon = r"/Users/ahau/Documents/marmaladetest/FitMonster/icons/icon_FitMonster.png"
    splashscreen = r"/Users/ahau/Documents/marmaladetest/FitMonster/icons/splash_FitMonster.png"
    splashscreen_use_all = True
    assets = assets["Default"]
    config = [ur"/Users/ahau/Documents/marmaladetest/FitMonster/resources/common.icf", ur"/Users/ahau/Documents/marmaladetest/FitMonster/resources/app.icf"]
    name = ur"FitMonster"
    caption = ur"FitMonster"
    provider = ur"ahau"
    copyright = ur"(C) ahau"
    version = [0, 0, 1]
    android_extra_manifest = [ur"/Users/ahau/Documents/marmaladetest/FitMonster/../../../../../Applications/Marmalade.app/Contents/extensions/s3eAndroidGooglePlayBilling/source/android/ExtraManifests.xml", ur"/Users/ahau/Documents/marmaladetest/FitMonster/../../../../../Applications/Marmalade.app/Contents/extensions/s3eSamsungInAppPurchasing/source/android/ExtraManifests.xml", ur"/Users/ahau/Documents/marmaladetest/FitMonster/../../../../../Applications/Marmalade.app/Contents/extensions/Fortumo/extras.manifest.txt"]
    android_extra_application_manifest = [ur"/Users/ahau/Documents/marmaladetest/FitMonster/../../../../../Applications/Marmalade.app/Contents/extensions/s3eFacebook/source/android/extra_app_manifest.xml", ur"/Users/ahau/Documents/marmaladetest/FitMonster/../../../../../Applications/Marmalade.app/Contents/extensions/s3eAmazonInAppPurchasing/source/android/AmazonInAppPurchasingManifestSnippet.xml", ur"/Users/ahau/Documents/marmaladetest/FitMonster/../../../../../Applications/Marmalade.app/Contents/extensions/s3eAndroidMarketBilling/s3eAndroidMarketBillingManifest.xml", ur"/Users/ahau/Documents/marmaladetest/FitMonster/../../../../../Applications/Marmalade.app/Contents/extensions/s3eAndroidGooglePlayBilling/source/android/ExtraAppManifests.xml", ur"/Users/ahau/Documents/marmaladetest/FitMonster/../../../../../Applications/Marmalade.app/Contents/extensions/s3eSamsungInAppPurchasing/source/android/ExtraAppManifests.xml", ur"/Users/ahau/Documents/marmaladetest/FitMonster/../../../../../Applications/Marmalade.app/Contents/extensions/Fortumo/extras.application.txt"]
    android_extra_strings = ur"(app_id,fb_app_id)"
    pass

default = HubConfig()
