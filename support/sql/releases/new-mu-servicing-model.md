---
title: Updates to the Microsoft Update detection logic 
description: This article describes the updates to the Microsoft Update detection logic for SQL Service servicing.
ms.date: 01/11/2021
ms.custom: sap:Database Engine
ms.reviewer: jeffwil 
---

# Updates to the Microsoft Update detection logic for SQL Server servicing

_Applies to:_ &nbsp; SQL Server 2019, SQL Server 2017, SQL Server 2016

Historically, servicing baselines (RTM or Service Pack) have included the following servicing branches:

- A General Distribution Release (GDR) branch that contains only security and other critical fixes.
- A cumulative update (CU) branch that contains security and other critical fixes plus all other fixes for the baseline.

The Microsoft Update (MU) detection logic was constructed so that instances at the servicing baseline or along the GDR branch would be offered updates from the GDR branch.

Previously, users had to proactively install at least one CU to align the instance to the CU branch for servicing through MU. However, after that was done, you could not return to the GDR branch for that instance until either of the following changes were made:

- The baseline was reset by moving up to the next service pack.
- The instance was reverted to the GDR branch or servicing baseline by uninstalling all CUs.

This logic was established to minimize the changes to the instance if a security update or other critical update was required. Instances on the CU branch have to take all updates that are released for the baseline when a required security or other critical release appears. This includes all nonsecurity changes up to the required security update.

However, this logic created problems for users who tried to manage routine servicing of large sets of instances by using WSUS. This is because the MU logic couldn't be used without first manually updating every client so that it could participate. To work around this issue and still avoid flipping instances to the CU train without explicit user consent, the following changes were made to the MU detection logic for both routine CU servicing and security releases for the more recent servicing releases of baselines in support:

- Cumulative Updates: The MU detection logic now allows clean instances that are at the baseline (RTM or SP,  with no servicing updates) or that are already updated along the CU branch to receive the update. A CU update does not have to be installed for an instance to be offered the update. However, if the instance has a GDR update, the instance must still be manually updated outside MU to become manageable through MU (WSUS) automation.
- Security Releases (GDRs): The logic for security releases is now split into the following channels:
  - An *Automatic Updates* channel (Microsoft Update) keeps the older historic behavior that requires a CU to be installed on the instance in order for the CU branch version of the security release to be offered. It does this to protect instances from receiving all updates instead of only critical and security-related updates without evidence of the user explicitly opting in to the more extensive mode of servicing.
  - A *WSUS / Catalog* channel that uses the new detection logic that allows the CU branch version of the security release to be applied against a clean baseline instance. This is the channel of the release that will be presented to users who go to the Microsoft Update Catalog website.

This new updated detection logic applies to the following CU and GDR releases:

- SQL Server 2016 Service Pack 2: CU14 and later CUs
- SQL Server 2017 RTM: CU19 and later CUs
- SQL Server 2019 RTM: All CUs
- GDR and Security Releases: All starting in 2021

> [!NOTE]
> For SQL Server 2019, the RTM baseline can be either the RTM (**15.0.2000.5**) version baseline or the RTM + RTM GDR (**15.0.2070.41**) version baseline. Either version will work for this release.
> For the SQL Server 2014 SP3 (**12.3.6024.0**) version baseline, the new model will be implemented for GDR Security Releases on the CU branch starting in 2021.
> For information about the old Microsoft Update detection model, see [Non-applicable SQL Server CUs are listed in WSUS, MU, or ConfMgr](../database-engine/install/windows/cu-apply-installation.md).

