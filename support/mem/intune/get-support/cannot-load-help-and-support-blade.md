---
title: Cannot load the Microsoft Intune Help and support blade
description: Provides a solution for when the Intune Help and support blade doesn't load correctly in the Microsoft Intune admin center.
ms.date: 12/05/2023
search.appverid: MET150
ms.reviewer: kaushika
---
# You cannot load the Microsoft Intune Help and support blade

This article gives a solution for when the **Help and support** blade doesn't load in the Microsoft Intune admin center.

## Symptoms

You experience one of the following issues:

- You cannot load the **Help and support** blade in the Intune portal.
- You receive a **login.microsoftonline.com refused to connect** error message in browsers such as Chrome or Firefox. Other browsers such as Safari or Microsoft Edge may display similar errors or nothing at all.

    :::image type="content" source="media/cannot-load-help-and-support-blade/login-refused-connect-error.png" alt-text="Screenshot of the login.microsoftonline.com refused to connect error in Help and support blade." lightbox="media/cannot-load-help-and-support-blade/login-refused-connect-error.png":::

The exact symptom may differ depending on the browser. However, the overall problem is that the **Help and support** blade doesn't load correctly even when you use a Global Administrator account.

## Cause

This issue may occur if your browser is configured to block third-party cookies.

## Solution

To resolve this issue, configure your browser to allow third-party cookies. To do this, follow these steps.

> [!NOTE]
> The following example is for the Chrome browser on an Apple Mac device. However, this also works on Windows devices.

1. In the top-right corner of the browser, to the right of the **Address** bar, click the little icon with a red **x** to display the **Cookies blocked** dialog box.

    :::image type="content" source="media/cannot-load-help-and-support-blade/cookies-blocked.png" alt-text="Screenshot of Cookies blocked dialog.":::

2. Select **Show cookies and other site data**, and then click **Blocked** in the **Cookies in use** dialog box to list the blocked sites.  

    :::image type="content" source="media/cannot-load-help-and-support-blade/cookies-in-use-allowed.png" alt-text="Screenshot of allowed cookies in use.":::

    :::image type="content" source="media/cannot-load-help-and-support-blade/cookies-in-use-blocked.png" alt-text="Screenshot of blocked cookies in use.":::

3. Select each site individually, and then click **Allow** at the bottom of the dialog box.
4. Click **Done** to save your changes.
5. Refresh the page. The blade should now load correctly.
