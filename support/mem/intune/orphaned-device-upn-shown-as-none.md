---
title: Missing Intune information if removing user from Azure AD
description: Fixes a problem in which a user's device becomes unidentifiable if the user is removed from Azure Active Directory before the device is removed from Intune.
ms.date: 05/13/2020
ms.prod-support-area-path: Remove devices
ms.reviewer: patlewis
---
# Removing a user from Azure AD before removing the user's device from Intune shows the device UPN as None

This article solves the issue that a removed user's Intune information is not available if the user is deleted from Azure Active Directory before the device is removed from Intune.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 4471001

## Symptoms

If an administrator removes or deletes a user from Microsoft Azure Active Directory (Azure AD), and that user has a device that's enrolled in Microsoft Intune, the Intune information for that user becomes unavailable. If you view the enrolled device in the Intune portal under **Devices** > **All Devices**, you see that the user principal name (UPN) is listed as **None**.

## Resolution

A script is available that removes an orphaned device that is managed by Intune and whose owner was removed from Azure AD. The script requires that you have the UPN of the active or deleted user. You can download the script ([RemoveIntuneDevice.ps1](https://github.com/patlewis-MSFT/RemoveIntuneDevice/blob/master/RemoveIntuneDevice.ps1)) from the following Microsoft website:  
[https://github.com/patlewis-MSFT/RemoveIntuneDevice](https://github.com/patlewis-MSFT/RemoveIntuneDevice)

### Prerequisites

- The Azure Active Directory recycle bin must be enabled before you delete a device for a deleted user. Read more about [Azure AD Connect sync: Enable AD recycle bin](/azure/active-directory/hybrid/how-to-connect-sync-recycle-bin).

- The logged-on user must have the appropriate Graph permissions set up in Intune before you run the script. For more information, see the **Intune permission scopes** section of [How to use Azure AD to access the Intune APIs in Microsoft Graph](/mem/intune/developer/intune-graph-apis#intune-permission-scopes).

- Install the Azure AD PowerShell module by running `Install-Module AzureAD` or `Install-Module AzureADPreview` at an elevated PowerShell prompt.

- You must have an Intune tenant that supports the Azure portal by having a production or trial license. Read more about [Introduction to Microsoft Intune in the Azure portal](/mem/intune/fundamentals/what-is-intune).

- Using the Microsoft Graph APIs to configure Intune controls and policies requires an Intune license.
- You must have an account that has permissions to administer the Intune Service.

- You must be using PowerShell 5.0 on Windows 10 x64 (PowerShell 4.0 is a minimum requirement for the scripts to function correctly.)

    > [!NOTE]
    > For PowerShell 4.0, you must have the **PowershellGet** module to enable using the **Install-Module** functionality. A first-time use of these scripts requires a Global Administrator of the tenant to accept the permissions of the application.

- If you receive an error message that states that scripts are disabled on your computer, you have to enable the script to run by running the `Set-ExecutionPolicy` cmdlet. For more information, see [Set-ExecutionPolicy](/powershell/module/microsoft.powershell.security/set-executionpolicy).

### Getting started

After the prerequisites are installed or met, follow these steps to use the script:

1. Download the RemoveIntuneDevice.ps1 script file to your local Windows computer.
2. Run PowerShell at an elevated administrator account.
3. Browse to the folder to which you copied RemoveIntuneDevice.ps1, and then type: **.\RemoveIntuneDevice.ps1**.
4. Follow the prompts for authentication and to get the UPN of the owner or previous owner's device.
