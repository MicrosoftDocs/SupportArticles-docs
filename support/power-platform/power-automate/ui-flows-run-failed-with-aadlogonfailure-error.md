---
title: Desktop flows run failed with AadLogonFailure
description: UI flows run failed with AadLogonFailure error code. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# Desktop flows run failed with AadLogonFailure error code

This article provides a resolution to solve the unattended desktop flows run failure issue.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4555446

## Symptoms

Your unattended desktop flows run failed with the error code **AadLogonFailure**.

## Cause

UI flows failed to validate your Azure Active Directory credentials on the machine.

## Resolution

You need to disable Network Level Authentication (NLA) on the machine.

1. Open **Control Panel**.
2. Open **System and Security**.

    :::image type="content" source="media/ui-flows-run-failed-with-aadlogonfailure-error/system-and-security-in-control-panel.png" alt-text="Open System and Security in Control Panel":::

3. Open **Allow remote access**.

    :::image type="content" source="media/ui-flows-run-failed-with-aadlogonfailure-error/open-allow-remote-access.png" alt-text="Allow remote access in System and Security":::

4. Disable Network Level Authentication and select **OK**.

    :::image type="content" source="media/ui-flows-run-failed-with-aadlogonfailure-error/disable-network-level-auth.png" alt-text="Disable Network Level Authentication in System Properties":::
