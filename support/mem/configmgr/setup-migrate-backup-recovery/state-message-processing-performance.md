---
title: Troubleshoot state message backlog
description: Describes how to troubleshoot state messaging performance issues in Configuration Manager.
ms.date: 12/05/2023
ms.reviewer: kaushika, buzb, lamosley
author: helenclu
ms.author: luche
ms.custom: sap:Site Server and Roles\Inbox Backlog
---
# Troubleshoot state message processing performance issues

*Applies to*: Configuration Manager

State messaging is one of the most important reporting mechanisms in Configuration Manager. It's responsible for application and update deployment statistics, and many other flows.

In this article, we focus on the SMS_STATE_SYSTEM component (also referred to as StateSys) that processes the incoming state messages and updates the database.

For more information about the state messaging system, see [Description of state messaging in Configuration Manager](../update-management/state-messaging-description.md).

## Symptoms

A Configuration Manager administrator notices a significant delay in reporting Software Update compliance and application deployment. In this situation, the `<Configuration Manager Installation Directory>\Inboxes\auth\statesys.box\incoming` folder contains a large number of files. For example, there are millions of files.

Here's a sample output when you filter the *InboxMon.log* file by `StateSys`:

```output
06-11-2021 08:53:35.276    SMS_INBOX_MONITOR    8972 (0X230C)    FILE COUNT FOR DIRECTORY F:\PROGRAM FILES\MICROSOFT CONFIGURATION MANAGER\INBOXES\AUTH\STATESYS.BOX\INCOMING\HIGH IS 13360.~
06-11-2021 08:53:35.401    SMS_INBOX_MONITOR    8972 (0X230C)    FILE COUNT FOR DIRECTORY F:\PROGRAM FILES\MICROSOFT CONFIGURATION MANAGER\INBOXES\AUTH\STATESYS.BOX\INCOMING\LOW IS 347.~
06-11-2021 08:53:36.556    SMS_INBOX_MONITOR    8972 (0X230C)    FILE COUNT FOR DIRECTORY F:\PROGRAM FILES\MICROSOFT CONFIGURATION MANAGER\INBOXES\AUTH\STATESYS.BOX\INCOMING IS 1087076.~
06-11-2021 09:00:00.785    SMS_INBOX_MONITOR    8972 (0X230C)    FILE COUNT FOR DIRECTORY F:\PROGRAM FILES\MICROSOFT CONFIGURATION MANAGER\INBOXES\AUTH\STATESYS.BOX\INCOMING\HIGH IS 7.~
06-11-2021 09:00:01.170    SMS_INBOX_MONITOR    8972 (0X230C)    FILE COUNT FOR DIRECTORY F:\PROGRAM FILES\MICROSOFT CONFIGURATION MANAGER\INBOXES\AUTH\STATESYS.BOX\INCOMING\LOW IS 213.~
06-11-2021 09:00:02.885    SMS_INBOX_MONITOR    8972 (0X230C)    FILE COUNT FOR DIRECTORY F:\PROGRAM FILES\MICROSOFT CONFIGURATION MANAGER\INBOXES\AUTH\STATESYS.BOX\INCOMING IS 1099177.~
06-11-2021 09:15:00.135    SMS_INBOX_MONITOR    8972 (0X230C)    FILE COUNT FOR DIRECTORY F:\PROGRAM FILES\MICROSOFT CONFIGURATION MANAGER\INBOXES\AUTH\STATESYS.BOX\INCOMING\HIGH IS 23.~
06-11-2021 09:15:00.240    SMS_INBOX_MONITOR    8972 (0X230C)    FILE COUNT FOR DIRECTORY F:\PROGRAM FILES\MICROSOFT CONFIGURATION MANAGER\INBOXES\AUTH\STATESYS.BOX\INCOMING\LOW IS 0.~
06-11-2021 09:15:01.130    SMS_INBOX_MONITOR    8972 (0X230C)    FILE COUNT FOR DIRECTORY F:\PROGRAM FILES\MICROSOFT CONFIGURATION MANAGER\INBOXES\AUTH\STATESYS.BOX\INCOMING IS 1117189.~
```

