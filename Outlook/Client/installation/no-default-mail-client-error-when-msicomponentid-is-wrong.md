---
title: No default mail client error with wrong MSIComponentID
description: This article provides a resolution for the No default mail client error that occurs when the MSIComponentID registry value is not correct for Outlook 2013.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: robevans, gregmans
appliesto: 
  - Outlook 2013
search.appverid: MET150
ms.date: 01/30/2024
---
# No default mail client error when MSIComponentID registry value is incorrect for Outlook 2013

_Original KB number:_ &nbsp; 2991457

## Symptoms

Consider the following scenario. A user is running Office 2013 with Outlook 2013 as their default mail client:

- In Microsoft Word a user attempts to share a document as an attachment by email or when a user attempts a mail merge and receives the errors:

    > Either there is no default mail client or the current mail client cannot fulfill the messaging request. Please run Microsoft Outlook and set it as the default mail client.
    >
    > Word couldn't send mail because of MAPI failure: "Unspecified error".

- In Microsoft PowerPoint a user attempts to share a presentation as an attachment by email and receives the errors:

    > Either there is no default mail client or the current mail client cannot fulfill the messaging request. Please run Microsoft Outlook and set it as the default mail client.
    >
    > There was a general failure with the e-mail system and this action could not be completed.

- In Microsoft Excel a user attempts to share a spreadsheet as an attachment by email and receives the errors

    > Either there is no default mail client or the current mail client cannot fulfill the messaging request. Please run Microsoft Outlook and set it as the default mail client.
    >
    > General mail failure. Quit Microsoft Excel, restart the mail system, and try again.

- A user in Windows Explorer attempts to send a file to a mail recipient and receives the error:

  > Either there is no default mail client or the current mail client cannot fulfill the messaging request. Please run Microsoft Outlook and set it as the default mail client.

## Cause

This problem occurs because the `MSIComponentID` is set to an improper GUID for Outlook 2013. The correct GUID for Outlook 2013 is {6DB1921F-8B40-4406-A18B-E906DBEEF0C9}.

## Resolution

A repair of Microsoft Office fixes the issue. To repair Microsoft Office, use the steps below.

1. Launch Control Panel.  

    **In Windows 8 and Windows 8.1**

    Select Windows Logo key, type *Control Panel* in the **Start** screen, and then select **Control Panel** in the search results.

    **In Windows 7 and Windows Vista**

    Select **Start**, type *Control Panel* in the **Start Search** box, and then press Enter.

2. Select **Program and Features**.
3. Select Microsoft Office 2013, select either **Quick Repair** or **Online Repair**.

## More information

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

The `MSIComponentID` can be found in the following registry data.

Key: HKEY_LOCAL_MACHINE\SOFTWARE\Clients\Mail\Microsoft Outlook  
Reg_SZ: MSIComponentID  
Value: {6DB1921F-8B40-4406-A18B-E906DBEEF0C9}

For more information on how to repair Microsoft Office, see [Repair an Office application](https://support.microsoft.com/office/repair-an-office-application-7821d4b6-7c1d-4205-aa0e-a6b40c5bb88b).
