---
title: Failed license check on desktop flow run
description: Provides a resolution for the issue where a desktop flow run failed license check performed at run time. 
ms.reviewer: 
ms.date: 03/06/2022
ms.subservice: power-automate-desktop-flows
---
# Failed license check on desktop flow run

This article provides a resolution for the issue where a desktop flow run failed license check performed at run time.

_Applies to:_ &nbsp; Power Automate for Desktop

## Symptoms

If you [trigger a desktop flow run](https://learn.microsoft.com/power-automate/developer/desktop-flow-public-apis#trigger-a-desktop-flow-run) using the [Dataverse Web API RunDesktopFlow Action](https://learn.microsoft.com/power-apps/developer/data-platform/webapi/reference/rundesktopflow?view=dataverse-latest), you will retrieve a JSON output containing a "licenseCheck" object : 

        {
            "licenseCheck": {
                "code": "ValidLicenseCoverage",
                "message": "Valid License Coverage"
            }
        }
 
If valid, the licenceCheck code is "ValidLicenseCoverage". Any other code informs you of a <b>missing licensing component</b> (license and/or add-on).



## Cause

The licenseCheck result, if invalid, will give in its message attribute the missing licensing components : 
   |code|message|
   |---|---|
   |ValidLicenseCoverage|Valid License Coverage|
   |LicensingCheckFailed|Unable to perform licensing checks for this Desktop Flow|
   |AttendedNoLicense|Invalid License Coverage. Running this desktop flow requires a ‘Per user plan with attended RPA’ license|
   |UnattendedWithoutParentCloudFlowNoLicense|Invalid License Coverage. Running this desktop flow requires a ‘Per user plan with attended RPA’ license|
   |UnattendedNoAddon|Invalid License Coverage.  Running this desktop flow requires an ‘Unattended RPA’ add-on.|
   |UnattendedNoLicenseNoFlowPlan|Invalid License Coverage. Running this desktop flow requires a ‘Per user plan with attended RPA’ license or a ‘Per flow plan’ license.|
   |UnattendedNoLicenseNoFlowPlanNoAddon|Invalid License Coverage. Running this desktop flow requires a ‘Per user plan with attended RPA’ license or a ‘Per flow plan’ license and an ‘Unattended RPA’ add-on. |
   |UnattendedWithoutParentCloudFlowNoLicenseNoAddon|Invalid License Coverage. Running this desktop flow requires a ‘Per user plan with attended RPA’ license and an ‘Unattended RPA’ add-on.|
   
## Resolution

To solve this issue :

- if the message indicates a ‘Per user plan with attended RPA’ license is required : contact your M365 administrator to get this license assigned to the user triggering the run
- if the message indicates a ‘Per flow plan’ license is required : assign a 'Per flow plan' to the cloud flow triggering the desktop flow run
- if the message indicates an ‘Unattended RPA’ add-on is required : ask your Power Platform administrator to assign an 'Unattended RPA' add-on to your environment from Power Platform Admin Center

## Notes

A failed license check, if it doesn't block the desktop flow run immediately, can mean that the cloud flow triggering the desktop flow run will soon be suspended for licensing reasons. Check the cloud flow in question to get more information about it.
