---
title: Orphaned record for PowerPivot service application database
description: Fixes an error that occurs in Windows Event Viewer or the SharePoint Unified Logging Service (ULS) logs.
author: helenclu
ms.author: luche
ms.reviwer: zakirh
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administration\Farm Administration
  - CSSTroubleshoot
appliesto: 
  - Microsoft SharePoint
ms.date: 12/17/2023
---

# Orphaned record for PowerPivot service application database

This article was written by [Zakir Haveliwala](https://social.technet.microsoft.com/profile/Zakir+H+-+MSFT), Senior Support Escalation Engineer.

## Symptoms

You may receive the following error in Windows Event Viewer or the SharePoint Unified Logging Service (ULS) logs:

> Cannot open database "*Database name of PowerPivot Service application*" requested by the login. The login failed. Login failed for user 'username'.

## Cause

This is an indication of an orphaned record about the PowerPivot service application database in SharePoint. This issue may occur after you delete a PowerPivot service application. The records for the deleted PowerPivot service application database are sometimes not removed from the SharePoint configuration database. Therefore, SharePoint throws an error when it can't open the PowerPivot service application database since it no longer exists.

## Resolution

To fix this issue, remove these orphaned records. You can open the SharePoint Management Shell on a SharePoint server and run the following command:

**Get-SPDatabase | where {$_.exists -eq $false}**

This will display a list of the databases that no longer exist on the SharePoint database server. The PowerPivot database that's referenced in the previous error should show in this list. After confirming this, you can remove the orphaned record by running this command:

**Get-SPDatabase | where {$_.exists -eq $false} | foreach {$_.delete()}**

Then the orphaned record that points to the old PowerPivot service application database will be removed, and the error that you noticed earlier will stop occurring.
