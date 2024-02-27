---
title: OSDResults doesn't display applications installed by UDI
description: Describes an issue in which applications installed by a Configuration Manager UDI task sequence aren't displayed in the Deployment Complete dialog box.
ms.date: 12/05/2023
ms.reviewer: kaushika
---
# OSDResults doesn't display applications installed by a UDI task sequence in Configuration Manager

This article fixes an issue in which applications installed by a Configuration Manager User-Driven Installation (UDI) task sequence aren't displayed in the Deployment Complete dialog box.

_Original product version:_ &nbsp; Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 4493667

## Symptoms

You create a Microsoft Deployment Toolkit (MDT) integrated UDI task sequence in Configuration Manager current branch version 1806 or a later version. In the task sequence, users can select the applications to install at deployment time. After the task sequence runs, OSDResults doesn't display the packages or applications that were installed by the UDI wizard.

When this issue occurs, the following error messages are logged in SMSTS.log:

> TSManager    Executing command line: smsswd.exe /run: cscript.exe //nologo "%deployroot%\Scripts\OSD_BaseVariables.vbs"  
> InstallSoftware     ===================== [ smsswd.exe ] =======================  
> InstallSoftware    PackageID = ''  
> InstallSoftware    BaseVar = '', ContinueOnError=''  
> InstallSoftware    ProgramName is logged, to ensure it not shown in log set 'OSDDoNotLogCommand' task sequence variable to 'True'  
> InstallSoftware    ProgramName = 'cscript.exe //nologo "C:\\_SMSTaskSequence\WDPackage\Scripts\OSD_BaseVariables.vbs"'  
> InstallSoftware    SwdAction = '0001'  
> InstallSoftware    Command line for extension .exe is "%1" %*  
> InstallSoftware    Set command line: Run command line  
> InstallSoftware    Working dir 'not set'  
> InstallSoftware    Executing command line: Run command line  
> InstallSoftware    Process completed with exit code 200  
> InstallSoftware    --------------------------------  
> InstallSoftware    Initializing Objects  
> InstallSoftware    --------------------------------  
> InstallSoftware  
> InstallSoftware    --------------------------------  
> InstallSoftware    Extracting TS Base Variable  
> InstallSoftware    --------------------------------  
> InstallSoftware  
> InstallSoftware    Reading OSD variable: [_SMSTSTaskSequence]  
> InstallSoftware    Loading XML from variable string content...  
> InstallSoftware    Using XPATH to query for [BaseVariableName]  
> InstallSoftware    Failed to read XPATH query value, or value is empty.  
> InstallSoftware    --------------------------------  
> InstallSoftware     Exiting with [200]  
> InstallSoftware    --------------------------------  
> InstallSoftware    Command line cscript.exe //nologo "C:\\_SMSTaskSequence\WDPackage\Scripts\OSD_BaseVariables.vbs" returned 200  
> TSManager    Process completed with exit code 200  
> TSManager    !------------------------------------------------------------------!  
> TSManager    Failed to run the action: Parse Base Variable.  
> The code segment cannot be greater than or equal to 64K. (Error: 000000C8; Source: Windows)

## Cause

This issue occurs under one of the following conditions:

- In the task sequence, the dynamic **Install Application** step runs before the dynamic **Install Package** step.

  The dynamic **Install Package** step must run before the dynamic **Install Application** step.

- In the task sequence, a static **Install Package** or static **Install Application** step runs before the dynamic **Install Package** and dynamic **Install Application** steps.

  All static **Install Package** and static **Install Application** steps must run after the dynamic **Install Package** and dynamic **Install Application** steps.

When the tasks in the task sequence aren't run in the proper order, the `OSD_BaseVariables.vbs` MDT script can't populate the necessary registry values. The script runs during the **Parse Base Variables** action and is responsible for populating registry values that are used by OSDResults. The script parses the task sequence XML in a predefined order looking for the base variables in the dynamic **Install Package** and dynamic **Install Application** steps. When either of the conditions occur, `OSD_BaseVariables.vbs` can't read the base variables correctly.

> [!NOTE]
>
> - In the MDT UDI task sequence, the dynamic **Install Package** step is displayed as **Install Software**.
> - A dynamic **Install Package** or dynamic **Install Application** step installs packages or applications by using a dynamic variable list. Otherwise, we call it a static **Install Package** or static **Install Application** step.

## Resolution

To fix the issue, in the task sequence:

1. Make sure that the dynamic **Install Package** (displayed as **Install Software**) step is placed before the dynamic **Install Application** step.
2. Make sure that all static **Install Package** and static **Install Application** steps are placed after the dynamic **Install Package** (displayed as **Install Software**) and dynamic **Install Application** steps.

> [!NOTE]
>
> - By default, the dynamic **Install Application** step is under the **Install Applications** group. When you change the order of the steps, don't remove the dynamic **Install Application** step from the group, and make sure that the original order of steps in the group is preserved.
> - Also, make sure that the **Install Applications** group is placed after the dynamic **Install Package** (displayed as **Install Software**) step, but before any static **Install Package** or static **Install Application** steps.
