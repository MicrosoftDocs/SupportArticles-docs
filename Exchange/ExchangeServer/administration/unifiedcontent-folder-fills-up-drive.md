---
title: Exchange UnifiedContent folder fills up the drive
description: Resolves an issue in which the Exchange Server UnifiedContent folder fills up the drive.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow\Need help with Transport Logs
  - CI 163530
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: mialin, arindam, batre, meerak, v-trisshores
appliesto:
  - Exchange Server 2019
  - Exchange Server 2016
  - Exchange Server 2013
search.appverid: MET150
ms.date: 08/28/2024
---

# Exchange UnifiedContent folder fills up the drive

## Symptoms

You receive low disk space alerts for the drive on which Microsoft Exchange Server is installed, and files and apps on that drive take longer to open. When you check the size of the *%ExchangeInstallPath%\TransportRoles\data\Temp\UnifiedContent* folder, you find that it uses up most of the drive space.

## Cause

Exchange Server creates and manages temporary files in the *UnifiedContent* folder to assist antimalware scanning. Although the Microsoft Exchange Health Manager service runs a scheduled cleanup task on that folder, either of the following scenarios can cause the cleanup to fail:

- You didn't install Exchange Server in the default location (*C:\Program Files\Microsoft\Exchange Server\V15*). Therefore, the *UnifiedContent* folder doesn't exist at its default location (*C:\Program Files\Microsoft\Exchange Server\V15\TransportRoles\data\Temp\UnifiedContent*).

- You changed the default location of the *UnifiedContent* folder by directly editing `TemporaryStoragePath` in the *%ExchangeInstallPath%\Bin\EdgeTransport.exe.config* configuration file or by running [Move-TransportDatabase.ps1](/exchange/mail-flow/queues/relocate-queue-database#use-the-command-prompt-to-move-the-existing-queue-database-and-transaction-logs-to-a-new-location).

Cleanup fails if Exchange Health Manager can't locate the *UnifiedContent* folder. The *UnifiedContent* folder location is specified by `CleanupFolderResponderFolderPaths` in the *%ExchangeInstallPath%\Bin\Monitoring\Config\Antimalware.xml* settings file. Regardless of the actual Exchange Server installation path, `CleanupFolderResponderFolderPaths` contains the default *UnifiedContent* folder installation path (*C:\Program Files\Microsoft\Exchange Server\V15\TransportRoles\data\Temp\UnifiedContent*).

## Resolution

Use either of the following resolutions to update the *UnifiedContent* folder path in *Antimalware.xml*.

> [!IMPORTANT]
> If an Exchange Server cumulative update overwrites your changes to *Antimalware.xml*, rerun your selected resolution after the update finishes.

### Resolution 1

On each server that runs Exchange Server in your organization, follow these steps to point Exchange Health Manager to the *UnifiedContent* folder:

> [!NOTE]
> If you back up the *Antimalware.xml* settings file, store the backup file in a different folder.

1. Get the *UnifiedContent* folder path. To do this, open the *%ExchangeInstallPath%\TransportRoles\data\Temp\UnifiedContent* folder in File Explorer, and then copy the expanded folder path.

2. Open the *%ExchangeInstallPath%\Bin\Monitoring\Config\Antimalware.xml* settings file.

3. In *Antimalware.xml*, replace the path, *C:\Program Files\Microsoft\Exchange Server\V15\TransportRoles\data\Temp\UnifiedContent* in `CleanupFolderResponderFolderPaths`, with the expanded folder path that you obtained in step 1.

   For example, if the existing `CleanupFolderResponderFolderPaths` value is *D:\ExchangeTemp\TransportCts\UnifiedContent;C:\Windows\Temp\UnifiedContent;C:\Program Files\Microsoft\Exchange Server\V15\TransportRoles\data\Temp\UnifiedContent*, change that value to *D:\ExchangeTemp\TransportCts\UnifiedContent;C:\Windows\Temp\UnifiedContent;\<actual UnifiedContent folder path\>*.

4. Save your changes to *Antimalware.xml*, and then restart the Exchange Health Manager service. The service name is MSExchangeHM.

Exchange Health Manager cleans the *UnifiedContent* folder during the next maintenance cycle. By default, maintenance cycles run every four hours.

### Resolution 2

Use the [SetUnifiedContentPath](https://aka.ms/SetUnifiedContentPath) PowerShell script. The script sets the `CleanupFolderResponderFolderPaths` value in the `AntiMalware.xml` file. Exchange Health Manager uses this value to locate the *UnifiedContent* folder to clean up.
