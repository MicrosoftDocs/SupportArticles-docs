---
title: SLA KPI instance doesn't reach Nearing Non-compliance or Non-compliant and the timer continues to run
description: Provides a resolution for the issue related to the permissions and licenses of the SLAInstanceMonitoringWarningAndExpiryFlow in Dynamics 365 Customer Service.
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 05/23/2023
---
# The SLA KPI instance doesn't reach Nearing Non-compliance or Non-compliant and the SLA KPI instance timer continues to run

This article provides a resolution for the issue where the service-level agreements (SLA) KPI instance doesn't reach **Nearing Non-compliance** or **Non-compliant** state, and the SLA KPI instance timer continues to run in Dynamics 365  Customer Service.

## Symptoms

The flow runs created for the SLA KPI instances timer fail with a license error message.

## Cause

The `SLAInstanceMonitoringWarningAndExpiryFlow` is required to move the SLA KPI instances to a **Nearing non-compliance** or **Non-complaint** state. The flow always works in the context of the user who activates the first SLA in the organization. The user who activates the first SLA on the organization must have all the required licenses for the flow execution. The flow must only be turned off and on by a user who has the SLA KPI privileges at a global level for `prvReadSLAKPIInstance` and `prvWriteSLAKPIInstance`.

If the user is missing any of the required licenses, then the flow runs that are created for the corresponding SLA KPI instance will fail with a license required error "The user with SystermUserId = XXXX in OrganizationContext = YYYY is not licensed." Thus, the SLA KPI instance will never reach the **Nearing non-compliance** or **Non-complaint** state, and the SLA KPI instance timer will continue to run.

Additionally, the current owner of the flow must have the required permissions with read and write access for the SLA KPI instance.

If a user who is the current owner of the flow needs to be removed from the organization, you should first change the owner of the flow to another user. This new user must also have all the required permissions. Once a new owner is added, you can remove the previous owner. This action ensures the flow runs continue to be executed without issues.

## Resolution

## Possible Mitigation 1: 

To change the owner of any flow:

1. In [Power Automate](https://powerautomate.microsoft.com), navigate to **Default solution** > **Cloud flows**.
1. Search for the failed flow with the error.
1. Select **Edit**. A new flyout menu is displayed where you can set a new owner.
1. In the **Owner** field, remove the current owner and add the new owner. Ensure the new owner has all required flow licenses.

## Possible Mitigation 2: 

To turn off and turn on the static flow again. Below are the steps :

1. In [Power Automate](https://powerautomate.microsoft.com), navigate to **Default solution** > **Cloud flows**.
2. In Cloud flows, select SLAInstanceMonitoringWarningAndExpiryFlow.
3. Even though it in on state. Select Turn off and then again Turn on.
4. This will fix the issue for newly created kpiinstances.
5. For older kpiinstance Cx can change the status with their own logic or Can reach out the dev team for script, with affected record details and the status in which the slakpiinstance needs to be.

## Possible Mitigation 3:

1. This steps should be performed by real AAD user
2. On customers environment, through power automate go to default solution.
3. Get the all "flows". open flow "Flow to monitor warning and failure of service level agreement".
4. Verified its not getting triggered.
5. "Save as" with another name and turn it on.
6. It started executed.
7. Verified instance for above created flow has been instantiated.

And status started updating for SLA.

:::image type="content"source="media\sla-kpi-instance-compliance-timer\SLA_KPI_Timer.png" alt-text="Screenshot that shows how to turn on/off flow." Border="false":::