---
title: Understand AD FS sign-in events in Microsoft Entra ID with Connect Health
description: Understand how to correlate sign-in events in Active Directory Federation Services (AD FS) security logs into one sign-in event in Azure for parsing.
ms.date: 05/18/2023
ms.reviewer: brheld, v-leedennis
ms.service: active-directory
ms.subservice: hybrid
#Customer intent: As a Microsoft Entra user, I want to know how sign-in events in AD FS security logs relate to a single Azure sign-in event so that I can parse sign-in data in Azure.
---
# Understand AD FS sign-in events in Microsoft Entra ID with Connect Health

With Microsoft Entra Connect Health, you can integrate Active Directory Federation Services (AD FS) sign-in events into the Microsoft Entra sign-ins report. The Microsoft Entra sign-ins report includes information about when the following types of entities sign in to Microsoft Entra ID and access resources:

- Users
- Applications
- Managed resources

This article shows how to use the Connect Health for AD FS agent, Azure Monitor, and Log Analytics to correlate and analyze AD FS sign-in data.

## Prerequisites

- [Microsoft Entra Connect Health](/azure/active-directory/hybrid/connect/how-to-connect-health-agent-install) for AD FS installed and upgraded to latest version (3.1.95.0 or greater).
- The [Global Administrator](/azure/active-directory/roles/permissions-reference#global-administrator) or [Reports Reader](/azure/active-directory/roles/permissions-reference#reports-reader) role to view the Microsoft Entra sign-ins.
- At least one Microsoft Entra ID P1 or P2 license for the first Connect Health agent.
- 25 extra Microsoft Entra ID P1 or P2 licenses for each extra registered agent.
- An equal agent count to the total number of agents that are registered across all monitored roles (AD FS, Microsoft Entra Connect, and Active Directory Domain Services).
- The requisite number of valid Microsoft Entra Connect Health licenses. (You aren't required to assign the license to specific users.)

## Sign-in data reporting

The Connect Health for AD FS agent correlates many event IDs from AD FS to offer information about the sign-in request and error details if a request fails. The request information is correlated to the Microsoft Entra sign-ins report schema. The information can be displayed in the Microsoft Entra sign-in report user interface. Along with the report, a new Azure Monitor workbook template and a new Azure Log Analytics stream are available with the AD FS data. You can use and modify the workbook template for an in-depth analysis for scenarios, such as:

- AD FS account lockouts.
- Bad password attempts.
- Spikes of unexpected sign-in attempts.

The available data mirrors the same data that's available for Microsoft Entra sign-ins. Five tabs with information are available, based on the sign-in type:

- Microsoft Entra ID
- AD FS

Connect Health correlates events from AD FS, dependent on the server version. It then matches the events with the AD FS schema. For more information, see [What data is displayed in the report?](/azure/active-directory/hybrid/how-to-connect-health-ad-fs-sign-in#what-data-is-displayed-in-the-report)

## Configuration

Basic configuration is automatic. Data is fed into the report after the feature goes live and prerequisites are met.

You can enable Log Analytics for AD FS sign-ins and use it with any other Log Analytics-integrated components, such as Microsoft Sentinel. For more information, see [Enabling Log Analytics and Azure Monitor](/azure/active-directory/hybrid/how-to-connect-health-ad-fs-sign-in#enabling-log-analytics-and-azure-monitor).

## Basic troubleshooting

For current known issues and limitations, see [Frequently asked questions](/azure/active-directory/hybrid/how-to-connect-health-ad-fs-sign-in#frequently-asked-questions).

### Kusto logging

To collect the sign-in events from AD FS sign-ins, run the following Kusto query in Log Analytics.

```kusto
unioncluster('Idsharedweu').database('ADFSConnectHealth').SignInEvent,  
cluster('Idsharedwus').database('ADFSConnectHealth').SignInEvent 
| where env_time > ago(2d)
| where tenantId == "00000000-0000-0000-0000-000000000000"
| take 15
```

## Next steps

Read more about [AD FS sign-ins in Microsoft Entra ID with Connect Health](/azure/active-directory/hybrid/how-to-connect-health-ad-fs-sign-in).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
