---
title: Room mailbox can't automatically accept or decline meeting requests
description: Meeting requests that are routed through a third-party mail service by using mail flow connectors aren't automatically processed by a room mailbox. 
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Calendaring
  - CI 162396
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: alexaca, tylewis
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Room mailbox doesn't process meeting requests routed through a third-party mail service

## Symptoms

Consider the following scenario:

- Your environment includes Exchange Online but doesn't have a hybrid Exchange deployment.
- Your environment uses a third-party mail service and mail flow connectors to route email messages from and to your Microsoft 365 organization. An outbound connector routes messages from the organization to the third-party mail service, and an inbound connector routes messages from the third-party mail service to the organization.

In this scenario, when you schedule a meeting with users who are internal to your organization, and you specify a meeting room in the meeting invitation, the room mailbox for the meeting room doesn't accept or decline the meeting automatically even if it's set up to do this.

If you run the following cmdlet to verify the automated calendar processing option that's set for the room mailbox, the value for the `AutomateProcessing` property in the output displays as **AutoAccept**:

```powershell
Get-CalendarProcessing -Identity <name_of_room_mailbox> | select AutomateProcessing
```

## Cause

This issue occurs because the room mailbox treats the invitation that's received from the third-party mail service through the inbound connector as an external message.

## Resolution

To resolve the issue, use one of the following methods:

### Method 1: Allow the room mailbox to process requests from external users

This method lets users who are external to the Microsoft 365 organization book the meeting room that's associated with the room mailbox. However, the risk involved to the organization is minimal because external users aren't likely to know the email address of the room mailbox.

In [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell), run the following cmdlet:

```powershell
Set-CalendarProcessing -Identity <name_of_room_mailbox > -ProcessExternalMeetingMessages $True
```

### Method 2: Set the inbound connector to consider external messages as internal

> [!WARNING]
> This method has potential security risks because internal messages bypass antispam filtering. You must make sure that the messages that are routed through the third-party mail service are only for internal use.

To use this method, the value of the `ConnectorType` parameter for the inbound connector must be set to **OnPremises**. For more information, see the section about using the `TreatMessagesAsInternal` parameter in the [Set-InboundConnector](/powershell/module/exchange/set-inboundconnector) cmdlet.

In [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell), run the following cmdlet:

```powershell
Set-InboundConnector -Identity <name_of_inbound_connector > -TreatMessagesAsInternal $True 
```

## More information

When this issue occurs, you can check the RBA log and the message trace, as follows:

### Check the RBA log

1. In [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell), run the following cmdlet to export the RBA log for the room mailbox:

    ```powershell
    Export-MailboxDiagnosticLogs <name_of_room_mailbox > -ComponentName RBA > RoomMBXLogs.txt
    ```

2. In the RBA log, check for the following entry:

    > Message Skipping processing because user settings for processing external items is false.

    The timestamp for this entry will closely match the timestamp of the meeting request that was received by the mailbox.

This entry indicates that the meeting invitation wasn't processed because it was treated as an external message.

### Check the message trace

1. Run an [extended message trace](/exchange/monitoring/trace-an-email-message/message-trace-modern-eac#message-trace-page).
2. In the message trace, find the **RECEIVE** event in the **Custom** column to identify the outbound connector through which the meeting invitation was routed outside the organization, and the inbound connector that was used to route the invitation back to the organization.
3. Run the following cmdlet to check the details of the inbound connector that's listed in the message trace:

    ```powershell
    Get-InboundConnector -Identity <name_of_inbound_connector> | flConnectorType,Enabled, TreatMessagesAsInternal
    ```

The output will display the following values for the parameters:

> ConnectorType: Partner  
> Enabled: True  
> TreatMessagesAsInternal: False  

These values indicate that the meeting invitation wasn't processed because it was treated as an external message.
