---
title: Event ID 4769 errors in SharePoint OnPrem audit log
ms.author: meerak
author: Cloud-Writer
manager: dcscontentpm
ms.date: 12/17/2023
audience: ITPro
ms.topic: troubleshooting
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - SharePoint Server
ms.custom: 
  - sap:Administration\Performance
  - CI 122278
  - CSSTroubleshoot
ms.reviewer: flaviuc
description: How to resolve an issue where Event ID 4769 appears multiple times in the SharePoint audit log.
---

# Multiple Event ID 4769 errors in SharePoint OnPrem audit log

## Symptoms

You see Event ID 4769 repeated multiple times in the SharePoint OnPrem event log under the following conditions:

- Microsoft SharePoint 2016 Server is active in an on-premises Active Directory Domain.
- You configure a Search Service Application.
- You configure the environment to have separate accounts according to least-privileged administration best practices.
- The environment is configured according to Kerberos best practices for SharePoint.
- Kerberos auditing is enabled on the domain-controlled servers, and the "Audit Kerberos Service Ticket Operations" is set to audit failures and success.

In this scenario, the application event log container on domain controllers (DCs) is flooded with "Audit failure" events that list Event ID 4769 many times per second, as shown in the following screenshot.

:::image type="content" source="media/event-id-4769-error/event-id-4769-error.png" alt-text="Screenshot of the application event log container page listing Event ID 4769 Audit failure many times.":::

The Search Service account is mentioned as the "Service Name," and the farm account is mentioned as the caller account name.

## Cause

These events are generated primarily (but not exclusively) from of the following timer operations in SharePoint:

- **Application Server Administration Service Timer Job**
- **Application Server Timer Job**

These operations synchronize farm-wide settings that are related to the Search and SSO services to each server in the farm.

The events are caused by requests to the DC Kerberos Ticket Granting Service (TGS) from the SharePoint Timer Service process (OWSTimer.exe) that runs under the farm account for the SharePoint Search Service.

However, the SharePoint Search Service does not use a Server Principal Name (SPN) for any other purpose. And because no SPN is set, the request fails and generates the false positive audit failure Event ID 4769 on the DC.

Therefore, these multiple event listings may impede the ability to meaningfully monitor relevant audit failures for other accounts.

## Resolution

To resolve this issue, you can assign a nonexistent or “fake” SPN to the SharePoint Search Service account. To do this, use the **SETSPN -S** command.

For example:
**SETSPN -S FAKEPROTOCOL/FAKESERVICENAME CONTOSO\SPSVC**

This command prevents the Kerberos audit event log from filling up with false positive audit failure messages. The command does not adversely affect SharePoint functionality or create security risks.

This action takes effect immediately. No other administrative action is required..

## More information

Setting a non-existent SPN is a common, safe practice recommended in scenarios where a nonfunctional SPN is needed. 

For more information about this, see [Example deployment of KCD with Office Online Server and Analysis Services](/analysis-services/instances/install-windows/configure-analysis-services-and-kerberos-constrained-delegation-kcd?view=asallproducts-allversions#example-deployment-of-kcd-with-office-online-server-and-analysis-services&preserve-view=true). 


Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
