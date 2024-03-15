---
title: Offline sync errors in the Power Apps mobile app
description: If you encounter an error while syncing offline data in the Power Apps mobile app, look for the error message in this article and contact your admin or app maker to follow the recommended actions.
ms.reviewer: mkaur, bwalters, clarading
ms.date: 03/15/2024
author: trdehove
ms.author: trdehove
ms.custom: sap:Mobile Apps\Can't connect
---
# Troubleshoot with offline sync errors in the Power Apps mobile app

Data sync can fail in [offline-enabled mobile apps](/power-apps/mobile/mobile-offline-overview) due to various errors. Depending on the type of the app, the error message might appear differently.

## Model-driven apps including Field Service

If the offline sync status icon indicates a warning or error, you can tap on it to open the **Device Status** page to see more details. On the **Device Status** page, you'll see your current device state and details from the last sync. If an error or warning occurrs, you'll see a message describing the issue.  

For more information, see [View offline sync status](/power-apps/mobile/offline-sync-icon).

## Canvas apps (preview)

In canvas apps, sync errors might occur when opening the app for the first time. A dialogue appears with an error message. For more information, see [Work with canvas apps offline (preview)](/power-apps/mobile/canvas-mobile-offline-working).

## Offline sync errors

If you encounter an error while syncing offline data in the Power Apps mobile app, look for the error message listed below and contact your administrator or app maker to follow the recommended actions.

Make sure you have installed the latest version of the mobile app from the Google Play Store, Apple App Store, or Microsoft Store.

| Error message | Recommended actions|
|---------|---------|
| Failed to download because we cannot connect to the server. | Check that you have a strong internet connection and try again. |
| It's taking a while to calculate data to download (entity with timeout: \<tablename>) | The sync for the table \<tablename> times out. Consider simplifying the filters specified by this table and its related tables. For best practices, see [Offline profile guidelines](/power-apps/mobile/mobile-offline-guidelines).|
| The operation timed out. This may be because of ongoing server updates. Please try again later. | Wait and try again later. Solutions should be imported outside of working hours if possible. For more information, see [Manage your maintenance window](/power-platform/admin/manage-maintenance-window).|
| An error occurred from ISV code.  |For more information, see [Troubleshoot Dataverse plug-ins](~/power-platform/power-apps/dataverse/dataverse-plug-ins-errors.md#error-the-given-key-wasnt-present-in-the-dictionary).|
| The plug-in execution failed. This is typically due to an error in the plug-in code. |For more information, see [Troubleshoot Dataverse plug-ins](~/power-platform/power-apps/dataverse/dataverse-plug-ins-errors.md#error-the-given-key-wasnt-present-in-the-dictionary).|
| Internal issue while downloading your data (Error code: \<errorCode>) | Look for the error code in [Web service error codes](/previous-versions/dynamicscrm-2016/developers-guide/gg328182(v=crm.8)).|
