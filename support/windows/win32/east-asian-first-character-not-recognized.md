---
title: East Asian first character isn't recognized
description: This article provides resolutions for the problem where the first input character for East Asian languages isn't recognized correctly in DataGridView cell on Windows 10.
ms.date: 01/29/2021
ms.custom: sap:Desktop app UI development
ms.reviewer: hirotoh
ms.subservice: desktop-app-ui-dev
---
# East Asian language first character not recognized in DataGrid cell

This article helps you resolve the problem where the first input character for East Asian languages isn't recognized correctly in DataGridView cell on Windows 10.

_Original product version:_ &nbsp; Windows 10  
_Original KB number:_ &nbsp; 4563779

## Symptoms

The first input character for East Asian Languages isn't recognized correctly by IME in DataGrid cell.

## Cause

The input composition for Edit control doesn't include the first character typed into the DataGrid cell. The text entered could therefore be incorrect.  The Edit control content must be cleared to ensure the correct text is entered. This is an application compatibility issue. Changing compatibility registry is workaround.

## Resolution

> [!IMPORTANT]
> This section explains how to modify the registry. Improper modifications can cause serious issues. Follow the steps carefully to avoid any mistake. For added protection, back up the registry so that it can be restored if a problem occurs.

For more information about how to back up and restore the registry, see: [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

There are two registry keys to address this problem. Customers can apply one of the following registry key to the system.

Consider the following scenario.

- If you have multiple applications that encounter this problem and each application has a different Window Class name for each DataGrid cell. In this case, you can add the new registry key, which contains an executable file name of application. Then, you will set the value to 0x00008000. You will need to repeatedly set up the registry keys for every single application.

- If you have multiple applications that encounter this problem but your applications use single-Window Class name for DataGrid cell because all of those applications' Window Class names are the same. In this case, you can add `AppCompatClassName` registry key. Then, you will set the value to Window class name of your application.

1. **For specific process name:**  
 **Registry entry**  

    > HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\Compatibility\\\<ExecutableFileName>  
    REG_DWORD: Compatibility  
    DWORD Value: 0x00008000 (Hex value of 32,768)

    If x86 applications are executed on a x64 Windows system, the following registry key can be applied instead of the one mentioned above:

    > HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\CTF\Compatibility\\\<ExecutableFileName>  
    REG_DWORD: Compatibility  
    DWORD Value: 0x00008000 (Hex value of 32,768)

    For example: The workaround for a specific executable file name such as `sample.exe`

    > HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\Compatibility\sample.exe  
    REG_DWORD: Compatibility  
    DWORD Value: 0x00008000 (Hex value of 32,768)

2. **For specific Windows class name:**  
 If you use this scenario, you have to apply following Windows Updates on your system.

    | Windows 10 Version| Article link |
    |---|---|
    | Windows 10 Version 1803| [KB4550944](https://support.microsoft.com/help/4550944) |
    | Windows 10 Version 1809| [KB4550969](https://support.microsoft.com/help/4550969) |
    | Windows 10 Version 1903| [KB4541335](https://support.microsoft.com/help/4541335) |
    | Windows 10 Version 1909| [KB4541335](https://support.microsoft.com/help/4541335) |
    | Windows 10 Version 2004| [KB4571744](https://support.microsoft.com/help/4571744) |

    **Registry entry:**  

    > HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\Compatibility\AppCompatClassName  
    REG_SZ: Compatibility  
    String Value: \<WindowClassName>

    If x86 applications are executed on an x64 Windows system, the following registry key can be applied instead of the one mentioned above:

    > HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\CTF\Compatibility\AppCompatClassName  
    REG_SZ: Compatibility  
    String Value: \<WindowClassName>

    For example: The workaround for specific Window Class Name as **Edit**
  
    > KEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\CTF\Compatibility\AppCompatClassName  
    REG_SZ: Compatibility  
    String Value: Edit

## References

Learn about the terminology that Microsoft uses to describe software updates.
