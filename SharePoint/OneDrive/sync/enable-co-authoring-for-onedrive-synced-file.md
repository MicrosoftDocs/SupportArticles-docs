---
title: Enable coauthoring for OneDrive-synced files
description: Explains how to enable coauthoring for OneDrive-synced files in Microsoft 365 after an October 2019 change removes the feature.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
localization_priority: Normal
search.appverid: 
  - MET150
appliesto: 
  - OneDrive for Business
ms.date: 12/17/2023
---

# How to enable coauthoring for OneDrive-synced files in Microsoft 365

## Summary

Beginning in the October 2019 update for Microsoft 365, coauthoring capabilities are no longer available for files that are synced to a local computer through the OneDrive for Business (Groove.exe) sync client. 

After this update is applied, you will see the following changes:  
 
- Locally synced Office files (such as Word documents, Excel spreadsheets, and PowerPoint presentations) that are synced by OneDrive for Business (Groove.exe) will no longer allow coauthoring between multiple users. This affects only locally synced files. It does not affect files that are opened directly from a SharePoint URL.     
- Files will have multiple entries for the Most Recently Used list in Office applications. This includes both the local and SharePoint-accessed file.    
- Files that are opened directly from a SharePoint URL while the computer is not connected to the internet will not open.

 
This change is in effect starting in the October 2019 monthly update (build 16.0.12228) Additionally, this change will be rolled into the next semi-annual channel release in the January 2020 update (build 16.0.12527).   

## Workaround

If you are affected by this change, you can use one of the following workarounds (provided in recommended order).

### Workaround 1: Use the OneDrive sync client for SharePoint workloads

The OneDrive Sync Client (OneDrive.exe) is the recommended client for syncing SharePoint Online and SharePoint 2019 content. It will continue to allow coauthoring capabilities for synced files, together with features and improvements such as Files On-Demand. We recommend that all users and organizations move to the OneDrive sync client. 
For more information about how to deploy the OneDrive sync client, see [The OneDrive sync client](/onedrive/one-drive-sync).

### Workaround 2: Open the file directly from SharePoint 

This change affects only local files that are synced by OneDrive for Business (Groove.exe). Users who open the Office file directly from SharePoint or OneDrive on the web will continue to be able to coauthor.

### Workaround 3: Stay on a version of Office earlier than October 2019 (not recommended)

Versions of Office that are earlier than the October 2019 monthly update will continue to have coauthoring capabilities. However, we do not recommend this method. This is because the rest of the Office suite will no longer get the latest features, bug fixes, and improvements.