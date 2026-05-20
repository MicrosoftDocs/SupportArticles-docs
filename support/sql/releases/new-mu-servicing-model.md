---
title: Updates to the Microsoft Update detection logic
description: Learn how the modern SQL Server servicing model in Microsoft Update offers cumulative updates (CUs) and GDR security releases through MU, WSUS, and the Microsoft Update Catalog.
ms.date: 05/20/2026
ms.topic: concept-article
ms.custom: sap:Installation, Patching, Upgrade, Uninstall
ms.reviewer: jeffwil, v-shaywood
---

# Updates to the Microsoft Update detection logic for SQL Server servicing

_Applies to:_ &nbsp; SQL Server 2019, SQL Server 2022, SQL Server 2025

## Summary

This article describes the modern SQL Server servicing model used by Microsoft Update (MU), Windows Server Update Services (WSUS), and the Microsoft Update Catalog. It explains how the detection logic offers cumulative updates (CUs) and General Distribution Release (GDR) security updates to SQL Server instances, why the logic changed, and which releases the updated behavior applies to. Use this information to plan routine patching, manage large fleets through WSUS, and choose between the CU and GDR servicing branches.

## How SQL Server servicing baselines work

A SQL Server servicing baseline (RTM or, for older versions, a Service Pack) branches into two servicing tracks:

- A *General Distribution Release* (GDR) branch that contains only security and other critical fixes.
- A *cumulative update* (CU) branch that contains the same security and critical fixes, plus all other fixes released for the baseline.

After you install a CU, the instance moves to the CU branch and continues to get CUs (and the CU branch version of GDR security releases) for that baseline.

## How the original Microsoft Update detection logic worked

The original Microsoft Update (MU) detection logic offered updates from the GDR branch to instances that were at the servicing baseline or already on the GDR branch.

To get CU-branch updates through MU, you had to install at least one CU manually first. After the instance was on the CU branch, you couldn't return it to the GDR branch unless one of these things happened:

- The baseline was reset by moving to the next Service Pack (for SQL Server versions that still shipped Service Packs).
- All CUs were uninstalled to revert the instance to the GDR branch or servicing baseline.

This design minimized the changes applied to an instance when only a security or other critical fix was needed. Instances on the CU branch get every update released for the baseline when a required security release ships, including all nonsecurity changes up to that security update.

### Why the original logic was a problem for WSUS

The original logic made routine servicing of large SQL Server fleets through WSUS difficult, because each instance had to be manually moved to the CU branch before WSUS could offer CU-branch updates to it. That manual step doesn't scale for environments that manage many instances centrally.

### Changes to the MU detection logic

To make WSUS-based servicing practical without silently moving instances to the CU branch, the MU detection logic was updated for both routine CU servicing and GDR security releases on supported baselines.

#### Cumulative updates

The detection logic now offers a CU to a clean instance that's at the baseline (RTM, with no servicing updates applied) or that's already on the CU branch. You don't have to install a CU first to be offered the next CU.

If the instance has a GDR update applied, you still need to update it manually (outside MU) before WSUS automation can manage it on the CU branch.

#### Security releases (GDRs)

The logic for GDR security releases is split into two channels:

- **Automatic Updates channel (Microsoft Update)**. This channel keeps the original behavior. A CU must already be installed on the instance for the CU branch version of a security release to be offered. This requirement protects instances from getting all CU content when the user hasn't explicitly opted in to CU branch servicing.
- **WSUS and Microsoft Update Catalog channel**. This channel uses the new detection logic, which lets the CU branch version of a security release be applied to a clean baseline instance. This version of the release is offered to users who go to the [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/) website.

## Applicable releases

The updated detection logic applies to the following releases:

- SQL Server 2016 Service Pack 2: CU14 and later CUs
- SQL Server 2017 RTM: CU19 and later CUs
- SQL Server 2019 RTM: all CUs
- SQL Server 2022 RTM: all CUs
- SQL Server 2025 RTM: all CUs
- GDR and security releases: all releases starting in 2021

> [!NOTE]
>
> - For SQL Server 2019, the RTM baseline can be either the RTM (**15.0.2000.5**) baseline or the RTM + RTM GDR (**15.0.2070.41**) baseline. Either baseline works with this model.
> - For the SQL Server 2014 SP3 (**12.3.6024.0**) baseline, the model applies to GDR security releases on the CU branch starting in 2021. SQL Server 2014 reached the end of extended support on July 9, 2024, and no longer gets security updates outside of [Extended Security Updates](/sql/sql-server/end-of-support/sql-server-end-of-life-overview).
> - For information about the original Microsoft Update detection model, see [Non-applicable SQL Server CUs are listed in WSUS, MU, or ConfMgr](../database-engine/install/windows/cu-apply-installation.md).

