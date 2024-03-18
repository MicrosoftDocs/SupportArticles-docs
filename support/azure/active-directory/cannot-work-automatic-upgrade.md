---
title: Microsoft Entra Connect is not working correctly after an automatic upgrade
description: Discusses an issue in which Microsoft Entra Connect is only partially upgraded or the password synchronization and the password writeback features are disabled. Provides a workaround.
ms.date: 05/09/2020
ms.reviewer: 
ms.service: active-directory
ms.subservice: enterprise-users
---
# Microsoft Entra Connect is not working correctly after an automatic upgrade

This article discusses an issue in which Microsoft Entra Connect is only partially upgraded or the password synchronization and the password writeback features are disabled.

_Original product version:_ &nbsp; Microsoft Entra ID  
_Original KB number:_ &nbsp; 4038479

## Symptoms

When you run Microsoft Entra Connect 1.1.443.0 or an earlier version, you experience one of the following issues:

- Microsoft Entra Connect is only partially upgraded, the scheduler is suspended, and no automatic synchronization cycle occurs.
- Microsoft Entra Connect is upgraded correctly, the scheduler is enabled, and object changes are synchronized correctly to Microsoft Entra ID. However, the password synchronization feature or the password writeback feature is disabled.

## Cause

A problem in the automatic upgrade feature for Microsoft Entra Connect causes the **Microsoft.Azure.ActiveDirectory.Synchronization.Upgrader.exe** process to terminate because of an unhandled exception. Therefore, the automatic upgrade does not finish. To verify this, follow these steps:

<a name='step-1-determine-whether-automatic-upgrade-recently-tried-to-upgrade-azure-ad-connect'></a>

### Step 1: Determine whether automatic upgrade recently tried to upgrade Microsoft Entra Connect

Examine the log files in the `%ProgramData%\AADConnect` folder. Log files that have a title of `SyncEngine-AutoUpgrader-[Date]-[Time].log` indicate the time that the automatic upgrade occurred.

:::image type="content" source="media/cannot-work-automatic-upgrade/log-file.png" alt-text="Screenshot of the log file that indicates the time of the automatic upgrade." border="false":::

<a name='step-2-determine-whether-azure-ad-connect-is-partially-upgraded'></a>

### Step 2: Determine whether Microsoft Entra Connect is partially upgraded

Run the Microsoft Entra Connect wizard. If Microsoft Entra Connect is partially upgraded, you are prompted to upgrade Microsoft Entra Connect.

:::image type="content" source="media/cannot-work-automatic-upgrade/upgrade-aad-connect.png" alt-text="Screenshot of the Microsoft Entra Connect wizard that prompts you to upgrade Microsoft Entra Connect." border="false":::

<a name='step-3-compare-the-installed-version-of-azure-ad-connect-with-the-version-in-the-server-configuration'></a>

### Step 3: Compare the installed version of Microsoft Entra Connect with the version in the server configuration

During automatic upgrade, the current installation of Microsoft Entra Connect is upgraded, and then the version in the server configuration is updated. If the two versions don't match, Microsoft Entra Connect is only partially upgraded.

To check which version of Microsoft Entra Connect is installed, open the **Programs and Features** item in Control Panel, and examine the version number of Microsoft Entra Connect.

To check the version of Microsoft Entra Connect in the server configuration, run the following command in Windows PowerShell, and look for the value of the **Microsoft.Synchronize.ServerConfigurationVersion** property:

```powershell
(Get-ADSyncGlobalSettings).Parameters | select Name,Value
```

:::image type="content" source="media/cannot-work-automatic-upgrade/serverconfigurationversion-property.png" alt-text="Screenshot shows the Microsoft Entra Connection version in the server configuration." border="false":::

Check the status of the scheduler by running the following command:

```powershell
Get-ADSyncScheduler
```

If the value of **SchedulerSuspended** is **True**, the scheduler is suspended.

:::image type="content" source="media/cannot-work-automatic-upgrade/schedulersuspended-value.png" alt-text="Screenshot shows the scheduler status of Microsoft Entra Connect." border="false":::

### Step 4: Verify that password synchronization and password writeback are enabled

If Microsoft Entra Connect is upgraded correctly, open the Microsoft Entra Connect wizard, and then select **Review your solution** to verify that the password synchronization and password writeback features are enabled.


## Workaround

To work around this issue, follow these steps:

1. Start the Microsoft Entra Connect wizard, and then select **Upgrade**.
2. After the upgrade is complete, verify that the installed version of Microsoft Entra Connect matches the version in the server configuration.
3. If you have previously enabled the password synchronization feature or the password writeback feature, verify that the feature remains enabled after the upgrade is complete.
4. If any of the features is disabled after the upgrade, select **Customize synchronization options** in the Microsoft Entra Connect wizard, and then manually enable the feature.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
