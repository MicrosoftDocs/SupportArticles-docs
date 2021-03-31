---
title: Error occurs when configuring Dynamics CRM for Outlook
description: When configuring the Microsoft Dynamics CRM 2011 Outlook client, you receive an error during the Loading Outlook Profile portion of Configuration Wizard.
ms.reviewer: jowells
ms.topic: troubleshooting
ms.date: 
---
# Error occurs during the Loading Outlook Profile portion of the Microsoft Dynamics CRM Configuration Wizard

This article provides resolutions for the issue that you may receive an error message during the Loading Outlook Profile portion of the Microsoft Dynamics CRM Configuration Wizard.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2538692

## Symptoms

When configuring the Microsoft Dynamics CRM 2011 Outlook client, an error occurs after entering the user's Windows Live ID and during the Loading Outlook Profile portion of the Configuration Wizard.

In the Crm50ClientConfig.log, the following error occurs:

> Error| Exception : at Microsoft.Interop.Mapi.CRcwMsgServiceAdmin.CreateMsgServiceEx(String ServiceName, String DisplayName, IntPtr UIParam, IMsgServiceAdmin_CreateMsgService_Flags Flags)  
at Microsoft.Crm.Application.Outlook.Config.OutlookCRMDatastoreInstaller.InstallCrmDatastore(Guid organizationId, Guid userId, String serverUrl, String organizationName, String displayName)  
at Microsoft.Crm.Application.Outlook.Config.OutlookConfigurator.Configure(IProgressEventHandler progressEventHandler)  
at Microsoft.Crm.Application.Outlook.Config.ConfigEngine.Configure(Object stateInfo)

The Crm50ClientConfig.log is located in the following directories:

- Windows7/2008

  %userprofile%\AppData\Local\Microsoft\MSCRM\Logs

- WindowsXP/2003

  %userprofile%\Local Settings\Application Data\MSCRM\Logs

## Cause

The above error might occur if any of the following conditions are true:

Cause 1:

The MAPISVC.inf file does not exist in the proper location.

Cause 2:

The Microsoft Dynamics CRM services are not being registered to the MAPISVC.inf file

## Resolution

Resolution 1:

1. The location of the MAPISVC.inf file depends on the architecture type of Windows as well as Outlook. Below is where the MAPISVC.inf file should exist based on the architecture types of Windows and Outlook.

    **32 bit or x86 version of Windows and Outlook:**  
    `C:\Windows\System32\mapisvc.inf`  
    `C:\Program Files\Common Files\System\MSMAPI\1033\mapisvc.inf`

    **64 bit or x64 version of Windows and Outlook:**  
    `C:\Program Files\Common Files\System\MSMAPI\1033\mapisvc.inf`  
    `C:\windows\SysWOW64\mapisvc.inf`

    **32 bit or x86 version of Outlook with a 64 bit or x64 version of Windows:**  
    `C:\Program Files (x86)\Common Files\System\MSMAPI\1033\mapisvc.inf`  
    `C:\windows\SysWOW64\mapisvc.inf`

2. If the MAPISVC.inf file does not exist in any of these locations, try locating it in the UserProfile:

    **Windows7/2008**  
    `%userprofile%\AppData\Local\Microsoft\Outlook`

    **WindowsXP/2003**  
    `%userprofile%\Local Settings\Application Data\Microsoft\Outlook`

3. If the MAPISVC.inf file exists in the UserProfile, then copy it to the proper directories based on the architecture type of Windows and Outlook.

4. If you are not sure what architecture type you are using for Windows or Outlook, use the following steps:

    Windows:

    1. Select Windows/Start button.
    2. Go to **Programs** > **Accessories**.
    3. Right-Click on Command Prompt and select **Run as administrator**.
    4. Run the following command:

       `reg query "HKLM\System\CurrentControlSet\Control\Session Manager\Environment" /V PROCESSOR_ARCHITECTURE`

    If it returns, the following results, it would indicate the Operating System is a 64-bit Operating System:

    `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment`  
    `PROCESSOR_ARCHITECTURE REG_SZ AMD64`

    If it returns, the following results, it would indicate the Operating System is a 32-bit Operating System:

    `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment`  
    `PROCESSOR_ARCHITECTURE REG_SZ x86`

    If Windows is a 32-bit Operating System, then Outlook will be a 32-bit application. However, if Windows is a 64-bit Operating System, Outlook can be either a 32-bit application or a 64-bit application. Outlook 2003 and Outlook 2007 only are supported as 32-bit applications. However, Outlook 2010 has both architecture types:

    To determine which version Outlook 2010 is, use the following steps:

    1. Select Windows/Start button.
    2. Go to **Programs** > **Accessories**.
    3. Right-Click on Command Prompt and select **Run as administrator**.
    4. Run the following command based on the version of Office:

       `reg query "HKLM\Software\Microsoft\Office\14.0\Outlook" /V Bitness`

Resolution 2:

If the Microsoft Dynamics CRM services are not being registered to the MAPISVC.inf file, we can manually add these entries to the MAPISVC.inf file and place them in the proper locations.

To address this issue, contact Microsoft Dynamics CRM support for assistance.

## More information

Check whether the problem is fixed. If the problem is fixed, you are finished with this section. If the problem is not fixed, you can contact [Microsoft Support](https://support.microsoft.com/contactus).
