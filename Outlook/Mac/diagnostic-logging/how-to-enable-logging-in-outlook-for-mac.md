---
title: How to enable logging in Outlook for Mac
description: Describes how to enable logging in Microsoft Outlook for Mac and how to collect logs, log file locations, and other important information about logging in Outlook for Mac.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Errors, Crashes, and Performance
  - Outlook for Mac
  - CSSTroubleshoot
ms.reviewer: pawankap, tasitae
appliesto: 
  - Outlook 2016 for Mac
  - Outlook for Microsoft 365 for Mac
search.appverid: MET150
ms.date: 01/30/2024
---
# How to enable logging in Outlook for Mac

_Original KB number:_ &nbsp; 2872257

## Summary

Outlook for Mac provides the option to enable logging for the following features:

- AutoDiscover service
- Microsoft Exchange (folder and item synchronization)
- Microsoft Exchange Calendar
- LDAP transactions

In Outlook 2016 for Mac version 15.12.3 and later versions, the following features are also logged in addition to those listed earlier:

- Database
- IMAP
- Network Connections
- Import
- Upgrade
- Sync

## More information

### To enable logging in Outlook 2016 for Mac, follow these steps

Enable logging

- On the Window menu, select **Sync Errors**.
- In the **Sync Errors** window, select the **Gear icon**.
- Select the **Turn on logging for troubleshooting** option, and then select **OK**.
- Restart Outlook and when prompted to turn off logging select **Leave Logging On** and reproduce the issue you experience and then Quit Outlook to stop the log capture

To disable logging:

- Restart Outlook and when prompted to turn off logging, select **Turn Logging Of**. If you disable logging manually, you must restart Outlook to fully disable logging, otherwise it will continue logging in the background.

### To enable logging in Outlook for Mac 2011, follow these steps

Enable logging

- On the Window menu, select **Error Log**.
- In the **Error** window, select the **Gear icon**.
- Select the **Turn on logging** for troubleshooting option, and then select **OK**.
- Close the **Error** window.

To disable logging:

- Restart Outlook and when prompted to turn off logging select **Turn Logging Off**. If you disable logging manually you must restart Outlook to fully disable logging, otherwise it will continue logging in the background.

> [!NOTE]
> It is important to turn off logging after you complete your troubleshooting and reproduce the issue. If logging is not turned off, the log files size will continue to increase. If you must keep logging enabled for several hours or several days in order to capture the issue, make sure that the hard disk has sufficient free space.

#### Log file locations

Depending on the edition and version of Outlook for Mac in which the log is being collected, the log name and location will differ. To locate the log, see the following table.

|Outlook for Mac edition|Version|Location|File name|
|---|---|---|---|
|Outlook for Mac 2011|14.0.0 - 14.2.4|~/Desktop/|Microsoft Outlook_Troubleshooting_0.log|
|Outlook for Mac 2011|14.2.5 - current|~/Desktop/OfficeLogging/|Microsoft Outlook_Troubleshooting_#.csv|
|Outlook 2016 for Mac|15.3 - 15.11.2|~/Library/Group Containers/ UBF8T346G9.Office/OfficeLogging/|Microsoft Outlook_Troubleshooting_#.csv|
|Outlook 2016 for Mac|15.12.3 - Current|~/Library/Containers/com.microsoft.Outlook/Data/Library/Logs/ or ~/Library/Containers/Microsoft Outlook/Data/Library/Logs/|Microsoft outlook-\<date>-\<time>.log|

> [!NOTE]
> The character combination "~/" in the **Location** column in this table refers to the Home folder of the user. This folder is located under the Users folder on the root of the hard disk.

> [!IMPORTANT]
> In Outlook for Mac 2011 version 14.2.4 and earlier versions, data was appended to the same log file for every Outlook session. In Outlook for Mac 2011 version 14.2.5 and later versions and in Outlook 2016 for Mac, every time that you quit and start Outlook when logging is enabled, a new log file is created.

#### Viewing the log file

When you collect and send the log file, Microsoft Customer Service and Support uses it to identify issues. If you are a messaging server administrator, you can use the information in the log file to diagnose issues when you troubleshoot.

The log file contains the following information:

- Issues that occur when email messages, calendar items, notes, tasks, and meeting requests are sent or received.
- Type or severity of errors, if known.

In the Outlook for Mac log collected for Outlook for Mac 2011 and Outlook 2016 for Mac through version 15.11.2, each entry has a name that identifies the feature that is being logged. The following table lists the label for each feature.

|Feature|Label that identifies the feature in the log file|
|---|---|
|AutoDiscover service|Outlook Exchange Auto Configure|
|Exchange (folder and item synchronization)|Outlook Exchange Web Services|
|Exchange Calendar|Outlook Calendar|
|LDAP transactions|Outlook LDAP|

In Outlook 2016 for Mac version 15.12.3 and later versions, the log file opens in the Console and you can view it while Outlook is running. Each entry has a name that identifies the feature that is being logged. The following table lists the label for each feature.

|Feature|Label that identifies the feature in the log file|
|---|---|
|AutoDiscover service|outlook.account.exchange.addaccount.config|
|Exchange (folder and item synchronization)|outlook.exchange.ews|
|Exchange Calendar|outlook.calendar|
|LDAP transactions|outlook.account.ldap|
|Database|outlook.database|
|IMAP|outlook.account.imap|
|Network Connections|outlook.network|
|Import|outlook.import|
|Upgrade|outlook.database.upgrade|
|Sync|outlook.sync|

> [!NOTE]
> The log file may also contain user information. This includes user name, sender and receiver's email addresses, and the contents of the user's email messages, notes, tasks, calendar, and contacts. Microsoft does not use this information to contact users without their consent. If you are concerned that the data file contains sensitive or confidential information, you may review the contents of the data file by using text-editing software and then remove the information from the file before you send the data file to support professionals. Authentication information is not included in the log files.

#### EWS SyncState message size

Starting with the Outlook for Mac 2011 14.3.4 update, the size of the SyncState binary large object (BLOB) of EWS messages increased from 6 kilobytes (KB) to 32 KB and can be increased up to no more than 300 KB. If you are troubleshooting an issue in which you have to view more of this data, you must increase this value. To increase the default value of the SyncState binary large object of EWS messages, follow these steps:

1. Exit Outlook 2011.
2. Open **Terminal**.
3. To set the SyncState binary large object of EWS messages to a specific size, type the following command in **Terminal** window:

    ```console
    defaults write ~/Library/Preferences/com.microsoft.Outlook EWSMaxLogLength \<max bytes>
    ```

    > [!NOTE]
    > The placeholder \<max bytes> represents a byte value. For example, if you want to change the maximum byte size to 10 KB, you would type the value 10240.

4. To set the SyncState binary large object of EWS messages back to the default size of 32 KB, type the following command in **Terminal** window:

    ```console
    defaults write ~/Library/Preferences/com.microsoft.Outlook EWSMaxLogLength
   ```

5. Start Outlook, and then enable Outlook logging.
