---
title: Unable to add attachment due to IO error - Android Enterprise device in Intune
description: Gives a workaround for the issue where Android Enterprise enrolled devices can't attach photos to applications.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:AppDeployment - Android\EnterpriseSystem
ms.reviewer: kaushika, kakimble, intunecic, joelste
---
# Can't attach photos to applications on Android Enterprise work profile enrolled devices

This article fixes an issue in which you can't attach photos to applications on an Android Enterprise enrolled device.

## Symptoms

On an Android Enterprise work profile enrolled device, when you try to attach a photo into the work profile's application (such as Word, Excel, Outlook, or OneDrive), you receive the following error message:

> Unable to add attachment due to IO error

:::image type="content" source="media/android-enterprise-enrolled-devices-fails-attaching-photo/unable-add-attachment-error.png" alt-text="Screenshot of the IO error." border="false":::

## Cause

This occurs because Android requires an additional application in the workspace to open photos.

## Solution

To resolve this issue, approve and assign a File Explorer application (such as [File Explorer application by Google](https://play.google.com/store/apps/details?id=com.google.android.apps.nbu.files)) from the managed Google Play store to your device.

Then navigate to the application, and click the **Attach** icon to attach photos.

> [!NOTE]
> Each app has a different attaching process. For example, when configuring it through Outlook, select the **three horizontal lines** menu in the top left and then select **more**. Then, an option is provided for you to select photos to attach.

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-disclaimer.md)]
