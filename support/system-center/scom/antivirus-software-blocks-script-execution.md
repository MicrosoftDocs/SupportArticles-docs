---
title: Antivirus software blocks script execution
description: Fixes an issue in which antivirus software blocks script execution in System Center Operations Manager.
ms.date: 04/15/2024
ms.reviewer: adoyle, jchornbe, jarrettr
---
# Antivirus software blocks script execution in System Center Operations Manager

This article provides a resolution to solve the **Script or Executable Failed to run** warning that's caused by some antivirus software in System Center Operations Manager.

_Original product version:_ &nbsp; System Center 2012 Operations Manager  
_Original KB number:_ &nbsp; 967503

## Symptoms

In System Center Operations Manager, you may receive alerts that have a warning severity that resembles the following:

> Script or Executable Failed to run
>
> The process started at *DateTime* failed to create System.PropertyBagData, no errors detected in the output. The process exited with 1
>
> Command executed: "C:\WINDOWS\system32\cscript.exe" //nologo "C:\Program Files\System Center Operations Manager \<version>\Health Service State\Monitoring Host Temporary Files 73\3456\ScriptName.vbs"
>
> Working Directory: C:\Program Files\System Center Operations Manager \<version>\Health Service State\Monitoring Host Temporary Files 73\3456\
>
> One or more workflows were affected by this.

## Cause

This problem occurs because some antivirus software blocks Visual Basic scripts or Java scripts.

## Resolution

To resolve this problem, verify that your antivirus software is not blocking scripts from running.
