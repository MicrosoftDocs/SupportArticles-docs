---
title: SMS Agent Host service not starts
description: Describes a problem that occurs when the system path variable is incorrect on the client computer. Provides two methods to resolve the problem.
ms.date: 10/19/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika, steverac
ms.custom: sap:wmi, csstroubleshoot
ms.subservice: system-mgmgt-components
---
# The SMS Agent Host service does not start after you restart a Systems Management Server 2003 client computer

This article provides a resolution for the issue that SMS Agent Host service does not start after you restart a Systems Management Server 2003 client computer.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 922362

>[!IMPORTANT]
>This article contains information about how to modify the registry. Make sure to back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
[256986](https://support.microsoft.com/help/256986) Description of the Microsoft Windows registry  

## Symptoms

After you restart a Microsoft Systems Management Server (SMS) 2003 client computer, the SMS Agent Host service (Ccmexec.exe) does not start. When this problem occurs, error entries that resemble the following ones may appear in the CCMExec.log file on the SMS client computer:

>CCMExec.log file entry 1  
Starting CCMEXEC service... $$\<CcmExec>\<Fri Feb 13 8:13:13.819 2004 Central Standard Time>\<thread=1216 (0x4C0)>  
Running on machine **ComputerName** as user SYSTEM.  
$$\<CcmExec>\<Fri Feb 13 8:13:13.859 2004 Central Standard Time>\<thread=1216 (0x4C0)>  
ERROR!! WBEM not found in the system path. $$\<CcmExec>\<Fri Feb 13 8:13:13.859 2004 Central Standard Time>\<thread=1216 (0x4C0)>  
Successfully added WBEM to the process environment variable PATH. $$\<CcmExec>\<Fri Feb 13 8:13:13.859 2004 Central Standard Time>\<thread=1216 (0x4C0)>  
Initializing COM. $$\<CcmExec>\<Fri Feb 13 8:13:13.859 2004 Central Standard Time>\<thread=1216 (0x4C0)>  
Registering for logging change notifications. $$\<CcmExec>\<Fri Feb 13 8:13:13.869 2004 Central Standard Time>\<thread=1216 (0x4C0)>  
Setting default logging component for process. $$\<CcmExec>\<Fri Feb 13 8:13:13.869 2004 Central Standard Time>\<thread=1216 (0x4C0)>  
Setting service status to RUNNING. $$\<CcmExec>\<Fri Feb 13 8:13:13.869 2004 Central Standard Time><thread=1216 (0x4C0)>  
Checking if repair is required. $$\<CcmExec>\<Fri Feb 13 8:13:13.889 2004 Central Standard Time><thread=1216 (0x4C0)>  
Failed to open to WMI namespace '\\\\.\root\ccm' (80004002) $$\<CcmExec>\<Fri Feb 13 8:13:17.224 2004 Central Standard Time>\<thread=1216 (0x4C0)>  
CCMExec.log file entry 2  
1/25/2006 9:16:35 PMFailed to open to WMI namespace '\\\\.\root\ccm' (8004100a)  
1/25/2006 9:16:35 PMCCMDoCertificateMaintenance failed (0x8004100a).  
1/25/2006 9:16:35 PMFailed to open to WMI namespace '\\\\.\root\CCM\Events' (8004100a)  
1/25/2006 9:16:35 PMCCMDoCertificateMaintenance() raised  CCM_ServiceHost_CertificateOperationsFailure status event.  
1/25/2006 9:16:35 PMLoading service settings.  
1/25/2006 9:16:35 PMFailed to open to WMI namespace '\\\\.\root\ccm\Policy\Machine' (8004100a)  
1/25/2006 9:16:35 PMError loading service settings. Code 0x8004100a  
1/25/2006 9:16:35 PMPhase 0 initialization failed (0x8004100a).  
1/25/2006 9:16:35 PMService initialization failed (0x8004100a).  
1/25/2006 9:16:35 PMShutting down AdditonallyCCMEXEC...  
Additionally, the Wbemcore.log file may contain an error entry that resembles the following:  
(Fri Feb 13 08:13:13 2004.69289) : Registry entry is indicating a setup is running  
(Fri Feb 13 08:14:13 2004.129856) : CFactory construct  
(Fri Feb 13 08:14:13 2004.129886) : CFactory destruct  
(Fri Feb 13 08:14:13 2004.129896) : Created WINMGMT_ACTIVE mutex  
(Fri Feb 13 08:14:13 2004.129946) : Reading config info from registry  
(Fri Feb 13 08:14:16 2004.132800) : Preparing a namespace init request for active namespace //./ROOT/ccm/policy  
(Fri Feb 13 08:14:16 2004.132901) : Preparing a namespace init request for active namespace //./root/CIMV2  
(Fri Feb 13 08:14:16 2004.132961) : Preparing a namespace init request for active namespace //./root/subscription  
(Fri Feb 13 08:14:16 2004.133021) : Initializing namespace //./ROOT/ccm/policy  
(Fri Feb 13 08:14:16 2004.133041) : Initializing namespace //./root  

## Cause

This problem occurs when one or both of the following conditions are true:  

- The %SystemRoot%\System32\Wbem path variable is not listed in the system path on the client computer.
- The type of the Path registry entry is incorrect on the SMS client computer.  

The problem may also occur when the Windows Management Instrumentation (WMI) service does not start in a timely manner.

## Resolution

To resolve this problem, use one of the following methods.

### Method 1: Make sure that the %SystemRoot%\System32\Wbem variable is listed in the system path on the client computer

1. Click **Start**, click **Run**, type sysdm.cpl, and then click **OK**.
2. Click the **Advanced** tab, and then click **Environment Variables**.
3. Under **System variables**, click **Path**, and then click **Edit**.
4. Make sure that **%SystemRoot%\System32\Wbem** is listed in the **Variable value** box. If this value is not listed, you must add it. To do it, follow these steps:  

    1. In the **Edit System Variable** dialog box, click after the end of text in the **Variable value** box, and then type:  
    `;%SystemRoot%\System32\Wbem`  

    2. Click **OK** three times to save the changes.

### Method 2: Set the type of the Path registry entry to REG_EXPAND_SZ

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall your operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.  

1. Click **Start**, click **Run**, type regedit, and then click **OK**.
2. In Registry Editor, locate and then click the following registry subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment`  

3. Make sure that the type of the **Path** entry is REG_EXPAND_SZ and not REG_SZ. If the type of this entry is REG_SZ, you must copy the path information, delete the existing Path entry, and then create a new entry of type REG_EXPAND_SZ. To do it, follow these steps:  

      1. In Registry Editor, double-click the **Path** value.
      2. Right-click the text in the **Value data** box, click **Copy**, and then click **Cancel**.
      3. Paste the text into a Notepad document.
      4. In Registry Editor, right-click **Path**, and then click **Delete**.
      5. On the menu bar, click **Edit**, point to **New**, and then click **Expandable String Value**.
      6. Type Path, and then press ENTER.
      7. Double-click **Path**.
      8. Right-click the **Value data** box, click **Paste**, and then click **OK**.
      9. Exit Registry Editor.

## More information

For more information on troubleshooting Advanced Client Push Installations, see the following article in the Microsoft Knowledge Base:  

[928282](https://support.microsoft.com/help/925282) How to troubleshoot Advanced Client Push Installation Issues in Systems Management Server 2003 and System Center Configuration Manager 2007
