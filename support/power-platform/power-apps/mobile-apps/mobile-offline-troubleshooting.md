
# Offline Sync error troubleshooting 
Data sync can fail in offline-enabled apps due to various errors. Depending on the type of app, the error message may appear differently. 

## Model-driven apps including Field Service 

If the offline sync status icon indicates a warning or error, you can tap on it to open the Device Status page to see more details. In the Device Status page, you’ll see your current device state and details from the last sync. If an error or warning occurred, you’ll see a message describing what went wrong.  

See [View offline sync status - Power Apps | Microsoft Learn](https://learn.microsoft.com/power-apps/mobile/offline-sync-icon#types-of-offline-syncs). 

## Canvas apps (preview)
In canvas apps, sync errors may occur when opening the app for the first time. A dialogue will appear with the error message. See [Work with canvas apps offline (preview) - Power Apps | Microsoft Learn](https://learn.microsoft.com/power-apps/mobile/canvas-mobile-offline-working) for details. 

## Offline sync errors 
If you encounter an error while syncing offline data, look for the error message below and contact your admin or app maker to follow the recommended actions. 

Make sure you have the latest version of the app from the Google Play Store, Apple App Store or Microsoft Store. 

| Error message | Recommended actions|
| Failed to download because we cannot connect to the server. | Check that you have a strong internet connection and try again. |
| It’s taking a while to calculate data to download (entity with timeout: <tablename>) | The sync for the table <tablename> is timing out. Consider simplifying the filters specified by this table and its related tables. See best practives: [Offline profile guidelines - Power Apps | Microsoft Learn](https://learn.microsoft.com/power-apps/mobile/mobile-offline-guidelines)|
| The operation timed out. This may be because of ongoing server updates. Please try again later. | Wait and try again later. Solutions should be imported outside of working hours if possible. [Manage your maintenance window - Power Platform | Microsoft Learn](https://learn.microsoft.com/power-platform/admin/manage-maintenance-window)|
| An error occured from ISV code.  | [Troubleshoot Dataverse plug-ins - Power Apps | Microsoft Learn  ](https://learn.microsoft.com/troubleshoot/power-platform/power-apps/dataverse/dataverse-plug-ins-errors#error-the-given-key-wasnt-present-in-the-dictionary)|
| The plug-in execution failed. This is typically due to an error in the plug-in code. | [Troubleshoot Dataverse plug-ins - Power Apps | Microsoft Learn  ](https://learn.microsoft.com/troubleshoot/power-platform/power-apps/dataverse/dataverse-plug-ins-errors#error-the-given-key-wasnt-present-in-the-dictionary)|
| Internal issue while downloading your data (Error code: <errorCode>) | Look for <errorCode> in [Web service error codes | Microsoft Learn](https://learn.microsoft.com/previous-versions/dynamicscrm-2016/developers-guide/gg328182%28v=crm.8%29?redirectedfrom=MSDN)|
