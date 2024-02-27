---
title: Failures with the Capture User State task or task sequence
description: Fixes an issue where Capture User State task or task sequence fails when you do a hard-link migration in System Center 2012 Configuration Manager.
ms.date: 12/05/2023
ms.reviewer: kaushika, mansee, erinwi
---
# Failures with the Capture User State task or task sequence when using System Center 2012 Configuration Manager

This article helps you fix an issue where **Capture User State** task or task sequence fails when you do a hard-link migration in System Center 2012 Configuration Manager.

_Original product version:_ &nbsp; System Center 2012 Configuration Manager  
_Original KB number:_ &nbsp; 2713469

## Symptoms

When doing hard-link migrations in System Center 2012 Configuration Manager, the User State Migration Toolkit (USMT) state store becomes much bigger than expected and potentially causes disk space problems. This also potentially causes the **Capture User State** task and task sequence to fail.

## Cause

The **Capture User State** task of System Center 2012 Configuration Manager has the ability to set the USMT option of `/efs` to either `skip` or `copyraw` via the option **Skip Files that use the Encrypting File System (EFS)**. However there is no option to set it to `hardlink`. Without the ability to change the `efs` option to `hardlink`, a hard-link to the EFS file is not created and instead a full copy of the file is created.

## Resolution

Manually run USMT's scanstate.exe via a **Run Command Line** task that points to the USMT 4 package and provides a customized command line. An example command line using task sequence variables that does a hard-link migration with the `efs` option set to `hardlink` would be:

`.\%PROCESSOR_ARCHITECTURE%\scanstate.exe %OSDStateStorePath% /o /localonly /c /efs:hardlink /v:5 /l:%_SMSTSLogPath%\scanstate.log /progress:%_SMSTSLogPath%\scanstateprogress.log /i:.\%PROCESSOR_ARCHITECTURE%\migdocs.xml /i:.\%PROCESSOR_ARCHITECTURE%\migapp.xml /hardlink /nocompress %OSDMigrateAdditionalCaptureOptions%`
