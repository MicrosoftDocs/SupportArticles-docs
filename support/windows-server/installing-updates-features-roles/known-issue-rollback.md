---
title: Known Issue Rollback
description: Learn how Known Issue Rollback technology improves the Windows update experience and makes it even more reliable for organizations.
ms.topic: troubleshooting
ms.date: 09/22/2025
manager: dcscontentpm
audience: itpro
ms.reviewer: kaushika, dstrome, v-appelgatet
ms.custom:
- sap:windows servicing, updates and features on demand\windows update - configuring and managing client settings
- pcy:WinComm Devices Deploy
---

# Known Issue Rollback (KIR)

Known Issue Rollback (KIR) is a robust mitigation technology that's built into Windows updates to help you safeguard and troubleshoot individual parts of the update. This capability is part of Microsoft's continuous efforts to improve the Windows update experience and make it even more reliable for organizations.

The mitigation mechanism quickly reverts a Windows update issue by affecting only the targeted change, fix, functionality, or feature that caused the problem. KIR rolls that change back to its previous behavior. All other changes that are part of that update remain intact.

This technology is available for changes applied as part of Windows updates for the supported versions of Windows on all Enterprise-managed and retail or consumer devices.

## Motivation behind KIR

To help customers stay protected and productive, Microsoft releases multiple Windows updates monthly. Historically, if a Windows update encountered an issue, the Windows user or organizational IT admin had the following options:

- Uninstall the entire update. This option prevents the organization from getting the latest security updates. As a result, the organization becomes non-compliant and less secure.
- Skip the entire update. This option prevents the organization from getting the latest security updates. As a result, the organization becomes non-compliant and less secure.
- Deploy the update and wait for the fix to become available. Depending on the issue, this option could hamper productivity.

To address security and productivity concerns, Microsoft created KIR. KIR is a technology solution that allows users to be productive while minimizing the impact to security or compliance.

KIR came together as a functionally complete system beginning in Windows 10, version 2004. Since then, most of the code changes in Microsoft's monthly updates support KIR capability.

## How KIR works at the code level

Changes that Windows updates implement have built-in runtime feature flags. At runtime, the KIR infrastructure uses the policies on the device (determined by Group Policy settings and service-delivered metadata) to determine whether to run the new code or the previous code. This approach means that if the policies or metadata indicate that there's an issue in a specific change, that change reverts to the older code behavior.

## Scenarios that KIR supports

Windows offers KIR capability on all supported versions of [Windows Server](/windows-server/get-started/windows-server-release-info) and [client](/windows/release-health/supported-versions-windows-client) platforms, beginning with Windows Server 2008 SP2. Most of the servicing fixes on Windows use the KIR capability as a mitigation strategy.

> [!IMPORTANT]  
> KIR only affects non-security updates and fixes. Security updates and fixes do not use KIR.

