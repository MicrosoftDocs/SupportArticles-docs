---
title: Change hard error popup handling
description: This article describes how to change the hard error popup mode and give example code.
ms.date: 03/13/2020
ms.custom: sap:Desktop app UI development
ms.reviewer: kayda
ms.topic: article
ms.technology: windows-dev-apps-desktop-app-ui-dev
---
# How to change hard error popup handling in Windows

In an unattended environment, you may want to automatically dispatch hard error popups that require user intervention. This article gives you the code you need to change the hard error popup mode.

_Original product version:_ &nbsp; Windows  
_Original KB number:_ &nbsp; 128642

## Summary

Windows allows the user to change the handling of hard error popups that result from application and system errors. Such errors include no disk in the drive and general protection (GP) faults.

These events cause a hard error popup to be displayed, which requires user intervention to dispatch. This behavior can be modified so that such errors are logged to the Windows event log. When the error is logged to the event log, no user intervention is necessary, and the system provides a default handler for the hard error. The user can examine the event log to determine the cause of the hard error.

## Registry entry

The following registry entry controls the hard error popup handling in Windows:  
`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Windows\ErrorMode`

## Valid modes

The following are valid values for `ErrorMode`:

- **Mode 0**

    This is the default operating mode that serializes the errors and waits for a response.

- **Mode 1**

    If the error doesn't come from the system, this is the normal operating mode. If the error comes from the system, this logs the error to the event log and returns **OK** to the hard error. No intervention is required and the popup isn't seen.

- **Mode 2**

    This always logs the error to the event log and returns **OK** to the hard error. Popups aren't seen.

In all modes, system-originated hard errors are logged to the system log. To run an unattended server, use mode 2.

## Sample code to change hard error popup mode

The following function changes the hard error popup mode. If the function succeeds, the return value is **TRUE**. If the function fails, the return value is **FALSE**.

```cpp
BOOL SetGlobalErrorMode(
    DWORD dwErrorMode   // specifies new ErrorMode value
    )
{
    HKEY hKey;
    LONG lRetCode;

    // make sure the value passed isn't out-of-bounds
    if (dwErrorMode > 2)
        return FALSE;

    if(RegOpenKeyEx(HKEY_LOCAL_MACHINE,
                    "SYSTEM\\CurrentControlSet\\Control\\Windows",
                    0,
                    KEY_SET_VALUE,
                    &hKey) != ERROR_SUCCESS)
        return FALSE;

    lRetCode=RegSetValueEx(hKey,
                            "ErrorMode",
                            0,
                            REG_DWORD,
                            (CONST BYTE *) &dwErrorMode,
                            sizeof(DWORD));

    RegCloseKey(hKey);
    if (lRetCode != ERROR_SUCCESS)
        return FALSE;

    return TRUE;
}
```

## Sample code to obtain hard error popup mode

The following function obtains the hard error popup mode. If the function succeeds, the return value is **TRUE**. If the function fails, the return value is **FALSE**. If the function succeeds, `dwErrorMode` contains the error popup mode. Otherwise, `dwErrorMode` is undefined.

```cpp
BOOL GetGlobalErrorMode(
    LPDWORD dwErrorMode // Pointer to a DWORD to place popup mode
    )
{
    HKEY hKey;
    LONG lRetCode;
    DWORD cbData=sizeof(DWORD);

    if(RegOpenKeyEx(HKEY_LOCAL_MACHINE,
                    "SYSTEM\\CurrentControlSet\\Control\\Windows",
                    0,
                    KEY_QUERY_VALUE,
                    &hKey) != ERROR_SUCCESS)
        return FALSE;

    lRetCode=RegQueryValueEx(hKey,
                            "ErrorMode",
                            0,
                            NULL,
                            (LPBYTE) dwErrorMode,
                            &cbData);

    RegCloseKey(hKey);
    if (lRetCode != ERROR_SUCCESS)
        return FALSE;

    return TRUE;
}
```
