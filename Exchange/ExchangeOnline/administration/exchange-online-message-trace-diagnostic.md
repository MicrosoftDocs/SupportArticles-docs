---
title: Exchange Online Message Trace Diagnostic
description: Discusses the data that's collected by the Exchange Online Message Trace Diagnostic tool.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: article
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Online
- CSSTroubleshoot
ms.reviewer: brianpr
appliesto:
- Exchange Online
search.appverid: MET150
---
# Microsoft Exchange Online Message Trace Diagnostic

_Original KB number:_ &nbsp; 2871040

## Summary

This Support Diagnostics Platform (SDP) package collects sender, recipient and/or contact, connectors, transport and inbox rules, junk email and content filter configuration, and message trace information from your Exchange Online organization.

> [!NOTE]
>
> - This diagnostic package is produced specifically for customers who have Office 365 Exchange Online senders or recipients.
> - All file names in the data collection are prefaced with <YYYYMMDD_HHMMSS>.
> - Information that's collected will depend on whether the sender or recipient has a mailbox or is a mail contact in your Exchange Online organization.
> - Message trace information will be collected for the sender-recipient pair and date (+/- one day) that you enter, when prompted.
> - Message trace can be collected only if you're using Office 365 after the service upgrade.

## Information collected

### Anti-Junk mail detail

| Description| File name |
|---|---|
|Get-HostedContentFilterPolicy cmdlet output for specified recipient.|Recipient_HostedContentFilterPolicy.xml|
|Get-MailboxJunkEmailConfiguration cmdlet output for specified recipient.|Recipient_MailboxJunkEmailConfiguration.xml|
|||

### Connectors detail

| Description| File name |
|---|---|
|Get-InboundConnector cmdlet output for the Exchange Online environment.|InboundConnector.xml|
|Get-OutboundConnector cmdlet output for the Exchange Online environment.|OutboundConnector.xml|
|||

### Data collection log

| Description| File name |
|---|---|
|Log of all cmdlet output in a single text file.|Data_Collection.log|
|||

### General information

| Description| File name |
|---|---|
|Basic system information including computer name, service pack, computer model and processor name and speed|esultreport.xml|
|||

### Message trace detail

| Description| File name |
|---|---|
|Get-MessageTrace cmdlet output for date entered +/- one day.|MessageTrace_Detail.txt|
|||

### Recipient detail

| Description| File name |
|---|---|
|Get-AcceptedDomain cmdlet output for specified recipient.|Recipient_AcceptedDomain.xml|
|Get-Mailbox cmdlet output for specified recipient.|Recipient_Mailbox.xml|
|Get-MailContact cmdlet output for specified recipient.|Recipient_MailContact.xml|
|||

### Rules detail

| Description| File name |
|---|---|
|Get-InboxRule cmdlet output for specified recipient.|Recipient_InboxRule.xml|
|Get-TransportRule cmdlet output for the Exchange Online environment.|TransportRule.xml|
|||

### Sender detail

| Description| File name |
|---|---|
|Get-AcceptedDomain cmdlet output for specified sender.|Sender_AcceptedDomain.xml|
|Get-Mailbox cmdlet output for specified sender.|Sender_Mailbox.xml|
|Get-MailContact cmdlet output for specified sender.|Sender_MailContact.xml|
|||

## References

For more information about Microsoft Automated Troubleshooting Services and about the Support Diagnostics Platform, see [Information about Microsoft Automated Troubleshooting Services and Support Diagnostic Platform](https://support.microsoft.com/help/2598970).
