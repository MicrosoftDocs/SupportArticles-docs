---
title: ThresholdDate might be set back after upgrade
description: This article provides a resolution for the problem that occurs even if they have been processed before.
ms.reviewer: chanson
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# ThresholdDate in SystemState.xml might be set back after upgrade

This article provides a resolution for the problem that occurs even if they have been processed before.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2491350

## Symptoms

Email router polls through the entire user's inbox and processes all emails - even if they have been processed before.

This means much redundant processing work is done. Dependent on the number of emails and users, it can take email router a while to finish the reprocessing. Emails that have been deleted by CRM users before, might be brought back into the system.

This issue might be caused if the following conditions are both true:

1. Email Router is not started with security context of LocalSystem account but with a different account
1. Email Router was upgraded to version CRM 2011

## Cause

The ThresholdDate timestamp values of user profiles within the file SystemState.xml will be set back to **0001-01-01** during upgrade.

> [!NOTE]
> You can find the SystemState.xml file here:
>
> `<drive>:\Program Files\Microsoft CRM Email\Service\Microsoft.Crm.Tools.EmailAgent.SystemState.xml`

## Resolution

Use this workaround if you hit the issue described above.

1. Stop Email Router service after upgrade.
1. Change log on account for Email Router service.
1. Delete the file `C:\Program Files\Microsoft CRM Email\Service\Microsoft.Crm.Tools.EmailAgent.SystemState.xml`.
1. Start Email Router service

This will allow Email Router to use the contents of the backup system state file of CRM 4.0 that was created during upgrade. It will then repopulate the StateXML values and thereby continuing to process the mails where it left off in CRM 4.0.

## More information

Issue applies to RTW (version 5.0.9688.32 or higher), but will be fixed in RTM version.
