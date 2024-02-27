---
title: Outlook may be slower to resolve names
description: You may experience delays in resolving recipient names if Outlook is not configured to download and use a local copy of the Offline Address Book (OAB) files.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: gregmans
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
  - Microsoft Office Outlook 2003
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# Outlook may be slower to resolve names because there are no .oab files locally

_Original KB number:_ &nbsp; 2746896

## Symptoms

In Microsoft Outlook, when you attempt to resolve the email address for someone in your Microsoft Exchange organization, the process may take longer than expected. Or, if you are working offline, you are unable to resolve any names for people in your Exchange organization.

## Cause

This problem occurs if Outlook is not using local Offline Address Book (OAB) files to resolve names. Instead, Outlook is performing name resolution using the online Global Address List (GAL). If you are in Online mode, this is to be expected. However, if you are in Cached mode, the default configuration is to always download the OAB locally and use it for name resolution.

## Resolution

To resolve this problem, download the Offline Address Book using the following steps (depending on the Outlook version).

- Outlook 2010 or later versions
  1. Select the **Send/Receive** tab on the Ribbon.
  2. Select **Send/Receive Groups** and then select **Download Address Book**.
  3. Select **OK**.

- Outlook 2007 or Outlook 2003
  1. On the **Tools** menu, point to **Send/Receive**, and then select **Download Address Book**.
  2. Select **OK**.

See the following article if you are unable to download the OAB.

[HTTP version of the Outlook Offline Address Book (OAB) does not download](https://support.microsoft.com/help/2619347)

> [!NOTE]
> If the OAB does not automatically download and you have to manually download the OAB each time (using the above steps), check for the existence of the DownloadOAB value in the registry. The following article provides complete details on this registry value.
>
> [Administering the offline address book in Outlook](https://support.microsoft.com/help/841273)

## More information

Use the following steps to determine if you are using the online GAL for name resolution instead of local `.oab` files.

1. Start Outlook.
2. Select the **Address Book** icon.
3. In the **Address Book** dialog box, right-click drop-down under **Address Book** and select **Properties** (The screenshot for this step is listed below).

   :::image type="content" source="media/outlook-may-be-slower-to-resolve-names/properties-in-address-book.png" alt-text="Screenshot of the Properties option of Address Book.":::

4. In the **Global Address List** dialog box, examine the text in **The current server is:** box (The screenshot for this step is listed below).

    :::image type="content" source="media/outlook-may-be-slower-to-resolve-names/general-tab-on-global-address-list.png" alt-text="Screenshot of the Global Address List dialog box.":::

   - If you see a local file path, as shown in the above figure, you are downloading the `.oab` files locally.
   - If you see the name of a server, you are currently not downloading `.oab` files locally.

The location of the  files on your computer varies according to your Outlook version and the version of Windows on which Outlook is installed. The default location for `.oab` files is provided below.

- Outlook 2010 and later versions
  - Windows 10, Windows 8.1, Windows 8, or Windows 7

    %userprofile%\AppData\Local\Microsoft\Outlook\Offline Address Books\<*guid*>

  - Windows XP (Outlook 2010 only)

    %userprofile%\Local Settings\application data\Microsoft\Outlook\Offline Address Books\<*guid*>

    > [!NOTE]
    > <*guid*> in the above folder path varies between Exchange organizations. The folder name, for example, will look like *0a1f33a0-dbeb-4007-92e3-57926c848000*

- Outlook 2003 and Outlook 2007
  - Windows 10, Windows 8.1, Windows 8 or Windows 7

    %userprofile%\AppData\Local\Microsoft\Outlook

  - Windows XP

    %userprofile%\LocalSettings\application data\Microsoft\Outlook
