---
title: Error 530 when you browse anonymous FTP sites
description: This article provides resolutions for the error 530 that occurs when users browse an anonymous FTP site configured for Active Directory User Isolation in IIS 7.0 and 7.5.
ms.date: 04/07/2020
ms.custom: sap:FTP authentication and authorization
ms.reviewer: Robmcm, MLaing
ms.technology: ftp-authentication-authorization
---
# Error 530 when you browse anonymous FTP sites configured for Active Directory User Isolation in IIS 7.0 and 7.5

This article helps you resolve the error 530 that occurs when you browse an anonymous FTP site configured for Active Directory User Isolation in Microsoft Internet Information Services (IIS) 7.0 or 7.5.

_Original product version:_ &nbsp; Internet Information Services 7.0, 7.5  
_Original KB number:_ &nbsp; 2649659

## Symptoms

Consider the following scenario. You configure an FTP site in IIS 7.0 or 7.5. In the IIS manager, you allow anonymous authentication for the FTP site, and then configure Active Directory User Isolation to isolate users to their own FTP directories. When a user then tries to access the FTP site anonymously, one of the following error conditions may occur:

- Error condition 1: Using the ftp.exe FTP client

    If the user is navigating to the FTP site using the ftp.exe command-line FTP client built into Windows, or another similar command-line FTP client, the following error is displayed:

    > 530-User cannot log in.  
    > Win32 error: Access is denied.  
    > Error details: Home directory lookup failed.

- Error condition 2: Using Internet Explorer as the FTP client

    If the user is navigating to the FTP site using Internet Explorer, and the **Log on anonymously** checkbox is checked, clicking the **Log on** button will result in the user being prompted to enter the anonymous credentials repeatedly.

## Cause

This behavior is by design. Configuring an FTP site for anonymous access as well as Active Directory User Isolation is not supported.

## Resolution

When configuring an FTP site for Active Directory User Isolation, do not allow anonymous access. FTP sites configured with Active Directory User Isolation must use Basic Authentication.

## More information

For more information about configure FTP User Isolation in IIS 7.0 and 7.5, see the following articles:

- [FTP User Isolation](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd722768(v=ws.10))

- [Configuring FTP User Isolation in IIS 7](/iis/publish/using-the-ftp-service/configuring-ftp-user-isolation-in-iis-7)
