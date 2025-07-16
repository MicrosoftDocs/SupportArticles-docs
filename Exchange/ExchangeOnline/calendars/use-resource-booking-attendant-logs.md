---
title: Use Booking Attendant logs to investigate resource booking issues
description: Discusses how to collect Resource Booking Attendant logs from the EAC to investigate issues that might occur when a user tries to book a conference room, workspace, equipment, or other resource.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Calendaring
  - Exchange Online
  - CSSTroubleshoot
  - CI 187187
ms.reviewer: erichart, ninob, meerak, v-trisshores
appliesto:
  - Exchange Online
search.appverid: MET150
ms.date: 03/11/2024
---

# Use Booking Attendant logs to investigate resource booking issues

You can download Resource Booking Attendant logs from the Exchange admin center (EAC) to investigate booking issues that might occur when a user requests a room, workspace, equipment, or other resource. After a resource mailbox receives a booking request, the Booking Attendant automatically accepts, declines, or delegates the request based on the booking policy ([calendar processing options](/powershell/module/exchange/get-calendarprocessing)) for the resource mailbox. To investigate a booking issue, collect both the Booking Attendant log and the booking policy.

## Collecting the Booking Attendant log and booking policy

Select either of the following options to get the Booking Attendant log and booking policy for a resource mailbox:

- Use the EAC by following these steps:

  1. Navigate to **Troubleshoot** \> **Collect** **Logs**, and then select **Resource** **Booking** to open the **Resource Booking** pane.

  2. Enter the resource mailbox name, and then select **Start**. Exchange Online will download the Booking Attendant log (*RBA.txt*) and the booking policy (*GetCalendarProcessing.txt*) to your default **Downloads** folder.

- Use PowerShell by following these steps:

  1. Connect to [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

  2. Run the following PowerShell cmdlet to save the Booking Attendant log to a file:

     ```PowerShell
     Export-MailboxDiagnosticLogs -Identity <resource mailbox> -ComponentName RBA > "<text file path>"
     ```

  3. Run the following PowerShell cmdlet to view the booking policy:

     ```PowerShell
     Get-CalendarProcessing -Identity <resource mailbox> | FL
     ```

## Searching the Booking Attendant log

Search the Booking Attendant log for entries that are relevant to a problematic booking request. When you search the log, keep in mind the following information:

- Log entries are timestamped based on the time that the Booking Attendant processed the booking request. The entries are listed in descending order. Also, the log entries for each booking request are consecutive.

- The first log entry for a booking request usually contains the following text:

  `LogComment: START - HandleEventInternal Automatic Booking is enabled for resource.`

- The final log entry for a booking request usually contains the following text:
  
  `LogComment: END`

- At least one entry for a booking request contains the following text that specifies the subject of the booking request:

  `subject: <subject of booking request>`

  > [!NOTE]
  > If you know the subject of a booking request and you can find the subject entry in the log, all relevant log entries are located around that entry.

- At least one log entry for a booking request contains the following text that specifies the `LegacyExchangeDN` of the organizer (author of the booking request):

  `Sender: <LegacyExchangeDN of organizer>`

  Note: To get the email address of the organizer, run the following PowerShell cmdlet:
  
  ```PowerShell
  Get-Mailbox -Filter {LegacyExchangeDN -eq "<LegacyExchangeDN of organizer>"} | FL Alias, PrimarySmtpAddress
  ```

- Every log entry for a booking request contains the following text that specifies the resource mailbox name:

  `Mailbox: '<name of resource mailbox>'`

If you can't find the relevant entries for a booking request in the Booking Attendant log, consider the following possible causes:

- The Booking Attendant log for each resource mailbox holds a maximum of 1,000 entries. After the maximum number of entries is reached, new entries replace the oldest existing entries. Therefore, the relevant entries might have been overwritten.

- The Booking Assistant can't process booking requests for a resource mailbox that has a [mailbox delegate](https://support.microsoft.com/office/allow-someone-else-to-manage-your-mail-and-calendar-41c40c04-3bd1-4d22-963a-28eafec25926#:~:text=Make%20someone%20my%20delegate.%201%20Click%20the%20File,Exchange%20folders.%20If%20a%20delegate%20...%20More%20items). All delegates who manage resource mailboxes should be added as [resource delegates](/powershell/module/exchange/set-calendarprocessing#-resourcedelegates).

- The Booking Assistant might not process booking requests for a resource mailbox if the Calendar folder owner or a mailbox delegate installed add-ins or modified Calendar items in the mailbox.

- The Booking Assistant can't process booking requests for a resource mailbox if the booking policy specifies a dynamic distribution group in any of the following policy fields:

  - [ResourceDelegates](/powershell/module/exchange/set-calendarprocessing#-resourcedelegates)
  - [BookInPolicy](/powershell/module/exchange/set-calendarprocessing#-bookinpolicy)
  - [RequestInPolicy](/powershell/module/exchange/set-calendarprocessing#-requestinpolicy)
  - [RequestOutOfPolicy](/powershell/module/exchange/set-calendarprocessing#-requestoutofpolicy)

- The Booking Assistant can't process a booking request for a resource mailbox if the organizer of the request is the resource mailbox. The resource mailbox should be specified only in the attendee fields of the request.

- By default, the Booking Attendant doesn't process external booking requests. Depending on how your Exchange organization routes internal mail, internal booking requests might be marked as external. For example, internal booking requests are marked as external if your organization routes internal mail through an outbound connector.

  > [!NOTE]
  > If you want the Booking Attendant to process external booking requests, use the [Set-CalendarProcessing](/powershell/module/exchange/set-calendarprocessing) cmdlet together with the `ProcessExternalMeetingMessages` switch.

- The Booking Attendant can process booking requests for a workspace mailbox only if the `AcceptConflict` and `EnforceCapacity` parameters in the booking policy are both set to `true`. By default, the value of both parameters is `false`.

- The Booking Attendant can't process booking requests if the booking request **Location** specifies more than one workspace mailbox and the `EnforceCapacity` parameter in the booking policy is set to `true`.

> [!NOTE]
> If you can't use the Booking Attendant log, you can also use Calendar diagnostic logs to investigate resource booking issues.