The number of files might continue to grow, or it might decrease too slowly for the files to be processed within a reasonable time frame. This issue might occur after a long server outage or a large-scale deployment.

## Cause

The incoming files are plain text XML files that usually have a file name extension of `.smx` or `.smw`. These files contain the client ID (known as SMS GUID) and payload. Typically, every file contains multiple messages. It's because a client will batch the messages before it sends them (the default is 15 minutes).

StateSys is designed to pick up files in batches, parse XML files, and update the database. When it updates the database, it runs some SQL stored procedures and CLR assemblies that are provided by Configuration Manager. Therefore, it mainly depends on the SQL Server back-end performance. When SQL Server is saturated with other tasks for a long time, this condition can cause state messages to accumulate.

At the same time, StateSys has some designs that may prevent it from catching up with a backlog of nearly millions of files:

- Files are processed in alphabetical order, not in "first in first out (FIFO)" order. Because the management point generates random names for the files, new messages might be processed before old messages. StateSys is resilient to this situation.
- Each message contains a sequence number. StateSys maintains a list of missing ranges that are stored in the `SR_MissingRanges` table. When a missing range becomes older than two days (default), StateSys issues a resynchronization for the client. The resynchronization causes the client to send a large XML file that goes to the same queue as all other messages. If new state messages are always processed two days earlier than old messages, this condition can become a vicious cycle for some clients and cause frequent resynchronization.

## Resolution

To troubleshoot the performance issue, follow these steps:

1. Identify and eliminate the issue that causes the backlog.

   If the issue is a massive deployment, disable the deployment temporarily, or reconsider the deployment strategy. For example, if you deploy a software update group of 1,000 updates, it might generate enforcement state messages for each update, each state (by default), each client, and the entire group. This can create millions of state messages.

   If the issue is poor SQL Server performance, work with your database administrator to resolve the issue. If there are many files that can't be processed, investigate the root cause first.

2. Establish a Configuration Manager performance baseline to understand the usual processing rate of your environment. Particular performance counters for StateSys include "Message Records Processed/min" and "Message File Records PreProcessed/min." Typically, these average tens of thousands. If there are no files to be processed, both counters will decrease to 0.

   :::image type="content" source="media\state-message-processing-performance\performance-counter.png" alt-text="Performance counters for StateSys.":::

   If your usual processing rate isn't enough to handle the backlog, go to the next step.