To find out if KIR can mitigate your regression issue, see [Ways for enterprises to discover KIR Group Policies](#ways-for-enterprises-to-discover-kir-gp).

## How KIR activates

For the purpose of KIR activation, Windows devices belong to two different categories. Each category has its own process for activating KIR.

- **Enterprise-managed devices:** Enterprise-managed devices are [update-managed Windows devices](/windows/deployment/update/update-managed-unmanaged-devices#what-are-update-managed-windows-devices). Microsoft provides a Group Policy template for the organization's IT administrator. To activate KIR, the IT administrator applies the template to the organization's Group Policy infrastructure.
- **Retail and consumer devices:** Retail and consumer devices are devices that aren't considered update-managed Windows devices. Typically, these are devices that aren't managed by an IT admin. These devices receive policy changes for activating KIR through the Microsoft-managed Windows Update cloud service.

### KIR for Enterprise-managed devices

As an enterprise IT admin for these devices, you're in control. In accordance with Microsoft policy, for enterprise-managed devices, Microsoft publishes a specific Group Policy template on the Download Center. You can download this Group Policy template, and then configure and apply the template to activate KIR.

:::image type="content" source="media/known-issue-rollback/enterprise-admin-downloads-kir-gp-template.png" alt-text="Diagram that shows how an administrator downloads a K.I.R. group policy template, integrates it into Group Policy for the enterprise, and then deploys the change to enterprise devices." lightbox="media/known-issue-rollback/enterprise-admin-downloads-kir-gp-template.png":::

> [!NOTE]  
> [Group Policy](/windows-server/identity/ad-ds/manage/group-policy/group-policy-overview) is a feature in Microsoft Windows that allows IT admins to centrally manage and configure operating system settings, applications, and user settings across devices in an Active Directory environment.

If you experience an issue that's related to a feature update, check the Download Center for a related KIR policy template. If you don't find one, follow these steps to request a KIR activation for your organization.

1. Report the issue or regression to [Microsoft Support](https://support.serviceshub.microsoft.com/supportforbusiness/onboarding), the customer-facing arm of Microsoft, and request the Group Policy to activate KIR.
1. Microsoft Support works with product teams to identify the applicable Group Policy settings, uploads an appropriate Group Policy template to the Download Center, and then provides you with the link to download the template.

Download the template, and then follow the steps in [How to use Group Policy to deploy a Known Issue Rollback](/troubleshoot/windows-client/group-policy/use-group-policy-to-deploy-known-issue-rollback).

For enterprise-managed devices that are domain joined, the Group Policy refresh happens at certain regular intervals. Choose one of the following actions to make sure that the Group Policy settings take effect:

- Wait for Group Policy to refresh in the background, then restart the affected devices.
- To force a single device to update its Group Policy settings, open a Command Prompt window on the device, and then run 'gpupdate /force'. After the command runs, restart the device.

For more information about refreshing Group Policy, see [Group Policy processing for Windows](/windows-server/identity/ad-ds/manage/group-policy/group-policy-processing).

Additionally, for information about how to mitigate regressions on Intune or endpoint management service managed devices, see [Use Group Policy to deploy a Known Issue Rollback](/troubleshoot/windows-client/group-policy/use-group-policy-to-deploy-known-issue-rollback).

### KIR for retail and consumer devices

For these devices, Microsoft activates KIR by using Windows Update. Users don't have to take any action.

> [!NOTE]  
> Any device that's not connected to Windows Update won't get Windows updates or KIR.

When an issue or regression is identified in retail devices, Microsoft product teams gather detailed information about the problem and its impact, determine the root cause, and report the incident internally. Then based on the results of this analysis, Microsoft decides whether to roll back a regressing change. If required, Microsoft activates KIR through cloud services.

:::image type="content" source="media/known-issue-rollback/retail-kir-propagates-through-windows-update-service.png" alt-text="Diagram that shows how Microsoft distributes a K.I.R. by using the Windows Update infrastructure." lightbox="media/known-issue-rollback/retail-kir-propagates-through-windows-update-service.png":::

After Microsoft qualifies a regression for KIR activation, it makes a configuration update change in the cloud. All devices that get updates through **Settings** > **Windows Update** (WU) get notice of this change and receive the configuration update within 24 hours. Upon receiving and installing the update, the code causing the issue is disabled. In some cases, a device reboot might be required to disable the code.

In accordance with Microsoft's safe deployment practices, in most cases, Microsoft identifies and publishes a rollback before user devices have the chance to even install the update containing the issue. Hence, most users never see the regression.

Microsoft transmits specific information regarding KIR activation. This data assists us in evaluating the effectiveness of the rollback within the ecosystem. See how to [configure Windows diagnostic data in your organization](/windows/privacy/configure-windows-diagnostic-data-in-your-organization).

## Ways for Enterprises to discover KIR GP

When Microsoft identifies that an issue affects multiple customers or represents a frequent scenario, this issue is documented on Windows servicing communication channels. The documentation explains the most common symptoms and provides a link to the Group Policy .msi file for the commercial users, so they can mitigate the issue.

Here's where you can look for known issues and KIR mitigations:

- Windows release notes on the Windows update history sites, such as the [Windows 11](https://aka.ms/Windows11/24H2/UpdateHistory), [Windows 10](https://support.microsoft.com/topic/windows-10-update-history-8127c2c6-6edf-4fdf-8b9f-0f7be1ef3562), and [Windows Server](https://support.microsoft.com/topic/windows-server-2025-update-history-10f58da7-e57b-4a9d-9c16-9f1dcd72d7d7) update history pages. Scroll down to the **Known issues in this update** section.
- [Windows release health](/windows/release-health/) dashboard. This site provides links to all Windows release notes for Windows versions in support.
- Windows release health section on the [Microsoft 365 admin center](https://admin.microsoft.com/Adminportal/Home#/homepage). You can also sign up for [Windows release health notifications](/windows/deployment/update/check-release-health).

If you can't find documentation for the issue that you encounter, contact [Microsoft Support](https://support.serviceshub.microsoft.com/supportforbusiness/onboarding).

## KIR lifecycle management: What to do once KIR is activated?

Once KIR is activated, there's no other action required from you throughout the lifecycle of the KIR. Once the issue is resolved, it's included into subsequent Windows updates. The outdated policy simply becomes a benign setting that does nothing and isn't needed anymore.

## Frequently asked questions (FAQ)

### Does the same Group Policy apply for all devices for a given regression?

No. When requesting a GP to activate KIR, you need to tell Microsoft Support the comprehensive list of the OS versions on which you observe the regression. Microsoft Support then provides a unique Group Policy template for each of the specified Windows versions. Pay attention to the OS version in the file name before you install and activate them on the respective devices.

### What do I do if I still see the regression after I installed a Group Policy for activating the KIR?

There are a few reasons you might still observe regressions after activating the KIR. Troubleshoot as follows:

1. Make sure that you install the Group Policy corresponding to the OS version running on the device.
1. Go to Group Policy Editor and ensure that the state is **Disabled** for the specific Group Policy.
1. Restart the devices after changing the Group Policy state.
1. If the issue persists, contact your assigned Microsoft Support partner.

### What do I do if I need to deploy KIR for my enterprise but can't use Group Policy infrastructure?

For additional details about how to deploy KIR, including how to deploy KIR to single devices and alternative solutions for deployihg KIR, see [Use Group Policy to deploy a Known Issue Rollback](/troubleshoot/windows-client/group-policy/use-group-policy-to-deploy-known-issue-rollback) .
