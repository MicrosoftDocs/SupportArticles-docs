---
title: Outdated client ID error
description: Provides a solution to an error that occurs after your organization is upgraded to the December 2016 update for Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Outdated client ID error after upgrading to the December 2016 update for Microsoft Dynamics 365

This article provides a solution to an error that occurs after your organization is upgraded to the December 2016 update for Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics CRM  
_Original KB number:_ &nbsp; 4014490

## Symptoms

After your organization is upgraded to the December 2016 update for Dynamics 365, existing mailbox records may quit synchronizing and the following alert is logged:  

> "Mailbox \<Mailbox Name> didn't synchronize because the user has an outdated client ID. We have reset the information for you.
>
> Email Server Error Code: Crm:80044113."

If you select **Details**, the details section includes text like the following example:

> "subscriptionclients with clientid \<GUID> doesn't exist"  

## Cause

Microsoft has identified an issue that can cause this symptom and plans to release a fix. In the meantime, follow the steps in the [Resolution](#resolution) section to enable the mailboxes.

## Resolution

1. Sign into Dynamics 365 as a user with the System Administrator role.
2. Navigate to **Settings**, and then select **Email Configuration**.
3. Select **Mailboxes**.
4. Change the view to **Active Mailboxes**.
5. Select the mailbox record(s), and then select **Test & Enable Mailboxes**.  
