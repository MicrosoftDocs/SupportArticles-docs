---
title: The request failed with HTTP status 403
description: Describes an issue in which you receive a The request failed with HTTP status 403 error message when you run the Hybrid Configuration wizard.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: scotro, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# The request failed with HTTP status 403: Forbidden when you run the Hybrid Configuration wizard

_Original KB number:_ &nbsp; 3067975

## Problem

You want to set up a hybrid deployment between your on-premises Microsoft Exchange Server organization and Exchange Online in Microsoft 365. However, when you run the Hybrid Configuration wizard, you receive an "An error occurred accessing Windows Live. The request failed with HTTP status 403: Forbidden" error message. The full text of the message resembles the following:

> ERROR:Updating hybrid configuration failed with error 'Subtask Configure execution failed: Creating Organization Relationships.
>
> Execution of the Set-FederatedOrganizationIdentifier cmdlet had thrown an exception. This may indicate invalid parameters in your Hybrid Configuration settings.
>
> An error occurred while attempting to provision Exchange to the Partner STS. Detailed Information ""An error occurred accessing Windows Live. Detailed information: ""The request failed with HTTP status 403: Forbidden.""."".  
> at
Microsoft.Exchange.Management.Hybrid.RemotePowershellSession.RunCommand(String cmdlet, Dictionary`2 parameters, Boolean ignoreNotFoundErrors)

## Cause

This issue may occur if a timing issue is preventing the Hybrid Configuration wizard from completing successfully.

## Solution

Wait approximately 30 minutes, and then rerun the Hybrid Configuration wizard.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
