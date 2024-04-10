---
title: Customized settings in IEAK override defined settings
description: This article introduces a by design issue that customized settings that are defined in an IEAK installation package override the settings defined in Internet Explorer Maintenance Policy.
ms.date: 01/04/2021
ms.reviewer: heikom, yechen, axelr, aanders
ms.topic: article
---
# Customized settings in an IEAK installation package override setting defined in Internet Explorer Maintenance Policy

[!INCLUDE [](../../../includes/browsers-important.md)]

This article introduces a by design behavior that customized Internet Explorer settings that are defined in an IEAK installation package override the settings defined in Internet Explorer Maintenance Policy.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 2029043

## Summary

Consider the following scenario. You deploy an Internet Explorer installation package using the Internet Explorer Administrative Kit (IEAK), and specify some customized settings, for example for the proxy server setting. There's an existing Internet Explorer Maintenance Policy that applies to this Windows client machine and that defines proxy server settings different than those specified in the installation package.

When a user signs in to the Windows client machine for the first time after the installation of Internet Explorer, the Internet Explorer Maintenance Policy settings will be applied first at logon. Next, the IEAK Branding containing the proxy server settings will be applied last and will override the Internet Explorer Maintenance Policy.

This behavior is by design.

> [!NOTE]
> This behavior applies to any setting specified in an IEAK installation package that has a corresponding setting in an Internet Explorer Maintenance Policy. The proxy server setting in this article is used for example purposes only.

## More information

When Internet Explorer is installed on a machine, there's a Browser Customizations Install Component flagged under the Active Setup key. In the Active Setup key, there will be a Version number, which will be used by the OS when a new user signs in. The OS will execute the `RunDLL32 IEDKCS32.DLL,BrandIE4 CUSTOM` if the following condition exists:

- The Registry keys at `HKLM\Software\Microsoft\Active Setup\Installed Components\%APPNAME%` and `HKCU\Software\Microsoft\Active Setup\Installed Components\%APPNAME%` are compared, and if the HKCU registry entries don't exist.

OR

- The version number of HKCU is less than HKLM, and then the specified application is executed for the current user.

The IEAK Custom Component will be executed from C:\Program Files\Internet Explorer\Custom\\.

You can see the IEAK package settings overriding the settings in the Internet Explorer Maintenance policy by viewing the brndlog.txt and brndlog.bak files in the following locations:

**WinXP and Server 2003:**

%USERPROFILE%\Local Settings\Application Data\Microsoft\Internet Explorer

**Windows Vista and later:**

%USERPROFILE%\AppData\Local\Microsoft\Internet Explorer

To summarize, the sequence is as follows:

1. User signs in for the first time on this machine.

2. In the logon process, the IEM client Extensions is executed (iedkcs32.dll). If the policy hasn't changed, it won't execute. If this is the first time the user signs in to this domain, it will execute and will brand the user profile with the new settings.

   > [!NOTE]
   > This all happens at logon, and winlogon.exe is the process executing this operation.

3. Next, the user gets the desktop, which is when the IEAK Branding is executed by the active setup process. It processes the default-branding (for example, the default Favorites) with the following command:

   ```console
   "C:\Windows\System32\rundll32.exe" "C:\Windows\System32\iedkcs32.dll",BrandIEActiveSetup SIGNUP" StubPath with ComponentiD: Branding.cab.
   ```

   - The registry location for the Stub is: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\\>{60B49E34-C7CC-11D0-8953-00A0C90347FF}.

4. When an IEAK-package had been installed, the Active Setup in addition installs this Branding with the following command:

   ```console
   "RunDLL32 IEDKCS32.DLL,BrandIE4 CUSTOM"
   ```

   - The Registry-location of the Stub is: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\\>{*custom GUID*}.
