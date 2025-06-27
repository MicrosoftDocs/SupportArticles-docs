---
title: Managed Availability health monitoring probe messages are journaled in Exchange Server 2013
description: Describes a by-design behavior in which Managed Availability health monitoring probe email messages are journaled when you enable Global Journaling. Provides a workaround for this behavior.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:High Availability, Health, Performance, Content Indexing\Health set unhealthy
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: lukeds, stephgil, exchblt, v-six
appliesto: 
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Managed Availability messages are journaled when you enable Global Journaling in Exchange Server 2013

_Original KB number:_ &nbsp;2823959

## Symptoms

When you enable Global Journaling in Microsoft Exchange Server 2013, you notice that emails from the Managed Availability health monitoring probe are journaled.

## Cause

This behavior is by design. It's included as a health-monitoring feature in the release version of Exchange Server 2013, Exchange Server 2013 Cumulative Update 1 (CU1), and Exchange Server 2013 CU2.

## Workaround 1: Create a journal rule

To work around this issue, create a journal rule to disable the probe messages. You can create a journal rule for individual recipients or a distribution group. The following is an example of a cmdlet that creates a journal rule for an individual recipient:

```powersehll
New-JournalRule -Name "User A journal" -journalemailaddress [journal@contoso.com](mailto:journal@contoso.com) -Scope Global -Recipient [usera@contoso.com](mailto:usera@contoso.com) -Enabled $true
```

You can also create a journal rule for a distribution group. The following is an example of a journal rule for a distribution group. After you create the journal rule, all messages that are sent to or sent by a member of the "Journal User" distribution group are journaled:

```powershell
New-JournalRule -Name "Journal Users" -journalemailaddress [journal@contoso.com](mailto:journal@contoso.com) -Scope Global -Recipient [journalusers@contoso.com](mailto:journalusers@contoso.com) -Enabled $true
```

## Workaround 2: Use a global override

To work around this issue, use a global override to disable the probes that are generating the email messages. To do this, follow these steps:

> [!NOTE]
> If you disable Global Monitoring, some server monitoring applications may not correctly monitor transport server components.

1. In the Exchange Management Shell, run the following commands:

    ```powershell
    Add-GlobalMonitoringOverride -Identity "FrontendTransport\OnPremisesSmtpClientSubmission" -PropertyName Enabled -PropertyValue 0 -ApplyVersion "15.0.620.29" -ItemType Probe
    ```

    ```powershell
    Add-GlobalMonitoringOverride -Identity "MailboxTransport\Mapi.Submit.Probe" -PropertyName Enabled -PropertyValue 0 -ApplyVersion "15.0.620.29" -ItemType Probe
    ```

    ```powershell
    Add-GlobalMonitoringOverride -Identity "FrontendTransport\OnPremisesInboundProxy" -PropertyName Enabled -PropertyValue 0 -ApplyVersion "15.0.620.29" -ItemType Probe
    ```

    > [!NOTE]
    > These commands are for Exchange Server 2013 CU1 only. If you're running a different build of Exchange 2013, you can determine the version and build information by running the following command:
    >
    > ```powershell
    > Get-ExchangeServer < ServerName > |fl name,*yver*
    > ```

    The ApplyVersion number is a combination of the version and the build. For example, for Exchange Server 2013 CU1, the version is 15.0, the build is 620.29, and the ApplyVersion number is 15.0.620.29.
2. Restart the Microsoft Exchange Diagnostics service and the Microsoft Exchange Health Manager service on all Exchange Server 2013 servers.

    > [!NOTE]
    > If you're running the Client Access server role and the Mailbox server role on separate servers, you must restart the services that are mentioned here on both roles.

## More information

For more information, go to the following Microsoft websites:

[Server Health and Performance](/exchange/server-health-and-performance-exchange-2013-help)

[Add-GlobalMonitoringOverride](/powershell/module/exchange/add-globalmonitoringoverride)

[Journaling](/exchange/journaling-exchange-2013-help)

[New-JournalRule](/powershell/module/exchange/new-journalrule)
