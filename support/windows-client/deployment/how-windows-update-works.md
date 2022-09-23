---
title: How Windows Update works
description: Learn about the process Windows Update uses to download and install updates on a Windows client device.
ms.date: 08/18/2022
ms.prod: windows-client
author: aczechowski
ms.author: aaroncz
manager: dcscontentpm
ms.reviewer: dougeby
ms.collection:
- M365-modern-desktop
- highpri
ms.topic: troubleshooting
ms.custom: sap:servicing, csstroubleshoot
ms.technology: windows-client-deployment
audience: itpro
localization_priority: medium
---

# How Windows Update works

_Applies to:_ &nbsp; Windows 10, Windows 11  

## Four core areas of functionality

The Windows Update workflow has four core areas of functionality:

- Scan
- Download
- Install
- Commit

### Scan

1. Orchestrator schedules the scan.
2. Orchestrator verifies admin approvals and policies for download.

### Download

1. Orchestrator starts downloads.
2. Windows Update downloads manifest files and provides them to the arbiter.
3. The arbiter evaluates the manifest and tells the Windows Update client to download files.
4. Windows Update client downloads files in a temporary folder.
5. The arbiter stages the downloaded files.

### Install

1. Orchestrator starts the installation.
2. The arbiter calls the installer to install the package.

### Commit

1. Orchestrator starts a restart.
2. The arbiter finalizes before the restart.

## How updating works

During the updating process, the Windows Update Orchestrator operates in the background to scan, download, and install updates. It does these actions automatically, according to your settings, and silently so that doesn't disrupt your computer usage.

## Scanning updates

:::image type="content" source="media/how-windows-update-works/update-scan-step.png" alt-text="Windows Update scanning step." border="false":::

The Windows Update Orchestrator on your PC checks the Microsoft Update server or your WSUS endpoint for new updates at random intervals. The randomization ensures that the Windows Update server isn't overloaded with requests all at the same time. The Update Orchestrator searches only for updates that have been added since the last time updates were searched, allowing it to find updates quickly and efficiently.  

When checking for updates, the Windows Update Orchestrator evaluates whether the update is appropriate for your device. It uses guidelines defined by the publisher of the update, for example, Microsoft Office including enterprise group policies.

Make sure you're familiar with the following terminology related to Windows Update scan:

|Term|Definition|
|----|----------|
|Update|We use this term to mean several different things, but in this context it's the actual updated code or change.|
|Bundle update|An update that contains 1-N child updates; doesn't contain payload itself.|
|Child update|Leaf update that's bundled by another update; contains payload.|
|Detector update|A special "update" that contains "IsInstalled" applicability rule only and no payload. Used for prereq evaluation.|
|Category update|A special "detectoid" that has an **IsInstalled** rule that is always true. Used for grouping updates and to allow the device to filter updates. |
|Full scan|Scan with empty datastore.|
|Delta scan|Scan with updates from previous scan already cached in datastore.|
|Online scan|Scan that uses the network and to check an update server. |
|Offline scan|Scan that doesn't use the network and instead checks the local datastore. Only useful if online scan has been performed before. |
|CatScan|Category scan where caller can specify a **categoryId** to get updates published under that **categoryId**.|
|AppCatScan|Category scan where caller can specify an **AppCategoryId** to get apps published under that **appCategoryId**.|
|Software sync|Part of the scan that only checks for software updates (both the apps and the operating system).|  
|Driver sync|Part of the scan that checks driver updates only. This sync is optional and runs after the software sync.|
|ProductSync|A sync based on attributes, in which the client provides a list of device, product, and caller attributes ahead of time to allow service to check applicability in the cloud. |

### How Windows Update scanning works

Windows Update does the following actions when it runs a scan.

#### Starts the scan for updates

When users start scanning in Windows Update through the Settings panel, the following occurs:  

- The scan first generates a "ComApi" message. The caller (Microsoft Defender Antivirus) tells the Windows Update engine to scan for updates.
- "Agent" messages: queueing the scan, then actually starting the work:
  - Updates are identified by the different IDs ("ID = 10", "ID = 11") and from the different thread ID numbers.
  - Windows Update uses the thread ID filtering to concentrate on one particular task.

    :::image type="content" source="media/how-windows-update-works/update-scan-log-thread-id-filtering.png" alt-text="Screenshot of Windows Update scan log which is filtered by thread ID." border="false":::

#### Proxy behavior

For Windows Update (WU) scans URLs that are used for update detection ([MS-WUSP]: SimpleAuth Web Service | Microsoft Learn, [MS-WUSP]: Client Web Service | Microsoft Learn):

