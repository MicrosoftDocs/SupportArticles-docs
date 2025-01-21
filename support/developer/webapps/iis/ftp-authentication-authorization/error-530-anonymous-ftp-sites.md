---
title: Error 530 when you browse anonymous FTP sites
description: This article provides resolutions for the error 530 that occurs when users browse an anonymous FTP site configured for Active Directory User Isolation in IIS.
ms.date: 12/16/2024
ms.custom: sap:FTP Authentication and Authorization\FTP authentication
ms.reviewer: Robmcm, MLaing, zixie
---
# Error 530 when you browse anonymous FTP sites configured for Active Directory User Isolation in IIS

This article helps you resolve the error 530 that occurs when you browse an anonymous FTP site configured for Active Directory User Isolation in Microsoft Internet Information Services (IIS).

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 2649659

## Symptoms

Consider the following scenario:

- You configure an FTP site in IIS.
- You allow anonymous authentication for the FTP site in the IIS manager. And then you configure Active Directory User Isolation to isolate users to their own FTP directories.
- A user tries to access the FTP site anonymously.

In this scenario, one of the following error conditions might occur:

- Error condition 1: Using the **ftp.exe** FTP client

  If the user is navigating to the FTP site using the **ftp.exe** command-line FTP client built into Windows or another similar command-line FTP client, the following error is displayed:

  > 530-User cannot log in.  
  > Win32 error: Access is denied.  
  > Error details: Home directory lookup failed.

- Error condition 2: Using Internet Explorer as the FTP client

  If the user is navigating to the FTP site using Internet Explorer, and the **Log on anonymously** checkbox is checked, selecting the **Log on** button will result in the user being prompted to enter the anonymous credentials repeatedly.

## Cause

This behavior is by design. Configuring an FTP site for anonymous access or Active Directory User Isolation isn't supported.

## Resolution

When configuring an FTP site for Active Directory User Isolation, don't allow anonymous access. FTP sites configured with Active Directory User Isolation must use Basic Authentication.

## More information

For more information about configure FTP User Isolation in IIS, see the following articles:

- [FTP User Isolation](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd722768(v=ws.10))

- [Configuring FTP User Isolation in IIS](/iis/publish/using-the-ftp-service/configuring-ftp-user-isolation-in-iis-7)
