---
title: Failed license check on a desktop flow run
description: Provides a resolution for the issue where a desktop flow run fails when a license check is performed at run time in Power Automate for desktop. 
ms.reviewer: tapanm, gtrantzas, cponath
ms.author: cvassallo
author: V-Camille
ms.date: 02/28/2024
ms.subservice: power-automate-desktop-flows
---
# A failed license check on a desktop flow run

This article provides a resolution for the issue where you receive a license check error code when you trigger a desktop flow run in Power Automate for desktop.

_Applies to:_ &nbsp; Power Automate for desktop

## Symptoms

If you [trigger a desktop flow run](/power-automate/developer/desktop-flow-public-apis#trigger-a-desktop-flow-run) using the [Dataverse Web API RunDesktopFlow Action](/power-apps/developer/data-platform/webapi/reference/rundesktopflow), you receive a JSON output that contains a `licenseCheck` object:

```json
        {
            "licenseCheck": {
                "code": "ValidLicenseCoverage",
                "message": "Valid License Coverage"
            }
        }
```

If the `licenseCheck` result is valid, the `code` attribute shows `ValidLicenseCoverage`. Any other code informs you of a missing licensing component (license, add-on, or both).

## Prerequisites

- To run a desktop flow in attended mode, the desktop flow connection owner requires a "Power Automate Premium" user license.
- To run a desktop flow in unattended mode, the target machine requires an "Unattended RPA add-on" or a "Power Automate Process" license.

For more information, see [Types of Power Automate licenses](/power-platform/admin/power-automate-licensing/types).

## Cause

If the `licenseCheck` result is invalid, the `message` attribute shows the missing licensing components. For more information, see the below table.

|Code|Message|
|---|---|
|`ValidLicenseCoverage`|Valid License Coverage|
|`LicensingCheckFailed`|Unable to perform licensing checks for this Desktop Flow|
|`AttendedNoLicense`|Invalid License Coverage. Running this desktop flow in attended mode requires a "Power Automate Premium" user license.|
|`UnattendedNoAddon`|Invalid License Coverage. Running this desktop flow in unattended mode requires an "Unattended RPA add-on" or a "Power Automate Process" license.|

## Resolution

To solve this issue:

- If the "Power Automate Premium" user license is missing, contact your Microsoft 365 administrator to get this license assigned to the user owning the desktop flow connection.
- If the "Unattended RPA add-on" or "Power Automate Process" license is missing, ask your Power Platform administrator to assign one to your environment from the Power Platform admin center.

> [!NOTE]
> A failed license check (if it doesn't block the desktop flow run immediately) can mean that the cloud flow triggering the desktop flow run will soon be suspended for licensing reasons. Check the cloud flow in question to get more information.
