---
title: Data collected by Dynamics CRM for Outlook Configuration Collector
description: This article describes the data that is collected by the Microsoft Dynamics CRM Client for Microsoft Office Outlook Configuration diagnostic tool.
ms.reviewer: 
ms.topic: article
ms.date: 3/31/2021
---
# [SDP 3][13e2903d-be79-4d6d-a928-d90580283cc8] Microsoft Dynamics CRM Client for Outlook Configuration Collector

The Microsoft Dynamics CRM Client for Microsoft Office Outlook Configuration diagnostic tool collects information related to configuration issues with the Microsoft Dynamics CRM Client. This article describes the information that may be collected from a machine when running the Microsoft Dynamics CRM Client for Outlook Configuration diagnostic tool.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2764449

> [!NOTE]
>
> This collector creates a report file prefaced with the *ComputerName* on which the Microsoft Support Diagnostic Tool is run.

## Information collected

### Operating system information

| Description| File Name |
|---|---|
|Operating System Version Information| *ComputerName_DateRan.htm* |

### Installed applications

| Description| File Name |
|---|---|
|Lists the applications that are installed on the Microsoft Dynamics CRM Client For Outlook computer.| *ComputerName_DateRan.htm* |

### Internet Explorer and Office version information

| Description| File Name |
|---|---|
|Lists the versions of Internet Explorer and Microsoft Office| *ComputerName_DateRan.htm* |

### Microsoft Outlook Add-in information  

| Description| File Name |
|---|---|
|Lists the add-ins that are installed for use with Microsoft Outlook| *ComputerName_DateRan.htm* |

### Internet Explorer trusted sites and proxy settings

| Description| File Name |
|---|---|
|The file lists registry keys and values that are stored under the HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains registry hive. Additionally, this file also lists the registry keys and values under the HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings hive.| *ComputerName_DateRan.htm* |

### Microsoft Dynamics CRM registry values

| Description| File Name |
|---|---|
|Lists registry keys and values that are stored that are under HKEY_LocalMachine\Software\Microsoft\MSCRMClient registry hive.| *ComputerName_DateRan.htm* |

### Microsoft Dynamics CRM user registry values

| Description| File Name |
|---|---|
|Lists registry keys and values that are stored under HKEY_CurrentUser\Software\Microsoft\MSCRMClient registry hive.| *ComputerName_DateRan.htm* |

### Internet Explorer Security Zone settings

| Description| File Name |
|---|---|
|Lists values that are stored under HKEY_CurrentUser\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones registry hive.| *ComputerName_DateRan.htm* |

### Microsoft Dynamics CRM Client configuration error log

| Description| File Name |
|---|---|
|Lists the errors found in the Microsoft Dynamics CRM configuration log file.| *ComputerName_DateRan.htm* |

### Installed Microsoft CRM hotfixes

| Description| File Name |
|---|---|
|Lists all applied Microsoft Dynamics CRM hotfixes.| *ComputerName_DateRan.htm* |

### Microsoft Dynamics CRM files

| Description| File Name |
|---|---|
|Lists all files from the InstallPath registry key value, including dates and file versions.| *ComputerName_DateRan.htm* |

### Microsoft Dynamics CRM files that installed in assembly cache

| Description| File Name |
|---|---|
|Lists all Microsoft Dynamics CRM files that are installed in the global assembly cache on the CRM server.| *ComputerName_DateRan.htm* |

### TCP/IP configuration

| Description| File Name |
|---|---|
|Lists TCP/IP registry keys and their values.| *ComputerName_DateRan.htm* |

### Application logs

| Description| File Name |
|---|---|
|Event log - Application - all Microsoft Dynamics CRM events in the last seven days</br>Event log - Application - all ASP.NET events in the last seven days| *ComputerName_DateRan.htm* |

### Installed .NET information

| Description| File Name |
|---|---|
|Lists all .NET Framework versions that are installed on the client computer.| *ComputerName_DateRan.htm* |

### Group policy

| Description| File Name |
|---|---|
|Lists information about the applied Group Policy settings by using the gpresult utility.| *ComputerName_DateRan.htm* |

### Mail profile information

| Description| File Name |
|---|---|
|Lists the keys and values under the HKCU: Software\Microsoft\Windows NT\CurrentVersion\Windows Messaging Subsystem\Profiles registry hive.| *ComputerName_DateRan.htm*|

> [!NOTE]
> The setup and client configuration log files from the %APPDATA%\Microsoft\MSCRM\Logs file directory are also collected by this diagnostic tool.

## Additional information

This collector has a notifications area at the top of the diagnostic report detailing items that may be important to make note of. These are items that aren't at the root cause of an issue but are worth noting as they may affect the performance or usability of Microsoft Dynamics CRM. For this reason, they are called out at the top of the report to give them visibility.

1. Checks to see if configuring user is a local Administrator on the machine.
2. Verification that the time on the client computer is within five minutes of the time of the Microsoft Dynamics CRM Server.
3. Notification that errors exist in the Microsoft Dynamics CRM Client configuration log file.
4. Verification that the Windows Live Sign-in Assistant service is running.
5. Verification that the Microsoft Online Services Sign-in Assistant is running.
6. Determination that the Mapisvc.inf file exists on the client workstation.
7. Check to determine whether client can successfully access the URL's for Microsoft Dynamics CRM Online if needed.
8. Checks to see if the Microsoft Dynamics CRM website has been added to the Trusted Sites Zone in Internet Explorer.
9. Check for the presence of stored credentials on the client computer.
