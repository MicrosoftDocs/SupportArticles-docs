---
title: Setup has detected Opalis 6.3 installed
description: Fixes an issue where you receive the Setup has detected Opalis 6.3 installed on this computer error when installing System Center 2012 Orchestrator.
ms.date: 08/04/2020
ms.reviewer: jfanjoy
---
# Setup has detected Opalis 6.3 installed on this computer error when installing System Center 2012 Orchestrator

This article helps you fix an issue where you receive the **Setup has detected Opalis 6.3 installed on this computer** error when installing System Center 2012 Orchestrator.

_Original product version:_ &nbsp; System Center 2012 Orchestrator  
_Original KB number:_ &nbsp; 2634522

## Symptoms

When installing all components of System Center 2012 Orchestrator or one of the individual components (Runbook Designer, runbook server, or Orchestration console and web service), the following error is received:

> Setup has detected Opalis 6.3 installed on this computer. To continue installing System Center 2012 Orchestrator, uninstall Opalis 6.3, and then run Setup again.  

## Cause

One or more Opalis Integration Server 6.3 components is being identified as installed by Windows Installer.

## Resolution

Remove the following programs using Windows **Programs and Features** (**Control Panel** > **Programs** > **Programs and Features**):

- Opalis Integration Server - Action Server
- Opalis Integration Server - Foundation Objects
- Opalis Integration Server v6.3 - Client
- Opalis Integration Server v6.3 - Management Service

If all of the above programs have been removed and no longer appear in **Programs and Features**, an artifact of one of the programs must still exist and is visible to Windows Installer. If this is the case, you can search the registry for each of the following identifiers and remove any that are found:

- {FE12BDDD-2CE7-4241-8B93-AF97BF361463} - (Opalis Integration Server v6.3 - Management Service)
- {2F8661D7-FE34-451F-800B-EEE98D8097E9} - (Opalis Integration Server - Action Server)
- {BAAC2B61-F3B5-4F13-AD13-784F59636F47} - (Opalis Integration Server v6.3 - Client)
- {EC6D5121-8B27-439F-A00D-AB69E273F346} - (Opalis Integration Server - Foundation Objects)

## More information

Depending on what artifact causes Windows Installer to recognize the program as at least partially installed, you may be able to utilize [MsiZap.exe](/windows/win32/msi/msizap-exe?redirectedfrom=MSDN) to forcibly remove the remaining artifacts as an alternative to manually modifying the registry.
