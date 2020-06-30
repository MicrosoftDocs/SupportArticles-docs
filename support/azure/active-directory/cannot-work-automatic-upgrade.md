---
title: Azure AD Connect is not working correctly after an automatic upgrade
description: Discusses an issue in which Azure AD Connect is only partially upgraded or the password synchronization and the password writeback features are disabled. Provides a workaround.
ms.date: 05/09/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: 
---
# Azure AD Connect is not working correctly after an automatic upgrade

This article discusses an issue in which Azure AD Connect is only partially upgraded or the password synchronization and the password writeback features are disabled and provides a workaround.

_Original product version:_ &nbsp; Azure Active Directory  
_Original KB number:_ &nbsp; 4038479

## Symptoms

When you run Azure AD Connect 1.1.443.0 or an earlier version, you experience one of the following issues:

- Azure AD Connect is only partially upgraded, the scheduler is suspended, and no automatic synchronization cycle occurs.
- Azure AD Connect is upgraded correctly, the scheduler is enabled, and object changes are synchronized correctly to Azure Active Directory (Azure AD). However, the password synchronization feature or the password writeback feature is disabled.

## Cause

A problem in the automatic upgrade feature for Azure AD Connect causes the **Microsoft.Azure.ActiveDirectory.Synchronization.Upgrader.exe** process to terminate because of an unhandled exception. Therefore, the automatic upgrade does not finish. To verify this, follow these steps:

### Step 1: Determine whether automatic upgrade recently tried to upgrade Azure AD Connect

Examine the log files in the `%ProgramData%\AADConnect` folder. Log files that have a title of `SyncEngine-AutoUpgrader-[Date]-[Time].log` indicate the time that the automatic upgrade occurred.

:::image type="content" source="media/cannot-work-automatic-upgrade/4038471_en_1.png" alt-text="Screenshot of log file that indicates azure ad connect automatic upgrade.":::

### Step 2: Determine whether Azure AD Connect is partially upgraded

Run the Azure AD Connect wizard. If Azure AD Connect is partially upgraded, you are prompted to upgrade Azure AD Connect.

:::image type="content" source="media/cannot-work-automatic-upgrade/4038472_en_1.png" alt-text="Screenshot of Prompted to upgrade Azure AD Connect.":::

### Step 3: Compare the installed version of Azure AD Connect with the version in the server configuration

During automatic upgrade, the current installation of Azure AD Connect is upgraded, and then the version in the server configuration is updated. If the two versions don't match, Azure AD Connect is only partially upgraded.

To check which version of Azure AD Connect is installed, open the **Programs and Features** item in Control Panel, and examine the version number of Azure AD Connect.

:::image type="content" source="media/cannot-work-automatic-upgrade/4038473_en_1.png" alt-text="Screenshot of Azure AD Connect version.":::

To check the version of Azure AD Connect in the server configuration, run the following command in Windows PowerShell, and look for the value of the **Microsoft.Synchronize.ServerConfigurationVersion** property:

```powershell
(Get-ADSyncGlobalSettings).Parameters | select Name,Value
```

:::image type="content" source="media/cannot-work-automatic-upgrade/4038475_en_1.png" alt-text="Screenshot of Azure AD Connection version in the server configuration.":::

Check the status of the scheduler by running the following command:

```powershell
Get-ADSyncScheduler
```

If the value of **SchedulerSuspended**  is **True**, the scheduler is suspended.

:::image type="content" source="media/cannot-work-automatic-upgrade/4038476_en_1.png" alt-text="Screenshot of scheduler status of Azure AD Connect.":::

### Step 4: Verify that password synchronization and password writeback are enabled

If Azure AD Connect is upgraded correctly, open the Azure AD Connect wizard, and then select **Review your solution** to verify that the password synchronization and password writeback features are enabled.

:::image type="content" source="media/cannot-work-automatic-upgrade/4038477_en_1.png" alt-text="Screenshot of checking if the password synchronization and password writeback features are enabled.":::

## Workaround

To work around this issue, follow these steps:

1. Start the Azure AD Connect wizard, and then select **Upgrade**.
2. After the upgrade is complete, verify that the installed version of Azure AD Connect matches the version in the server configuration.
3. If you have previously enabled the password synchronization feature or the password writeback feature, verify that the feature remains enabled after the upgrade is complete.
4. If any of the features is disabled after the upgrade, select **Customize synchronization options** in the Azure AD Connect wizard, and then manually enable the feature.

    :::image type="content" source="media/cannot-work-automatic-upgrade/4038478_en_1.png" alt-text="Screenshot of manually enable the password synchronization and password writeback features.":::

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Azure Active Directory Forums](https://social.msdn.microsoft.com/Forums/en-US/home?forum=windowsazuread) website.
