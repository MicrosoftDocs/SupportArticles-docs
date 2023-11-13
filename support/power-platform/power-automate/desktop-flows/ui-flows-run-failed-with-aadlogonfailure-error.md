---
title: Desktop flows run failed with AadLogonFailure
description: UI flows run failed with AadLogonFailure error code. Provides a resolution.
ms.reviewer: quseleba
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: power-automate-desktop-flows
---
# Desktop flows run failed with AadLogonFailure error code

This article provides a resolution to solve the unattended desktop flows run failure issue.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4555446

## Symptoms

Your unattended desktop flows run failed with the error code **AadLogonFailure**.

## Cause

UI flows failed to validate your Microsoft Entra credentials on the machine.

## Resolution

You need to disable Network Level Authentication (NLA) on the machine.
### Disable NLA using System and Security
1. Open **Control Panel**.
2. Open **System and Security**.

    :::image type="content" source="media/ui-flows-run-failed-with-aadlogonfailure-error/system-and-security-in-control-panel.png" alt-text="Screenshot to select the System and Security option in the Control Panel.":::

3. Open **Allow remote access**.

    :::image type="content" source="media/ui-flows-run-failed-with-aadlogonfailure-error/open-allow-remote-access.png" alt-text="Screenshot to select the Allow remote access option in the System and Security window.":::

4. Disable Network Level Authentication and select **OK**.

    :::image type="content" source="media/ui-flows-run-failed-with-aadlogonfailure-error/disable-network-level-auth.png" alt-text="Screenshot to disable Network Level Authentication in the System Properties window.":::


### Disable NLA using Group Policy Editor
Disabling NLA with Group Policy Editor on the machine may resolve the issue, but when the machine synchronizes Group Policy Object with domain, it overrides GPO on the machine.

1. Open run dialog (windows + R) and type "gpedit.msc".

    :::image type="content" source="media/ui-flows-run-failed-with-aadlogonfailure-error/run-gpedit.png" alt-text="Run 'gpedit.msc'.":::

2. Navigate to **Computer Configuration > Administrative Templates > Windows Components > Remote Desktop Services > Remote Desktop Session Host > Security**. 

3. On the right panel find and double-click on **Require user authentication for remote connections by using Network Level Authentication**

4. Click on "Disabled" and "Apply" and "OK".

    :::image type="content" source="media/ui-flows-run-failed-with-aadlogonfailure-error/disable-gpo-nla.png" alt-text="Disable 'Require user authentication for remote connections by using Network Level Authentication'":::