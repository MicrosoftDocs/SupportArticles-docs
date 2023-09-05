---
title: c00002e2 error occurs
description: Helps to fix the error c00002e2 or "Choose an option" when Domain controller does not start.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, nedpyle
ms.custom: sap:active-directory-backup-restore-or-disaster-recovery, csstroubleshoot
ms.technology: windows-server-active-directory
---
# Domain controller does not start, c00002e2 error occurs, or "Choose an option" is displayed

This article helps to fix the error c00002e2 or "Choose an option" when Domain controller does not start.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2737463

## Symptoms

A domain controller does not start or does not display the logon screen. After you restart the domain controller and watch the start process, you notice the following symptoms, according to your operating system.

Windows Server 2008 R2 or Windows Server 2008  

1. At startup, the server experiences a Stop error and briefly displays the following error message:  

    >STOP: c00002e2 Directory Services could not start because of the following error:  
    The specified procedure could not be found  
    Error status: 0xc000007a.

2. The server then switches to the startup menu for recovery or for a regular startup.  

Windows Server 2012 and later versions  

At startup, the server switches to the **Choose an option**  menu that offers to continue or troubleshoot.

## Cause

This issue happens because the Active Directory Domain Services role was removed from a domain controller without first demoting it. Using Dism.exe, Pkgmgr.exe, or Ocsetup.exe to remove the DirectoryServices-DomainController role will succeed, but these servicing tools do not validate whether the computer is a domain controller.

## Resolution

> [!NOTE]
> These steps assume that you have other working domain controllers, and you only want to remove Active Directory Domain Services from this server. If you do not have other working domain controllers, and this is the only domain controller in the domain, you must restore an earlier system state backup.

Windows Server 2008 R2 or Windows Server 2008  

1. Restart the server while you hold Shift+F8.
2. Select **Directory Services Repair Mode** (DSRM), and then log on by using the DSRM account.
3. Validate that the role was removed. For example, to do it on Windows Server 2008 R2, use the following command:

   ```console
   dism.exe /online /get-features
   ```

4. Add the DirectoryServices-DomainController role back to the server. For example, to do it on Windows Server 2008 R2, use the following command:

   ```console
   dism.exe /online /enable-feature /featurename:DirectoryServices-DomainController
   ```

5. Restart and select **Directory Services Restore Mode** again.
6. Apply a /forceremoval parameter to remove Active Directory Domain Services from the domain controller. To do it, run the following command:

   ```console
   dcpromo.exe /forceremoval
   ```

7. To remove the domain controller metadata, use the ntdsutil.exe or dsa.msc tool.  

 Windows Server 2012 and later versions  

1. From the **Choose an option** menu, select **Troubleshoot**, click **Startup Settings**, and then click **Restart**.
2. Select **Directory Services Repair Mode** (DSRM), and then log on by using the DSRM password.
3. Validate that the role was removed. To do it, use the following command:

   ```console
   dism.exe /online /get-features
   ```

4. Add the DirectoryServices-DomainController role back to the server. To do it, use the following command:

   ```console
   dism.exe /online /enable-feature /featurename:DirectoryServices-DomainController
   ```

5. Restart, select **Directory Services Restore Mode** again, and log on by using the DSRM account.
6. Use Server Manager or Windows PowerShell, and apply a -ForceRemoval parameter to remove Active Directory Domain Services from the domain controller. To do it, run the following command:  

   ```powershell
   Uninstall-AddsDomaincontroller -ForceRemoval  
   ```

7. To remove the domain controller metadata, use the ntdsutil.exe or dsa.msc tool.

## More information

Always use Server Manager or the ServerManager Windows PowerShell module to remove the Active Directory Domain Services role binaries. These tools validate whether a server is an active domain controller and do not let you remove critical files.

For more information about how to remove domain controller metadata, go to the following Microsoft TechNet website:  
 [Clean Up Server Metadata](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc816907%28v=ws.10%29)  
If it is the only server domain in the domain, do not remove the Active Directory Domain Services from the server. Instead, restore its system state from the most recent backup.
