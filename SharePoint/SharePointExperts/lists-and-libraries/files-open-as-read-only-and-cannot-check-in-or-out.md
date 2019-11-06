---
title: SharePoint files open as read-only and can't check in or out
author: AmandaAZ
ms.author: warrenr
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.topic: article
ms.service: sharepoint-online
ms.custom: CSSTroubleshoot
appliesto:
- Microsoft SharePoint
- OneDrive for Business
---
# SharePoint files open as read-only and can't check in or out

This article was written by [Warren Rath](https://social.technet.microsoft.com/profile/Warren_R_Msft), Support Escalation Engineer.

## Symptoms

Assume that you synchronize a SharePoint document library that requires checkout to a local folder through Microsoft OneDrive for Business. When you open a file from either online or the local synced folder, the file is opened as read-only, and it can't be checked in or checked out from Office applications.

## Cause

This is a limitation of OneDrive for Business. See [Libraries with specific columns for more information](https://support.office.com/en-us/article/invalid-file-names-and-file-types-in-onedrive-onedrive-for-business-and-sharepoint-64883a5d-228e-48f5-b3d2-eb39e07630fa?ui=en-US&rs=en-001&ad=US#librariesspecificcolumns).

## Workarounds

To resolve this issue, use either of the following methods:
- Do not sync SharePoint document libraries that require checkout.
- Disable the [**Use Office applications to sync Office files that I open**](https://support.office.com/article/use-office-applications-to-sync-office-files-that-i-open-8a409b0c-ebe1-4bfa-a08e-998389a9d823) setting on the **Office** tab in OneDrive sync settings.

> [!NOTE]
> This setting is controlled by the [**EnableAllOcsiClients**](https://docs.microsoft.com/onedrive/use-group-policy#EnableAllOcsiClients) policy. If you disable this setting, co-authoring will not work for any files that are opened from a local synced folder. However, co-authoring will work for any files that are opened from online.

## Status

Supporting SharePoint document libraries that require checkout is on the Microsoft product group's backlog.