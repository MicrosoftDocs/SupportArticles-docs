---
title: Dynamics 365 Portal Solution update
description: Provides a solution to an error that occurs when you navigate to a portal associated to a Dynamics 365 instance containing some solutions that haven't yet been upgraded.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Microsoft Dynamics 365 Portal Solution update consistency for Multi-Portal Deployments

This article provides a solution to an error that occurs when you navigate to a portal associated to a Dynamics 365 instance containing some solutions that haven't yet been upgraded.

_Applies to:_ &nbsp; Microsoft Dynamics CRM  
_Original KB number:_ &nbsp; 4020942

## Symptoms

Following an upgrade to the solutions that support a Portal Add-on in the Dynamics 365 Admin Center, customers who have multiple Portal Add-ons associated to the same Dynamics 365 instance could experience errors if the solutions for other portal types haven't yet been upgraded. Users who navigate to a portal associated to a Dynamics 365 instance containing some solutions that haven't yet been upgraded may receive an error similar to the following example:

> We're sorry, but something went wrong.  
[00000000-0000-0000-0000-000000000000]  
We've been notified about this issue and we'll take a look at it shortly.  
Thank you for your patience.

## Cause

When a Portal Add-on is deployed to a Dynamics 365 instance, multiple solutions are installed to support the functionality of the portal. Updates to these solutions are made available as enhancements and fixes are released, and customers can deploy those updates by taking the appropriate action within the Dynamics 365 Admin Center.

As many solutions are shared by multiple portal types, upgrading a single portal type without upgrading any other portal types that are deployed to the same Dynamics 365 instance will cause failures and could render one or more portals inoperable.

## Resolution

To avoid any solution version mismatch problems, the solutions for all portal types deployed to a single Dynamics 365 instance should be upgraded later and during the same time interval. To upgrade the Portal Add-on solutions for any deployed portal types, the following steps should be taken:

1. Sign into the Dynamics 365 Admin Center with a user with sufficient permissions to upgrade Dynamics 365 solutions.
2. On the **Instances** tab, select the instance that has two or more portals deployed.
3. With the instance selected, select the **Solutions** icon in the pane to the right.
4. On the **Solutions** view, select a portal type (such as Community Portal) that has been deployed to this instance.
5. If the **Upgrade** button appears in the right pane, select it to upgrade the respective solutions in the Dynamics 365 instance.
6. Once the upgrade finishes, select the next available portal type in the **Solutions** view and repeat step #5.

When all portal types have been upgraded, no further solution version mismatch errors will occur.
