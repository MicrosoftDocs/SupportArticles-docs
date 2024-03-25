---
title: Troubleshoot "Set up for work or school" enrollment in Intune
description: Troubleshoot blocked Microsoft Intune enrollment for Windows devices when the user chooses "Set up for work or school" and signs in with Microsoft Entra ID. The device is recognized as a personal device and the tenant doesn't allow for this device type.
ms.date: 12/05/2023
search.appverid: MET150
ms.reviewer: kaushika
ms.custom: sap:Enroll Device - Windows\Advisory
---

# Unblock Windows "Set up for work or school" enrollment

This article helps troubleshoot an enrollment failure during the out-of-box experience (OOBE) when enrolling Windows devices with a work or school account.

This issue can occur during device setup when the user chooses **Set up for work or school** and then signs in with an organization-linked Microsoft Entra account. The enrollment fails and you might see associated error code 80180014.

:::image type="content" source="media/troubleshoot-windows-work-school/windows-setup.png" alt-text="Windows setup screen showing options for setting up the device":::

:::image type="content" source="media/troubleshoot-windows-work-school/windows-setup-2.png" alt-text="Windows sign-in screen for setting up a work or school account.":::

## Cause

In this scenario, the device is recognized as a *personal* device. If you have personal device enrollment blocked for your tenant, this enrollment method will result in a failure.

## Solution

To fix this issue, you can allow personal enrollment of Windows devices either for all users or for a subset of users you want to be allowed to enroll personal devices. We recommend limiting the number of users you allow to enroll personal windows devices to only the users who will need this capability. This will ensure that other users in your organization don't accidentally enroll their personal devices.

To allow personal device enrollment, sign-in to the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431) and select **Devices** > **Enroll devices** > **Enrollment device platform restrictions**.

:::image type="content" source="media/troubleshoot-windows-work-school/enrollment-restrictions.png" alt-text="Enrollment device platform restrictions option in Intune.":::

Select **Windows restrictions** > **Create restriction** and give the restriction an informative name. On the **Platform settings** page, make sure to set **Personally owned devices** to **Allow**.

:::image type="content" source="media/troubleshoot-windows-work-school/allow-personal.png" alt-text="Allow personally owned devices in Intune.":::

Assign the restriction to the group(s) you want to let enroll personal devices.

:::image type="content" source="media/troubleshoot-windows-work-school/select-groups.png" alt-text="Assign the restriction to Microsoft Entra groups.":::

Review and create the restriction.
