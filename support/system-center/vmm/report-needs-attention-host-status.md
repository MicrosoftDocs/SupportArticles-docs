---
title: VMM reports a Needs Attention host status
description: fix an issue in which Virtual Machine Manager may report a Needs Attention status after you rebuild the Windows Management Instrumentation repository for a host.
ms.date: 04/09/2024
ms.reviewer: wenca, markstan
---
# Needs Attention host status after you rebuild the WMI repository

This article helps you fix an issue in which Virtual Machine Manager (VMM) may report a **Needs Attention** status after you rebuild the Windows Management Instrumentation (WMI) repository for a host.

_Original product version:_ &nbsp; Microsoft System Center 2012 R2 Virtual Machine Manager, System Center 2012 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2938227

## Symptoms

After you rebuild WMI repository for a host that is running Windows Server 2012 or Windows Server 2012 R2, Microsoft System Center 2012 Virtual Machine Manager may report a **Needs Attention** status for the host. Also, host update jobs finish with error 2915 and with the hexadecimal code 0x80338000 while they're trying to connect to the following WMI resource:

`https://schemas.microsoft.com/webm/wsman/1/wmi/root/standartcimv2/MSFT_NetAdapter`

An error similar to the following example will be displayed in the VMM Admin console:

> Error (2915)  
> The Windows Remote Management (WS-Management) service cannot process the request. The object was not found on the server (host.contoso.com).
>
> WinRM: URL: `https://host.contoso.com:5985`, Verb: [GET], Resource: [`https://schemas.microsoft.com/wbem/wsman/1/wmi/root/virtualization/v2/Msvm_VirtualSystemSettingData?InstanceID=Microsoft:73F1C285-7765-48F9-9472-9984B3B60336`]
>
> Unknown error (0x80338000)
>
> Recommended Action  
> Ensure that the VMM agent is installed and running. If the error persists, restart the virtualization server (PRDTDC-HVS001.cgli.int) and then try the operation again.

## Cause

Windows Server 2012 and Windows Server 2012 R2 have a known issue when they rebuild the WMI namespace. Specifically, both the removal of Managed Object Format (MOF) file and the installation MOF file are processed when the standard `mofcomp` command is issued to rebuild the WMI namespace. It can result in the installation MOF file being processed before the removal MOF file is processed. When it occurs, the WMI namespace isn't present after the rebuild.

## Resolution

To resolve this issue, use the following steps:

1. Open an elevated Command Prompt by right-clicking on the shortcut to Command Prompt and choosing **Run As Administrator** on the host computer.

2. Use the CD command to navigate to the `%windir%\System32\Wbem` directory.

3. Run the following command:

    ```console
    for /f %x in ('dir /b *.mof ^| findstr /v /i uninstall') do mofcomp %x
    ```

4. Return to the VMM Admin console and refresh the host computer.

These steps rebuild the WMI repository on the host. After the next host update in Virtual Machine Manager, the hosts should report that they are in the **Ready** state.
