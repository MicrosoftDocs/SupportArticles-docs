---
title: SLA KPI instance doesn't reach Nearing Non-compliance or Non-compliant and the timer continues to run
description: Provides a resolution for the issue related to the permissions and licenses of the SLAInstanceMonitoringWarningAndExpiryFlow in Dynamics 365 Customer Service.
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 10/18/2023
---
# The SLA KPI instance doesn't reach Nearing Non-compliance or Non-compliant and the SLA KPI instance timer continues to run

This article provides a resolution for the issue where the service-level agreements (SLA) KPI instance doesn't reach **Nearing Non-compliance** or **Non-compliant** state, and the SLA KPI instance timer continues to run in Dynamics 365 Customer Service.

## Symptoms

The flow runs created for the SLA KPI instances timer fail with a license error message.

## Cause

The `SLAInstanceMonitoringWarningAndExpiryFlow` is required to move the SLA KPI instances to a **Nearing non-compliance** or **Non-complaint** state. The flow always works in the context of the user who activates the first SLA in the organization. The user who activates the first SLA on the organization must have all the required licenses for the flow execution. The flow must only be turned off and on by a user who has the SLA KPI privileges at a global level for `prvReadSLAKPIInstance` and `prvWriteSLAKPIInstance`.

If the user is missing any of the required licenses, then the flow runs that are created for the corresponding SLA KPI instance will fail with a license required error "The user with SystermUserId = XXXX in OrganizationContext = YYYY is not licensed." Thus, the SLA KPI instance will never reach the **Nearing non-compliance** or **Non-complaint** state, and the SLA KPI instance timer will continue to run.

Additionally, the current owner of the flow must have the required permissions with read and write access for the SLA KPI instance.

If a user who is the current owner of the flow needs to be removed from the organization, you should first change the owner of the flow to another user. This new user must also have all the required permissions. Once a new owner is added, you can remove the previous owner. This action ensures the flow runs continue to be executed without issues.

## Possible mitigation step 1: change the owner of a flow

1. In [Power Automate](https://powerautomate.microsoft.com), navigate to **Default solution** > **Cloud flows**.
1. Search for the failed flow with the error.
1. Select **Edit**. A new flyout menu is displayed where you can set a new owner.
1. In the **Owner** field, remove the current owner and add the new owner. Ensure the new owner has all required flow licenses.

## Possible mitigation step 2: turn off and turn on the static flow again

1. In [Power Automate](https://powerautomate.microsoft.com), navigate to **Default solution** > **Cloud flows**.
1. In Cloud flows, select `SLAInstanceMonitoringWarningAndExpiryFlow`.
1. Even though its status is **On**, select **Turn off** and then **Turn on**.

This will fix the issue for the new KPI instances.

For the old KPI instances, you can change the status with your own logic or reach out to the development team for a script, with affected record details and the status in which the SLA KPI instance needs to be.

## Possible mitigation step 3: rename and trigger the flow

> [!NOTE]
> These steps should be performed by a [Microsoft Entra](/azure/active-directory/fundamentals/whatis) user.

1. In the environment, go to [Power Automate](https://powerautomate.microsoft.com), and navigate to **Default solution**.
1. Open the "Flow to monitor warning and failure of service level agreement" flow.
1. Verify that the flow isn't triggered.
1. Update and save the flow with another name, and then turn it on. The flow starts to be executed.
1. Verify that the instance for the above created flow is instantiated.

The status of the SLA will be updated succesfully.

:::image type="content" source="media\sla-kpi-instance-compliance-timer\sla-kpi-timer.png" alt-text="Screenshot that shows how to turn on or off a flow." Border="false":::
