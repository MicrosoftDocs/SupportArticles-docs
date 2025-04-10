---
title: Use Fiddler to Collect HTTPS Traffic from Microsoft Entra ID Apps
description: Provides instructions to use Fiddler to collect HTTPS traffic from Microsoft Entra ID apps
ms.date: 03/20/2025
ms.author: bachoang
ms.service: entra-id
ms.custom: sap:Enterprise Applications
---
# Collect HTTPS traffic using Fiddler for Microsoft Entra ID apps

This article provides instructions to use Fiddler to collect HTTPS traffic to troubleshoot Microsoft Entra ID apps.

## Collect HTTPS traffic

1. Download and install [Fiddler](https://www.telerik.com/fiddler/fiddler-classic) on the device that's used to reproduce the problem.

    > [!NOTE]
    > Fiddler is third-party software, not owned by Microsoft.
1. On the **Tool** menu, select **Options**.
1. On the **HTTPS** tab, select **Decrypt HTTPS Traffic**. If you're prompted to install the Fiddler certificate, select **Yes**.

    :::image type="content" source="media/capture-https-traffic-http-fiddler-entra-id-app/enable-https-decrypt.png" alt-text="Screenshot of the Decrypt HTTPS Traffic option." :::
1. Restart Fiddler.
1. Prepare your environment for traffic collection. Depending on the type of application you're troubleshooting, follow these steps:

    **For browser-based applications**:

    Use private browsing mode or clear the browser cache on the device that you'll use for testing. This action makes sure that any outdated or unnecessary files from previous sessions are cleared. It also lets the web app load the latest versions of essential files, such as JavaScript and CSS stylesheets. Having the latest files is especially important when you test changes or updates to the web app because it prevents old cached files from interfering with the current version.

    **For non-browser-based applications**:

    Start the client application that you're testing.

1. Reproduce the issue. You should see HTTPS traffic appearing in the Fiddler window.
1. On the **File** menu, select **Save** > **All Sessions** to save the sessions as SAZ files.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
