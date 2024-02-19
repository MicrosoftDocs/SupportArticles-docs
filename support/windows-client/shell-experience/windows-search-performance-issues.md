---
title: Troubleshoot Windows Search performance
description: Provides guidelines for troubleshooting poor Windows Search performance.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: winciccore, kaushika
ms.custom: sap:cortana-and-search, csstroubleshoot
adobe-target: true
---
# Troubleshoot Windows Search performance

> [!div class="nextstepaction"]
> <a href="https://vsa.services.microsoft.com/v1.0/?partnerId=7d74cf73-5217-4008-833f-87a1a278f2cb&flowId=DMC&initialQuery=31806433" target='_blank'>Try our Virtual Agent</a> - It can help you quickly identify and fix common Windows Search issues.

This article provides guidelines for troubleshooting poor Windows Search performance.

_Applies to:_ &nbsp; Windows 10 – all editions  
_Original KB number:_ &nbsp; 4558579

## Summary

This article discusses common performance issues that affect Windows Search and Search indexing.

If you observe general poor performance when you search or when Windows builds a search index, go to [Tune the Indexer performance](#tune-the-indexer-performance).

If you observe specific error messages, go to [Troubleshoot Search errors](#troubleshoot-search-errors).

## More information

### Tune the Indexer performance

The primary factors that affect indexing performance are the number of items indexed and the overall size of the index. These factors are related but separate.

#### Number of items indexed

On a typical user's computer, the Indexer indexes fewer than 30,000 items. On a power user's computer, the Indexer might index up to 300,000 items. If the Indexer indexes more than 400,000 items, you may begin to see performance issues. For more information, go to [Size of the index database](#size-of-the-index-database).

The Indexer can index up to 1 million items. If the Indexer tries to index beyond that limit, it may fail or cause resource problems on the computer (such as high usage of CPU, memory, or disk space).

> [!NOTE]
> By default, the Indexer indexes any Outlook mailboxes on the computer. If a mailbox contains more than 6 million items, the performance of the Indexer may degrade. For more information, go to the "Change Outlook settings" section.

To check the number of indexed items, select **Settings** > **Search** > **Searching Windows**, and then check the value of **Indexed items**.

:::image type="content" source="media/windows-search-performance-issues/indexing-status.png" alt-text="Screenshot of the Indexing Status value in the Searching Windows page of Settings.":::

#### Size of the index database

As the number of indexed items grows beyond 400,000, the index database grows considerably regardless of the size of those items. The size of the items also affects database size. A database that contains either a few large files or a large number of smaller files can affect performance. Both factors together can compound the problem. The Indexer tries to compress the index data. However, this approach becomes less effective as the index database grows.

> [!IMPORTANT]
> To check the size of the index database, use the **Size on disk** property of the Windows.edb file instead of relying on the **Size** property or the file size that's listed in Explorer. Because of the compression algorithms that the Indexer uses on sparse ESE and NTFS files, the value that's listed in Explorer may not be accurate. Additionally, this **Size** value might include space that was used by or allocated to the file in the past, instead of using the current size.

By default, Windows.edb is located in the C:\ProgramData\Microsoft\Search\Data\Applications\Windows folder. To check the size of the file, follow these steps:

1. Right-click Windows.edb, and select **Properties**.
2. Check the **Size on disk** value. This property reflects the actual disk space that the database uses.

    :::image type="content" source="media/windows-search-performance-issues/disk-size.png" alt-text="Screenshot of the Size on disk property of the Windows.edb file.":::

#### Tuning methods

You can use any of several approaches to improve the performance of Search and the Search Indexer.

> [!IMPORTANT]
> To make sure that the index reflects your changes, select **Settings** > **Search** > **Searching Windows >** **Advanced Search Indexer Settings** > **Advanced** > **Rebuild**.

Let the Indexer run for up to 24 hours to rebuild the index database.

##### Exclude folders  

You can use this approach to reduce the number of items that are indexed and to reduce the size of the index database. To exclude whole folders from the index, select **Settings** > **Search** > **Searching Windows** > **Add an excluded folder**. And then select a folder to exclude.

For a more granular method to include or exclude items, open **Searching Windows**, and select **Advanced Search Indexer Settings**. In **Indexing Options**, select **Modify**, and then select or deselect locations to index.

##### Change how the Indexer treats specific file types  

To control how the indexer treats specific file types, open **Indexing Options**, and select **Advanced** > **File Types**. You can change how the Indexer treats specific file types (identified by file extension) or add and configure new file types.

##### Defragment the index database  

You can use this approach to reclaim empty space within the index database. Open an administrative Command Prompt window, and then run the following commands in the given order:

```console
Sc config wsearch start=disabled
Net stop wsearch
EsentUtl.exe /d %AllUsersProfile%\Microsoft\Search\Data\Applications\Windows\Windows.edb
Sc config wsearch start=delayed-auto
Net start wsearch
```

For more information about how to defragment the index database, see the following Knowledge Base article:

 [2952967](https://support.microsoft.com/help/2952967/windows-edb-bets-big-when-a-pst-file-is-indexed-in-windows-10-8-1-8)  Windows.edb larger than expected when a PST file is indexed in Windows

##### Change Outlook settings

To help reduce the content of an Outlook mailbox, you can change the synchronization window to a shorter time interval than the default interval of one year. For more information, see the following article:

 [3115009](https://support.microsoft.com/help/3115009) Update allows administrators to set additional default mail and calendar synchronization windows for new Exchange accounts in Outlook 2016

### Troubleshoot Search errors

If the Indexer successfully builds the index database, you see the message **Indexing complete** on the Windows Search settings page and in **Indexing Options**.

:::image type="content" source="media/windows-search-performance-issues/indexing-complete.png" alt-text="Screenshot of the Indexing complete message in the Indexing Options dialog.":::

If a different message appears, see the following table for more information about the message and how to respond.

| **Status message**| **Explanation**| **Possible actions** |
|---|---|---|
|Indexing complete|The Indexer is running as usual, and has finished indexing.|Indexing should be complete, and all results available. If you're still missing files, make sure that the correct folders are selected to search. To see a detailed list of the locations that are indexed, open **Searching Windows**, and select **Advanced Search Indexer Settings**. In **Indexing Options**, select **Modify**.|
|Indexing in progress. Search results might not be complete during this time.|The Indexer has found new files on the system and is adding them to the index. Depending on the number of files that have recently changed, it could take a few hours|Leave the computer turned on and connected to power (if applicable) for a few hours to let indexing finish.|
|Indexing speed is reduced because of user activity.|The Indexer is adding new items to be searched, but has slowed its progress because the user is interacting with the device.|The indexing process will complete slowly. Wait a few hours, or leave the device unattended and connected to a power source.|
|Indexing is waiting for computer to become idle.|The Indexer has detected items that have to be indexed, but the device is too busy for the indexing process to continue.|Find out what is causing device to be busy. If the disk or CPU use is high, the indexer stops running to maximize the resources for foreground activities.|
|Indexing is paused to conserve battery power.|The Indexer has stopped adding new items to the index because of low battery power. Search results may not be complete.|Connect the device to power, and charge the battery. After the battery has sufficiently charged, indexing resumes.|
|Your group policy is set to pause indexing while on battery power.|Your IT department has configured the Indexer pause while the device uses battery power.|To finish indexing, connect the device to power. Contact your IT team if you want to change the policy.|
|Indexing is paused.|The Indexer has been paused from the Windows Search settings page.|Indexing resumes 15 minutes after it pauses. To resume indexing more quickly, restart the Windows Search service (`wsearch`). You can do it by using the **Services** tab of Task Manager or by using Services.msc.|
|Indexing is not running.|Indexer hasn't started or is disabled.|If you have upgraded Windows on the device, wait five minutes for the Windows Search service to start. The service automatically pauses during an upgrade. The service should have the following configuration:  <br/>- **Status**: Running<br/>- **Startup Type**: Automatic (Delayed Start) <br/><br/>Otherwise, make sure that the Windows Search service (`wsearch`) is configured correctly. To do this, open Services.msc, and scroll to the Windows Search service. To change the Windows Search service settings, right-click **Windows Search**, and then select **Properties**. Some anti-virus programs and "Optimize your PC" applications disable the Windows Search service. We recommend that you don't run such applications if you want to use Search. Or, check the status of the service after you run the applications.|
|Insufficient memory to continue indexing. Search results might not be complete.|The Indexer detected a low memory state and stopped to preserve the user experience.|Use Task Manager to discover applications that use a large amount of memory. If possible, close those applications. Install more memory in the device.|
|Insufficient disk space to continue indexing. Search results might not be complete.|There's not enough space on the disk to continue indexing. The Indexer stops before it fills the entire disk. The index is generally 10 percent of the size of the content that is being indexed.|Make sure that there's more than 1 GB of free space on the disk. Reduce the size of the database index, as described in this article.|
|Waiting the receive indexing status...|The Indexer hasn't replied to the status query.|Wait for the Indexer to reply. It should take about one minute. In Task manager, confirm that the searchindexer.exe process is running.|
|Indexing is starting up.|The Indexer is starting.|Wait for the Indexer to start. It should take about one minute.|
|Indexing is shutting down.|The Indexer has received the signal to shut down either because the operating system is shutting down or because the user requested it.|Make sure that the user hasn't manually stopped the service. Check the status of the Windows Search Service (`wsearch`) in services.msc.|
|Index is performing maintenance. Please wait.|The Indexer is trying to recover and optimize the index database. It could occur because lots of content was added recently, or because the Indexer encountered a problem while writing out data to the hard disk.|Wait a few minutes for the Indexer to finish. It can take up to 30 minutes on a slow computer. Make sure that the system hard disk isn't generating failures. Usually, Indexer writing issues precede drive failure. Make sure that the user has backed up personal data.|
|Indexing is paused by an external application.|An application on the computer requested the Indexer to stop. It commonly occurs during Game mode or during an upgrade.|Make sure that the device isn't in Game mode. Use services.msc or Task Manager to restart the Windows Search service. It resumes indexing until the next time that an external app requests a pause.|
|The status message is missing, and the entire page is greyed out.|Something has corrupted the Indexer registry keys or database. The service can no longer start or report status.|Delete the contents of C:\ProgramData\Microsoft\Search\Data.Refresh the operating system.|
