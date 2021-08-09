---
title: Cannot load Help and support in Intune portal
description: Provides a solution for an issue in which the Help and support blade doesn't load correctly.
ms.date: 05/20/2020
ms.prod-support-area-path: General Guidance or Advisory
---
# You cannot load the Help and support blade in the Intune portal

This article provides the resolution to solve the issue that the **Help and support** blade cannot be loaded in Intune portal.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 4493802

## Symptoms

You experience one of the following issues:

- You cannot load the **Help and support** blade in the Intune portal.
- You receive a **login.microsoftonline.com refused to connect** error message in browsers such as Chrome or Firefox. Other browsers such as Safari or Microsoft Edge may display similar errors or nothing at all.

    :::image type="content" source="media/cannot-load-help-and-support-blade/error.jpg" alt-text="screenshot of error]" border="false":::

The exact symptom may differ depending on the browser. However, the overall problem is that the **Help and support** blade doesn't load correctly even when you use a Global Administrator account.

## Cause

This issue may occur if your browser is configured to block third-party cookies.

## Resolution

To resolve this issue, configure your browser to allow third-party cookies. To do this, follow these steps.

> [!NOTE]
> The following example is for the Chrome browser on an Apple Mac device. However, this also works on Windows devices.

1. In the top-right corner of the browser, to the right of the **Address** bar, click the little icon with a red **x** to display the **Cookies blocked** dialog box.

    :::image type="content" source="media/cannot-load-help-and-support-blade/cookies-blocked.png" alt-text="screenshot of Cookies blocked" border="false":::

2. Select **Show cookies and other site data**, and then click **Blocked** in the **Cookies in use** dialog box to list the blocked sites.  

    :::image type="content" source="media/cannot-load-help-and-support-blade/cookies-in-use-allowed.png" alt-text="screenshot of allowed cookies in use" border="false":::

    :::image type="content" source="media/cannot-load-help-and-support-blade/cookies-in-use-blocked.png" alt-text="screenshot of blocked cookies in use" border="false":::

3. Select each site individually, and then click **Allow** at the bottom of the dialog box.
4. Click **Done** to save your changes.
5. Refresh the page. The blade should now load correctly.
