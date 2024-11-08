---
title: Access Denied error (Event ID 5566) when you open a form in the browser
description: Describes how to work around an access denied issue that occurs when you open an InfoPath form.
manager: dcscontentpm
search.appverid: 
  - MET150
audience: Admin|ITPro|Developer
ms.topic: troubleshooting
ms.custom: 
  - sap:Permissions\Errors
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# "Access Denied" error (Event ID 5566) when you open a form in the browser

## Symptoms

You have an InfoPath form that uses the **GetUserCollectionFromGroup** method of the UserGroup.asmx web service to enumerate users and groups. You try to open the form in a browser. However, the form does not open, and you receive an error message that resembles the following:

> An error occurred while trying to connect to a Web service.  
> An entry has been added to the Windows event log of the server.  
> Log ID:5566

When you view the Unified Logging System (ULS) log, you see an entry that resembles the following:

> Access Denied. Exception: 'Access is denied. (Exception from HRESULT: 0x80070005 (E_ACCESSDENIED))', StackTrace: ' at Microsoft.SharePoint.Library.SPRequestInternalClass.GetUsersDataAsSafeArray(String bstrUrl, UInt32 dwUsersScope, UInt32 dwUserCollectionFlags, String bstrValue, UInt32 dwValue, UInt32& pdwColCount, UInt32& pdwRowCount, Object& pvarDataSet) at Microsoft.SharePoint.Library.SPRequest.GetUsersDataAsSafeArray(String bstrUrl, UInt32 dwUsersScope, UInt32 dwUserCollectionFlags, String bstrValue, UInt32 dwValue, UInt32& pdwColCount, UInt32& pdwRowCount, Object& pvarDataSet)'.

## Cause

When you open the form, the **GetUserCollectionFromGroup** method uses your security context to enumerate SharePoint groups and users. If you are a member of the Site Owners group, your permissions may not be sufficient. In that case, the method fails.

## Workaround

This method should function correctly if you use an account that is a member of the Farm Administrators group.  

If you cannot use an account from the Farm Administrators group to open the form, you have to change the permissions of the SharePoint groups that the form enumerates. To do this, follow these steps:

1. Navigate to **Site Settings** > **People and Groups**, and then select the group that you want to edit.
1. On the group page, select **Settings** > **Group Settings**.
1. Under **Who can view the membership of a group?**, select **Everyone**.

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
