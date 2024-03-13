---
title: Can't run scripts in Azure Active Directory module for Windows PowerShell
description: Describes an issue in which you receive an error message when you try to run scripts in Azure Active Directory module for Windows PowerShell. Provides a resolution.
ms.date: 10/26/2021
ms.reviewer: willfid, willfid
ms.service: active-directory
ms.subservice: enterprise-users
ms.custom:
---
# Can't run scripts in Azure Active Directory module for Windows PowerShell

This article describes an issue in which you receive an error message when you try to run scripts in Azure Active Directory module for Windows PowerShell.

_Original product version:_ &nbsp; Microsoft Entra ID, Microsoft Intune, Azure Backup, Office 365 User and Domain Management, Office 365 Identity Management  
_Original KB number:_ &nbsp; 2411920

## Symptoms

When you try to run a script in Microsoft Azure Active Directory module for Windows PowerShell, you receive one of the following error messages:

> File C:\my_script.ps1 cannot be loaded. The execution of scripts is disabled on this system. Please see "Get-Help about_signing" for more details.

> File C:\Desktop\myscript.ps1 cannot be loaded because running scripts is disabled on this system. For more information, see about_Execution_Policies at `http://go.microsoft.com/fwlink/?LinkID=135170`.

> File C:\my_script.ps1 cannot be loaded. The file C:\my_script.ps1 is not digitally signed. The script will not execute on the system. For more information, see about_Execution_Policies at `http://go.microsoft.com/fwlink/?LinkID=135170`.

## Cause

This issue may occur if one of the following factors is true:

- The PowerShell version that you are using is higher than 5.1. The Azure Active Directory module only works with PowerShell 3 to 5.1.
- The execution policy is set to **Restricted**. Certain Windows PowerShell cmdlets can't run if the policy is too restricted.

## Resolution

To resolve this issue, follow these steps:

1. Identify the PowerShell version by running `$PSVersionTable`.
1. Run the Azure Active Directory module for Windows PowerShell as an administrator. To do it, select **Start**, select **All Programs**, select **Windows Azure Active Directory**, right-click **Windows Azure Active Directory module for Windows PowerShell**, and then select **Run as administrator**.
1. Set the execution policy to **Unrestricted**. To do it, type the following cmdlet, and then press Enter:

    ```powershell
    Set-ExecutionPolicy Unrestricted
    ```

3. Run the Windows PowerShell cmdlets that you want.
4. Set the execution policy to **Restricted**. To do it, type the following cmdlet, and then press Enter:

    ```powershell
    Set-ExecutionPolicy Restricted
    ```

## More information

To help deliver a more secure command-line administration experience, Windows PowerShell uses "execution policies" to control how Windows PowerShell can be used. Execution policies define the restrictions under which Windows PowerShell loads files for execution and configuration. Windows PowerShell runs in the Restricted execution policy by default. This mode is its most secure mode. In this mode, Windows PowerShell operates as an interactive shell only.

The four execution policies are as follows:

- Restricted is the default execution policy. This policy doesn't run scripts and is interactive only.
- AllSigned policy runs scripts. All scripts and configuration files must be signed by a publisher that you trust. This policy opens you to the risk of running signed but malicious scripts, after you confirm that you trust the publisher.
- RemoteSigned policy runs scripts. All scripts and configuration files downloaded from communication applications must be signed by a publisher that you trust. These communication applications include Microsoft Outlook, Windows Internet Explorer, Outlook Express, and Windows Messenger. This policy opens you to the risk of running malicious scripts that aren't downloaded from these applications. And you aren't prompted in this situation.
- Unrestricted policy runs scripts. All scripts and configuration files downloaded from communication applications run after you confirm that you understand that the file originated from the Internet. These communication applications include Outlook, Internet Explorer, Outlook Express, and Windows Messenger. No digital signature is required. This policy opens you to the risk of running unsigned, malicious scripts that are downloaded from these applications.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
