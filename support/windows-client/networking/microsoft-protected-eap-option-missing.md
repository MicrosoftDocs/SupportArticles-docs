---
title: Protected EAP (PEAP) option is missing
description: Fixes an issue where Microsoft Protected EAP (PEAP) option is missing.
ms.date: 09/14/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, prachank
ms.custom: sap:wireless-networking-and-802.1x-authentication, csstroubleshoot
---
# Microsoft: Protected EAP (PEAP) option is missing while creating the Wireless Profile

This article provides a solution to an issue where Microsoft: Protected EAP (PEAP) option is missing in some cases.

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2699785

## Symptoms

There are multiple symptoms for the issue:

- Microsoft: Protected EAP (PEAP) option may be missing while creating the Wireless Profile on a client.
- Microsoft: Protected EAP (PEAP) option may go missing once we start file transfer using Window Easy Transfer wizard.
- Remote Access Connection Manager does not start.

## Cause

The default location of the file SymRasMan.dll is %SystemRoot%\System32\rastls.dll. On installing Symantec Antivirus or Symantec Endpoint Protection the default location is then changed and edited in the registry to C:\Program Files\ Symantec\Symantec Endpoint Protection \SymRasMan.dll. After uninstallation this location is not reversed. The issue occurs because of a problem with registry keys that are not reverted to the defaults or .dll files indicated in registry values do not exist after removing Symantec Endpoint Protection 11.0.

These 2 registry hives are affected:

- `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RasMan\PPP\EAP\25`
- `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RasMan\PPP\EAP\13`

The values of the following keys under EAP are modified from C:\System32\rastls.dll to C:\Program Files\Symantec\Symantec Endpoint Protection\SymRasMan.dll.

- ConfigUiPath
- IdentityPath
- InteractiveUIPath
- Path

4 new registry keys with their value as C:\Windows\ System32\rastls.dll are created.

- ConfigUiPathBack
- IdentityPathBack
- InteractiveUIPathBack
- PathBack

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs.

To resolve this problem, modify the registry to correct the values of ConfigUiPath, IdentityPath, InteractiveUIPath and Path. To do this, follow these steps:

1. Click **Start**, click **Run**, type *regedit*, and then click **OK**.
2. Locate and then click the registry subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RasMan\PPP\EAP\13`.
3. Select the folder 13.
4. Change the value for keys: ConfigUiPath, IdentityPath, InteractiveUIPath and Path to: C:\Windows\ System32\rastls.dll
5. Navigate to `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RasMan\PPP\EAP\25`.
6. Select the folder 25.
7. Change the value for keys: ConfigUiPath, IdentityPath, InteractiveUIPath and Path to: C:\Windows\ System32\rastls.dll.
8. Delete the following keys under folder 13 and 25.

    Location:
    - `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RasMan\PPP\EAP\13`
    - `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RasMan\PPP\EAP\25`

    Registry keys:

    - ConfigUiPathBack
    - IdentityPathBack
    - InteractiveUIPathBack
    - PathBack

9. Exist the registry editor and then restart the computer.
