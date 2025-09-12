---
title: Get-WebServicesVirtualDirectory cmdlet error in HCW
description: Provides a workaround for an issue that triggers an error when you run the Hybrid Configuration wizard in Exchange Server 2013 in larger environments.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Hybrid
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
# Execution of the Get-WebServicesVirtualDirectory cmdlet has thrown an exception error when running HCW

_Original KB number:_ &nbsp; 3032093

> [!NOTE]
> The Hybrid Configuration wizard (HCW) that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the [Microsoft 365 Hybrid Configuration wizard](https://aka.ms/hybridwizard). For more information, see [Microsoft 365 Hybrid Configuration wizard for Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/office-365-hybrid-configuration-wizard-for-exchange-2010/ba-p/604541).

## Problem

When you run the Hybrid Configuration wizard in Microsoft Exchange Server 2013, you receive the following error message:

> Execution of the Get-WebServicesVirtualDirectory cmdlet has thrown an exception. This may indicate invalid parameters in your hybrid configuration settings.

This prevents the wizard from finishing.

## Cause

A time-out occurred when the Hybrid Configuration wizard was enabling the Mailbox Replication Service Proxy (MRS Proxy) endpoint. This behavior may occur in larger environments.

## Workaround

To work around this issue, use one of the following methods, as appropriate for your situation.

### If you have Exchange Server 2013 and Exchange Server 2010 servers in your on-premises environment

Configuration of the MRS Proxy endpoint is the last step in the wizard. You can safely ignore the error message.

Verify that the MRS Proxy endpoint is enabled for all the Exchange Server 2013 and Exchange Server 2010 servers. For information about how to do this, see [Enable the MRS Proxy endpoint for remote moves](/exchange/enable-the-mrs-proxy-endpoint-for-remote-moves-exchange-2013-help).

Or, you can use the [Microsoft 365 Hybrid Configuration Wizard stand-alone application](https://aka.ms/hybridwizard) to set up the hybrid environment.

### If you have only Exchange Server 2013 servers in your on-premises environment

Verify that the MRS Proxy endpoint is enabled. For information about how to do this, see [Enable the MRS Proxy endpoint for remote moves](/exchange/enable-the-mrs-proxy-endpoint-for-remote-moves-exchange-2013-help).

The error message also prevents the Hybrid Configuration wizard from displaying the link to the Exchange Hybrid (OAuth) Configuration wizard after the Hybrid Configuration wizard finishes. If your topology must have Exchange OAuth authentication set up, see [Configure OAuth authentication between Exchange and Exchange Online organizations](/exchange/configure-oauth-authentication-between-exchange-and-exchange-online-organizations-exchange-2013-help).

Or, you can use the [Microsoft 365 Hybrid Configuration Wizard stand-alone application](https://aka.ms/hybridwizard) to set up the hybrid environment.

### If you have only Exchange Server 2010 servers in your on-premises environment

Configuration of the MRS Proxy endpoint is the last step in the wizard. You can safely ignore the error message.

Verify that the MRS Proxy endpoint is enabled for all Exchange 2010 servers. For information about how to do this, see [Enable the MRS Proxy endpoint for remote moves](/exchange/enable-the-mrs-proxy-endpoint-for-remote-moves-exchange-2013-help).

## Status

This is a known issue. We're working to address this issue and will post more information in this article when such information becomes available.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