3. Change the [internal settings](../update-management/state-messaging-description.md#state_message_system-settings) of the SMS_STATE_SYSTEM component.

   > [!WARNING]
   > Serious problems might occur if you change these settings incorrectly. Microsoft can't guarantee that these problems can be solved, and doesn't support this scenario. Modify the settings at your own risk. We recommend that you restore these settings after you resolve the backlog.

   You must have at least Configuration Manager infrastructure administrator permissions to be able to modify these settings.

   1. Use the Windows Management Instrumentation Tester tool (Wbemtest) to connect to the SMS Provider. Select **Connect**, enter the site server under **Namespace**, and then select **Connect**. Enter `root\SMS\site_<site code>` for a local connection, or enter `\\MachineName\root\SMS\site_<site code>` for a remote connection.

      :::image type="content" source="media\state-message-processing-performance\connect-namespace.png" alt-text="Connect to the SMS Provider.":::
   2. Select **Query**, enter the following query, and then select **Apply**:

      ```sql
      SELECT * FROM SMS_SCI_COMPONENT WHERE ITEMNAME = 'SMS_STATE_SYSTEM|SMS SITE SERVER'
      ```

      This query returns the list of Configuration Manager sites that have the SMS_STATE_SYSTEM component installed.

      :::image type="content" source="media\state-message-processing-performance\query-result.png" alt-text="WMI query result.":::
   3. Double-click the site whose settings you want to change, and then double-click **Props** from the list of properties of the \<site\>/StateSys instance.

      :::image type="content" source="media\state-message-processing-performance\statesys-property.png" alt-text="Double-click Props.":::
   4. To see the list of embedded properties of this instance, select **View Embedded**.

      :::image type="content" source="media\state-message-processing-performance\embedded-properties.png" alt-text="View embedded properties.":::
   5. Double-click each embedded property to check the property name and value. Look for the property that has the name **Loader Threads** and the value **4**.

       :::image type="content" source="media\state-message-processing-performance\loader-threads.png" alt-text="Loader Threads.":::
   6. Double-click **Value**, increase the value to **16**. Select **Save Property**, and then select **Save Object**.

       :::image type="content" source="media\state-message-processing-performance\increase-loader-threads.png" alt-text="Increase Loader Threads.":::
   7. Look for another embedded property that has the name **Min Missing Message Age** and the value **2,880** (minutes).

       :::image type="content" source="media\state-message-processing-performance\missing-message-age.png" alt-text="Minimum missing message age.":::
   8. Double-click **Value**, and increase the value to **10,080** (seven days) to prevent unnecessary resynchronization. Select **Save Property**, and then select **Save Object**.
   9. In the **Property Editor** dialog of **Props**, select **Save Property**.

      :::image type="content" source="media\state-message-processing-performance\save-property.png" alt-text="Save property.":::
   10. In the **Object Editor** dialog of the StateSys instance, select **Save Object**.
   11. Close Wbemtest.
   12. Use Configuration Manager Service Manager to stop and then restart the SMS_STATE_SYSTEM component.

       After the SMS_STATE_SYSTEM component is restarted, the new settings are logged in *StateSys.log*, as follows.

       ```output
       08-24-2021 21:24:16.574    SMS_STATE_SYSTEM    19380 (0X4BB4)    USING THE FOLLOWING CONFIGURATION PROPERTIES FROM THE SITEF CONTROL FILE:
       08-24-2021 21:24:16.575    SMS_STATE_SYSTEM    19380 (0X4BB4)      SITE CODE                              CB1
       08-24-2021 21:24:16.575    SMS_STATE_SYSTEM    19380 (0X4BB4)      PARENT SITE CODE
       08-24-2021 21:24:16.576    SMS_STATE_SYSTEM    19380 (0X4BB4)      LOADER THREADS                         16
       08-24-2021 21:24:16.576    SMS_STATE_SYSTEM    19380 (0X4BB4)      INBOX POLLING INTERVAL (SECS)          900
       08-24-2021 21:24:16.577    SMS_STATE_SYSTEM    19380 (0X4BB4)      LOADER CHUNK SIZE (KB)                 256
       08-24-2021 21:24:16.578    SMS_STATE_SYSTEM    19380 (0X4BB4)      MAX CHUNKS FETCHED                     100
       08-24-2021 21:24:16.578    SMS_STATE_SYSTEM    19380 (0X4BB4)      VERBOSE LOGGING                        NO
       08-24-2021 21:24:16.579    SMS_STATE_SYSTEM    19380 (0X4BB4)      MIN RESYNC PERIOD (HOURS)              72
       08-24-2021 21:24:16.579    SMS_STATE_SYSTEM    19380 (0X4BB4)      RESYNC CHECK INTERVAL (MIN)            15
       08-24-2021 21:24:16.580    SMS_STATE_SYSTEM    19380 (0X4BB4)      MIN MISSING MESSAGE AGE (MIN)          10880
       08-24-2021 21:24:16.581    SMS_STATE_SYSTEM    19380 (0X4BB4)      HEARTBEAT MESSAGE INTERVAL (MIN)       60
       08-24-2021 21:24:16.581    SMS_STATE_SYSTEM    19380 (0X4BB4)    === STATESYS HAS BEEN SUCCESSFULLY INITIALIZED. ===
       ```

   13. Monitor the processing rate improvement through performance counters and SQL Server CPU load. If the CPU load continues to exceed 80 percent, consider reducing the Loader Threads value to avoid saturating other Configuration Manager activities. Conversely, if you see an increase in the processing speed at almost no CPU cost, increase the number of threads.

## More information

Microsoft Premier Services provides the following proactive delivery:

- [On-demand Assessment for Configuration Manager](/services-hub/health/getting-started-sccm)

Contact the Customer Success Account Manager (CSAM) for your Premier Support contract to plan these engagements.
