---
title: Customized settings override IE Maintenance Policy
description: Describes a by design behavior that occurs after you deploy an Internet Explorer installation package using the Internet Explorer Administrative Kit (IEAK), and specify some customized settings.
ms.date: 03/16/2020
ms.prod-support-area-path: Internet Explorer
ms.reviewer: yechen, heikom, aanders
---
# Customized settings in IEAK installation package override settings in Internet Explorer Maintenance Policy

This article discusses a by design behavior that customized Internet Explorer settings that are defined in an IEAK installation package override the settings that are defined in Internet Explorer Maintenance Policy.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 2029043

## Symptoms

You deploy an Internet Explorer installation package using the Internet Explorer Administrative Kit (IEAK), and specify some customized settings, for example for the proxy server setting. There is an existing Internet Explorer Maintenance Policy that applies to this Windows client machine and that defines proxy server settings different than those specified in the installation package.

When a user signs in to the Windows client machine for the first time after the installation of Internet Explorer, the Internet Explorer Maintenance Policy settings will be applied first. Next, the IEAK Branding containing the proxy server settings will be applied last and will override the Internet Explorer Maintenance Policy.

This behavior is by design.

> [!NOTE]
> This behavior applies to any setting specified in an IEAK installation package that has a corresponding setting in an Internet Explorer Maintenance Policy. The proxy server setting in this article is used for example purposes only.

## More Information

When Internet Explorer is installed on a machine, there is a Browser Customizations Install Component flagged under the Active Setup key. In the Active Setup key, there will be a Version number, which will be used by the OS when a new user signs in. The OS will execute the `RunDLL32 IEDKCS32.DLL,BrandIE4 CUSTOM` command if the following condition exists:

- The Registry keys at `HKEY_LOCAL_MACHINE\Software\Microsoft\Active Setup\Installed Components\%APPNAME%` and `HKEY_CURRENT_USER\Software\Microsoft\Active Setup\Installed Components\%APPNAME%` are compared, and if the HKEY_CURRENT_USER registry entries don't exist.  
**OR**
- The version number of HKEY_CURRENT_USER is less than HKEY_LOCAL_MACHINE, and then the specified application is executed for the current user.

The IEAK Custom Component will be executed from:  
C:\Program Files\Internet Explorer\Custom\

You can see the IEAK package settings overriding the settings in the Internet Explorer Maintenance policy by viewing the brndlog.txt and brndlog.bak files in the following locations:

**Windows XP and Server 2003:**  
%USERPROFILE%\Local Settings\Application Data\Microsoft\Internet Explorer

**Windows Vista and later:**  
%USERPROFILE%\AppData\Local\Microsoft\Internet Explorer

To summarize, the sequence is as follows:

1. A user signs in for the first time on this machine.

2. During the user signs in to the machine, the IEM client Extensions are executed (iedkcs32.dll). If the policy has not changed, it will not execute. If this is the first time the user signs in to this domain, it will execute and will brand the user profile with the new settings. This all happens when a user signs in, and winlogon.exe is the process executing this operation.

3. The user gets the desktop, which is when the IEAK Branding is executed by the active setup process. It processes the default-branding (for example, the default Favorites) with the following command:

   ```ps
   C:\Windows\System32\rundll32.exe
   ```

   ```ps
   C:\Windows\System32\iedkcs32.dll,BrandIEActiveSetup SIGNUP StubPath with ComponentiD: Branding.cab.
   ```

    - The registry location for the Stub is:  
    `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\>{custom GUID}`

4. When an IEAK-package had been installed, the Active Setup in addition installs this Branding with the following command:  

   ```ps
   RunDLL32 IEDKCS32.DLL,BrandIE4 CUSTOM
   ```

    - The Registry-location of the stub is:  
    `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\>{custom GUID}`
