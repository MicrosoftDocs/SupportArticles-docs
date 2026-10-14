---
title: Configure quick machine recovery by using Group Policy
description: Learn how to enable or disable quick machine recovery on Windows Server 2025 by using Group Policy. Follow these steps to configure your servers.
ms.date: 10/13/2026
ms.topic: concept-article
ms.reviewer: v-fvalentyna, kaushika
ms.custom:
- sap:group policy
- pcy:WinComm Directory Services
ai-usage: ai-assisted
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Use Group Policy to enable or disable quick machine recovery on Windows Server 2025

## Summary

Quick machine recovery on Windows Server 2025 uses Windows Recovery Environment (WinRE) to search Windows Update for a remediation when a server encounters a critical boot failure. This article explains how administrators can use Group Policy computer settings to enable or disable quick machine recovery. Recovery succeeds only if an applicable remediation is available.

## Before you begin

Use a Windows Server 2025 installation that includes the quick machine recovery and Group Policy support, a working WinRE configuration, and network connectivity from the recovery environment to the services required for cloud remediation. Quick machine recovery is disabled by default on server. An administrator must configure it to enable the feature.

- Release prerequisite: Quick machine recovery is available for Windows Server 2025 editions with the October 2026 security update or later installed.
- For local configuration, sign in to the target server with administrator permissions and use Local Group Policy Editor.
- For domain configuration, use Group Policy Management on a Windows Server or an administration computer with the appropriate management tools. You need permissions to edit the GPO and link it to the intended organizational unit (OU).

The policy editor must contain the quick machine recovery administrative template settings. 

> [!NOTE]
> This article doesn't apply to Windows clients or other Windows Server versions.

## Group Policy computer settings for quick machine recovery

In the policy editor, open **Computer Configuration** > **Administrative Templates** > **System** > **Quick Machine Recovery**. The configuration uses computer settings, not User Configuration. Group Policy loopback processing is not required for this procedure.

| **Policy setting** | **Enabled** | **Disabled** |  **Not Configured** |
|---|---|---|---|
| Enable Cloud Remediation | Permits the quick machine recovery engine to retrieve and apply cloud-sourced, targeted remediation content. | Prevents cloud-based remediation. Recovery relies on locally available resources. | Uses local recovery settings, if present, or the built-in default for the edition. |
| Enable Auto Remediation | If device fails to start, automatically checks for available cloud-sourced  remediations, without user interaction. | Prevents  quick machine recovery from automatically checking for solutions. Requires user interaction to manually check for remediations. | Uses local recovery settings, if  present, or the built-in default for the edition. |
| Set Recovery Retry Interval | Specifies the interval, in minutes, between successive quick machine recovery retry attempts. Enter a value from 0 to 4320 minutes. A value of 0 allows one recovery attempt with no retries. | Uses the locally configured retry interval, if present, or the built-in default of 0 minutes (one attempt with no retries). | Uses the locally configured retry interval, if present, or the built-in default of 0 minutes (one attempt with no retries). |
| Set Total Recovery Wait Time | Specifies the maximum total time, in minutes, spent across all recovery attempts before abandoning recovery and allowing the system to boot normally or enter the standard recovery environment. Enter a value from 1 to 4320 minutes. | Uses the locally configured total wait time, if present, or the built-in default of 180 minutes. |  Uses the locally configured total wait time, if present, or the built-in default of 180 minutes. |

## Enable quick machine recovery on a single server by using Local Group Policy

1. Sign in to the Windows Server 2025 computer as an administrator.
1. Open Local Group Policy Editor by running `gpedit.msc`.
1. Navigate to **Computer Configuration** > **Administrative Templates** > **System** > **Quick Machine Recovery**.
1. Open **Enable Cloud Remediation**, select **Enabled**, and select **Apply**, then **OK**.
1. Open **Enable Auto Remediation**, select **Enabled**, and select **Apply**, then **OK**. This is the two-setting configuration used in the Server validation procedure.
1. Set **Set Recovery Retry Interval** and **Set Total Recovery Wait Time** to the values that are appropriate for your deployment. *Note*: For headless servers, **Set Recovery Retry Interval** can be configured to a value greater than 0 to allow repeated remediation attempts during the Total Recovery Wait Time. Otherwise, only one remediation attempt is made per wait period, which may delay receiving remediations.
7. Close the editor, refresh computer policy, and verify the effective recovery settings as described below.

