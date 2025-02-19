---
title: Differences between flow approval actions
description: Explanation of the differences between the flow approval actions in Power Automate.
ms.reviewer: sranjan, hamenon
ms.date: 09/04/2024
ms.custom: sap:Approvals\Issue creating an approval flow
---
# Differences between flow approval actions

This article introduces the main differences between the **Start and wait for an approval**, **Create an approval**, and **Wait for an approval** actions in Power Automate.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4513676

## Summary

**Start and wait for an approval** automates the full lifecycle of the approval. It creates the records in Dataverse, sends the approval notifications, and then blocks the flow run until the approval criteria are met or the action times out. The outputs of the action include the approvers, responses, comments, and so on, because the approval is guaranteed to be completed before the next step runs in the flow.

**Create an approval** creates the records in Dataverse and sends approval notifications, but doesn't block execution of the flow. Responses, approvers, comments, and so on aren't available as outputs for other steps, because the approval isn't guaranteed to be completed before the next step. Flow authors need to use the **Wait for an approval** action to gather the responses, approvers, comments, and any other data gathered as part of the approval being approved or rejected.

For more information, see [Get started with approvals](/power-automate/get-started-approvals).

This table summarizes the differences between the two actions.

| Description| Start and wait for an approval | Create an approval|
|---|---|---|
| Creates records in Dataverse. | Yes | Yes |
| Basic email notifications (including actionable emails) and push [notifications](/power-automate/mobile/notifications) to the Power Automate mobile app. | Yes | Yes |
| Responses or comments are available as outputs. | Yes | No, use **Wait for an approval** to use these in the flow. |
| A step outputs an adaptive card that can be posted to Microsoft Teams. | No, the approval is already complete after this step completes. | Yes |

## Usage examples

- How can I store extra data that contains approver information at the time of the request in SQL, Dataverse, and so on?

  Use the **Create an approval** action, add steps that log the approval information, and then **Wait for an approval**.

- How do I send adaptive cards to users in Microsoft Teams for them to approve directly within the Teams client?

  Use the **Create an approval** action, add in an _Apply To Each_ over the approvers, use the **Teams connector** flow bot action to post the adaptive card output from **Create an approval** to each user, and then **Wait for an approval**.
  
  For more information, see [Directing content to Teams members or Microsoft Entra users](/power-automate/overview-adaptive-cards#directing-content-to-teams-members-or-microsoft-entra-users) and [Create your first adaptive card](/power-automate/create-adaptive-cards).
