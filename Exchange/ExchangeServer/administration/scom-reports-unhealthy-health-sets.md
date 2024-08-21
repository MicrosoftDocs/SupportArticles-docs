---
title: SCOM reports unhealthy health sets
description: Resolves an issue in which Active Monitoring probes can't find a Managed Availability health mailbox, and SCOM reports unhealthy health sets.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:High Availability, Health, Performance, Content Indexing\Health set unhealthy
  - CI 178865
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: helmutk, lusassl, meerak, v-trisshores
appliesto:
  - Exchange Server 2019
  - Exchange Server 2016
search.appverid: MET150
ms.date: 01/24/2024
---

# SCOM reports unhealthy health sets

## Symptoms

You receive a notification from Microsoft [System Center Operations Manager](/system-center/scom/welcome) (SCOM) that some of the Managed Availability [health sets](/exchange/high-availability/managed-availability/managed-availability#health-sets) in your environment are unhealthy.

When you search the Microsoft Windows Applications and Services event log on the affected servers, you find that some events that are listed under **Microsoft** \> **Exchange** \> **ActiveMonitoring** \> **ProbeResult** contain the following error message:

```output
System.ApplicationException: monitoring mailbox <UPN of health mailbox account> not found!
at Microsoft.Exchange.Monitoring.ActiveMonitoring.Common.CommonAccessTokenHelper.
ResolveRootOrgUser(String emailAddress, IRecipientSession& recipientSession)
```

Also, the Active Monitoring trace logs that are located in the `ActiveMonitoringTraceLogs` folder on the affected servers contain an entry that displays the following information:

```output
Component: "Common"
LogLevel: "Warning"
Method: "CreateMonitoringMailbox"
Source: "DirectoryAccessor.cs:1380"
Message: "Exception is caught trying to disable email address policy in OnPrem for monitoring mailbox: 
<UPN of health mailbox account>, error : Microsoft.Exchange.Data.Directory.ADNoSuchObjectException: 
Active Directory operation failed on <FQDN of domain controller>. The object <DN of health mailbox account> 
does not exist."
```

**Note**: The ActiveMonitoringTraceLogs folder is located at `%ExchangeInstallPath%\Logging\Monitoring\Monitoring\MSExchangeHMWorker\ActiveMonitoringTraceLogs`.

## Cause

When the Exchange Health Manager Worker process (MSExchangeHMWorker.exe) creates a new health mailbox, it tries to set the `EmailAddressPolicyEnabled` parameter value of the mailbox to `False`. However, in environments that have multiple domain controllers, Active Directory replication delays might cause `EmailAddressPolicyEnabled` to remain set as `True`. In that scenario, the following issues occur:

- The failed attempt by MSExchangeHMWorker.exe to disable the email address policy generates the Active Monitoring trace log error message that's mentioned in the "Symptoms" section.

- The email address policy remains enabled because the Exchange Health Manager Worker process doesn't retry the failed operation. Depending on your organization's email address policy, the SMTP address of the mailbox could be assigned a different value than the UPN.

- Some [Active Monitoring](/exchange/high-availability/managed-availability/managed-availability) probes generate errors in the Applications and Services event log if the SMTP address of a mailbox doesn't match the UPN. For example, the `RpsDeepTestPSProxyProbe/CertificateSid.<CN of health mailbox>` probe generates the error message in the Applications and Services event log that's displayed in the "Symptoms" section. Such errors cause Operations Manager to report some health sets as unhealthy.

## Resolution

To fix the issue, follow these steps:

1. Run the following command to set the `EmailAddressPolicyEnabled` parameter value of each health mailbox to `False`:

   ```powershell
   Get-Mailbox -Monitoring | Set-Mailbox -EmailAddressPolicyEnabled $False
   ```

2. Run the following command to make sure that the primary SMTP address of each health mailbox matches the UPN:

   ```powershell
   Get-Mailbox -Monitoring | Select-Object UserPrincipalName | foreach {Set-Mailbox -Identity $_.UserPrincipalName -PrimarySmtpAddress $_.UserPrincipalName}
   ```
