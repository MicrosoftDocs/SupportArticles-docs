---
title: Troubleshoot state message backlog
description: Describes how to troubleshoot state messaging performance issues in Configuration Manager.
ms.date: 09/02/2021
ms.prod-support-area-path: 
ms.reviewer: jarrettr
author: helenclu
ms.author: luche
---
# Troubleshoot state message processing performance issues

State messaging is one of the most important reporting mechanisms in Configuration Manager. It's responsible for application and update deployment statistics, and many other flows.

In this article, we focus on the SMS_STATE_SYSTEM component, which processes the incoming state messages and updates the database.

For more information about the state messaging system, see [Description of state messaging in Configuration Manager](state-messaging-description.md).

## Symptoms

A Configuration Manager administrator notices a significant delay on reporting Software Update compliance, and application deployment. In this situation, there are a large number of files under the `<Configuration Manager Installation Directory>\Inboxes\auth\statesys.box\incoming` folder. For example, there are millions of files.

Here's an example output when filtering the InboxMon.log file by `StateSys`:

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

The number of files may continue to grow, or the rate of decrease isn't fast enough to process the files within a reasonable time frame. This issue may occur after a long server outage, or a large-scale deployment.

## Cause

The incoming files usually have an extension of SMX or SMW, and are plain text XML files. These files contain the client ID (known as SMS GUID), and payload. Usually, each file contains multiple messages, because a client batches the messages before sending them (the default is 15 minutes).

StateSys is designed to pick up files in batches, parse XML files, and update the database. When updating the database, it runs some SQL stored procedures and CLR assemblies provided by Configuration Manager. Therefore, it mainly depends on the SQL Server backend performance. When SQL Server is saturated with other tasks for a long time, it may cause status messages to accumulate.

At the same time, StateSys has little design to prevent it from catching up with a backlog of nearly millions of files:

1. Files are processed in alphabetical order, but not first in first out (FIFO). Since the management point generates random names for the files, new messages may be processed earlier than old messages. StateSys is resilient to this situation.
2. Each message contains a sequence number, StateSys maintains a list of missing ranges stored in the `SR_MissingRanges` table. When a missing range becomes older than two days (default), StateSys will issue a resynchronization for the client, causing it to send a large XML file that goes to the same queue as all other messages. When new status messages are always processed two days earlier than old messages, it may become a vicious circle for some clients, leading to frequent resynchronization.

## Resolution

To troubleshoot the performance issue, follow these steps:

1. Identify and eliminate the issue that causes the backlog.

   If it's caused by a massive deployment, disable the deployment temporarily, or reconsider the deployment strategy. For example, if you deploy a software update group of 1,000 updates, it may generate enforcement state messages for each update, each state (by default), each client, and the entire group, resulting in millions of state messages.

   If it's caused by a SQL Server performance issue, work with your database administrator to resolve the issue first.

   If there are a large number of files that can't be processed, investigate the root cause first.
2. Establish a Configuration Manager performance baseline to understand the normal processing rate of your environment. Particular performance counters for StateSys include "Message Records Processed/min" and "Message File Records PreProcessed/min", usually they average tens of thousands. If there's no file to be processed, both counters will fade to 0.

   :::image type="content" source="media\state-message-processing-performance\performance-counter.png" alt-text="Performance counters for StateSys":::

   If your normal processing rate isn't enough to handle the backlog, go to the next step.
3. Change the internal settings of the StateSys component.

   > [!WARNING]
   > Serious problems might occur if you change these settings incorrectly. Microsoft can't guarantee that these problems can be solved, and doesn't support this scenario. Modify the settings at your own risk. And it's recommended that you restore these settings after you resolve the backlog.

   You must have at least Configuration Manager infrastructure administrator permissions to modify these settings.

   1. Use the Windows Management Instrumentation Tester tool (Wbemtest) to connect to your SMS Provider. Select **Connect**, enter the site server under **Namespace**, and then select **Connect**. Enter `root\SMS\site_<site code>` for a local connection,  enter `\\MachineName\root\SMS\site_<site code>` for a remote connection.

      :::image type="content" source="media\state-message-processing-performance\connect-namespace.png" alt-text="Connect to your SMS Provider":::
   2. Select **Query**, enter the following query, and then select **Apply**. It returns the list of Configuration Manager sites that have the SMS_STATE_SYSTEM component installed.

      ```sql
      SELECT * FROM SMS_SCI_COMPONENT WHERE ITEMNAME = 'SMS_STATE_SYSTEM|SMS SITE SERVER'
      ```

      :::image type="content" source="media\state-message-processing-performance\query-result.png" alt-text="WMI query result":::
   3. Double-click the site for which you want to change settings, and then double-click **Props** from the list of properties of the site/StateSys instance.

      :::image type="content" source="media\state-message-processing-performance\statesys-property.png" alt-text="Double-click Props ":::
   4. Select **View Embedded** to see the list of embedded properties of this instance.

      :::image type="content" source="media\state-message-processing-performance\embedded-properties.png" alt-text="View embedded properties ":::
   5. Double-click each embedded property to check the property name and value. Look for the property with the name **Loader Threads**, and the value **4**.

       :::image type="content" source="media\state-message-processing-performance\loader-threads.png" alt-text="Loader Threads":::
   6. Double-click **Value**, increase it to **16**. Select **Save Property**, and then select **Save Object**.

       :::image type="content" source="media\state-message-processing-performance\increase-loader-threads.png" alt-text="Incease Loader Threads":::
   7. Look for another embedded property with the name **Min Missing Message Age**, and the value **2880** (minutes).

       :::image type="content" source="media\state-message-processing-performance\missing-message-age.png" alt-text="Minimum missing message age":::
   8. Double-click **Value**, increase it to **10,080** (seven days) to prevent unnecessary resynchronization. Select **Save Property**, and then select **Save Object**.
   9. In the **Property Editor** dialog of **Props**, select **Save Property**.

      :::image type="content" source="media\state-message-processing-performance\save-property.png" alt-text="Save property":::
   10. In the **Object Editor** dialog of the StateSys instance, select **Save Object**.
   11. Close Wbemtest.
   12. Use Configuration Manager Service Manager to stop and restart the SMS_STATE_SYSTEM component.

       When the SMS_STATE_SYSTEM component is restarted, the new settings are logged in StateSys.log:

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

   13. Monitor processing rate improvement through performance counters and SQL Server CPU load. If the CPU load continues to exceed 80%, consider reducing the Loader Threads value to avoid saturation of other Configuration Manager activities. Vice versa, if you see an increase in processing speed with almost no CPU cost, increase the number of threads.

## More information

Microsoft Premier Services provides the following proactive deliveries:

- [On-demand Assessment for Configuration Manager](/services-hub/health/getting-started-sccm)
- [Microsoft Endpoint Configuration Manager: Troubleshooting Infrastructure](https://datasheet.azureedge.net/offerings-datasheets/11228%2FEN.pdf)

Contact the Customer Success Account Manager (CSAM) for your Premier Support contract to plan these engagements.
