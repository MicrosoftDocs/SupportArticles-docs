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
ms.reviewer: alexaca
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 5/11/2022
---
# Room mailbox can't automatically process meeting requests routed through a third-party mail service

## Symptoms

Consider the following scenario:

- You use a third-party mail service and don't have a hybrid Exchange deployment.
- You use an outbound connector and an inbound connector to route email messages to the third-party mail service, out from a Microsoft 365 organization and then back to the organization.
- You schedule an internal meeting with users in the same Microsoft 365 organization.
- You specify a room mailbox as a location for the meeting.

In this scenario, the calendar processing assistant doesn't automatically process the meeting based on its settings. As a result, the room mailbox doesn't automatically accept or decline the meeting.

However, if you check the `AutomateProcessing` property by using the following cmdlet, the property value correctly shows **AutoAccept**.

```powershell
Get-CalendarProcessing -Identity <room_mailbox_name> | select AutomateProcessing
```

## Cause

When the meeting request message that's routed through the third-party mail service passes through the inbound connector and is received by the room mailbox, it is considered as an external message and not processed by the room mailbox.

## Solution

To resolve this issue, use one of the following methods:

### Method 1 (no risk): Allow external users to book the room mailbox

In [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell), run the following cmdlet:

```powershell
Set-CalendarProcessing -Identity <room_mailbox_name> -ProcessExternalMeetingMessages $True 
```

**Note:** Replace \<room_mailbox_name> with the name of the affected room mailbox.  

### Method 2 (high risk): Set the inbound connector to treat external messages as internal

In [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell), run the following cmdlet:

```powershell
Set-InboundConnector -Identity <inbound_connector_name> -TreatMessagesAsInternal $True 
```

**Notes:**  

- Replace \<inbound_connector_name> with the name of the inbound connector in your organization. You can run the [Get-InboundConnector](/powershell/module/exchange/get-inboundconnector) cmdlet to get the list of inbound connectors.
- The `TreatMessagesAsInternal` parameter can only be used if the inbound connector is the on-premises type. For more information, see the `-TreatMessagesAsInternal` section in the [Set-InboundConnector](/powershell/module/exchange/set-inboundconnector) article.
- This method has potential security risks because internal messages bypass the antispam filtering. Therefore, you must make sure that the messages routed through the third-party mail service are only for internal use.

## More information

When this issue occurs, you can check and analyze the RBA log or message trace as follows:

### Check the RBA log

1. In [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell), run the following cmdlet to get the log:

    ```powershell
    Export-MailboxDiagnosticLogs <room_mailbox_name> -ComponentName RBA > RoomMBXLogs.txt
    ```

    **Note:** Replace \<room_mailbox_name> with the name of the affected room mailbox.

2. In the RBA log file, search for the timestamp as same as the creation time of the meeting request. The creation time is also the time when the meeting request is received by the room mailbox.  

3. Check whether there is an entry such as the following one:

    > Message Skipping processing because user settings for processing external items is false.

    **Note:** This entry time matches the timestamp of the meeting request, and it might have a difference of a few seconds or less.

### Check the message trace

1. Run an [extended message trace](/exchange/monitoring/trace-an-email-message/message-trace-modern-eac#message-trace-page) by selecting **Custom** queries.
2. In the message trace, find the **RECEIVE** event to check whether the meeting request message is routed outside the organization through an outbound connector and then routed back to it through an inbound connector.
3. Run the following cmdlet to check the details of the inbound connector that you find in the message trace.

    ```powershell
    Get-InboundConnector | fl Name,ConnectorType,Enabled, TreatMessagesAsInternal
    ```
