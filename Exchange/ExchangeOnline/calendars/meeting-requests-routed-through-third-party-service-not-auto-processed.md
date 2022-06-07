---
title: Room mailbox can't automatically accept or decline meeting requests
description: Meeting requests that are routed through a third-party mail service by using mail flow connectors aren't automatically processed by a room mailbox. 
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 162396
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: alexaca, tylewis
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 6/7/2022
---
# Room mailbox doesn't process meeting requests routed through a third-party mail service

## Symptoms

Consider a scenario where the environment uses:

- Exchange Online but doesn't have a hybrid Exchange deployment.
- A third-party mail service and mail flow connectors to route emails out from and in to your Microsoft 365 organization. An outbound connector routes emails from the organization to the third-party mail service and an inbound connector routes emails from the third-party mail service to the organization.

In this environment, when you schedule a meeting with users internal to your organization and specify a meeting room in the meeting invite, the room mailbox for the meeting room doesn't accept or decline the meeting automatically even if it is set up to do so.

If you run the following cmdlet to verify the automated calendar processing option set up for the room mailbox, the value for the `AutomateProcessing` property in the output will display **AutoAccept**.

```powershell
Get-CalendarProcessing -Identity <name_of_room_mailbox> | select AutomateProcessing
```

## Cause

This issue occurs because the room mailbox considers the invite received from the third-party mail service via the inbound connector to be an external message.

## Resolution

To resolve the issue, use one of the following methods:

### Method 1: Allow the room mailbox to process requests from external users

This method allows users who are external to the Microsoft 365 organization to book the meeting room associated with the room mailbox. However, the risk involved to the organization is minimal because external users are not likely to know the email address of the room mailbox.

In [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell), run the following cmdlet:

```powershell
Set-CalendarProcessing -Identity <name_of_room_mailbox > -ProcessExternalMeetingMessages $True
```

### Method 2: Set the inbound connector to treat external messages as internal

> [!WARNING]
> This method has potential security risks because internal messages bypass antispam filtering. You must make sure that the messages that are routed through the third-party mail service are only for internal use.

To use this method, the value of the `ConnectorType` parameter for the inbound connector must be set to **OnPremises**. For more information, see the section about using the `TreatMessagesAsInternal` parameter in the [Set-InboundConnector](/powershell/module/exchange/set-inboundconnector) cmdlet.

In [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell), run the following cmdlet:

```powershell
Set-InboundConnector -Identity <name_of_inbound_connector > -TreatMessagesAsInternal $True 
```

## More information

When this issue occurs, you can check the RBA log and the message trace as follows:

### Check the RBA log

1. In [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell), run the following cmdlet to export the RBA log for the room mailbox:

    ```powershell
    Export-MailboxDiagnosticLogs <name_of_room_mailbox > -ComponentName RBA > RoomMBXLogs.txt
    ```

2. In the RBA log, check for the following entry:

    > Message Skipping processing because user settings for processing external items is false.

    The timestamp for this entry will closely match the timestamp of when the meeting request was received by the mailbox.

This entry indicates that the meeting invite was not processed because it was treated as an external message.

### Check the message trace

1. Run an [extended message trace](/exchange/monitoring/trace-an-email-message/message-trace-modern-eac#message-trace-page).
2. In the message trace, find the **RECEIVE** event in the **Custom** column to identify the outbound connector through which the meeting invite was routed outside the organization and the inbound connector used to route the invite back to it.
3. Run the following cmdlet to check the details of the inbound connector that is listed in the message trace.

    ```powershell
    Get-InboundConnector -Identity <name_of_inbound_connector> | flConnectorType,Enabled, TreatMessagesAsInternal
    ```

The output will display the following values for the parameters:

> ConnectorType: Partner  
> Enabled: True  
> TreatMessagesAsInternal: False  

These values indicate that the meeting invite was not processed because it was treated as an external message.
