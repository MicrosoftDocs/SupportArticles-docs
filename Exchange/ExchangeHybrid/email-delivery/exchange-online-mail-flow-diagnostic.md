---
title: Exchange Online Mail Flow Diagnostic
description: Describes the data that's collected by the Exchange Online Mail Flow Diagnostic tool.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: jchapp, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Microsoft Exchange Online Mail Flow Diagnostic

_Original KB number:_ &nbsp; 2982028

## Introduction

The Microsoft Exchange Online Mail Flow Diagnostic tool Support Diagnostics Platform (SDP) package collects sender, recipient and contact, connectors, and message trace information from your on-premises and Exchange Online organizations.

> [!NOTE]
>
> - This diagnostic package is produced specifically for customers who have both an on-premises Exchange Server organization and Exchange Online in Microsoft 365 (hybrid deployment).
> - All file names in the data collection are prefaced with \<YYYYMMDD_HHMMSS>.
> - Information that's collected will depend on whether the sender or recipient has a mailbox or is a mail contact in your Exchange Online organization.
> - When the diagnostic is prompted, message trace information will be collected for the sender-recipient pair and date (plus or minus one day) that you enter.

## Information that is collected

### Connector detail

| Description| File name |
|---|---|
| `Get-InboundConnector` cmdlet output for the Exchange Online environment|InboundConnector.txt|
| `Get-OutboundConnector` cmdlet output for the Exchange Online environment|OutboundConnector.txt|
| `Get-SendConnector` cmdlet output for the Exchange on-premises environment|SendConnector.txt|
| `Get-ReceiveConnector` cmdlet output for the Exchange on-premises environment|ReceiveConnector.txt|

### Data-collection log

| Description| File name |
|---|---|
|Log of all cmdlet output in a single text file|Data_Collection.log|

### On-premises recipient detail

| Description| File name |
|---|---|
| `Get-AcceptedDomain` cmdlet output for the Exchange Online environment|Cloud_AcceptedDomain.txt|
| `Get-RemoteDomain` cmdlet output for the Exchange Online environment|Cloud_RemoteDomain.txt|
| `Get-Recipient` cmdlet output for the affected Exchange Online user|Cloud_Recipient.txt|

### Exchange Online user detail

| Description| File name |
|---|---|
| `Get-AcceptedDomain` cmdlet output for the on-premises Exchange environment|OnPrem_AcceptedDomain.txt|
| `Get-RemoteDomain` cmdlet output for the on-premises Exchange environment|OnPrem_RemoteDomain.txt|
| `Get-Recipient` cmdlet output for the affected on-premises Exchange user|OnPrem_Recipient.txt|

## References

For more information about Microsoft Automated Troubleshooting Services and about SDP, see [Information about Microsoft Automated Troubleshooting Services and Support Diagnostics Platform](https://support.microsoft.com/help/2598970).
