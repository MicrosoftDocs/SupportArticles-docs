---
title: Error_Message_0x8006ffff when accessing Dynamics 365
description: Error_Message_0x8006ffff occurs when you access Microsoft Dynamics 365 within the Add-ins area of Outlook.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# Issue when trying to access Microsoft Dynamics 365 within the Add-ins area of Outlook

This article provides a resolution to solve the **Error_Message_0x8006ffff** error that occurs when you try to access Microsoft Dynamics 365 within the Add-ins area of Microsoft Outlook.

_Applies to:_ &nbsp; December 2016 Service Pack for Microsoft Dynamics 365 (CRM 2016)  
_Original KB number:_ &nbsp; 3211586

## Symptoms

When attempting to access Microsoft Dynamics 365 within the Add-ins area of Outlook, you encounter one of the following issues:

- The following error occurs:

  > "We're sorry  
  Error_Message_0x8006ffff"

- The Add-ins area within Outlook does not appear.

## Cause

This Microsoft Dynamics 365 feature requires some Outlook updates. If the necessary updates are not installed, the option to access the Add-ins area will not appear or you encounter the error listed in the "Symptoms" section.

## Resolution

The required updates depend on the version of Office you have installed. There is a Windows Installer (MSI) based version of Office and a Click-to-Run (C2R) version of Office.  

### Click-to-Run (C2R) version of Office

The necessary updates are included in build 7466 or later. You can view the build number in Outlook by selecting the **File** menu and then selecting **Office Account**. If your build number is less than 7466, install the latest Office updates.

> [!IMPORTANT]
> If you are using Office 365 ProPlus and are configured to use the Deferred Channel for updates, you may not receive the latest available updates required to use this feature. If you are configured to use this option, the words **Deferred Channel** will appear just above the version number.

For more information about the different update channels and how to configure the use of a different update channel, see [Overview of update channels for Microsoft 365 Apps](/deployoffice/overview-update-channels) and [Change the Microsoft 365 Apps update channel for devices in your organization](/deployoffice/change-update-channels).

### MSI versions of Office

The following updates are required:

- [October 4, 2016, update for Office 2016 (KB3115500)](https://support.microsoft.com/help/3115500)
- [October 4, 2016, update for Outlook 2016 (KB3118375)](https://support.microsoft.com/help/3118375)
- [October 4, 2016, update for Office 2016 (KB3118374)](https://support.microsoft.com/help/3118374)
- [October 4, 2016, update for Office 2016 (KB3118330)](https://support.microsoft.com/help/3118330)
- [November 1, 2016, update for Outlook 2016 (KB3127912)](https://support.microsoft.com/help/3127912)
