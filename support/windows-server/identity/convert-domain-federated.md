---
title: Error when you run the Convert-MsolDomainToStandard cmdlet
description: Describes an issue where you receive an error message when converting a domain from federated to managed using Convert-MsolDomainToStandard cmdlet. Provides a resolution.
ms.date: 09/24/2021
author: willfid
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-federation-services-ad-fs, csstroubleshoot, has-azure-ad-ps-ref
ms.subservice: active-directory
---
# Error when you run the Convert-MsolDomainToStandard cmdlet: Failed to connect to Active Directory Federation Services 2.0 on the local machine

This article provides a resolution to resolve an issue where you receive "Failed to connect to Active Directory Federation Services 2.0 on the local machine" error when converting a domain from federated to managed using `Convert-MsolDomainToStandard` cmdlet.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012  
_Original KB number:_ &nbsp; 3018485

## Symptoms

When you run the `Convert-MsolDomainToStandard` cmdlet to convert a domain from **Federated** to **Managed**, you receive the following error message:

> Failed to connect to Active Directory Federation Services 2.0 on the local machine.  
Please try running Set-MsolADFSContect before running this command again.

## Cause

This problem occurs if the server on which you're running the `Convert-MsolDomainToStandard` cmdlet is not running Active Directory Federation Services (AD FS).

## Resolution

Do one of the following, as appropriate for your situation:

- If AD FS is still running, use the `Set-MsolADFSContext` cmdlet to specify the server on which AD FS is running.

    For example:

    ```powershell
    Set-MsolADFSContext -Computer <ServerName>
    ```

    For more information about the Set-MsolADFSContext cmdlet, see [Set-MsolADFSContext](/previous-versions/azure/dn194087(v=azure.100)).

- If AD FS is not running, use the `Set-MsolDomainAuthentication` cmdlet to change the domain to a managed domain.

    For example:

    ```powershell
    Set-MsolDomainAuthentication -DomainName <DomainName> -Authentication Managed
    ```

    For more info about the Set-MsolDomainAuthentication cmdlet, see [Set-MsolDomainAuthentication](/previous-versions/azure/dn194112(v=azure.100)).

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or [Microsoft Entra Forums](https://social.msdn.microsoft.com/Forums/home?forum=windowsazuread) website.
