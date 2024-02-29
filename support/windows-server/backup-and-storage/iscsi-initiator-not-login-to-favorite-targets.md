---
title: The iSCSI Initiator can't log in to Favorite Target
description: Provides a solution to an issue where the Microsoft iSCSI Initiator fails to login to Favorite Targets.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, jtierney
ms.custom: sap:iscsi, csstroubleshoot
---
# The Microsoft iSCSI Initiator may fail to log in to Favorite Targets after the Initiator Name is changed in Windows

This article provides a solution to an issue where the Microsoft iSCSI Initiator fails to log in to Favorite Targets after the initiator name is changed.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2500271

## Symptoms

Consider the following scenario. On a system running Windows, you are connecting to iSCSI-based storage using the Microsoft iSCSI Initiator. In the iSCSI Initiator Properties, you have configured Favorite Target entries, so that the iSCSI Initiator will automatically connect to certain iSCSI targets. The iSCSI target(s) you are connecting to uses access control, and this access control uses the iSCSI Initiator Name (for example, iQN) or initiator IP address for authentication.

If you change the *Initiator Name* in the Configuration tab of the iSCSI Initiator Properties, you may be unable to access certain access-controlled iSCSI targets when the system is rebooted, or when connectivity to an iSCSI target is lost. By way of example:

- If an iSCSI target is configured to use the new *Initiator Name*  for authentication, the iSCSI Initiator may fail to log in to the target using Favorite Target entries that were created while the iSCSI Initiator was configured to use the old *Initiator Name*.
- If an iSCSI target is configured to use the old *Initiator Name*  for authentication, the iSCSI Initiator may fail to log in to the target using Favorite Target entries that are created after the *Initiator Name* is changed. Also, you may no longer be able to discover the iSCSI target once the *Initiator Name* is changed.
- If the iSCSI target is configured to use the iSCSI initiator's IP address for authentication, the iSCSI Initiator will be able to log in using Favorite Target entries that were created both before and after the *Initiator Name* was changed. However, for security reasons the iSCSI target may prevent logons from a single IP address using multiple Initiator Names, and therefore some logon attempts may fail.

## Cause

When a Favorite Target entry is created, the iSCSI Initiator sets the Favorite Target entry to use the *Initiator Name* that is configured at the time of creation. If the *Initiator Name* is later changed, any pre-existing Favorite Target entries are not updated to reflect the newly configured *Initiator Name*.

## Resolution

When the Initiator Name is changed in the iSCSI Initiator Properties, any pre-existing Favorite Target entries should be removed and recreated to ensure they use the new *Initiator Name*. Also, ensure the *Initiator Name* always matches the Initiator Name that the iSCSI target is using for access control.
