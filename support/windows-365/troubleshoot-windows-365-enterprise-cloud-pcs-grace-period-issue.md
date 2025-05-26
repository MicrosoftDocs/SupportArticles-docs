---
title: Troubleshoot Windows 365 Enterprise Cloud PC Grace Period Issues
description: Introduces how to troubleshoot Windows 365 Enterprise Cloud PCs that are in the grace period.
manager: dcscontentpm
ms.date: 02/18/2025
ms.topic: troubleshooting
ms.reviewer: anwill
ms.custom:
- pcy:Provisioning\Grace Period Issues
- sap:WinComm User Experience
---
# Troubleshoot Windows 365 Enterprise Cloud PC grace period issues

Windows 365 Cloud PCs provide a seamless and scalable solution for virtual desktops. However, administrators might encounter situations where a Cloud PC enters a grace period. This guide explains how to troubleshoot Cloud PC grace period issues.

## Understand the grace period

When a Windows 365 license is removed from a user account, their Enterprise Cloud PC enters a grace period. During this time, the Cloud PC remains accessible before it's deprovisioned. It's important to act promptly to avoid service disruption.

A Windows 365 Cloud PC can enter a grace period when a valid Windows 365 license is removed from a user or the connection between the user and the provisioning policy is broken. This can happen in one of the following scenarios:

- The user account is removed from the group where the license is inherited.
- The direct license assignment is removed from the user.
- The user is removed from the group that is assigned to the provisioning policy used to create the Cloud PC.

In any of these scenarios, the Cloud PC remains operational for seven days, allowing time to resolve the issue before the Cloud PC is deprovisioned.

## Actions to address the grace period

To return Cloud PCs to a provisioned state, check the following two key areas:

1. The original license assignments are in place.
2. The connection to the relevant provisioning policy is in place.

The following sections provide the necessary actions to address the grace period. The sections include the following steps:

1. Reassign Windows 365 Enterprise licenses to users via group-based licensing or direct assignment.
2. Ensure the user is a member of any group assigned to a provisioning policy and that the assignments are in place.

## Missing Windows 365 licenses

There are two primary methods to reassign Windows 365 licenses to users: group-based licensing and direct assignment.

### Group-based licensing

Group-based licensing allows administrators to assign licenses to users through Microsoft Entra ID groups. This method simplifies management by automating license assignments based on group membership. Follow these steps to manage group-based licensing:

1. Sign in to the [Microsoft 365 admin center](https://go.microsoft.com/fwlink/p/?linkid=2024339) as at least a License Administrator.
2. Go to the **Billing** > [Licenses](https://go.microsoft.com/fwlink/p/?linkid=842264) page.
3. On the **Subscriptions** tab, select the Windows 365 license that you want to assign.
4. On the **License details** page, select the **Groups** tab, and then select **Assign licenses**.
5. In the details panel, search for the group that you want to assign licenses to, and then select its name from the **Suggested groups** list.
6. To assign or remove access to specific items, select **Turn apps and services on or off**.
7. When finished, select **Assign**, and then close the right pane.

### Direct assignment

Direct assignment involves manually assigning licenses to individual users. Follow these steps to manage the direct assignment of licenses:

1. Sign in to the [Microsoft 365 admin center](https://go.microsoft.com/fwlink/p/?linkid=2024339) as at least a License Administrator.
2. Go to the **Billing** > [Licenses](https://go.microsoft.com/fwlink/p/?linkid=842264) page.
3. On the **Subscriptions** tab, select the Windows 365 license that you want to assign.
4. On the **License details** page, select the **Users** tab, and then select **Assign licenses**.
5. In the **Assign licenses to users** pane, type a name, and then choose it from the results to add it to the list. You can add up to 20 users at a time.
6. To assign or remove access to specific items, select **Turn apps and services on or off**.
7. When finished, select **Assign**, and then close the right pane.

## Disconnection from provisioning policies

If a user is disconnected from a provisioning policy, either by being removed from the assigned group or if the group they belong to is unassigned, any Cloud PCs created from that association enter a grace period. To resolve this issue, ensure that the correct assignments and group memberships are in place.

### Validate group membership

Provisioning policies in Windows 365 require users to be part of specific Microsoft Entra ID groups to receive their Cloud PCs. Ensuring that users are members of these groups is crucial for proper provisioning.

To do so, follow these steps:

1. Sign in to the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431), and then select **Groups** > **All groups**.
2. Choose the relevant group associated with the provisioning policy.
3. Select **Members** > **Add members**.
4. Add the users who require Cloud PCs to this group and select **Select**.

### Validate group assignment to provisioning policies

If a group is removed from a provisioning policy, all Cloud PCs associated with its members enter a seven-day grace period. To resolve this issue, you need to reassign the group.

To do so, follow these steps:

1. Sign in to the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431), and then select **Devices** > **Windows 365**.
2. Navigate to **Provisioning policies** and open the provisioning policy the Cloud PCs in the grace period were created from.
3. Under **Assignments**, select **Edit**.
4. On the **Assignments** page, select **Add groups**, choose the groups you want this policy assigned to, and then select **Select**.

   > [!NOTE]
   > Nested groups aren't currently supported.

5. Select **Next** and **Update**.

## Monitoring and verification

After reassigning licenses and ensuring group memberships, it's important to verify that the Cloud PCs are no longer in the grace period and that users can access the virtual desktops.

To do so, follow these steps:

1. Sign in to the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431), and then select **Devices** > **Windows 365**.
2. Navigate to **All Cloud PCs** and check the status of the affected Cloud PCs.
3. Ensure that the Cloud PCs are in the **Provisioned** status and that the users can sign in to the Cloud PCs without issues.

## End the grace period by deprovisioning Cloud PCs

If a Cloud PC is no longer needed, you can end the grace period, thus circumventing the seven-day grace period by immediately deprovisioning the device. This process involves removing the Cloud PC from your environment and releasing the associated resources.

> [!NOTE]
> Deprovisioning a Cloud PC is a destructive action. This operation deletes the operating system and data, and the Cloud PC will no longer be available. This action is irreversible, so ensure that any necessary data is backed up before deprovisioning.

To do so, follow these steps:

1. Sign in to the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431), and then select **Devices** > **Windows 365**.
2. Navigate to **All Cloud PCs** and locate the Cloud PC that is in a grace period and no longer required.
3. In the **Status** column of the list, select **In grace period** > **Deprovision now** > **Yes**.

For more information, see [End grace period for Cloud PCs in Windows 365](/windows-365/enterprise/end-grace-period).

## Conclusion

Addressing issues with Windows 365 Cloud PCs in the grace period requires prompt action to reassign licenses and ensure proper group memberships. By following this guide, administrators can efficiently manage their Windows 365 environment and avoid service disruptions. Continual monitoring and verification are essential to maintaining a seamless user experience.
