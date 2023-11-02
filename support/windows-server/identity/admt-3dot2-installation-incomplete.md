---
title: ADMT 3.2 installation is incomplete
description: Fixes an error (Cannot open database "ADMT" requested by the login. The logon failed) that occurs when you run Active Directory Migration Tool (ADMT) console.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, nedpyle
ms.custom: sap:active-directory-migration-tool-admt, csstroubleshoot
ms.technology: windows-server-active-directory
---
# ADMT 3.2 installation incomplete, MMC console error "cannot open database 'ADMT' requested by the login"

This article provides help to an error (Cannot open database "ADMT" requested by the login. The logon failed) that occurs when you run Active Directory Migration Tool (ADMT) console.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2266373

## Symptoms

When installing ADMT 3.2 on a Windows Server 2008 R2 domain controller and using SQL Express 2008 with SP1 and SQL 2008 Cumulative Update 4, the installation completes without errors. However, the dialog "Active Directory Migration Tool Installation Wizard" is blank when the install is finished.

When then attempting to run the ADMT console, you receive error:
> Active Directory Migration Tool  
Unable to check for failed actions.:DBManager.IManageDB.1: Cannot open database "ADMT" requested by the login. The logon failed.  

The MMC console then displays:
> MMC could not create the snap-in.  
MMC could not create the snap-in. The snap-in might not have been installed correctly.  
Name: Active Directory Migration Tool  
CLSID: {E1975D70-3F8E-11D3-99EE-00C04F39BD92}  

## Cause

There is a code defect in how ADMT interoperates with SQL Express 2008 SP1 on domain controllers resulting in the "SQLServerMSSQLUser$ComputerName$InstanceName" group not being created. This group is required by ADMT to configure specific permissions during the ADMT install and allows the ADMT database to be created in the SQL instance. ADMT expects the group to be present, which leads to the blank dialog and an incomplete installation.

## Workaround 1

The standard practice is to install ADMT on a member computer in the target domain. Install SQL Express 2008 SP1 on a Windows 2008 R2 member server in the target domain and then install ADMT 3.2 on that same member server.

## Workaround 2

If you have a requirement to install ADMT 3.2 on a domain controller in order to use command-line or scripted user migrations with SID History, install SQL 2008 SP1 (non-Express edition) on a Windows Server 2008 R2 member server in the target domain and select that remote instance when installing ADMT 3.2 on the domain controller. Alternatively, you can install SQL Express 2005 SP3 on the domain controller.

## Workaround 3

If you have a requirement to install ADMT 3.2 and SQL Express 2008 SP1 on the same domain controller, use the following steps on the target domain's domain controller:

1. Install the Cumulative Update Package 4 for SQL Server 2008 on the domain controller.

2. Install SQL Express 2008 SP1 on the domain controller. Note the SQL instance name created during the install (default is SQLEXPRESS).

3. Create a domain local group with the format of "SQLServerMSSQLUser$\<DCComputerName>$\<InstanceName>". For example, if the domain controller is named "DC1" and the SQL instance was "SQLEXPRESS" you would run the following command in an elevated command prompt:

    ```console
    NET LOCALGROUP SQLServerMSSQLUser$DC1$SQLEXPRESS /ADD
    ```

4. Retrieve the SQL service SID using the SC.EXE command with the name of the SQL service instance. For example, if the SQL instance was "SQLEXPRESS" you would run the following command in an elevated command prompt and note the returned SERVICE SID value:

    ```console
    SC SHOWSID MSSQL$SQLEXPRESS
    ```

5. In the Windows directory, create the "ADMT" subfolder and a subfolder beneath that named "Data". For example, you would run the following command in an elevated command prompt:

    ```console
    MD %SystemRoot%\ADMT\Data
    ```

6. Using the SID retrieved in Step 4, set FULL CONTROL permissions on the %SystemRoot%\ADMT\Data folder. For example, if the SID returned in Step 4 was "S-1-5-80-3880006512-4290199581-3569869737-363123133" you would run the following command in an elevated command prompt:

    ```console
    ICACLS %systemroot%\ADMT\Data /grant *S-1-5-80-3880006512-4290199581-3569869737-363123133:F
    ```

7. Install ADMT 3.2 on the domain controller while selecting the local SQL Express 2008 instance.
