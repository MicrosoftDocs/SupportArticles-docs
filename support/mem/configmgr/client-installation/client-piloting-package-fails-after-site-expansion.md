---
title: Client piloting package fails after a site expansion
description: After you perform site expansion, the Configuration Manager client piloting package fails. Provides a resolution.
ms.date: 12/05/2023
ms.reviewer: kaushika
---
# Client piloting package fails after a site expansion in Configuration Manager

This article provides a solution for the issue that the Microsoft Corporation Configuration Manager Client Piloting Package fails after performing site expansion.

_Original product version:_ &nbsp; Configuration Manager (current branch - version 1511), Configuration Manager (current branch - version 1602), Configuration Manager (current branch - version 1606), Configuration Manager (current branch - version 1610), Configuration Manager (LTSB - version 1606)  
_Original KB number:_ &nbsp; 3205797

## Symptoms

Consider this scenario:

- You're running Configuration Manager current branch version 1511 through 1610 or Configuration Manager LTSB version 1606.
- The old primary site was being used for client piloting.
- You perform a site expansion.

In this scenario, the Microsoft Corporation Configuration Manager Client Piloting Package fails. You may receive a status message stating that Distribution Manager failed to access the source directory for Configuration Manager Client Piloting Package content. Additionally, the Distmgr.log file contains errors indicating that Distribution Manager cannot locate the source for PilotUpgrade and cannot process the snapshot of the package.

## Cause

This issue occurs if the PilotingUpgrade and StagingClient folders are missing from the new central administration site.

## Resolution

To work around this issue, manually create the StagingClient folder on the new central administration site, and then create an empty file named **CliUpg.acu** in the Hman.box folder on the CAS. This will trigger an update of the client packages by Hierarchy Manager.
