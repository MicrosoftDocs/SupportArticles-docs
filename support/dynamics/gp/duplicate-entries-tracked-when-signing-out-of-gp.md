---
title: Duplicate entries tracked when signing out via Activity Tracking
description: Duplicate entries tracked in the SY05000 table for Successful attempts to sign out.
ms.reviewer: cwaswick
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# Duplicate entries tracked when signing out of Microsoft Dynamics GP using Activity Tracking

This article provides a resolution for the issue that duplicate entries are tracked when signing out of Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2608403

## Symptoms

Duplicate entries are tracked in the SY05000 Activity Tracking table for successful attempts to sign out of Microsoft Dynamics GP. Activity Tracking reports show two entries for each sign-out tracked.

## Cause

GP code calls the exitDynamics code twice when signing out, so two records get tracked in the SY05000 - Activity Tracking table.

## Resolution

This was logged as quality issue, but unfortunately won't be fixed due to low customer count. We apologize for the inconvenience.

If you would like to be added to the customer count on this quality report, open a support case, and not charged for the case. You shouldn't be charged for the case if you're only requesting it to be added to the customer count on the bug write-up and no other technical assistance is needed.
