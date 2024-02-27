---
title: Remove Terminal Server licenses from a Remote Desktop Protocol (RDP) client
description: Describes how to remove Terminal Server licenses from an RDP client.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:remote-desktop-services-terminal-services-licensing, csstroubleshoot
---
# Remove Terminal Server licenses from an RDP client

This article describes how to remove Terminal Server licenses from a Remote Desktop Protocol (RDP) client.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 187614

## Summary

When an unlicensed client connects to a Terminal Server for the first time, the Terminal Server issues the client a temporary Terminal Server Client Access License (CAL) token. After the user has logged into the session, the Terminal Server instructs the License Server to mark the issued temporary Terminal Server CAL token as being validated. The next time the client connects, an attempt is made to upgrade the validated temporary Terminal Server CAL token to a full Terminal Server CAL token. If no license tokens are available, the temporary Terminal Server CAL token will continue to function for 90 days. The license is stored in the client's registry.

32-bit RDP clients store their license under the key `HKEY_LOCAL_MACHINE\Software\Microsoft\MSLicensing`.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

## Clean RDP client's license cache

To clean the client's license cache, just delete this key and its subkeys. The next time the client connects to the server, it will obtain another license.

For 16-bit RDP clients, run `regedit /v`. Then delete the keys under `\Software\Microsoft\MSLicensing` to clean the client's license cache. You can also delete the BIN files from `\Windows\System\Regdata`.

The RDP client for Macintosh stores the license in a file on the local computer in the folder hierarchy under `/users/Shared/Microsoft/RDC Crucial Server Information/`. To clean the Macintosh client's license cache, delete the contents of this folder. The client will try to obtain a new license from the server the next time that it connects.

If you delete the `HKEY_LOCAL_MACHINE\Software\Microsoft\MSLicensing` subkey on a client that is running Windows Vista or a later version, later attempts to connect to a Terminal Server may fail. Also, you receive the following error message:

> An Error occurred in the Licensing Protocol

To resolve this problem, right-click the **Remote Desktop Connection** shortcut, and then select **Run as Administrator**. By default, the remote desktop connection runs as a user with the lowest user permissions. By default, a restricted user doesn't have permission to write registry entries to HKEY_LOCAL_MACHINE. Therefore, attempts to rewrite the **`MSLicensing`** key fail. Starting Remote Desktop Connection with administrative credentials provides the permissions that are necessary to write the needed registry keys.

### Did this fix the problem

Check whether the problem is fixed. If the problem isn't fixed, [contact support](https://support.microsoft.com/contactus/).
