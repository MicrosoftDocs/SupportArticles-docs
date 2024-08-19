---
title: Installing Mailbox role fails with error
description: You cannot install the Mailbox role on an Exchange server. Provides options to solve this issue.
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Plan and Deploy\Exchange Install Issues, Cumulative or Security updates
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: jchapp, v-six
appliesto: 
  - Exchange Server 2010
search.appverid: MET150
---
# Exchange 2010 Setup of Mailbox role fails with the name reference is invalid error

_Original KB number:_ &nbsp; 2479802

## Symptoms

The install of the Mailbox role on an Exchange server will fail and the following is seen in the setup.log file:

```console
This error is not retriable. Additional information: The name reference is invalid.
This may be caused by replication latency between Active Directory domain controllers.
Active directory response: 000020B5: AtrErr: DSID-03152392, #1:
 0: 000020B5: DSID-03152392, problem 1005 (CONSTRAINT_ATT_TYPE), data 0, Att 200f4 (homeMDB)".
[MM/DD/YYYY HH:MM:SS] [1] [ERROR] Active Directory operation failed on DC-Name.Domain.com. This error is not retriable. Additional information: The name reference is invalid.
This may be caused by replication latency between Active Directory domain controllers.
Active directory response: 000020B5: AtrErr: DSID-03152392, #1:
 0: 000020B5: DSID-03152392, problem 1005 (CONSTRAINT_ATT_TYPE), data 0, Att 200f4 (homeMDB)
```

## Cause

This issue occurs when the value of the `ConfigurationDomainController` parameter and the value of the `PreferredGlobalCatalog` parameter are not equal. In this scenario, the Mailbox install fails because of the replication latency that occurs between the configured domain controllers and the preferred global catalog.

> [!NOTE]
> The `PreferredGlobalCatalog` parameter is randomly selected by Exchange Setup and may be different each time setup is run. Consequently, in some situations, setup may choose more than one Domain Controller/Global Catalog (DC/GC) during setup and objects created during setup may not be present on another DC/GC due to AD replication latency.

## Resolution

Option 1: Wait for AD Replication to complete, then run setup again and allow it to continue to completion.

Option 2: Run Setup from the shell with the `/DomainController` switch as listed in [Use unattended mode in Exchange Setup](/Exchange/plan-and-deploy/deploy-new-installations/unattended-installs).
