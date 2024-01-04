---
title: Incorrect custom domain in Salesforce
description: Resolves an error that occurs when you enter an incorrect custom domain while signing in to Salesforce CRM.
ms.date: 01/04/2024
ms.service: microsoft-sales-copilot
author: sbmjais
ms.author: shjais
manager: shujoshi
---
# An incorrect custom domain is entered when signing in to Salesforce

This article helps you troubleshoot and resolve issues when users enter an incorrect custom domain while signing in to Salesforce CRM.

> [!NOTE]
> Microsoft Sales Copilot is rebranded as Microsoft Copilot for Sales in January 2024. The screenshot in this article will be updated with the new name soon.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Copilot for Sales Outlook add-in        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Salesforce      |
|**Users**     | Users trying to sign in to Salesforce |

## Symptoms

After you sign in to Salesforce CRM through the [Copilot for Sales add-in for Outlook](/microsoft-sales-copilot/use-sales-copilot-outlook), you can't access the Salesforce environment, and the following error message is displayed:

> OAuth2 authorization flow failed for service 'Salesforce'. OAuth 2 sign in failed to exchange code for access token. Client ID and secret sent in form body.. Response status code-BadRequest. Response body: {"error":"invalid_grant","error_description":"authentication failure"} Client ID and secret sent in Basic authorization header.. Response status code=BadRequest. REsponse body: {"error":"invalid_grant","error_description":"authentication failure"}

## Cause

You entered an incorrect custom domain when signing in to Salesforce CRM.

## Resolution

Enter the correct custom domain and sign in to Salesforce CRM again. For example, in the following image, `correct.my.salesforce.com` is the host, and `/login` represents the path to a custom sign-in page.

:::image type="content" source="media/oauth2-authorization-flow-failed-for-service/custom-domain.png" alt-text="Screenshot that shows the correct custom domain in Salesforce.":::

## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]