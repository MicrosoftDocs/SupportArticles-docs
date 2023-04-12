---
title: SLA KPI instance doesn't reach Nearing Non-compliance or Non-compliant state, and the SLA KPI instance timer continues to run
description: Provides a solution for when SLA KPI instance doesn't reach Nearing Non-compliance or Non-compliant state, and the SLA KPI instance timer continues to run in Dynamics 365 Customer Service.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 04/11/2023
ms.subservice: d365-customer-service
---

# SLA KPI instance doesn't reach Nearing Non-compliance or Non-compliant state, and the SLA KPI instance timer continues to run

This article provides a solution for when SLA KPI instance doesn't reach Nearing Non-compliance or Non-compliant state, and the SLA KPI instance timer continues to run.

## Symptom

The flow runs that are created for the SLA KPI Instances timer fail with a license error message.

## Cause

The **SLAInstanceMonitoringWarningAndExpiryFlow** is required to move the **SLA KPI Instances** to a **Nearing non-compliance** or **Non-complaint** state. The flow always works in the context of the user who activates the first SLA in the organization. The user who activates the first SLA on the organization must have all the required licenses for the flow execution. The flow must only be turned off and on by a user who has the SLA KPI privileges at a global level for **prvReadSLAKPIInstance** and **prvWriteSLAKPIInstance**.

If the user is missing any of the required licenses, then the flow runs that are created for the corresponding SLA KPI instance will fail with a license required error: "The user with SystermUserId = XXXX in OrganizationContext = YYYY is not licensed". Thus, the SLA KPI instance will never reach the **Nearing non-compliance** or **Non-complaint** state and the SLA KPI instance timer will continue to run.

Additionally, the current owner of the flow must have the required permissions with read and write access for **SLAKPIInstance**.

If a user who is the current owner of the flow needs to be removed from the organization, you should first change the owner of the flow to another user. This new user must also have all the required permissions. Once a new owner is added, you can remove the previous owner. This will ensure that the flow runs continue to be executed without issues.

## Resolution

To change the owner of any flow, perform the following steps:

1. In https://powerautomate.microsoft.com, navigate to **My flows > Cloud flows**.
1. Search for the failed flow with the error.
1. Select **Edit**. A new flyout menu is displayed, where you can set a new owner.
1. In the **Owner** field, remove the current owner and add the new owner. Ensure that the new owner has all required flow licenses.
