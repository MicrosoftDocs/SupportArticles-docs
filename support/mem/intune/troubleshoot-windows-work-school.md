---
title: Troubleshoot “Set up for work or school” enrollment in Intune
description: Troubleshoot blocked Microsoft Intune enrollment for Windows devices when the user chooses "Set up for work or school" and signs in with Azure AD. The device is recognized as a personal device and the tenant does not allow for this device type.
ms.date: 01/31/2022
---

# Unblock Windows “Set up for work or school” enrollment

This article gives troubleshooting guidance..
Some customers run into issues during the out-of-box experience (OOBE) when enrolling Windows devices, specifically when the device is recognized as a *personal* device and the tenant does not allow for this device type. This scenario can occur during device setup when the user chooses **Set up for work or school** and then signs in with an organization-linked Azure Active Directory (Azure AD) account.

:::image type="content" source="media/windows-work-school-enroll/windows-setup.png" alt-text="Windows setup screen showing options for setting up the device":::

:::image type="content" source="media/windows-work-school-enroll/windows-setup-2.png" alt-text="Windows sign-in screen for setting up a work or school account.":::

If you have personal device enrollment blocked for your tenant, this enrollment method will result in a failure. The associated error code you might see is 80180014.

To fix this, you can allow personal enrollment of Windows devices either for all users or for a subset of users you want to be allowed to enroll personal devices. We recommend limiting the number of users you allow to enroll personal windows devices to only the users who will need this capability. This will ensure that other users in your organization do not accidentally enroll their personal devices.

To allow personal device enrollment, sign-in to the [Microsoft Endpoint Manager admin center](https://go.microsoft.com/fwlink/?linkid=2109431) and select **Devices** > **Enroll devices** > **Enrollment device platform restrictions**.

:::image type="content" source="media/windows-work-school-enroll/enrollment-restrictions.png" alt-text="Enrollment device platform restrictions option in Intune.":::

Select **Windows restrictions** > **Create restriction** and give the restriction an informative name. On the **Platform settings** page, make sure to set **Personally owned devices** to **Allow**.

:::image type="content" source="media/windows-work-school-enroll/allow-personal.png" alt-text="Allow personally owned devices in Intune.":::

Assign the restriction to the group(s) you want to let enroll personal devices.

:::image type="content" source="media/windows-work-school-enroll/select-groups.png" alt-text="Assign the restriction to Azure AD groups.":::

Review and create the restriction.
