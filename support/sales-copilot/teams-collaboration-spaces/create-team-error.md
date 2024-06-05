---
title: Resolve Microsoft Copilot for Sales team creation error
description: Resolve errors when creating a Team for an account or opportunity in Microsoft Copilot for Sales due to naming policy restrictions with this guide.
ms.date: 06/05/2024
author: sbmjais
ms.author: shjais
ms.custom:
  - sap:CRM Permissions and Configurations\CRM Settings
  - ai-gen-docs-bap
  - ai-gen-title
  - ai-seo-date:06/03/2024
  - ai-gen-desc
---
# Unable to create a team

This article helps you to resolve an error that occurs when you try to create a Team for an account or opportunity in Microsoft Copilot for Sales. The error message states that something went wrong and contact your admin or Microsoft support with the error details to resolve the issue.  

| Requirement type |Description |
|------------------|------------|
|**Client app** | Copilot for Sales Outlook add-in |
|**Platform** | Web and desktop clients |
|**OS** | Windows and Mac |
|**Deployment** | User managed and admin managed |
|**CRM** | Dynamics 365 and Salesforce |
|**Users** | Users who try to create a Team using the collaboration flow in Outlook |

## Symptoms

When you try to create a Team for an account or opportunity in Microsoft Copilot for Sales, the following error message is displayed—*Something went wrong. Copy the error details here, then share them with your admin or Microsoft support and ask if they can help you resolve this issue.*

The error could be due to blocked words in the team name as per the naming policy restrictions. Select **Copy error details** to view the error details. If the error includes **ContainsBlockedWord**, follow the resolution steps provided below.

:::image type="content" source="media/team-creation-error.png" alt-text="Screenshot that shows the error when creating a team.":::

## Cause and resolution

**Cause**  

The [naming policy](/microsoft-365/solutions/groups-naming-policy?view=o365-worldwide) enforces a consistent naming strategy for Microsoft 365 groups and teams created by users in your organization. If a word in the team or channel name is prevented by the naming policy, then the creation of such a team or channel fails.

**Resolution**
To resolve this issue, use either of the following methods:  

1. Contact your administrator to update the naming policy according to the public document [naming policy](/microsoft-365/solutions/groups-naming-policy?view=o365-worldwide).
1. Use a team or channel name without blocked words and create the team again.



## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
