---
title: Server App-V Agent installer custom actions
description: Describes a list of the custom actions for the Server Application Virtualization (Server App-V) Agent installer package.
ms.date: 04/29/2020
ms.reviewer: jeffpatt
---
# Custom actions for the Server Application Virtualization (Server App-V) Agent installer package

This article describes a list of the custom actions for the Server Application Virtualization (Server App-V) Agent installer package.

_Original product version:_ &nbsp; System Center 2012 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2704938

## Custom actions

|Installer|Custom action (CA)|Method name|Description|
|---|---|---|---|
|Server App-V Agent|`MUOptinRequired`|`MUOptinRequired`|This is an immediate custom action to check if MU option is required. If MU option is required, MU option page will be shown to the user by the user interface, if the user is running in UI mode.|
|Server App-V Agent|`OptinToMU`|`OptinToMU`|This is a deferred custom action to perform MU option. This custom action runs as elevated and impersonated (runs as the user running setup).|
|Server App-V Agent|`RegisterMOFFile`|`RegisterMOFFile`|This custom action registers a MOF file during install.
|Server App-V Agent|`RollbackRegisterMOFFile`|`RegisterMOFFile`|This custom action unregisters a MOF file during rollback when install is interrupted.|
|Server App-V Agent|`UnregisterMOFFile`|`RegisterMOFFile`|This custom action unregisters a MOF file during uninstall.|
|Server App-V Agent|`RollbackUnregisterMOFFile`|`RegisterMOFFile`|This custom action registers a MOF file during rollback when uninstall is interrupted.|
|Server App-V Agent|`ModifyAppInitDllProperty`|`ModifyAppInitDllProperty`|Reads the `AppInitDll` registry value from registry and appends a space to the cached value if the original value is not empty.|
|Server App-V Agent|`ModifyAppInitDllRegistryValue`|`ModifyAppInitDllRegistryValue`|This is a deferred custom action, that is run during uninstall. This custom action modifies app init registry value and deletes the value **avcpmon.dll** from it. If this results in app init registry value being empty, on windows 2008 and above machines, this also sets `load_appinitdll` registry value to **0**.|
|Server App-V Agent|`RollbackAppInitDllRegistryValue`|`RollbackAppInitDllRegistryValue`|This is a rollback custom action, that sets the value of `AppInitDll` registry value back to its original state at the time of uninstall.|
|Server App-V Agent|`SetModifyAppInitDllRegistryValue`|N/A|This sets an MSI property that includes new `AppInitDll` value with the avcpmon dll path.|
|Server App-V Agent|`SetOptinToMU`|N/A|This sets an MSI property that includes a path to the MU auth cab file.|
|Server App-V Agent|`SetRegisterMOFFile`|N/A|This sets an MSI property that includes a path to the MOF file to register the MOF file.|
|Server App-V Agent|`SetRollbackAppInitDllRegistryValue`|N/A|This sets an MSI property that includes the `AppInitDll` registry value.|
|Server App-V Agent|`SetRollbackRegisterMOFFile`|N/A|This sets an MSI property that includes a path to the MOF file to unregister the MOF file.|
|Server App-V Agent|`SetRollbackUnregisterMOFFile`|N/A|This sets an MSI property that includes a path to the MOF file to register the MOF file.|
|Server App-V Agent|`SetSSRSRealTlsAllocCountProperty`|N/A|This sets an MSI property that includes the number of TLS slots to allocate in SQL Server Reporting Services (SSRS) injector subsystem.|
|Server App-V Agent|`SetUnregisterMOFFile`|N/A|This sets an MSI property that includes a path to the MOF file to unregister the MOF file.|
|Server App-V Agent|`SetAVCPMon32PathProperty`|N/A|This sets an MSI property that includes the path to the avcpmon dll file.|
|Server App-V Agent|`SetAppInit_Dll32AdditionProperty`|N/A|This sets an MSI property that includes the path to the avcpmon dll file.|
