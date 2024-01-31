---
title: Error 403 when you access Windows Update
description: Provides a solution to an error 403 that occurs when you access Windows Update.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:servicing, csstroubleshoot
ms.subservice: deployment
---
# Error 403 (Access Denied/Forbidden) occurs when you connect to Windows Update

This article provides a solution to an error 403 that occurs when you access Windows Update.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 245142

## Symptoms

When you try to access the Windows Update website, you receive the following error message:

> Error 403: Access Denied/Forbidden

## Cause

This issue occurs for any of the following reasons:

- You're running personal firewall software or some other security, download assistant, or web accelerator software.
- The Windows Update site control is missing or is damaged on your computer.
- The Hosts file is damaged or contains incorrect information.
- There are missing or damaged Internet Explorer files that display the script on the page.

## Resolution

To resolve this issue, use one of the following procedures based on what's causing the issue. If you don't know what's causing the error message, use these resolutions in the order that they're listed. For example, if the first resolution doesn't solve the issue, continue to the next resolution.

### Disable security, download assistant, or web accelerator software

1. Microsoft has verified that the kinds of software programs in the following list contribute to **Unauthorized** or **Access Denied/Forbidden** errors. Disable any third-party software that fits one of the following descriptions:

   - Ad removal programs
   - Web accelerators
   - Download assistants
   - Security software
   - Antivirus software

2. Try to connect to the Windows Update site by going to Microsoft Update.

3. If you still can't connect, try the next resolution.

### Reset the Hosts file to the default

For information about how to reset the Hosts file to the default Hosts file, see [How can I reset the Hosts file back to the default?](https://support.microsoft.com/help/972034).

### Install a new scripting engine  

> [!NOTE]
> These steps only apply to computers that are running Windows XP or earlier versions of Windows.

1. Go to the [Microsoft Download Center](https://www.microsoft.com/download/en/search.aspx?q=windows%20script%205.7).
2. Click the Update symbol next to the update for your version of Windows.

    :::image type="icon" source="media/error-403-connect-to-windows-update/update-symbol.png":::

3. Click **Download** (on the right side of the page).
4. Click **Save to Disk**, and then save the file to the default location.
5. On your desktop, double-click the STE56en.exe icon (for Microsoft Windows 98, Microsoft Windows Millennium Edition, and Windows NT) or double-click the Scripten.exe icon (for Microsoft Windows 2000 and Windows XP).
6. After the installation is complete, you can remove STE56en.exe or Scripten.exe file from your Desktop. To do so, right-click the icon, and then click **Delete**.
7. Restart your computer, and then go to the Windows Update website.

> [!NOTE]
> Some Internet accelerators change the Hosts file. To resolve this issue, rename the file.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
