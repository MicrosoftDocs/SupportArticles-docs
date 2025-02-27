---
title: Troubleshoot Windows 365 Business Cloud PC setup issues
description: Troubleshoot the Setup failed error or the Cloud PC setup takes longer than 90 minutes after you assign the user a license in Windows 365 Business.
manager: dcscontentpm
ms.date: 01/20/2025
ms.topic: troubleshooting
ms.reviewer: ivivano, erikje
ms.custom: intune-azure, get-started
ms.collection:
- M365-identity-device-management
- tier2
---

# Troubleshoot Windows 365 Business Cloud PC setup issues

This article provides troubleshooting steps for the "Setup failed" error or the issue where the setup takes longer than 90 minutes after you assign the user a license.

> [!IMPORTANT]
> You must be a [Global Administrator](/entra/identity/role-based-access-control/permissions-reference#global-administrator) to do most tasks described in this article. If other admin roles can be used for a specific procedure, they're noted before the procedure. If you don't have permission to sign in to or access parts of the Azure portal, contact your IT administrator. For more information about Azure rules, see [Microsoft Entra built-in roles](/azure/active-directory/roles/permissions-reference). To learn more about the Azure portal, see [Azure portal overview](/azure/azure-portal/azure-portal-overview).

## Make sure the MDM authority configuration is set up correctly

Ensure that the mobile device management (MDM) authority configuration is set up correctly. Depending on whether you plan to use Microsoft Intune to manage the Cloud PCs, follow the appropriate path:

- If you use or plan to use Microsoft Intune for your Cloud PCs, follow the steps in [Path A: Use Microsoft Intune to manage your Cloud PCs](#path-a-use-microsoft-intune-to-manage-your-cloud-pcs).
- If you don't plan to use Microsoft Intune to manage your Cloud PCs, follow the steps in [Path B: Turn off automatic MDM enrollment and Intune enrollment in Organization Settings](#path-b-turn-off-automatic-mdm-enrollment-and-intune-enrollment-in-organization-settings).

### Path A: Use Microsoft Intune to manage your Cloud PCs

If you already use Microsoft Intune, or plan to use it to manage your Windows 365 Cloud PCs, make sure that your **Mobility (MDM and MAM)** settings in Microsoft Entra ID are correctly configured.

1. In the Azure portal, go to the [Microsoft Entra Overview](https://go.microsoft.com/fwlink/p/?linkid=516942) page.
2. In the left navigation pane, under **Manage**, select **Mobility (MDM and MAM)**, and then select **Microsoft Intune**.
3. On the **Configure** page, next to **MDM user scope**, select **Some** or **All**, and then select **Save**.
4. In the left navigation pane, under **Manage**, select **Mobility (MDM and MAM)** > **Microsoft Intune Enrollment**, and then repeat step 3.

If the automatic enrollment of new Cloud PCs into the Microsoft Intune setting is turned on, users might see their Cloud PCs fail to complete their setup on the Windows 365 home page. Consult the following table for how to troubleshoot these issues:

| Error | Troubleshooting steps |
| --- | --- |
| To complete the setup, ask your administrator to update policy settings in Microsoft Intune to enroll this device. | Check the Intune settings you might have previously set on your tenant. For more information, see [Troubleshoot policies and profiles](../mem/intune/device-configuration/troubleshoot-policies-in-microsoft-intune.md). Once the issue is fixed, either you or the user can reset the Cloud PC. |
| To complete the setup, ask your administrator to remove restrictions preventing Intune from allowing Windows enrollment.| You might have set up enrollment restrictions on your Intune tenant. For more information, see [Enrollment restrictions overview](/mem/intune/enrollment/enrollment-restrictions-set). Once the restrictions are removed, either you or the user can reset the Cloud PC. |
| To complete the setup, ask your administrator to correct the configuration of the Mobile Device Management discovery URL in Intune.| Confirm that the MDM discovery URL is the default for Intune. Follow steps 1-4 to set it in [Configure automatic MDM enrollment](/mem/intune/enrollment/windows-enroll#configure-automatic-mdm-enrollment). Once the MDM discovery URL is set to the default, either you or the user can reset the Cloud PC. |

Users who are assigned a Cloud PC must have an Intune license assigned to them to receive user policies. The CloudPCBPRT system account doesn't need to be assigned an Intune license.

> [!IMPORTANT]
> To assign licenses, you must be a Global or Licensing administrator, or you must have a role with licensing permissions.

1. In the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/p/?linkid=2169290), select **Users** > **All Users**.
2. In the **All users** list, select a user.
3. On the user **Profile** page, select **Licenses**.
4. On the **Licenses** page, select **Assignments**.
5. Find **Intune**, select the checkbox, and then select **Save**. The user account now has the permissions to use the service and enroll devices.
6. Go to [Reset your Cloud PCs](#reset-your-cloud-pcs).

### Path B: Turn off automatic MDM enrollment and Intune enrollment in Organization Settings

If you don't plan to use Microsoft Intune for your Cloud PC management, turn off automatic MDM enrollment and clear the **Enroll new Cloud PCs in Microsoft Intune** checkbox in **Organization Settings**.

> [!IMPORTANT]
> If you're not the MDM administrator, don't use either of the following procedures without first consulting your IT administrator. Only follow these procedures if Cloud PCs aren't being set up. Any configuration changes could affect your management environment. If you need help, [contact Intune support](/mem/get-support).

<a name='use-the-azure-ad-portal-to-turn-off-automatic-intune-enrollment'></a>

#### Use the Microsoft Entra admin center to turn off automatic Intune enrollment

1. In the Azure portal, go to the [Microsoft Entra Overview](https://go.microsoft.com/fwlink/p/?linkid=516942) page.
2. In the left navigation pane, under **Manage**, select **Mobility (MDM and MAM)**, and then select **Microsoft Intune**.
3. On the **Configure** page, you see one of two things. If you have a Microsoft Entra ID P1 or P2 subscription, select **None** next to MDM user scope, and then select **Save**. If you don't have a Microsoft Entra ID P1 or P2 subscription, select **Disable**.
4. In the left navigation pane, under **Manage**, select **Mobility (MDM and MAM)**, and select **Microsoft Intune Enrollment**.
5. Go to [Reset your Cloud PCs](#reset-your-cloud-pcs).

#### Turn off the automatic enrollment of newly created Cloud PCs

1. On the [Windows 365 home page](https://windows365.microsoft.com), go to **Your organization's Cloud PCs**, and then select **Update organization settings**.
2. On the right-hand side, scroll down to **Microsoft Intune** and clear the **Enroll new Cloud PCs in Microsoft Intune** checkbox.
3. Select **Save** at the bottom.

## Reset your Cloud PCs

After you complete the troubleshooting steps in this article, your users must restart their Cloud PC setup. All the Cloud PC users who received the "Setup failed" error should take the following steps to reset their Cloud PCs.

1. On the [Windows 365 home page](https://windows365.microsoft.com), select the gear icon for any Cloud PC that has the "Setup failed" status, and then select **Reset**. This action restarts the setup process.
2. If the "Setup failed" error still displays after the reset, and you skipped [Make sure the MDM authority configuration is set up correctly](#make-sure-the-mdm-authority-configuration-is-set-up-correctly), complete that step, and then reset the Cloud PC again. Otherwise, in the left navigation pane, select **New support request** to open a support ticket.
