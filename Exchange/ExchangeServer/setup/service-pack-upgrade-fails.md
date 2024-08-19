---
title: Service Pack upgrade fails
description: Provides a solution to an issue where upgrading Microsoft Exchange Server Service Pack fails.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Plan and Deploy\Exchange Install Issues, Cumulative or Security updates
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server
ms.date: 01/24/2024
ms.reviewer: v-six
---
# Exchange Service Pack upgrade fails with an unexpected error in ServiceControl.ps1

_Original KB number:_ &nbsp; 2034420

## Symptoms

When you attempt to upgrade Exchange Server 2007 by using `setup.com /m:upgrade`, the process mail fail during the Preparing Setup phase.

```console
Performing Microsoft Exchange Server Prerequisite Check  

Edge Transport Role Checks       ......................... COMPLETED  

Configuring Microsoft Exchange Server  

Preparing Setup                  ......................... FAILED
An unexpected error has occurred and debug information is being generated: Unex
pected error [0xCF6CDA0B] while executing command '$error.Clear(); $RoleNames =
$RoleRoles.Replace('Role','').Split(','); if( test-path "$env:TMP\StoppedService
s.xml" ) { .\ServiceControl.ps1 Stop $RoleNames; } else { .\ServiceControl.ps1 S
ave; .\ServiceControl.ps1 Stop $RoleNames; .\ServiceControl.ps1 DisableServices
$RoleNames; }'.
Unexpected error [0xCF6CDA0B] while executing command '$error.Clear(); $Rol
eNames = $RoleRoles.Replace('Role','').Split(','); if( test-path "$env:TMP\Stopp
edServices.xml" ) { .\ServiceControl.ps1 Stop $RoleNames; } else { .\ServiceCont
rol.ps1 Save; .\ServiceControl.ps1 Stop $RoleNames; .\ServiceControl.ps1 Disable
Services $RoleNames; }'.  

Exchange Server setup encountered an error.
```

> [!NOTE]
> The hexidecimal code in this error may vary.

## Cause

A Pre-Setup task was trying to execute ServiceControl.PS1 to stop all exchange services for the Exchange upgrade process. However, the ServiceControl.ps1 script has been flagged as `Do Not Run`.

## Resolution

1. Open the Exchange Management Shell and change directory to `<Service Pack installation path>:\Setup\ServerRoles\common\`.
2. Run `.\ServiceControl.ps1`.
3. You will see the default setting is `[D] Do not run`. Enter option `[A]` for `Always run`.
4. Close the Exchange Management Shell.
5. From a command prompt, run `setup.com /m:upgrade` again.

## More information

It's possible for the upgrade to fail while executing other scripts. You may be able to work around this by executing the required scripts from the Exchange Management Shell and allowing them to complete individually.
