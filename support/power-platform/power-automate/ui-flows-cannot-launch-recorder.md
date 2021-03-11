---
title: UI Flows cannot launch recorder
description: Troubleshooting recorder launch for UI Flows in Power Automate.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# UI flows cannot launch recorder

This article provides a solution to an issue where UI flows recorder won't launch.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4555735

## Symptoms

UI flows recorder won't launch. Instead, the UI flows wizard will prompt you to download the installation package.

:::image type="content" source="media/ui-flows-cannot-launch-recorder/download-install-package.png" alt-text="UI Flows install package message.":::

## Verifying the issue

1. Check that you're using a compatible web browser:

    - Microsoft Edge (version 80 or later)
    - Google Chrome

2. Check that you've enabled the UI flows for Power Automate chromium extension:

    - In Microsoft Edge, navigate to [edge://extensions](edge://extensions)
    - In Google Chrome, navigate to [chrome://extensions](chrome://extensions)

    Verify that the extension is enabled in the extensions page:
    :::image type="content" source="media/ui-flows-cannot-launch-recorder/verify-extension-is-enabled.png" alt-text="Edge Chromium Extension Page.":::

    Enable the extension by toggling the switch on the card.

3. Verify that the UI flows service is running

    There should be an icon in the system tray:

    :::image type="content" source="media/imui-flows-cannot-launch-recorder/iconage.png" alt-text="UI Flows tray icon.":::

    If the icon isn't present, you can manually start the service by searching for **UI flows** in the **start** menu:

    :::image type="content" source="media/ui-flows-cannot-launch-recorder/search-ui-flows.png" alt-text="UI Flows start menu.":::

4. Check that you've installed the UI flows package:

    - In Windows 10, navigate to **Settings** → **Apps & features**  
    - In Windows 8.1 or earlier, navigate to **Control Panel** → **Add or Remove Programs**

    Look for the UI flows installation package:

    :::image type="content" source="media/ui-flows-cannot-launch-recorder/ui-flows-installation-package.png" alt-text="UI Flows installation.":::

    If the package isn't installed, follow the instructions in the UI flows wizard to download and install the latest version.
