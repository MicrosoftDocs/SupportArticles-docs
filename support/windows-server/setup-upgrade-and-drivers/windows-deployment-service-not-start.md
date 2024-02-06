---
title: Error 0x5 when starting Windows Deployment Service
description: Provides a solution to the error 0x5 that occurs when you start the Windows Deployment Service.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:installing-or-upgrading-windows, csstroubleshoot
---
# Windows Deployment Service fails to start with error information of 0x5

This article provides help to fix the error 0x5 that occurs when you start the Windows Deployment Service.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2009647

## Symptoms

When trying to start the Windows Deployment Service, you may see the following event IDs logged:

> Event Source: WDSServer  
Event ID: 257  
Description:  
An error occurred while trying to start the Windows  Deployment Services server.  
Error information: 0x5  
>
>Event Source: WDSServer  
Event ID: 513  
Description:  
An error occurred while trying to initialize provider WDSPXE from C:\WINDOWS\system32\wdspxe.dll. Windows Deployment Services server will be shutdown.  
Error Information 0x5  
>
> Event Source:  WDSPXE  
Event id:  265  
Description:  
An error occurred while trying to initialize provider BINSVC. Since the provider is marked as critical the windows deployment services server will be shutdown.  
Error information:  0x5

## Cause

This can occur if you are logged in as local administrator or if the computer account for the WDS server does not have correct security permissions

## Resolution

To resolve this issue, make sure you are logged in as domain or Enterprise administrator and check the permissions for the computer account by doing the following:  

1. Log into a Domain Controller and launch **Active Directory Users and Computers**  
2. Enable **Advanced Features** from the **View** menu
3. Find the server object for the WDS server and in Properties select the **Security** tab
4. Verify the following permissions:  
Domain Admins:  Full Control  
Enteprise Admins:  Full Control  
Account Operators:  Full Control  
System:  Full Control  
SELF:  Create All Child Objects, Delete All Child Objects, Validated write to DNS host name, Validated write to service principal name, Read Personal Information, Write Personal Information

## More information

For more information, see [Event ID 1804—Active Directory Integration](https://technet.microsoft.com/library/cc726539(WS.10).aspx)

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
