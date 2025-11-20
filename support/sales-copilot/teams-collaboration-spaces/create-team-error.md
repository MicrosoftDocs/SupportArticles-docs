---
title: Sales app team creation error ContainsBlockedWord
description: Resolves an error that occurs when creating a team for an account or opportunity in Sales app due to naming policy restrictions.
ms.date: 11/20/2025
author: sbmjais
ms.author: shjais
ms.custom:
  - sap:Teams Collaboration Spaces\Collaboration Space Creation and access from Outlook Side-Panel
  - ai-gen-docs-bap
  - ai-gen-title
  - ai-seo-date:06/03/2024
  - ai-gen-desc
---
# Can't create a team for an account or opportunity in Sales app

This article helps you resolve an error that occurs when you try to create a team for an account or opportunity in Sales app.

| Requirement type |Description |
|------------------|------------|
|**Client app** | Sales app in Outlook |
|**Platform** | Web and desktop clients |
|**OS** | Windows and Mac |
|**Deployment** | User managed and admin managed |
|**CRM** | Dynamics 365 and Salesforce |
|**Users** | Users who try to create a team using the collaboration flow in Outlook |

## Symptoms

When you try to [create a team for an account or opportunity](/microsoft-sales-copilot/collaborate-teams-newly-created-existing-team) in Sales app, the following error message is displayed:

> Something went wrong. Copy the error details here, then share them with your admin or Microsoft support and ask if they can help you resolve this issue.

:::image type="content" source="media/create-team-error/team-creation-error.png" alt-text="Screenshot that shows the error that occurs when creating a team for an account or opportunity.":::

Select **Copy error details** to view the error details. If the error includes **ContainsBlockedWord**, see the **Resolution** section of this article.

## Cause

The [Microsoft 365 Groups and Microsoft Teams naming policy](/microsoft-365/solutions/groups-naming-policy) enforces a consistent naming strategy for Microsoft 365 groups and teams created by users in your organization. If a word in the team or channel name is blocked by the naming policy, the creation of such a team or channel fails.

## Resolution

To resolve this issue, use either of the following methods:  

- Contact your administrator to update the naming policy according to the [Microsoft 365 Groups and Microsoft Teams naming policy](/microsoft-365/solutions/groups-naming-policy).
- Use a team or channel name without blocked words and create the team again.

## More information

If your issue is still unresolved, go to the [Sales in Microsoft 365 Copilot - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
