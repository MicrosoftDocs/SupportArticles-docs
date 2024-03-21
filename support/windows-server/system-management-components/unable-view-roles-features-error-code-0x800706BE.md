---
title: error code 0x800706BE
description: Provides a resolution for the issue that you are unable to view Roles and Features and receive error code 0x800706BE in Server Manager.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:System Management Components\Server Manager, csstroubleshoot
---
# You are unable to view Roles and Features and receive error code 0x800706BE in Server Manager

This article provides a resolution for the issue that you are unable to view Roles and Features and receive error code 0x800706BE in Server Manager.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2461206

## Symptoms

Consider the following scenario:  

1. You have a computer that is running Windows Server 2008 or Windows Server 2008 R2.
2. You open the Server Manager window to view/add/remove roles and features.  

In this scenario, roles and features are not displayed with a yellow bang against them in the Server Manager window. You receive the following error message at the bottom of Server Manager if you try to open it:  

>Server Manager  
Unexpected error refreshing Server Manager: The remote procedure call failed. (Exception from HRESULT: 0x800706BE)  
For more information, see the event log: Diagnostics, Event Viewer, Applications and Services Logs, Microsoft, Windows, Server Manager, Operational.)  

At the same time, the event below is added into the Microsoft-Windows-ServerManager/Operational log:  

>Log Name:      Microsoft-Windows-ServerManager/Operational  
Source:        Microsoft-Windows-ServerManager  
Date:          \<date & time>  
Event ID:      1601  
Task Category: None  
Level:         Error  
Keywords:  
User:          \<user name>  
Computer:      \<computer name>  
Description:  
Could not discover the state of the system. An unexpected exception was found:  
System.Runtime.InteropServices.COMException (0x800706BE): The remote procedure call failed. (Exception from HRESULT: 0x800706BE)  
   at System.Runtime.InteropServices.Marshal.ThrowExceptionForHRInternal(Int32 errorCode, IntPtr errorInfo)  
   at Microsoft.Windows.ServerManager.ComponentInstaller.CreateSessionAndPackage(IntPtr& session, IntPtr& package)  
   at Microsoft.Windows.ServerManager.ComponentInstaller.InitializeUpdateInfo()  
   at Microsoft.Windows.ServerManager.ComponentInstaller.Initialize()  
   at Microsoft.Windows.ServerManager.Common.Provider.RefreshDiscovery()  
   at Microsoft.Windows.ServerManager.LocalResult.PerformDiscovery()  
   at Microsoft.Windows.ServerManager.ServerManagerModel.CreateLocalResult(RefreshType refreshType)  
   at Microsoft.Windows.ServerManager.ServerManagerModel.InternalRefreshModelResult(Object state)  

## Cause

Some catalog files, manifest files, or MUM files are corrupted on the computer.

## Resolution

Here are the steps to fix the issue:  

1. Get the Microsoft Update Readiness Tool from the location: [https://support.microsoft.com/kb/947821](https://support.microsoft.com/kb/947821).  
2. Run the Microsoft Update Readiness Tool on the problematic computer.
3. You open the %Systemroot%\\Windows\\logs\\CBS\\Checksur.log file after the scan was completed.
4. You check corrupt information in the files. Here are some samples:  
    > (f) CBS MUM Corrupt 0x00000000 servicing\\Packages\\Package_for_KB978601~31bf3856ad364e35~amd64\~~6.0.1.0.mum  Expected file name Package_for_KB978601_server~31bf3856ad364e35~amd64\~~6.0.1.0.mum does not match the actual file name  
    (f) CBS MUM Corrupt 0x00000000 servicing\\Packages\\Package_for_KB979309~31bf3856ad364e35~amd64\~~6.0.1.0.mum  Expected file name Package_for_KB979309_server~31bf3856ad364e35~amd64\~~6.0.1.0.mum does not match the actual file name

    Or  

    > (f) CBS MUM Corrupt 0x800B0100  servicing\\Packages\\Package_for_KB978601~31bf3856ad364e35~amd64\~~6.0.1.0.mum   servicing\\Packages\\Package_for_KB978601~31bf3856ad364e35~amd64\~~6.0.1.0.cat Package   manifest cannot be validated by the corresponding catalog
    (f) CBS MUM Corrupt 0x800B0100   servicing\\Packages\\Package_for_KB979309~31bf3856ad364e35~amd64\~~6.0.1.0.mum  servicing\\Packages\\Package_for_KB979309~31bf3856ad364e35~amd64\~~6.0.1.0.cat Package  manifest cannot be validated by the corresponding catalog

    Or  
    > (f) CBS MUM Missing 0x00000002   servicing\\packages\\Package_114_for_KB955839~31bf3856ad364e35~amd64\~~6.0.1.0.mum
    (f) CBS MUM Missing 0x00000002   servicing\\packages\\Package_83_for_KB955839~31bf3856ad364e35~amd64\~~6.0.1.0.mum

    Further down you will see:  

    > Unavailable repair files:  
    servicing\\packages\\Package_for_KB978601~31bf3856ad364e35~amd64\~~6.0.1.0.mum  
    servicing\\packages\\Package_for_KB979309~31bf3856ad364e35~amd64\~~6.0.1.0.mum  
    servicing\\packages\\Package_for_KB978601~31bf3856ad364e35~amd64\~~6.0.1.0.cat  
    servicing\\packages\\Package_for_KB979309~31bf3856ad364e35~amd64\~~6.0.1.0.cat  

Copy these files into: %systemroot\\Windows\\Servicing\\Packages.  

1. You first need to gain control over that folder. In order to do this, use the following commands:

    ```console  
    takeown /F c:\Windows\Servicing\Packages /D y /R
    ```

2. Now assign full control using the following command. It will grant you full control over the directory:

    ```console  
    cacls c:\Windows\Servicing\Packages /E /T /C /G "UserName": F
    ```

3. Now you need to gather the missing or corrupted files from the `checksur` log:
download the KB files for the missing files.

    > servicing\\packages\\Package_for_ KB978601 ~31bf3856ad364e35~amd64~~6.0.1.0.mum

4. Unpack them using the following command:

    ```console  
    Expand -F:\* UpdateKBXXXX.msu x:\DestinationDirectory
    ```

5. After you expand, you will see an UpdateKBXXXX.cab File. Expand it as well:

    ```console  
    Expand -F:\* UpdateKBXXXX.CAB x:\DestinationDirectoryCAB
    ```

   Inside of this cab you will need to grab two files: update.mum and update.cat.  
6. Rename the gathered update.mum and update.cab files exactly as they are in the checksur.log:

    > Ex.: update.mum for KB978601 will be Package_for_ KB978601 ~31bf3856ad364e35~amd64~~6.0.1.0.mum  
    Do the same for all the other missing/corrupt files and place them into the directory specified in checksur.log (/servicing/packages).

After these steps, the problem should be fixed, no reboot required.

>[!Note]
>If Server Manager is not working even after doing these steps, run the Update Readiness Tool again and double check the steps described above.
