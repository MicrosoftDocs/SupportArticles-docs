---
title: Sysprep may fail after Internet Explorer 10 is installed
description: After installing Internet Explorer 10 on Windows 7, Sysprep may fail to execute, since iesysprep.dll registry configurations are point to SysWOW64, instead of System32.
ms.date: 06/09/2020
ms.reviewer: 
---
# Sysprep in Windows 7 may fail after Internet Explorer 10 is installed

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides information on how to change the registry to ensure that **Sysprep** can be successfully executed after installing Internet Explorer 10 on Windows 7.

_Original product version:_ &nbsp; Internet Explorer 11, Internet Explorer 10  
_Original KB number:_ &nbsp; 2868126

## Symptoms

After installing Internet Explorer 10 on Windows 7, executing **Sysprep** may fail with the following error:
> SYSPRP LaunchDll:Could not load DLL C:\Windows\SysWOW64\iesysprep.dll[gle=0x000000c1]

## Cause

This occurs error because the relevant **Sysprep** registry entries point to the wrong location, for **iesysprep.dll**, after installing Internet Explorer 10.

## Resolution

In order to successfully execute **Sysprep** in a machine in this state, please follow these steps:

1. Change the default permissions in the following registry keys to include **Full Control** for the **Administrators** group. (check step 3 on how to do it using the **regini.exe** utility):

    - `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Setup\Sysprep\Cleanup`
    - `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Setup\Sysprep\Generalize`
    - `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Setup\Sysprep\Specialize`

2. Change the value **{EC9FE15D-99DD-4FB9-90D5-676C338DC1DA}** to the following, for all three registry keys:

    - `reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Setup\Sysprep\Cleanup /v {EC9FE15D-99DD-4FB9-90D5-5B56E42A0F80} /t REG_SZ /d "C:\Windows\System32\iesysprep.dll,Sysprep_Cleanup_IE" /f`
    - `reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Setup\Sysprep\Generalize /v {EC9FE15D-99DD-4FB9-90D5-CE53C91AB9A1} /t REG_SZ /d "C:\Windows\System32\iesysprep.dll,Sysprep_Generalize_IE" /f`
    - `reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Setup\Sysprep\Specialize /v {EC9FE15D-99DD-4FB9-90D5-676C338DC1DA} /t REG_SZ /d "C:\Windows\System32\iesysprep.dll,Sysprep_Specialize_IE" /f`

3. Execute Sysprep again.

    For step 1, you can use the **regini.exe** utility to change permissions on the mentioned registry keys. For more information, see [How to change registry values or permissions from a command line or a script](https://support.microsoft.com/help/264584).
