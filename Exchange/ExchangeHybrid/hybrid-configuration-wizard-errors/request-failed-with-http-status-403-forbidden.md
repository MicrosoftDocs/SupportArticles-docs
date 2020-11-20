---
title: The request failed with HTTP status 403
description: Describes an issue in which you receive a "The request failed with HTTP status 403" error message when you run the Hybrid Configuration wizard.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Hybrid
- CSSTroubleshoot
ms.reviewer: scotro
appliesto:
- Exchange Online
- Exchange Server 2013 Enterprise
- Exchange Server 2013 Standard Edition
search.appverid: MET150
---
# The request failed with HTTP status 403: Forbidden when you run the Hybrid Configuration wizard

_Original KB number:_ &nbsp; 3067975

## Problem

You want to set up a hybrid deployment between your on-premises Microsoft Exchange Server organization and Exchange Online in Microsoft Office 365. However, when you run the Hybrid Configuration wizard, you receive an "An error occurred accessing Windows Live. The request failed with HTTP status 403: Forbidden" error message. The full text of the message resembles the following:

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

## More information

If you experience issues with the Hybrid Configuration wizard, you can run the [Exchange Hybrid Configuration Diagnostic](https://aka.ms/hcwcheck). This diagnostic is an automated troubleshooting experience. Run it on the same server on which the Hybrid Configuration wizard failed. Doing this collects the Hybrid Configuration wizard logs and parses them for you. If you're experiencing a known issue, a message is displayed that tells you what went wrong. The message includes a link to an article that contains the solution. Currently, the diagnostic is supported only in Internet Explorer.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
