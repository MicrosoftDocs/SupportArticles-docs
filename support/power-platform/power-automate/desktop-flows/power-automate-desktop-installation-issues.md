---
title: Installation issues in Power Automate for desktop
description: Helps troubleshoot stallation issues in Power Automate for desktop.
ms.reviewer: guco, johndund
ms.date: 01/20/2025
ms.custom: sap:Desktop flows\Installation issues
---
# Troubleshoot installation issues in Power Automate for desktop

This article provides troubleshooting steps to resolve issues that might occur when you install Power Automate for desktop.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 5001534

## General steps

To ensure a successful installation, make sure that:

- You use the [latest installer for Power Automate for desktop](/power-automate/desktop-flows/install).

  > [!NOTE]
  > Administrator permissions on your local computer are required to install Power Automate for desktop using [MSI installer](/power-automate/desktop-flows/install#install-power-automate-using-the-msi-installer).
- You restart your machine.

  Some Windows changes require a restart to take effect, or they might block your installation.
- You run an up-to-date version of a supported Windows operating system.

For a complete list of prerequisites, see [Prerequisites and limitations](/power-automate/desktop-flows/requirements#prerequisites).

## Gather diagnostic information

Installation logs can provide useful details about the installation and help you diagnose and fix issues. For more information about where to find the logs, see [Power Automate for desktop installation logs](how-to-get-power-automate-desktop-installer-logs.md#installer-logs).

## Known issues and workarounds

### Power Automate service fails to start: Unable to load DLL 'uiflowsclient.dll'

The installation fails with this error if the Power Automate Windows service fails to start. The Windows Event Viewer shows that the reason why it couldn't start is "System.DllNotFound Exception: Unable to load DLL 'uiflowsclient.dll'".

#### Workaround

To work around this issue, uninstall "Microsoft Visual C++ 2015-2022 Redistributable" and then reinstall Power Automate for desktop by following these steps:

1. Go to **Settings** > **Apps** > **Installed apps**.
2. Find "Microsoft Visual C++ 2015-2022 Redistributable" and uninstall it.

   :::image type="content" source="media/power-automate-desktop-installation-issues/visual-c-2015-2022-installed-app.png" alt-text="Screenshot that shows how to find and uninstall Microsoft Visual C++ 2015-2022 Redistributable.":::

3. Reinstall Power Automate for desktop. The Power Automate for desktop installer reinstalls the C++ redistributable as part of the installation.

### Power Automate service crashes at startup: Failed to enumerate sessions

The installation fails with this error if the Power Automate service crashes at startup. The Windows Event Viewer shows the "FailedToEnumerateSessions" error.

> UIFlowService  
> Exception caught during service startup:  
> Microsoft.Flow.RPA.Service.Core.UIFlowServiceException: Error code: FailedToEnumerateSessions

:::image type="content" source="media/power-automate-desktop-installation-issues/failed-to-enumerate-sessions-error.png" alt-text="Screenshot that shows the FailedToEnumerateSessions error logged in Event Viewer.":::

#### Cause

The installer grants permissions to the Power Automate service to enumerate user sessions on the machine. You might need to retart your machine for these permissions to take effect.

#### Resolution

To solve this issue, you can prevent the Power Automate service from starting automatically during the installation by running the installer from a command line and passing the `/SKIPSTARTINGPOWERAUTOMATESERVICE` argument.

:::image type="content" source="media/power-automate-desktop-installation-issues/skipstartingpowerautomateservice.png" alt-text="Screenshot that shows how to prevent the Power Automate service from starting automatically by using a command.":::

Then, manually restart the machine right after the installation. If the restart is successful, the Power Automate Windows service will run successfully after the restart, and should no longer crash or generate the "FailedToEnumerateSessions" error in the event log.

### Power Automate service fails to start: Service account errors

The installation fails because the Power Automate service crashes at startup, and the Windows Event Viewer shows the following errors:

> UIFlowService  
> Exception caught during service startup:  
> Microsoft.Flow.RPA.Common.DataRepository.KeyValueStoreException: ReliableKeyValueStore 'UIFlowServiceSecretStore' backing store is unhealthy.

:::image type="content" source="media/power-automate-desktop-installation-issues/backing-store-is-unhealthy-error.png" alt-text="Screenshot that shows the UIFlowServiceSecretStore backing store is unhealthy error.":::

> Windows cannot log you on because your profile cannot be loaded. Check that you are connected to the network, and that your network is functioning correctly.

:::image type="content" source="media/power-automate-desktop-installation-issues/profile-cannot-be-loaded-error.png" alt-text="Screenshot that shows the Windows can't log you on because your profile can't be loaded error.":::

#### Cause

There might be an issue with your machine that doesn't allow the Windows account of the Power Automate service (`NT Service\UIFlowService`) to be created during the installation.

You can confirm this by running the installation again and checking if the account exists when the installer attempts to start the Power Automate service. The account's profile can be found in the registry here:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\S-1-5-80-3017052307-2994996872-1615411526-3164924635-3391446484`

If this registry key doesn't exist, it means that your machine doesn't allow the service user account to be created.

> [!NOTE]
> The registry key won't exist if Power Automate for desktop isn't installed.

#### Workaround

Instead of the default account (`NT SERVICE\UIFlowService`), you can provide a Windows user account to run the service. This account needs to be a member of the remote desktop user group and needs to have the "Logon as a service" privilege.

First run the installer from a command line and pass the `/SKIPSTARTINGPOWERAUTOMATESERVICE` argument to prevent the Power Automate service from starting automatically during the installation.

:::image type="content" source="media/power-automate-desktop-installation-issues/skipstartingpowerautomateservice.png" alt-text="Screenshot that shows how to prevent the Power Automate service from starting automatically by using a command.":::

When the installation completes, run the Power Automate Machine runtime application and use the **Troubleshoot** menu to change the service account. For more information on changing the service account, see [Change the on-premises Service account](/power-automate/desktop-flows/troubleshoot#change-the-on-premises-service-account).

### Power Automate service fails to start: Verify that you have sufficient privileges to start system services

You see the following event logged in the Windows Event Viewer:

> Product: Power Automate for desktop -- Error 1920. Service 'Power Automate service' (UIFlowService) failed to start. Verify that you have sufficient privileges to start system services.

:::image type="content" source="media/power-automate-desktop-installation-issues/event-11920-verify-sufficient-privileges.png" alt-text="Screenshot that shows the event 11920 stating that you need to verify that you have sufficient privileges to start system services.":::

#### Cause

The account used to start the Power Automate service can't start the service because the **Deny log on as a service** security policy prevents it.

During installation, the `UIFlowService` runs as `NT SERVICE\UIFlowService`. The account used by `UIFlowService` can be changed later, but for installation purposes it mustn't be blocked from logging on.

> [!NOTE]
> If you find a service crash log, similar to the one shown in the following screenshot, it means that the service has sufficient privileges to start, and the installation is blocked by the service crashing on startup. To solve the issue, see the other sections of this article.
>
> "UIFlowService  
> Exception caught during service startup:"
>
> :::image type="content" source="media/power-automate-desktop-installation-issues/exception-caught-during-service-startup-error.png" alt-text="Screenshot that shows the event that occurs when the Power Automate service crashes during startup.":::

#### Resolution

Update the **Deny log on as a service** policy setting to remove the account or group that prevents `NT SERVICE\UIFlowService` from logging on as a service. For more information, see [Change the on-premises Service account](/power-automate/desktop-flows/troubleshoot#change-the-on-premises-service-account).

:::image type="content" source="media/power-automate-desktop-installation-issues/deny-log-on-as-a-service.png" alt-text="Screenshot that shows the Deny log on as a service setting.":::

### The LanmanServer service can't be started

You see the following error message in the [installation logs](how-to-get-power-automate-desktop-installer-logs.md):

> Exception thrown while Starting LanmanServer service: System.InvalidOperationException: Cannot start service LanmanServer on computer

#### Cause

The Power Automate installer depends on the LanmanServer service and attempts to start it if it isn't already running. If the service can't be started, installation steps that depend on it fail.

#### Resolution

To solve this issue,

1. Select Windows logo key+<kbd>R</kbd> and type _services.msc_ or _services_ in the **Run** window to open the Services manager. Find the service named "Server", right-click it and select **Properties**.
1. In the **General** tab, make sure that its **Startup type** isn't disabled (it should be **Automatic** by default.)
1. Select **Apply** to update the startup type.
1. You can then start the service manually by right-clicking it in the services manager tool and selecting **Start**.
1. Once the service runs, you can attempt the installation again.
