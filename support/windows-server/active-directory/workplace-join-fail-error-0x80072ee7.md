---
title: Error 0x80072EE7 when you perform Workplace Join
description: Fixes an error 0x80072EE7 that occurs when users perform a Workplace Join.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, willfid, AAdcontent, rkiran
ms.custom: sap:active-directory-federation-services-ad-fs, csstroubleshoot
---
# "Workplace Join discovery failed" error with exit code 0x80072EE7

This article provides a solution to an error 0x80072EE7 that occurs when users perform a Workplace Join.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3045385

> [!NOTE]
> Home users: This article is intended for use by support agents and IT professionals, not by home users. For best search results, change your search keywords to include the product that's triggering the error and the error code.

## Symptoms

When users try to perform a Workplace Join, they receive the following error message:

> Confirm you are using the current sign-in info, and that your workplace uses this feature. Also, the connection to your workplace might not be working right now. Wait and try again.

Additionally, an administrator may see the following event details in Event Viewer:

> Event ID: 102  
Log Name: Microsoft-Windows-Workplace Join/Admin  
Source: Microsoft-Windows-Workplace Join  
Level: Error  
Description:  
Workplace Join discovery failed.
>
> Exit Code: 0x80072EE7.
>
> The server name or address could not be resolved. Could not connect to `https://EnterpriseRegistration.domainTEST.com:443/EnrollmentServer/contract?api-version=1.0`.

## Cause

This problem occurs if one of the following conditions is true:

- The currently signed-in user is from a domain that does not contain a DNS record for the DRS Service.
- A user who has a user principal name (UPN) suffix that uses the initial domain (for example, joe@contoso.onmicrosoft.com) and who is not yet enabled as the mobile device management authority through Microsoft Intune for mobile device management in Office 365 tries to perform a Workplace Join.

## Resolution

### Verify DNS

To resolve this problem, follow these steps:

1. Verify the EnterpriseRegistration CNAME record for the UPN suffix of the user account. This is the part after the "@" character, such as in john@contoso.com.
2. Open a **Command Prompt** window, and then run the following command:

    ```console
    Nslookup enterpriseregistration.domain.com 
    ```

    - If you use Microsoft Entra join

      Results should return the CNAME result of EnterpriseRegistration.windows.net.

    - If you use Windows Server Workplace Join
      - Internal host should return internal ADFS node.
      - External host should return external ADFS Proxy (if present).

## References

For more troubleshooting information, see the following article in the Microsoft Knowledge Base:

[3045377](https://support.microsoft.com/help/3045377) Diagnostic logging for troubleshooting Workplace Join issues
