---
title: Can't set time zone automatically
description: Provides several methods to resolve the issue in which you cannot set the time zone automatically.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, warrenw, hunterm, ronruz, aandrejs
ms.custom: sap:dst-and-timezones, csstroubleshoot
---
# Can't set time zone automatically in Windows 10

_Applies to:_ &nbsp; Windows 10

> [!NOTE]
> If you're not a support agent or IT professional, you'll find more helpful information in [How to set your time and time zone](https://support.microsoft.com/windows/how-to-set-your-time-and-time-zone-dfaa7122-479f-5b98-2a7b-fa0b6e01b261).

Non-administrator users cannot change or interact with the **Set time zone automatically** setting. The setting is either not visible or is "greyed out" in the **Settings** app. This is by design as the **Set time zone automatically** setting is a system wide setting that applies to all user profiles on a machine.

To resolve this issue, the IT administrators should make sure the setting **Set time zone automatically** is enabled before deployment of a device. If the device is already deployed, you can use one of the following methods mentioned below to enable the setting.

## Use Registry Editor

Run **Registry Editor** as an administrator and follow these steps:

1. <a id="1"></a>Change the **Set time zone automatically** setting and set the data value of the registry entry `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\tzautoupdate\Start` as follows:

    |Value data  |Result  |
    |---------|---------|
    |3     |Enable Set time zone automatically         |
    |4     |Disable Set time zone automatically         |

2. Change the location setting and set the value of the registry entry `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location\Value` as follows:

    |Value string  |Result  |
    |---------|---------|
    |Allow     |On         |
    |Deny     |Off         |

    > [!NOTE]
    > If the **Location** setting is turned off by a group policy, you must reverse the policy otherwise it will override the manual editing of the entry.

## Use Group Policy

To change the [registry settings](#1), use [Group Policy Preferences](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn789188(v=ws.11)) to enable the **Set the time zone automatically** setting. Next, follow these steps to enable the **Location** setting in **Local Group Policy Editor**.

1. Go to **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Location and Sensors** > **Windows Location Provider** > **Turn off Windows Location Provider**.
2. Set the value of the **Turn off Windows Location Provider** setting to **Not Configured** as follows:

    :::image type="content" source="media/cannot-set-timezone-automatically/turn-off-location-setting-group-policy.png" alt-text="Screenshot of the Not Configured option of Turn off Windows Location Provider value setting window.":::

## Use MDM policy

Run a [PowerShell script](/mem/intune/apps/intune-management-extension) to change the [registry settings](#1) in Microsoft Intune. Next, use the mobile device management (MDM) policy [Privacy/LetAppsAccessLocation](/windows/client-management/mdm/policy-csp-privacy#privacy-letappsaccesslocation) to enable the **Location** setting as follows:

|Value  |Result  |
|---------|---------|
|0     |User in control         |
|1     |Force allow         |
|2     |Force deny         |

> [!NOTE]
> The recommended value is *0*, but setting the value to *1* ensures that automatic time zone gets the correct location.

For more information about other options to control applications access to the location, see [Privacy/LetAppsAccessLocation_ForceAllowTheseApps](/windows/client-management/mdm/policy-csp-privacy#privacy-letappsaccesslocation-forceallowtheseapps), [Privacy/LetAppsAccessLocation_ForceDenyTheseApps](/windows/client-management/mdm/policy-csp-privacy#privacy-letappsaccesslocation-forcedenytheseapp) and [Privacy/LetAppsAccessLocation_UserInControlOfTheseApps](/windows/client-management/mdm/policy-csp-privacy#privacy-letappsaccesslocation-userincontroloftheseapps).
