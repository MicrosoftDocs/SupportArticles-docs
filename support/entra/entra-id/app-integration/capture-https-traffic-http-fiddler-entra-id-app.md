---
title: Collect HTTPS Traffic using Fiddler from Microsoft Entra ID Apps
description: Provide instructions on how to collect HTTPS traffic using Fiddler from Microsoft Entra ID Apps
ms.date: 03/20/2025
ms.author: bachoang
ms.service: entra-id
ms.custom: sap:Enterprise Applications
---
# Collect HTTPS traffic using Fiddler from Microsoft Entra ID Apps

This article provides instructions on how to use Fiddler to collect HTTPS traffic for troubleshooting purposes.

## Collect HTTPS traffic for troubleshooting

1. [Download and install Fiddler](https://www.telerik.com/) on the device that is used to reproduce the problem.
1. On the **Tool** menu, select **Options**.
1. On the **HTTPS** tab, select **Decrypt HTTPS Traffic**. If you'r prompted to install the Fiddler certificate, select **Yes**.

    :::image type="content" source="media/capture-https-traffic-http-fiddler-entra-id-app/enable-https-decrypt.png" alt-text="Screenshot of the Decrypt HTTPS Traffic option." :::
1. Restart Fiddler.
1. Prepare your environment for traffic collection. Depending on the type of application you're troubleshooting, perform the following steps:

    **For browser-based applications**:

    Use private browsing mode or clear the browser cache on the device that will be used for testing. This ensures that any outdated or unnecessary files from previous sessions are cleared. It allows the web app to load the latest versions of essential files like JavaScript and CSS stylesheets. This is especially important when testing changes or updates to the web app, as it prevents old cached files from interfering with the current version.

    **For non-browser-based applications**:

    Launch the client application you're testing.

1. Reproduce the issue. You should see HTTPS traffic appearing in the Fiddler window.
1. On the **File** menu, select **Save** > **All Sessions** to save the sessions as SAZ files.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
