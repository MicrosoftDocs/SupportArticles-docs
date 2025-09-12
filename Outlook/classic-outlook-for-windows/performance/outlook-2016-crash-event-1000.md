---
title: Outlook 2016 crashes and event 1000 after you install a language pack
description: Describes an issue that causes Outlook 2016 to crash when you start it. Occurs if you apply Outlook 2016 updates before you install the language pack. Workarounds are provided.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Product Stability, startup or Shutdown and perform\Crash using Outlook
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: tasitae
appliesto: 
  - Outlook 2016
search.appverid: MET150
ms.date: 01/30/2024
---
# Outlook 2016 crashes after you install a language pack and use that language

_Original KB number:_ &nbsp;3180987

## Symptoms

After you install a Microsoft Office 2016 language pack and then set Microsoft Office to use that language, Outlook 2016 crashes when you start it. In this situation, you may find one of the following crash signatures in the Application log for Event ID 1000:

| Application name| Module name| Offset |
|---|---|---|
|Outlook.exe|Outlook.exe|00026083|
|Outlook.exe|Outlook.exe|000260ad|
|Outlook.exe|Outlook.exe|000260ab|
|Outlook.exe|Outlook.exe|00026088|
|Outlook.exe|Outlook.exe|0002605a|

## Cause

This issue may occur if you install the language pack after you install Outlook 2016 updates.

## Workaround 1: Install a recent Outlook update if already installed the language pack

After you've installed the language pack, to work around this issue, install a recent Outlook update through Windows Update, or manually install a recent Outlook update.

### Method 1: Run Windows Update

#### Windows 10

1. Click **Start** > **Settings**.
2. Click **Advanced options**.
3. Select the **Give me updates for other Microsoft products when I update Windows** option.
4. Click the Back button.
5. Click **Check for updates**, and then install the updates that are found.

#### Windows 8.1 or Windows 8

1. In Control Panel, open the **Windows Update** item.
2. Click **Change settings**.
3. Under **Microsoft Update**, select the **Give me updates for other Microsoft products when I update Windows** option, and then click **OK**.
    > [!NOTE]
    > If this option isn't available, follow these steps:
    >
    > 1. Click **Cancel** to go back to Windows Update.
    > 1. Next to **Get updates for other Microsoft Products**, click **Find out more**.
    > 1. Agree to the terms of use, and then click **Install**.
    > 1. When installation is complete, click **Change settings in Windows update**, and then select the **Give me updates for other Microsoft products when I update Windows** option.
    > 1. Click **OK**.

4. Click **Check for updates**, and then install the updates that are found.

### Method 2: Manually install a recent Outlook update

1. Download a recent update for Outlook 2016. To determine the latest update for Outlook, see [Outlook Updates](https://support.office.com/article/outlook-updates-472c2322-23a4-4014-8f02-bbc09ad62213).
2. Install the Outlook update.

## Workaround 2: Prevent this issue if not yet installed the language pack

If you haven't yet installed the language pack, you can prevent this issue by adding a recent update executable for Outlook 2016 to the Updates folder of the language pack before you install it. To do this, follow these steps:

1. Download a recent update for Outlook 2016. To determine the latest update for Outlook, see [Outlook Updates](https://support.office.com/article/outlook-updates-472c2322-23a4-4014-8f02-bbc09ad62213).
    > [!NOTE]
    > The update must be of the same bitness as your Office installation.
2. Copy the update you downloaded to the Updates folder in the installation source of the language pack.
3. Install the language pack.

> [!NOTE]
> If you have already installed the language pack, uninstall it, and then follow these steps to install it again.
