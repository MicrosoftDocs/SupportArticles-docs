---
title: How to set Group Policy Preference settings
description: This article introduces how to configure Group Policy Preference settings for Internet Explorer 11.
ms.date: 10/13/2020
ms.reviewer: ajayps, kaushika, ramakoni
---
# How to configure Group Policy Preference settings for Internet Explorer 11 in Windows

[!INCLUDE [](../../../includes/browsers-important.md)]

This article explains how to configure Internet Explorer 11 Group Policy Preference (GPP) settings to apply on computers running Windows operating system.

_Original product version:_ &nbsp; Internet Explorer 11, Windows 8.1, Windows Server 2012 R2 Datacenter, Windows Server 2012 R2 Standard  
_Original KB number:_ &nbsp; 2898604

## More information

Pre-requisite: Install Remote Server Administration Tools (RSAT)](/windows-server/remote/remote-server-administration-tools) on your system.

After installing the tools, you can use the following procedure to configure Internet Explorer 11 Group Policy Preference (GPP) settings on your computer.

1. Open Group Policy Management Console (GPMC.MSC)
2. Create a new Group Policy Object (GPO) or select an existing Group Policy Object (GPO) to modify.
3. Right-click the selected Group Policy Object (GPO) and select **Edit** and browse to:

   1. User Configuration\Preferences\Control Panel Settings\Internet Settings
   1. Select **Internet Settings** and then right-click to select New and choose the option of **Internet Explorer 10**.
   1. Configure the desired Internet Explorer Preference settings and select **Apply** and then **OK**.
   1. Run the following command at a command prompt on clients where you want the settings to apply or wait for the group policy background refresh:

      ```console
      gpupdate.exe /force
      ```

> [!NOTE]
> You need to select the option of Internet Explorer 10 in Group Policy Preference (GPP) to apply the settings for Internet Explorer 11 as the same settings apply to Internet Explorer 11.

## References

For more information, see [How to set advanced settings in Internet Explorer by using Group Policy objects](/troubleshoot/browsers/advanced-settings).
