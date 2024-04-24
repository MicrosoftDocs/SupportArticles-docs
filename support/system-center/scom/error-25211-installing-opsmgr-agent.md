---
title: Error 25211 installing the Operations Manager agent
description: Fixes an issue in which you receive an Error 25211-The parameter is incorrect message when you try to install the Operations Manager agent on Windows Server 2008 SP2.
ms.date: 04/15/2024
ms.reviewer: danmul, michjohn, magoedte
---
# Error 25211 when you try to install the System Center Operations Manager agent

This article helps you fix an issue in which you can't install Microsoft System Center Operations Manager agent on Windows Server 2008 Service Pack 2 and receive error 25211.

_Original product version:_ &nbsp; System Center 2016 Operations Manager, System Center 2012 R2 Operations Manager, Microsoft System Center 2012 Operations Manager  
_Original KB number:_ &nbsp; 4036329

## Symptoms

When you try to install the System Center Operations Manager agent on Windows Server 2008 Service Pack 2, the installation fails, and you receive the following error message:

> Error 25211. Failed to install performance counters.. Error Code: -2147024809 (The parameter is incorrect.).

You may receive a different error code, such as the following:

> Error Code: -2147024894 (The system cannot find the file specified.).

Additionally, the event log displays the following event:

> Event Type: Error  
> Event Source: MsiInstaller  
> Event Category: None  
> Event ID: 10005  
> User:  \<USER_NAME>  
> Computer: \<COMPUTER_NAME>  
> Description:  
> Product: System Center Operations Manager \<VERSION> Agent -- Error 25211.Failed to install performance counters.. Error Code: -2147024809 (The parameter is incorrect.).

## Cause

This issue occurs for any of the following reasons:

- Some registry keys are missing.
- The Perfh009.dat file is locked by another process.
- Some performance counters are corrupted.

## Resolution

To fix this issue, try the following steps in the given order:

1. Install the Operations Manager agent by running the following command at an elevated command prompt:

   ```console
   msiexec.exe /i MOMAgent.msi NOAPM=1
   ```

   If the issue persists, go to step 2.

2. Determine whether the following full registry subkeys exist:

   - `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\HealthService\Performance`

   - `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MOMConnector\Performance`

   Create the indicated **Performance** keys if they don't exist, and then reinstall the Operations Manager agent.

   > [!NOTE]
   > You don't have to create values for the new registry keys.

   If the issue persists, go to step 3.

3. Use a tool such as [Process Monitor](/sysinternals/downloads/procmon) or [Process Explorer](/sysinternals/downloads/process-explorer) to determine whether Perfh009.dat is locked by another process. If Perfh009.dat is locked, stop the other process, and then reinstall the Operations Manager agent.

   If Perfh009.dat isn't locked or if the issue persists, go to step 4.

4. [Rebuild the performance counter library](https://support.microsoft.com/help/300956/how-to-manually-rebuild-performance-counter-library-values), and then reinstall the Operations Manager agent.
