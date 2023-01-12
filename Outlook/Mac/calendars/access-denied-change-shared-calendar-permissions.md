---
title: Can't change shared calendar permissions
description: Fixes an issue in which you receive an Access Denied error when you change permissions to a calendar shared by another user.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Mac
  - CI 142018
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Outlook 2016 for Mac
  - Outlook 2019 for Mac
  - Outlook for Microsoft 365 for Mac
search.appverid: MET150
ms.date: 3/31/2022
---
# "Access Denied" error when you change shared calendar permissions in Outlook for Mac

## Symptoms

Assume that you have owner permissions to a user's shared calendar in Microsoft Outlook for Mac. When you try to grant permissions to other users to access the shared calendar, you receive an "Access is denied" error message. This error occurs when you change the permissions in the **Calendar Properties** box.

Similar messages are displayed in the Outlook Mac logs:

> \<m:UpdateFolderResponse xmlns:m="`http://schemas.microsoft.com/exchange/services/2006/messages`"
 xmlns:xsd="`http://www.w3.org/2001/XMLSchema`" xmlns:xsi="`http://www.w3.org/2001/XMLSchema-instance`"
 xmlns:t="`http://schemas.microsoft.com/exchange/services/2006/types`">\<m:ResponseMessages>  
> \<m:UpdateFolderResponseMessage ResponseClass="Error">\<m:MessageText>
 **Access is denied. Check credentials and try again., Can't look up the requested Entry ID**.
> \</m:MessageText>\<m:ResponseCode>**ErrorAccessDenied**\</m:ResponseCode>
> \<m:DescriptiveLinkKey>0\</m:DescriptiveLinkKey>\<m:Folders/>\</m:UpdateFolderResponseMessage>
> \<m:UpdateFolderResponseMessage ResponseClass="Warning">
> \<m:MessageText>**Item was not processed as a result of a previous error**.\</m:MessageText>
> \<m:ResponseCode>ErrorBatchProcessingStopped\</m:ResponseCode>\<m:DescriptiveLinkKey>0\</m:DescriptiveLinkKey>\<m:Folders/>
> \</m:UpdateFolderResponseMessage>\</m:ResponseMessages>\</m:UpdateFolderResponse>\</s:Body>\</s:Envelope>

## Cause

This behavior is by design in Outlook for Mac.

## Resolution

Let the original calendar owner grant permissions to other users to access the shared calendar.
