---
title: UI Flows cannot launch recorder
description: Troubleshooting recorder launch for UI Flows in Power Automate.
ms.reviewer: jokovace
ms.topic: troubleshooting
ms.date: 3/31/2021
ms.subservice: power-automate-flows
---
# UI flows cannot launch recorder

This article provides a solution to an issue where UI flows recorder won't launch.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4555735

## Symptoms

UI flows recorder won't launch. Instead, the UI flows wizard will prompt you to download the installation package.

:::image type="content" source="media/ui-flows-cannot-launch-recorder/download-install-package.png" alt-text="Screenshot of the U I Flows installation package message.":::

## Verifying the issue

1. Check that you're using a compatible web browser:

    - Microsoft Edge (version 80 or later)
    - Google Chrome

2. Check that you've enabled the UI flows for Power Automate chromium extension:

    - In Microsoft Edge, navigate to `edge://extensions`
    - In Google Chrome, navigate to `chrome://extensions`

    Verify that the extension is enabled in the extensions page:

    :::image type="content" source="media/ui-flows-cannot-launch-recorder/extension-enabled.png" alt-text="Screenshot to check the extension is enabled in the extensions page." lightbox="media/ui-flows-cannot-launch-recorder/extension-enabled.png":::

    Enable the extension by toggling the switch on the card.

3. Verify that the UI flows service is running

    There should be an icon in the system tray:

    :::image type="content" source="media/ui-flows-cannot-launch-recorder/ui-flows-icon.png" alt-text="Screenshot shows the U I flows icon in the system tray.":::

    If the icon isn't present, you can manually start the service by searching for **UI flows** in the **start** menu:

    :::image type="content" source="media/ui-flows-cannot-launch-recorder/search-ui-flows.png" alt-text="Screenshot to search for the U I Flows app in the start menu." border="false":::

4. Check that you've installed the UI flows package:

    - In Windows 10, navigate to **Settings** → **Apps & features**  
    - In Windows 8.1 or earlier, navigate to **Control Panel** → **Add or Remove Programs**

    Look for the UI flows installation package:

    :::image type="content" source="media/ui-flows-cannot-launch-recorder/ui-flows-installation-package.png" alt-text="Screenshot of the U I flows installation package.":::

    If the package isn't installed, follow the instructions in the UI flows wizard to download and install the latest version.
