---
title: Failed license check on a desktop flow run
description: Provides a resolution for the issue where a desktop flow run fails when a license check is performed at run time in Power Automate for desktop. 
ms.reviewer: tapanm, gtrantzas 
ms.author: cvassallo
author: V-Camille
ms.date: 03/06/2023
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

## Cause

If the `licenseCheck` result is invalid, the `message` attribute shows the missing licensing components. For more information, see the below table.

|code|message|
|---|---|
|`ValidLicenseCoverage`|Valid License Coverage|
|`LicensingCheckFailed`|Unable to perform licensing checks for this Desktop Flow|
|`AttendedNoLicense`|Invalid License Coverage. Running this desktop flow requires a 'Per user plan with attended RPA' license.|
|`UnattendedWithoutParentCloudFlowNoLicense`|Invalid License Coverage. Running this desktop flow requires a 'Per user plan with attended RPA' license.|
|`UnattendedNoAddon`|Invalid License Coverage. Running this desktop flow requires an 'Unattended RPA' add-on.|
|`UnattendedNoLicenseNoFlowPlan`|Invalid License Coverage. Running this desktop flow requires a 'Per user plan with attended RPA' license or a 'Per flow plan' license.|
|`UnattendedNoLicenseNoFlowPlanNoAddon`|Invalid License Coverage. Running this desktop flow requires a 'Per user plan with attended RPA license or a 'Per flow plan' license and an 'Unattended RPA' add-on.|
|`UnattendedWithoutParentCloudFlowNoLicenseNoAddon`|Invalid License Coverage. Running this desktop flow requires a 'Per user plan with attended RPA' license and an 'Unattended RPA' add-on.|

## Resolution

To solve this issue:

- If the "Per user plan with attended RPA" license is missing, contact your Microsoft 365 administrator to get this license assigned to the user triggering the run.
- If the "Per flow plan" license is missing, assign a "Per flow plan" to the cloud flow triggering the desktop flow run.
- If the "Unattended RPA" add-on is missing, ask your Power Platform administrator to assign an "Unattended RPA" add-on to your environment from the Power Platform admin center.

> [!NOTE]
> A failed license check (if it doesn't block the desktop flow run immediately) can mean that the cloud flow triggering the desktop flow run will soon be suspended for licensing reasons. Check the cloud flow in question to get more information.
