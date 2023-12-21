---
title: Incorrect custom domain in Salesforce
description: Troubleshoot and resolve issues when users enter incorrect custom domain while signing in to Salesforce CRM.
ms.date: 12/20/2023
ms.topic: troubleshooting-problem-resolution
ms.service: microsoft-sales-copilot
author: sbmjais
ms.author: shjais
manager: shujoshi
---

# Incorrect custom domain in Salesforce

This article helps you troubleshoot and resolve issues when users enter incorrect custom domain while signing in to Salesforce CRM.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Copilot for Sales Outlook add-in        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Salesforce      |
|**Users**     | Users trying to sign in to Salesforce |

## Symptom

After a user signs in to Salesforce CRM through Copilot for Sales add-in for Outlook, the user is unable to access the Salesforce environment and the following error message is displayed:

`OAuth2 authorization flow failed for service 'Salesforce'. OAuth 2 sign in failed to exchange code for access token. Client ID and secret sent in form body.. Response status code-BadRequest. Response body: {"error":"invalid_grant","error_description":"authentication failure"} Client ID and secret sent in Basic authorization header.. Response status code=BadRequest. REsponse body: {"error":"invalid_grant","error_description":"authentication failure"}`

## Cause

User entered incorrect custom domain when signing in to Salesforce CRM.

## Solution

Enter the correct custom domain and sign in to Salesforce CRM again. For example, in the following image, `correct.my.salesforce.com`, is the host and `/login` represents the path to a custom sign-in page.

:::image type="content" source="media/tsg-cust-domain.png" alt-text="Screenshot showing correct custom domain in Salesforce.":::

## Is your issue still not resolved?

Visit the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.