## Apply quick machine recovery policy to domain-managed Windows Server 2025 computers

Use a dedicated GPO and target only the intended Windows Server 2025 computer accounts. Start with a pilot group before expanding the configuration.

1. Open Group Policy Management and locate the domain containing the target server computer accounts.
1. Under **Group Policy Objects**, create a GPO with a descriptive name, such as Windows Server 2025 - Quick Machine Recovery.
1. Edit the new GPO and go to **Computer Configuration** > **Administrative Templates** > **System** > **Quick Machine Recovery**.
1. Configure **Enable Cloud Remediation** and **Enable Auto Remediation** as **Enabled** to use the validated enablement configuration. To turn off both capabilities, configure both settings as **Disabled**.
1. Link the GPO to the OU containing the intended Windows Server 2025 computer accounts. If the OU contains other operating systems, restrict the GPO scope to the intended Windows Server 2025 computers before rollout.
1. Refresh computer policy on a target server and verify both the applied GPO and effective recovery settings (see section below).
1. Confirm pilot results before expanding the scope. Resolve conflicting computer policies through your normal Group Policy management process.

## Disable quick machine recovery through Group Policy

To prevent cloud-sourced quick machine recovery remediation, explicitly disable **Enable Cloud Remediation**. To also suppress automatic application of local remediation packages, disable **Enable Auto Remediation**. Other recovery resources aren't equivalent to cloud quick machine recovery and aren't all disabled by these settings.

1. Open the local policy or domain GPO that manages the target Windows Server 2025 computers.
1. Go to **Computer Configuration** > **Administrative Templates** > **System** > **Quick Machine Recovery**.
1. Open **Enable Cloud Remediation**, select **Disabled**, and select **Apply**, then **OK**.
1. Open **Enable Auto Remediation**, select **Disabled**, and select **Apply**, then **OK**.
1. (Optional) Verify the effective configuration.

> [!IMPORTANT]
> **Not Configured** isn't an explicit off switch. This setting returns control to local recovery settings or the edition default. Don't use **Not Configured** as a substitute for **Disabled** when you need to enforce that a capability is off.

## Verify the effective quick machine recovery policy (optional)

> [!NOTE]
> Run the following commands from an elevated command prompt.

After applying the policy, administrators can run `gpresult /scope computer /r` to verify that the policy was applied.

From the elevated command prompt, run `reagentc /getrecoverysettings` to confirm the effective quick machine recovery configuration.

Use a manual `gpupdate /force` when you want immediate policy processing.

## Troubleshooting

| **Issue** | **Check** |
|---|---|
| Quick machine recovery settings are missing | Confirm the Windows Server 2025 image or update and policy templates include quick machine recovery support. For a domain editor, confirm the templates available to that editor. Don't substitute Windows client prerequisites. Check the release prerequisite section under the Before you begin section. |
| The intended GPO isn't applied | Check the computer's OU, GPO link, computer-policy status, scope, permissions, and conflicting policies. Review `gpresult` output. |
| The editor shows Enabled, but effective recovery settings differ| Refresh computer policy and inspect  `reagentc /getrecoverysettings` on the target server. Confirm which policy is actually applied. |
| Quick machine recovery can't find a solution | Verify that the device meets the required build prerequisites and that quick machine recovery is enabled. Quick machine recovery is a best-effort feature and might not resolve every issue. Microsoft might not have released remediation for the issue, or the available remediation might not apply to the device. Review the relevant Microsoft support or release documentation for information about available remediations and their applicability. |
| The environment uses only WSUS or disconnected update infrastructure | Don't assume that Windows Server Update Services (WSUS) or an offline update source supplies quick machine recovery remediations. The server design depends on Windows Update based remediations only. |

## Data collection

When requesting support, collect the Windows Server 2025 edition and OS build, installed update details, the relevant policy states, `gpresult` output, and `reagentc /getrecoverysettings` output. If a recovery attempt was performed in a controlled test, include its time and recovery logs. Review collected files for credentials or other sensitive information before sharing them.

## Related documentation

- [Group Policy overview - Windows Server](/troubleshoot/windows-server/group-policy/group-policy-overview)
- [Group Policy Management Console](/windows-server/identity/ad-ds/manage/group-policy/group-policy-management-console)
- [Quick machine recovery](/windows/configuration/quick-machine-recovery)
