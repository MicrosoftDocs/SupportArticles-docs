---
title: Server App-V Sequencer custom actions
description: Describes a list of the custom actions for the Server Application Virtualization (Server App-V) Sequencer installer package.
ms.date: 04/29/2020
ms.reviewer: jeffpatt
---
# Custom actions for the Server Application Virtualization (Server App-V) Sequencer installer package

This article describes a list of the custom actions for the Server Application Virtualization (Server App-V) Sequencer installer package.

_Original product version:_ &nbsp; System Center 2012 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2704939

## Custom actions

|Installer|Custom action (CA)|Method name|Description|
|---|---|---|---|
|Server App-V Sequencer|`MUOptinRequired`|`MUOptinRequired`|This is an immediate custom action to check if MU option is required.|
|Server App-V Sequencer|`OptinToMU`|`OptinToMU`|This is a deferred custom action to perform MU option. This custom action does not run in Sequencer.|
|Server App-V Sequencer|`SetSSRSRealTlsAllocCountProperty`|N/A|This sets an MSI property that includes the number of TLS slots to allocate in SQL Server Reporting Services (SSRS) injector subsystem.|
