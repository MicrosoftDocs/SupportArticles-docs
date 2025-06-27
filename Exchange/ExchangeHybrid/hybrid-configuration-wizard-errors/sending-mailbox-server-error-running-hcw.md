---
title: Sending Mailbox Server isn't running Exchange 2013 or a later version
description: Provides a workaround for an issue that triggers an error when you run the Hybrid Configuration Wizard to upgrade your hybrid deployment configuration from Exchange 2010 to Exchange 2013.
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
search.appverid: MET150
ms.date: 01/24/2024
---
# Sending Mailbox Server isn't running Exchange 2013 or a later version when you run HCW

_Original KB number:_ &nbsp; 3013420

> [!NOTE]
> The Hybrid Configuration wizard (HCW) that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the [Microsoft 365 Hybrid Configuration wizard](https://aka.ms/hybridwizard). For more information, see [Microsoft 365 Hybrid Configuration wizard for Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/office-365-hybrid-configuration-wizard-for-exchange-2010/ba-p/604541).

## Problem

When you use the Hybrid Configuration Wizard to upgrade a hybrid deployment configuration from Exchange Server 2010 to Exchange Server 2013, you receive the following error message:

> The Wizard did not complete successfully. Please see the list below for error details.  
> Sending Mailbox Server '\<ServerName>' isn't running Exchange 2013 or a later version.

## Cause

This issue occurs if you run the Exchange 2013 version of the Hybrid Configuration Wizard, and Exchange 2010 server information is stored in the configuration information.

## Workaround

To work around this issue, follow these steps:

1. Use the Exchange Management Shell to run the following commands:

    ```powershell
    Get-hybridconfiguration |fl >Hybrid.txt

    Set-HybridConfiguration -ClientAccessServers $null -ReceivingTransportServers $null -SendingTransportServers $null
    ```

2. Rerun the Hybrid Configuration Wizard from an Exchange 2013 server.

## Status

This is a known issue. We are working to address this issue and will post more information in this article when it becomes available.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