- System proxy is attempted (set using the `netsh` command).
- If WUA fails to reach the service due to a certain proxy, service, or authentication error code, then user proxy is attempted (generally it's the logged-in user).

    > [!Note]
    > For intranet WSUS update service URLs, we provide an option via Windows Update policy to select the proxy behavior.

For Windows Update URLs that _aren't_ used for update detection, such as for download or reporting:

- User proxy is attempted.
- If WUA fails to reach the service due to a certain proxy, service, or authentication error code, then the system proxy is attempted.

#### Identifies service IDs

- Service IDs indicate which update source is being scanned.

- The Windows Update engine treats every service as a separate entity, even though multiple services may contain the same updates.
:::image type="content" source="media/how-windows-update-works/update-scan-log-multiple-services-same-updates.png" alt-text="Screenshot of Windows Update scan log, which shows multiple services may contain the same updates." border="false":::
- Common service IDs

   > [!IMPORTANT]
   > ServiceId here identifies a client abstraction, not any specific service in the cloud. No assumption should be made of which server a serviceId is pointing to. It's totally controlled by responses from the Service Locator Service.

|Service|ServiceId|
|-------|---------|
|Unspecified / Default|Windows Update, Microsoft Update, or WSUS <br>00000000-0000-0000-0000-000000000000 |
|Windows Update|9482F4B4-E343-43B6-B170-9A65BC822C77|
|Microsoft Update|7971f918-a847-4430-9279-4a52d1efe18d|
|Store|855E8A7C-ECB4-4CA3-B045-1DFA50104289|
|OS Flighting|8B24B027-1DEE-BABB-9A95-3517DFB9C552|
|WSUS or Configuration Manager|Via ServerSelection::ssManagedServer <br>3DA21691-E39D-4da6-8A4B-B43877BCB1B7 |
|Offline scan service|Via IUpdateServiceManager::AddScanPackageService|

#### Finds network faults

Common update failure is caused due to network issues. To find the root of the issue:  

- Look for "ProtocolTalker" messages to see client-server sync network traffic.
- "SOAP faults" can be either client- or server-side issues; read the message.
- The Windows Update client uses the Service Locator Service to discover the configurations and endpoints of Microsoft network update sources: Windows update, Microsoft Update, or Flighting.

   > [!NOTE]
   > If the search is against WSUS or Configuration Manager, you can ignore warning messages for the Service Locator Service.

- On sites that only use WSUS or Configuration Manager, the Service Locator Service might be blocked at the firewall. In this case the request will fail, and though the service can't scan against Windows Update or Microsoft Update, it can still scan against WSUS or Configuration Manager, since it's locally configured.

    :::image type="content" source="media/how-windows-update-works/update-scan-log-existing-configuration.png" alt-text="Screenshot of Windows Update scan log, which shows it can still scan against existing configuration." border="false":::

## Downloading updates

:::image type="content" source="media/how-windows-update-works/update-download-step.png" alt-text="Screenshot of Windows Update download step." border="false":::

Once the Windows Update Orchestrator determines which updates apply to your computer, it will begin downloading the updates, if you've selected the option to automatically download updates. It does operation in the background without interrupting your normal use of the device.  

To ensure that your other downloads aren't affected or slowed down because updates are downloading, Windows Update uses Delivery Optimization, which downloads updates and reduces bandwidth consumption.

For more information, see [Configure Delivery Optimization for Windows 10 updates](/windows/deployment/do/waas-delivery-optimization).

## Installing updates

:::image type="content" source="media/how-windows-update-works/update-install-step.png" alt-text="Screenshot of Windows Update install step." border="false":::

When an update is applicable, the "Arbiter" and metadata are downloaded. Depending on your Windows Update settings, when downloading is complete, the Arbiter will gather details from the device, and compare that with the downloaded metadata to create an "action list".  

The action list describes all the files needed from Windows Update, and what the installation agent (such as CBS or Setup) should do with them. The action list is provided to the installation agent along with the payload to begin the installation.

## Committing updates

:::image type="content" source="media/how-windows-update-works/update-commit-step.png" alt-text="Screenshot of Windows Update commit step." border="false":::

When the option to automatically install updates is configured, the Windows Update Orchestrator, in most cases, automatically restarts the device for you after installing the updates. It has to restart the device because it might be insecure, or not fully updated, until it restarts. You can use Group Policy settings, mobile device management (MDM), or the registry (not recommended) to configure when devices will restart after a Windows 10 update is installed.  

For more information, see [Manage device restarts after updates](/windows/deployment/update/waas-restart).
