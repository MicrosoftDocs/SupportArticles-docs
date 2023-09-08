---
title: CRM users don't sync from Office 365
description: Provides a solution to an issue where Microsoft Dynamics CRM Online users don't sync from Office 365 after deleting O365 Security Group.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-access
---
# Microsoft Dynamics CRM Online users don't sync from Office 365 after deleting O365 security group

This article provides a solution to an issue where Microsoft Dynamics CRM Online users don't sync from Office 365 after deleting O365 security group.

_Applies to:_ &nbsp; Microsoft Dynamics CRM Online  
_Original KB number:_ &nbsp; 3052831

## Symptoms

After deleting a Security Group from the Office 365 portal that was associated with a Microsoft Dynamics CRM Online organization, users outside of the group didn't sync into the CRM Online organization.

## Cause

When deleting a Security Group from the Office 365 portal, it won't automatically disassociate the group from a CRM Online organization.

## Resolution

Remove the security group from the CRM instance within the CRM Online Admin Center using the following steps:

1. Sign in to CRM from the Office 365 portal and go to the CRM Online Admin Center.
2. Select the CRM instance and select **Edit**.
3. Remove the security group and select **Save**.

## More information

It will be addressed in a future update for Microsoft Dynamics CRM Online.
