---
title: Large WMI repository causes slow logon
description: Provides help to solve slow logon process that occurs when users log on to the Remote Desktop servers.
ms.date: 09/11/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, Ajayps
ms.prod-support-area-path: Boot is slow
ms.technology: Performance
---
# Unexpectedly slow logon caused by large WMI repository in Windows or Windows Server

This article provides help to solve slow logon process that occurs when users log on to the Remote Desktop servers.

_Original product version:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2020286

## Symptoms

You notice one of the following symptoms:
- The logon process is unexpectedly slow when users log on to the Remote Desktop servers.
- Users experience delays when they log on to the console of a Windows client or of a Windows Server-based computer.

This delay is logged in the Userenv.log log file in Windows Server 2003 and in the Gpsvc.log log file in Windows 8.1, Windows 8, and Windows 7 clients and on Windows Server 2012 R2-based, Windows Server 2012-based, Windows Server 2008 R2-based, and Windows Server 2008-based computers.
To enable USERENV Logging in Windows Server 2003, see the following Microsoft Knowledge Base article:
 [221833](https://support.microsoft.com/kb/221833) How to enable user environment debug logging in retail builds of Windows
 **Example Userenv.log entry:**  
USERENV(234.82c) 08:28:36:210 ParseRegistryFile: Leaving.
USERENV(234.82c) 08:30:26:839 LogRegistry RsopData: Successfully logged registry Rsop data

This example shows a ~ 2-minute delay in writing RSoP logging data.

### How to enable logging in the Gpsvc.log file on Windows 8.1, Windows 8, and Windows 7 clients and Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, and Windows Server 2008 computers

To enable logging in the Gpsvc.log file, follow these steps. 

**Important** This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/kb/322756) How to back up and restore the registry in Windows

1. Click **Start**, click **Run**, type regedit, and then click **OK**.
2. Locate and then click the following registry subkey: `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion` 

3. On the **Edit** menu, point to **New**, and then click **Key**.
4. Type Diagnostics, and then press Enter.
5. Right-click the **Diagnostics** entry, point to **New**, and then click **DWORD Value**.
6. Type GPSvcDebugLevel, and then press Enter.
7. Right-click **GPSvcDebugLevel**, and then click **Modify**.
8. In the **Value data** box, type **0x30002**, and then click **OK**.
9. Exit Registry Editor.
10. At a command prompt, type the following command, and then press Enter: gpupdate /force 

11. View the Gpsvc.log file in the following folder:%windir%\debug\usermode

**Note**  If the Usermode folder does not exist under %WINDIR%\debug\, the Gpsvc.log file will not be created. If the Usermode folder does not exist, create it under %windir%\debug.

 **Example Gpsvc.log entry:**  
GPSVC(638.13d4) hh:mm:41:316 AllocAdmFileInfo: Adding File name <\\contoso.com\sysvol\contoso.com\Policies\{\<policy guid>}\Adm\wuau.adm> to the Adm list.
GPSVC(638.13d4) hh:mm:47:556 LogRegistry RsopData: Successfully logged registry Rsop dataThis example shows a ~ 6-second delay in writing RSoP logging data.

## Cause

This issue may occur if RSoP logging is enabled and there is a large WMI repository on the problem Windows client or Windows Server computer. The WMI repository is located on the following path:
%windir%\System32\Wbem\Repository
RSoP uses the CIMOM database through WMI. When a computer logs on to a network, information such as the computer hardware, Group Policy Software Installation settings, Internet Explorer Maintenance settings, Scripts, Folder Redirection settings, and Security Settings, are written to the CIMOM database. When you start RSoP in logging mode, RSoP reports policy settings that have been applied by using the information that is provided in the CIMOM database.
The RSoP logging process to the WMI repository causes delays to console logons and especially Remote Desktop logons.
Larger WMI repository sizes in %windir%\system32\wbem\repository cause longer logon delays.
For more information about RSoP, see the following Microsoft TechNet topic:

[RSoP Overview](https://technet.microsoft.com/library/cc778752%28WS.10%29.aspx)

## Workaround

To work around this issue, determine the size of the WMI repository.

The WMI repository is located on the following path:
%windir%\System32\Wbem\Repository
If the size of the WMI repository is large, temporarily disable RSoP logging to monitor its impact on user logons.
To disable RSoP logging, enable the following Group Policy setting:

| Turn off RSoP logging (Computer Configuration/Administrative Templates/System/Group Policy)| This setting allows you to enable or disable Resultant Set of Policy (RSoP) logging on a client computer. |
|---|---|

 After you enable this policy, run **gpupdate /force** on the computer, and then restart the computer. Measure the impact on user logon duration. 
 **Note** By disabling RSoP logging, you prevent the RSoP snap-in (rsop.msc) from running on that computer. You can get RSoP modeling information by using the Group Policy Management Console (GPMC), if it is necessary.  

## More information

Article edited on April 4, 2014 by AJAYPS - Initial author sanmanp is no longer in the company

From case 109120272304694:
What the log tells me is only that RSoP is writing to the repository quite a bit.  I can't say why but you can see where RSoP related instances and classes are being written to the WMI repository by looking for the following in the wbemcore.log: 
Wed Dec 09 11:06:19 2009.2309671): CALL CWbemNamespace::PutClass
   long lFlags = 0x0
   IWbemClassObject *pObj = 0x48D17C0
   __CLASS=RSOP_IEToolbarButtonLink

(Wed Dec 09 11:06:19 2009.2309671): CALL CWbemNamespace::PutClass
   long lFlags = 0x0
   IWbemClassObject *pObj = 0x35C4CBF0
   __CLASS=RSOP_GPO
You will see these entries over and over again in the log. There are many activities to the WMI repository from RSoP but these are verbose logs so we will see just about everything that is done.  The above is an execution of the PutClass method and there are tons of these in the log.  I don't know how to tell if the method being executed is writing a new Class to the repository or updating an old one, but RSoP just seems to be busy. 

IWbemServices::PutClass Method
The IWbemServices::PutClass method creates a new class or updates an existing one. The class specified by the pObject parameter must have been correctly initialized with all of the required property values.
The user may not create classes with names that begin or end with an underscore (_). This is reserved for system classes.
This log is huge though and there is RSoP related stuff all over it, so I can only tell you what it is doing, I do not really know why.  I think it is because of how their profiles and policies are structured, and looking at the following case it seems that the only workaround here is to delete the repository from time to time when the size starts to affect logon performance or simply disable RSoP logging.  I'm sure they don't need to have RSoP logging enabled all the time for any other reason other than to troubleshoot a problem.

Recommendation will be to disable RSoP logging.
