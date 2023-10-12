---
title: Error when you use the Set-MsolADFSContext command
description: Describes an issue in which you receive an error message when you use the Set-MsolADFSContext command.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, brheld
ms.custom: sap:active-directory-federation-services-ad-fs, csstroubleshoot, has-azure-ad-ps-ref
ms.technology: windows-server-active-directory
---
# Error when you use the Set-MsolADFSContext command: The connection to \<ServerName> Active Directory Federation Services 2.0 server failed

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012  
_Original KB number:_ &nbsp; 2587730

## Symptoms

When you run the `Set-MsolADFSContext -Computer` command in the Microsoft Azure Active Directory module for Windows PowerShell, you receive the following error:

> Set-MsolADFSContext : The connection to \<ServerName> Active Directory Federation Services 2.0 server failed due to invalid credentials.

## Cause

This error occurs if Remote PowerShell isn't enabled on the Active Directory Federation Services (AD FS) federation server that the `-computer` parameter references.

When a domain is added correctly and verified in the portal, you can use the Azure Active Directory module for Windows PowerShell to set up single sign-on (SSO) from a management workstation by using Remote PowerShell.

However, the Azure Active Directory module for Windows PowerShell can only be installed on Windows 7 and on Windows Server 2008 SR2. The Azure Active Directory module for Windows PowerShell can't be installed on Windows Server 2008 Service Pack 2 (SP2). Therefore, this problem is especially relevant where AD FS is installed on a Windows Server 2008 SP2 platform. In this case, the Azure Active Directory module for Windows PowerShell command that's related to AD FS must be issued from a remote computer.

## Resolution

To enable Remote PowerShell on the AD FS federation server, follow these steps:

1. Start Windows PowerShell as an administrator. To do this, right-click the **Windows PowerShell** shortcut, and then select **Run As Administrator**.

2. To set up Windows PowerShell for remoting, type the following command, and then press Enter:

    ```powershell
    Enable-PSRemoting -force
    ```

## More information

For more information about Remote PowerShell requirements, see [About_Remote_Requirements](/previous-versions/dd315349(v=technet.10)).

For more information about Remote PowerShell functionality, see [Windows PowerShell: Dive Deep into Remoting](/previous-versions/technet-magazine/gg981683(v=msdn.10)).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Entra Forums](https://social.msdn.microsoft.com/Forums) website.
