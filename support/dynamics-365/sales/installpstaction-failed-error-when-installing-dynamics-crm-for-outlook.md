---
title: InstallPSTAction failed error during installation
description: InstallPSTAction failed error when installing Microsoft Dynamics CRM client for Microsoft Office Outlook. Provides a resolution.
ms.reviewer: chanson, henningp
ms.topic: troubleshooting
ms.date: 
---
# InstallPSTAction failed error when installing Microsoft Dynamics CRM client for Microsoft Office Outlook

This article provides a resolution for the issue that the **InstallPSTAction failed** error occurs when installing Microsoft Dynamics CRM client for Microsoft Office Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2496442

## Symptoms

After uninstalling Microsoft Dynamics CRM 2011 client for Microsoft Office Outlook and installing the Microsoft Dynamics CRM 4.0 client for Outlook, you get the following error when trying to run the configuration wizard.

> Error| Configuration exception.System.Exception: Action Microsoft.Crm.Config.Client.InstallPstAction failed. --->  
System.Runtime.InteropServices.COMException (0x8004010F): LaunchOutlookInstallerProcess failed.  
at System.Runtime.InteropServices.Marshal.ThrowExceptionForHRInternal(Int32 errorCode, IntPtr errorInfo)  
at Microsoft.Crm.Config.Client.InstallPstAction.Do(IDictionary parameters)  
at Microsoft.Crm.Setup.Common.Action.ExecuteAction(Action action, IDictionary parameters, Boolean undo)

## Cause

This is due to the uninstall leaving the CRMForOutlookInstaller.exe file in the `C:\Program Files\Microsoft Dynamics CRM\Client\ConfigWizard` directory.

## Resolution

To fix this issue, follow these steps:

1. Navigate to `C:\Program Files\Microsoft Dynamics CRM\Client\ConfigWizard` directory or `C:\Program Files (x86)\Microsoft Dynamics CRM\Client\ConfigWizard` directory.
2. Delete the CRMForOutlookInstaller.exe file.
3. Do one of the following options:
    - Replace the CRMForOutlookInstaller.exe from the Microsoft Dynamics CRM 4.0 client install bits.
    - Run a repair on the Microsoft Dynamics CRM 4.0 client for Microsoft Office Outlook installation.
    - Uninstall and reinstall the Microsoft Dynamics CRM 4.0 client.
4. Run the Configuration Wizard.

## More information

The CRMForOutlookInstaller.exe is left behind in order to remove the per-user registry keys from any other users that may have configured the Microsoft Dynamics CRM Client.
