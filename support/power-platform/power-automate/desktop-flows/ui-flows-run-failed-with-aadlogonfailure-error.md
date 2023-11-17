---
title: Desktop flows run failed with AadLogonFailure
description: Provides a resolution for an issue where desktop flows run failed with the AadLogonFailure error code. 
ms.reviewer: fredg, johndund
author: QuentinSele
ms.author: quseleba
ms.date: 11/17/2023
ms.subservice: power-automate-desktop-flows
---
# Desktop flows run failed with the AadLogonFailure error code

This article provides a resolution to solve the unattended desktop flows run failure issue.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4555446

## Symptoms

Your unattended desktop flows run failed with the error code **AadLogonFailure**.

## Cause

Desktop flows failed to validate your Microsoft Entra credentials on the machine.

## Resolution

You need to disable Network Level Authentication (NLA) on the machine.

### Disable NLA using the "System and Security" setting

1. Go to **Control Panel**, and then select **System and Security**.

    :::image type="content" source="media/ui-flows-run-failed-with-aadlogonfailure-error/system-and-security-in-control-panel.png" alt-text="Screenshot to select the System and Security option in the Control Panel." lightbox="media/ui-flows-run-failed-with-aadlogonfailure-error/system-and-security-in-control-panel.png":::

2. Select **Allow remote access**.

    :::image type="content" source="media/ui-flows-run-failed-with-aadlogonfailure-error/open-allow-remote-access.png" alt-text="Screenshot to select the Allow remote access option in the System and Security window." lightbox="media/ui-flows-run-failed-with-aadlogonfailure-error/open-allow-remote-access.png":::

3. Disable Network Level Authentication and select **OK**.

    :::image type="content" source="media/ui-flows-run-failed-with-aadlogonfailure-error/disable-network-level-auth.png" alt-text="Screenshot to disable Network Level Authentication in the System Properties window.":::

### Disable NLA using the Local Group Policy Editor

> [!NOTE]
> The following steps show how to check if the policy setting is enabled. If NLA is required, work with your system administrator to disable this policy on the required machines.

To understand whether NLA is required by Group Policy on your computer, you can use the Local Group Policy Editor.

1. Open the **Run** dialog box (<kbd>Windows</kbd> + <kbd>R</kbd>), type *gpedit.msc*, and select **OK**.

    :::image type="content" source="media/ui-flows-run-failed-with-aadlogonfailure-error/run-gpedit.png" alt-text="Screenshot that shows how to open the Local Group Policy Editor by running gpedit.msc.":::

2. Navigate to **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Remote Desktop Services** > **Remote Desktop Session Host** > **Security**.

3. On the right panel, find and double-click **Require user authentication for remote connections by using Network Level Authentication**.

4. If the setting is enabled, work with your system administrator to disable it.
