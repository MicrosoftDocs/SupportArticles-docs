---
title: DPM 2010 Consistency check fails with error 0x80070005
description: Fixes an issue where consistency check on the primary Data Protection Manager server fails and you receive the Access Denied (0x80070005) error.
ms.date: 07/24/2020
ms.prod-support-area-path:
ms.reviewer: anjanik
---
# An unexpected error occurred while the job was running error when DPM 2010 consistency check fails

This article helps you fix an issue where consistency check on the primary Data Protection Manager (DPM) server fails and you receive the **Access is Denied (0x80070005)** error.

_Original product version:_ &nbsp; System Center Data Protection Manager 2010  
_Original KB number:_ &nbsp; 2506326

## Symptoms

Agent status on the primary System Center Data Protection Manager (DPM) 2010 server shows as **OK** for all agents. However, you may experience one or more of the following symptoms:

- The consistency check on the primary DPM server fails with the following error:

  > An unexpected error occurred while the job was running. (ID 104 Details: Access is denied (0x80070005))

- Recovery point creation fails with the following error:

   > DPM failed to communicate with the protection agent on \<Server Name> because access is denied. (ID 42 Details: The targetprincipal name is incorrect (0x80090322))

- On the secondary DPM server, agent status for the primary shows as **Unavailable**.

    > Detailed error code: A security package specific error occurred (0x80070721
    The protection agent operation failed because DPM could not communicate with the Protection Agent service on \<Primary DPM Server Name>.  
    > Detailed error code: A security package specific error occurred (0x80070721)

## Cause

In a DPM 2010 primary - secondary configuration, the DPMRA service account on the primary DPM server is changed from the Local System account to a domain user account who is also part of the Local Admin group.

## Resolution

To resolve this issue, DPM services should be configured to run using the Local System account on the primary DPM server.
