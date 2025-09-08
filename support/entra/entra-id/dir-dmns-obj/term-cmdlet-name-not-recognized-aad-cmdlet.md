---
title: Error (The term \<cmdlet name> is not recognized) when you try to run Azure Active Directory module for Windows PowerShell cmdlets
description: Describes an issue in which you receive an error message when you try to run Azure Active Directory module for Windows PowerShell cmdlets. Resolutions are provided.
ms.date: 07/06/2020
ms.reviewer: 
ms.service: entra-id
ms.custom: sap:Directory Management, no-azure-ad-ps-ref
---
# Error when you try to run Azure Active Directory module for Windows PowerShell cmdlets: The term \<cmdlet name> is not recognized

_Original product version:_ &nbsp; Cloud Services (Web roles/Worker roles), Microsoft Entra ID, Microsoft Intune, Azure Backup, Office 365 Identity Management  
_Original KB number:_ &nbsp; 2669552

## Symptoms

When you try to run Microsoft Azure Active Directory module for Windows PowerShell cmdlets, you receive the following error message:

> The term \<cmdlet name> is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was included, verify that the path is correct and try again.

For example, you might see the following similar message:

> The term 'Connect-MsolService' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was included, verify that the path is correct and try again.  
At line:1 char:20  
\+ Connect-MsolService <<<<  
\+ CategoryInfo : ObjectNotFound: (Connect-MsolService:String) [], CommandNotFoundException  
\+ FullyQualifiedErrorId : CommandNotFoundException

## Cause

This issue can occur if the Azure Active Directory module for Windows PowerShell isn't loaded correctly.

## Resolution

To resolve this issue, follow these steps.

1. Install the Azure Active Directory module for Windows PowerShell on the computer (if it isn't already installed). To install the Azure Active Directory module for Windows PowerShell, see [Manage Microsoft Entra ID using Windows PowerShell](/previous-versions/azure/jj151815(v=azure.100)?redirectedfrom=MSDN).
2. Select **Start** > **All Programs**, select **Windows Azure Active Directory**, and then select **Windows Azure Active Directory module for Windows PowerShell**.
3. At the Windows PowerShell command prompt, type `Get-Module`, and then press Enter.
4. In the output, check that the `MSOnline` module is present. The output should look similar to the following one:

    ```output
    Module Type Name Exported Commands
    -------------- -------- ----------------
    Binary MSOnline {Add-MsolRoleMember, Remove-MsolContact...
    ```

    If the `MSOnline` module isn't present, use Windows PowerShell to import the `MSOnline` module. To do it, follow these steps:

    1. Connect to Exchange Online by using remote PowerShell. For more info about how to do it, see [Connect to Exchange Online Using Remote PowerShell](/powershell/exchange/connect-to-exchange-online-powershell?redirectedfrom=MSDN&view=exchange-ps&preserve-view=true).
    2. Type the following cmdlet, and then press Enter:

        ```powershell
        Import-Module MSOnline
        ```  

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
