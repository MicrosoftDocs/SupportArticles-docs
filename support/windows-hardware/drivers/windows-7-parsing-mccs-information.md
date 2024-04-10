---
title: Windows 7 parsing MCCS information
description: This article provides resolutions for the problem that occurs when you parse MCCS information in Windows 7.
ms.date: 09/04/2020
ms.custom: sap:Windows 7 Enterprise
ms.subservice: display-driver
---
# Problems with Windows 7 parsing MCCS information

This article helps you resolve the problem that occurs when you parse MCCS information in Windows 7.

_Original product version:_ &nbsp; Windows 7 Enterprise, Windows 7 Home Premium, Windows 7 Professional, Windows 7 Ultimate  
_Original KB number:_ &nbsp; 2515532

## Symptoms

Displays that are MCCS compliant provide an MCCS capability string to be read and parsed by the system to provide information about that display through `GetMonitorCapabilities` API. The VESA Monitor Control Command Set Version 2.2a Standard provides a sample string as follows:

```console
Prot(display) type(lcd) model(xxxxx) cmds(xxxxx) vcp(02 03 10 12 C8 DC(00 01 02 03 07) DF) mccs_ver(2.2)
window1(type (PIP) area(25 25 1895 1175) max(640 480) min(10 10) window(10)) vcpme(10(Brightness))
```

This string would not be parsed correctly with the current parser in Windows 7 and GetLastError will return an error - `STATUS_GRAPHICS_DDCCI_INVALID_CAPABILITIES_STRING`

> The monitor returned a DDC/CI capabilities string which did not comply with the ACCESS.bus 3.0, DDC/CI 1.1, or MCCS 2 Revision 1 specification.

## Cause

This is caused by some overly restrictive rules in the parser that are not required in the specification.

## Resolution

To work around these restrictions, the display firmware would need to follow some more restrictive criteria to be properly parsed by the system.

- The string must be encapsulated in parentheses

- Each header must not be preceded by a space after the ending parentheses of the previous header

- Windows 7 supports only MCCS versions 1.0, 2.0, and 2.1. Any reported versions other than those will not be parsed correctly and would return an error and GetLastError will return `ERROR_GRAPHICS_MCA_UNSUPPORTED_MCCS_VERSION`.

- The display firmware needs to ensure that the version reported in the capability string matches the version info returned by `GetVCPFeatureAndVCPFeatureReply()` or else the system will return an error and GetLastError will return `ERROR_GRAPHICS_MCA_MCCS_VERSION_MISMATCH` error.
