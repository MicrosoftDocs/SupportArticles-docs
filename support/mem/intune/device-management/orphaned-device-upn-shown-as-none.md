---
title: How to remove a disabled Azure AD user's device from Intune
description: Fixes a problem in which a device becomes orphaned/unidentifiable if its owner is removed from Azure Active Directory before the device is removed from Microsoft Intune.
ms.date: 09/22/2021
search.appverid: MET150
ms.custom: sap:Remove devices
ms.reviewer: patlewis
---

# How to remove a disabled Azure AD user's device from Intune

This article explains how to remove an orphaned device in Intune if its owner has been deleted from Azure Active Directory (Azure AD). In this scenario, the device's user principal name (UPN) in Intune is listed as **None**.

## Symptoms

If you view an enrolled device in the [Microsoft Endpoint Manager admin center](https://go.microsoft.com/fwlink/?linkid=2109431) under **Devices** > **All Devices**, you see that the UPN is **None**.

## Cause

This issue occurs when an administrator removes or deletes a user from Azure AD, before deleting their enrolled device in Microsoft Intune. Once the user is removed from Azure AD, the Intune information for that user becomes unavailable and the UPN for their enrolled device shows **None**.

## Solution

A script is available that removes an orphaned, Intune-managed device if the owner was removed from Azure AD. The script requires that you have the UPN of the active or deleted user. You can download the script ([RemoveIntuneDevice.ps1](https://github.com/patlewis-MSFT/RemoveIntuneDevice/blob/master/RemoveIntuneDevice.ps1)) from the following Microsoft website:  
[https://github.com/patlewis-MSFT/RemoveIntuneDevice](https://github.com/patlewis-MSFT/RemoveIntuneDevice)

### Prerequisites

- The Azure AD recycle bin must be enabled before you delete a device for a deleted user. Read more about [Azure AD Connect sync: Enable AD recycle bin](/azure/active-directory/hybrid/how-to-connect-sync-recycle-bin).

- The logged-on user must have the appropriate Graph permissions set up in Intune before you run the script. For more information, see the **Intune permission scopes** section of [How to use Azure AD to access the Intune APIs in Microsoft Graph](/mem/intune/developer/intune-graph-apis#intune-permission-scopes).

- Install the Azure AD PowerShell module by running `Install-Module AzureAD` or `Install-Module AzureADPreview` at an elevated PowerShell prompt.

- You must have an Intune tenant that supports the Azure portal by having a production or trial license. Read more about [Introduction to Microsoft Intune in the Azure portal](/mem/intune/fundamentals/what-is-intune).

- Using the Microsoft Graph APIs to configure Intune controls and policies requires an Intune license.
- You must have an account that has permissions to administer the Intune Service.

- You must be using PowerShell 5.0 on Windows 10 x64 (PowerShell 4.0 is a minimum requirement for the scripts to function correctly.)

    > [!NOTE]
    > For PowerShell 4.0, you must have the **PowershellGet** module to enable using the **Install-Module** functionality. A first-time use of these scripts requires a Global Administrator of the tenant to accept the permissions of the application.

- If you receive an error message that states that scripts are disabled on your computer, you have to enable the script to run by running the `Set-ExecutionPolicy` cmdlet. For more information, see [Set-ExecutionPolicy](/powershell/module/microsoft.powershell.security/set-executionpolicy).

### Run the script

After the prerequisites are installed or met, follow these steps to use the script:

1. Download the RemoveIntuneDevice.ps1 script file to your local Windows computer.
1. Run PowerShell at an elevated administrator account.
1. Browse to the folder where you copied RemoveIntuneDevice.ps1, and then type: **.\RemoveIntuneDevice.ps1**.
1. Follow the prompts for authentication and to get the UPN of the owner or previous owner's device.
