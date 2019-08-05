---
title: 
description: 
author: Teresa-Motiv
manager: 
audience: ITPro
ms.prod: sharepoint-server-itpro
ms.topic: article
ms.author: v-tea
appliesto:
- SharePoint Online
---

# Access denied error (Event ID 5566) when opening a form in the browser

## Symptoms

You have an InfoPath form that uses the **GetUserCollectionFromGroup** method of the UserGroup.asmx web service to enumerate users and groups. You open the form in a browser, but it fails to open and you receive a message that resembles the following:

> An error occurred while trying to connect to a Web service.  
> An entry has been added to the Windows event log of the server.  
> Log ID:5566

When you view the Unified Logging System (ULS) log, you see a message that resembles the following:

> Access Denied. Exception: 'Access is denied. (Exception from HRESULT: 0x80070005 (E_ACCESSDENIED))', StackTrace: ' at Microsoft.SharePoint.Library.SPRequestInternalClass.GetUsersDataAsSafeArray(String bstrUrl, UInt32 dwUsersScope, UInt32 dwUserCollectionFlags, String bstrValue, UInt32 dwValue, UInt32& pdwColCount, UInt32& pdwRowCount, Object& pvarDataSet) at Microsoft.SharePoint.Library.SPRequest.GetUsersDataAsSafeArray(String bstrUrl, UInt32 dwUsersScope, UInt32 dwUserCollectionFlags, String bstrValue, UInt32 dwValue, UInt32& pdwColCount, UInt32& pdwRowCount, Object& pvarDataSet)'.

## Cause

When you open the form, the **GetUserCollectionFromGroup** method uses your security context to enumerate SharePoint groups and users. If you are a member of the Site Owners group, your permissions may not be sufficient. In that case, the method fails.

## Workaround

This method should function correctly if you use an account that is a member of the Farm Administrators group.  

If you cannot use a Farm Administrator account to open the form, you have to change the permissions of the SharePoint groups that the form enumerates. To do this, follow these steps:

1. Navigate to **Site Settings** > **People and Groups**, and then select the group that you want to edit.
1. On the group page, select **Settings** > **Group Settings**, and then under **Who can view the membership of a group?** select **Everyone**.
