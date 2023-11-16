---
title: Differences between flow approval actions
description: Explanation of the differences between the flow approval actions in Power Automate.
ms.reviewer: sranjan, hamenon
ms.date: 03/31/2021
ms.subservice: power-automate-flows
---
# Differences between flow approval actions

This article introduces the differences between the flow approval actions in Power Automate.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4513676

The primary difference s between using Start and Wait for an Approval and Create an Approval with the Wait for an approval action are:

- Start and Wait for an Approval automates the full lifecycle of the Approval. It creates the records in CDS, send notifications, and then blocks the flow run until the Approval criteria is met or the action times out. The outputs of the action include the approvers, responses, comments, and so on. because the approval is guaranteed to be complete at the time that the next step runs in the Flow.
- Create an Approval will create the records in CDS and send notifications, but will not block execution of the Flow. Responses, approvers, comments, and so on, are not available as outputs for use in other steps, because the approval is not guaranteed to be complete. Flow authors will need to use the Wait for an approval step to gather the responses, approvers, comments, and any other data gathered as part of the approval being approved or rejected.

| Description| Start and Wait for an approval | Create an Approval|
|---|---|---|
| Creates records in CDS | Yes | Yes |
| Basic email notifications (including actionable email) and push notifications to the Flow Mobile app | Yes | Yes |
| Responses/comments available as outputs | Yes | No, use Wait for an Approval to use these in the Flow. |
| Step outputs an adaptive card that can be posted to Microsoft Teams | No, the approval is already complete after this step completes. | Yes |
  
If you:

Want to store extra data in SQL, CDS, and so on, that contains approver information at the time of the request?

- Use Create an Approval, add steps that log the approval information, then Wait for an approval.

Want to send adaptive cards to users in Microsoft Teams for them to approve directly within the Teams client?

- Use Create an Approval, an in an _Apply To Each_ over the approvers, use the Teams connector Flow bot action to post the adaptive card output from Create An Approval to each user, and then Wait for an approval.
