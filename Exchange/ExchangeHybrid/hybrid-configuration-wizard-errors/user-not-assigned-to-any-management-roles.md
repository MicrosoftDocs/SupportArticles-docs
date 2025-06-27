---
title: Can't run HCW without sufficient permissions
description: Fixes an issue that occurs when the user account that you're using to run the wizard doesn't have sufficient permissions.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Hybrid
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: timothyh, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# The user isn't assigned to any management roles when you run the Hybrid Configuration wizard

_Original KB number:_ &nbsp; 3058293

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the [Microsoft 365 Hybrid Configuration wizard](https://aka.ms/hybridwizard). For more information, see [Microsoft 365 Hybrid Configuration wizard for Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/office-365-hybrid-configuration-wizard-for-exchange-2010/ba-p/604541).

## Problem

When you run the Hybrid Configuration wizard, you receive the following error message:

> ERROR:Updating hybrid configuration failed with error 'System.Management.Automation.Remoting.PSRemotingTransportException: Processing data from remote server failed with the following error message: The user "\<>/Users/Administrator" isn't assigned to any management roles. For more information, see the about_Remote_Troubleshooting Help topic.

## Cause

The user account that you're using to run the Hybrid Configuration wizard doesn't have sufficient permissions.

## Solution

You must be an Exchange administrator to run the Hybrid Configuration wizard. To resolve this problem, add the administrator account to the Domain Admins group or to another group whose permissions resemble those of the Domain Admins group.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
