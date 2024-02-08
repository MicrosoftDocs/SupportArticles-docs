---
title: Old user profiles aren't deleted as expected on system restart
description: Helps resolve an issue in which the Delete user profile older than a specified number of days on system restart Group Policy is applied but doesn't take effect.
ms.date: 11/23/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, dennhu, rahugoyal, v-lianna
ms.custom: sap:problems-applying-group-policy-objects-to-users-or-computers, csstroubleshoot, ikb2lmc
---
# User profiles older than a specified number of days aren't deleted as expected on system restart

This article helps resolve an issue in which the **Delete user profiles older than a specified number of days on system restart** Group Policy is applied but doesn't take effect.

The **Delete user profiles older than a specified number of days on system restart** Group Policy is under **Computer Configuration** > **Administrative Templates** > **System** > **User Profiles** in either the Local Group Policy Editor or some Group Policy Objects (GPOs). After it's applied, it fails to delete user profiles older than the number of days specified in the GPO.

This issue occurs because the related settings configured in Windows Management Instrumentation (WMI) take precedence over the GPO settings. The settings in WMI can come from either Microsoft System Center Configuration Manager (SCCM) compliance settings or third-party applications.

To determine if user profile settings are controlled by SCCM or some third-party application, check the following registry settings. If they're set to **1**, it means that the settings are managed by either SCCM or some third-party application, and therefore the GPO settings are ignored.

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\UserState\UserStateTechnologies\ConfigurationControls`

|Value name|Value type|Value data|
|---|---|---|
|`RoamingUserProfile`|DWORD|00000001|
|`FolderRedirection`|DWORD|00000001|
|`OfflineFiles`|DWORD|00000001|

## Disable the "Enable User Data and Profile" compliance setting pushed through SCCM

To resolve the issue, follow these steps:

1. In the Configuration Manager console, go to **Administration** > **Client Settings** > **Default Settings**.
2. On the **Home** tab of the ribbon, in the **Properties** group, select **Properties**.
3. In the **Default Settings** dialog box, select **Compliance Settings**.
4. From the **Enable User Data and Profiles** drop-down list, select **No**.
5. Select **OK** to close the **Default Settings** dialog box.

If they aren't controlled by SCCM but by some third-party application, contact the vendor for how to disable the settings.

For more information, see [Create user data and profiles configuration items in Configuration Manager](/mem/configmgr/compliance/deploy-use/create-user-data-and-profiles-configuration-items).
