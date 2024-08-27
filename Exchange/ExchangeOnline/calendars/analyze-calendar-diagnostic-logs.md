---
title: Analyze calendar diagnostic logs for Exchange Online mailboxes
description: Discusses how to analyze CDL logs to investigate calendar issues for Exchange Online mailboxes. 
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Calendaring
  - Exchange Online
  - CSSTroubleshoot
  - CI 194594
ms.reviewer: meshel, shanefe, erichart, ninob, meerak, v-trisshores
appliesto:
  - Exchange Online
  - Outlook on the web
  - Outlook for Windows
  - Outlook for Mac
  - Outlook for iOS
  - Outlook for Android
  - Outlook for Microsoft 365
  - Outlook 2021
  - Outlook 2019
  - Outlook 2016
  - New Outlook for Windows
search.appverid: MET150
ms.date: 08/27/2024
---

# Analyze calendar diagnostic logs for Exchange Online mailboxes

To help diagnose meeting issues for Exchange Online mailboxes, you can analyze calendar diagnostic logs (CDLs). To get the CDLs for a meeting, see [Get calendar diagnostic logs for Exchange Online mailboxes](./get-calendar-diagnostic-logs.md).

The following sections guide you through the analysis process.

## Prerequisites

[Use the Get-CalendarDiagnosticObjectsSummary.ps1 script](./get-calendar-diagnostic-logs.md#use-the-get-calendardiagnosticobjectssummaryps1-script) to output the following Microsoft Excel file:

_CalLogSummary_\<short meeting ID\>.xlsx_

The file contains the following set of worksheets for each key meeting participant:

- A timeline worksheet that's named: \<participant SMTP address\>_TimeLine
- An enhanced CDL worksheet that's named: \<participant SMTP address\>
- A raw CDL worksheet that's named: \<participant SMTP address\>_Raw

> [!NOTE]
> - The script downloads and processes the raw CDLs to provide enhanced CDLs and a concise timeline of meeting actions.
> - The article discusses how to analyze the timeline of meeting actions and enhanced CDLs. Raw CDL analysis is outside the scope of this article.

## Analyze the timeline of meeting actions

The top rows of the timeline worksheet for a participant provide general meeting information, such as the meeting ID, subject, and organizer. Those rows are followed by a time-stamped, high-level summary of meeting actions that relate to the participant. You can use the timeline to troubleshoot basic meeting issues.

For example, consider a scenario in which you want to learn who canceled a meeting. In the following screenshot, the timeline worksheet for a delegate shows that the delegate canceled the meeting in Outlook on the web.

:::image type="content" source="media/analyze-calendar-diagnostic-logs/timeline-example-1.png" border="true" alt-text="Screenshot of a timeline worksheet for a delegate." lightbox="media/analyze-calendar-diagnostic-logs/timeline-example-1.png":::

> [!NOTE]
> Each numbered entry in the timeline corresponds to a row in the raw CDL worksheet. The skipped numbers correspond to raw CDL rows that have ignorable meeting actions.

In the following screenshot, the timeline worksheet for a user shows that the user deleted the meeting in Outlook.

:::image type="content" source="media/analyze-calendar-diagnostic-logs/timeline-example-2.png" border="true" alt-text="Screenshot of a timeline worksheet for a user." lightbox="media/analyze-calendar-diagnostic-logs/timeline-example-2.png":::

## Analyze enhanced CDLs

The enhanced CDLs for a participant provide a detailed record of meeting actions that relate to the participant. Although the enhanced CDL worksheet contains the same meeting actions in the same order as the raw CDL worksheet, it has the following advantages:

- The column headers have filters that you can use to hide nonrelevant meeting actions. By filtering, you can significantly reduce the number of entries that you review.

- The worksheet has new columns that add information to each meeting action. For example:

   - A **LogType** column that categorizes each meeting action. If you filter on this column, you can hide all meeting actions that are labeled as ignorable, such as some system actions or cleanup actions.

   - A **FreeBusy** column that provides the meeting free/busy status after each log action.

   - A **ResponsibleUser** column that specifies which user or component is responsible for the meeting action.

### Enhanced CDL worksheet columns

The following table describes each column in the enhanced CDL worksheet from left to right. Column names that have asterisks indicate important diagnostic data.

| **Column Name** | **Description** |
| - | - |
| LogRow | Row values that correspond to row numbers in the raw CDL worksheet but are offset by one because of the raw CDL worksheet header. |
| LogTimestamp | UTC date and time that the meeting action was logged. |
| LogType\* | Meeting action type:<br>- `Core`: An important meeting action.<br>- `Ignorable`: A routine system action that you can ignore. For example, a meeting action that's performed by a Microsoft event-based assistant (EBA) or time-based assistant (TBA).<br>- `Cleanup`: A routine maintenance action that you can ignore. For example, an automatic Outlook action that deletes a meeting response. |
| SubjectProperty\* | Meeting subject. |
| Client\* | Short name of the client that performed the action on a calendar item. For example:<br>- `Outlook : Desktop : MAPI`: A user used the Outlook desktop client to perform the meeting action.<br>- `OWA-ModernCalendarSharing`: A user used the Outlook web app to perform the meeting action.<br>- `Other EBA`: An EBA performed the meeting action.<br>- `Transport`: The meeting action occurred while the calendar item was in transport. |
| LogClientInfoString | Long name of the client that performed the action on a calendar item. |
| TriggerAction\* | Upstream action that triggered the meeting action, such as:<br>- `Create`: A user creates a calendar item.<br>- `Update`: A user updates a calendar item.<br>- `Move`: A user moves a calendar item to a different Outlook folder.<br>- `MoveToDeletedItems`: A user moves a calendar item to the Deleted Items folder in Outlook.<br>- `SoftDelete`: A user soft-deletes a calendar item.<br>- `HardDelete`: A user hard-deletes a calendar item.<br>Trigger actions frequently occur in pairs, separated by a few seconds. For example:<br>- A `Create` trigger action for a meeting is usually followed by a `Create` or `Update` trigger action on an IPM.Appointment meeting item.<br>- A `Create` trigger action for an acceptance is usually followed by an `Update` trigger action on IPM.Appointment to set its free/busy status to Busy.<br>- A `Transport` trigger action that occurs when an attendee sends a meeting request response is usually followed by an `Update` trigger action on `IPM.Appointment`. |
| ItemClass\* | Class of the calendar item, such as:<br>- `IPM.Appointment`: Meeting item.<br>- `IPM.Schedule.Meeting.Request`: Meeting request item.<br>- `IPM.Schedule.Meeting.Canceled`: Meeting cancellation item. For this item class, only the `Create` trigger action is of interest.<br>- `IPM.Schedule.Meeting.Notification.Forward`: Meeting forward notification item that's generated when a meeting is forwarded to a new user. For this item class, only the Create trigger action is of interest.<br>- `IPM.Schedule.Meeting.Resp.Pos`: Accepted meeting response item. For this item class, only the Create trigger action is of interest.<br>- `IPM.Schedule.Meeting.Resp.Tent`: Tentative meeting response item. For this item class, only the Create trigger action is of interest.<br>- `IPM.Schedule.Meeting.Resp.Neg`: Declined meeting response item. For this item class, only the Create trigger action is of interest.<br>**Note**: Unless you're troubleshooting a response tracking issue, you can ignore the `IPM.Schedule.Meeting.Resp.Pos/Tent/Neg` item classes. |
| Seq:Exp:ItemVersion | Compound value that consists of: <br>- AppointmentSequenceNumber: Sequence number of an appointment or meeting. Updated on major changes to the time, date, or location.<br>- ExceptionNumber: Sequence number of an exception. <br>- ItemVersion: Version of the calendar item. |
| Organizer\* | Email address of the organizer of an appointment or meeting. For a meeting response, the organizer is the user that replied. |
| From | SMTP address of the organizer of an appointment or meeting. |
| FreeBusyStatus | The free/busy status of a calendar item, such as:<br>- `Free`<br>- `Busy`<br>- `Tentative`<br>- `Out of office` |
| ResponsibleUser\* | User or component that's responsible for the meeting action. |
| Sender | SMTP address of the calendar item sender. |
| LogFolder | Mailbox folder in which the log entry was found. Typically, you can ignore this column.<br>**Note**: Log entries in the `Calendar Logging` folder are removed after 31 days. |
| OriginalLogFolder | Mailbox folder that the calendar item was originally delivered to. |
| SharedFolderName | <br>- If the folder is shared, the value is the name of the folder owner.<br>- If the folder isn't shared, the value is `Not Shared`. |
| IsFromSharedCalendar | Boolean value that indicates whether the calendar item is from a shared calendar. |
| ExternalSharingMasterId | Unique identifier of the master calendar item that is shared externally. If the CDL entry is from another mailbox, the value is `NotFound`. |
| ReceivedBy | Email address of the recipient of the calendar item, or a blank value. Typically, you can ignore this column. |
| ReceivedRepresenting | Email address of the delegate that received the calendar item on behalf of the recipient. |
| MeetingRequestType | Type of meeting request, such as:<br>- `NewMeetingRequest`<br>- `FullUpdate`<br>- `InformationalUpdate`<br>- `Response` |
| StartTime\* | Start time of the meeting. |
| EndTime | End time of the meeting. |
| OriginalStartDate | Original start date of the meeting. Unless a meeting is rescheduled, the value is blank. |
| TimeZone | Time zone of the meeting. |
| Location | Location of the meeting. |
| CalendarItemType | Type of calendar item, such as:<br>- `Single`: Nonrecurring calendar item.<br>- `Occurrence`: Recurring calendar item.<br>- `RecurringMaster`: Parent of a set of recurring calendar items. |
| IsException | Boolean value that indicates whether the calendar item is an exception to a recurring calendar series. |
| RecurrencePattern | Recurrence frequency of the calendar item, such as:<br>- `DailyRecurrence`: Recurrence frequency in days.<br>- `WeeklyRecurrence`: Recurrence frequency in weeks and days.<br>- `RelativeMonthlyRecurrence`: Relative monthly recurrence pattern.<br>- `AbsoluteYearlyRecurrence`: Yearly recurrence pattern.<br>If the calendar item is nonrecurring, the value is blank. |
| AppointmentAuxiliaryFlags | Set of flags that provide additional information about the appointment or meeting. If no flags apply, the value is blank. |
| DisplayAttendeesAll | List of attendees for a meeting request. For other calendar items, the value is `NotFound`. |
| AttendeeCount | Number of attendees. |
| AppointmentState | Compound value of appointment or meeting states such as:<br>- `Meeting`<br>- `Received`<br>- `Cancelled`<br>For example, the value might be `Meeting, Cancelled` to indicate that a meeting was canceled. |
| ResponseType\* | Attendee response type, such as:<br>- `None`<br>- `Organizer`<br>- `Tentative`<br>- `Accept`<br>- `Decline`<br>- `NotResponded` |
| ClientIntent | Intent of the client application that performed the action that triggered the log entry, such as:<br>- `None`<br>- `MeetingMessageDelivery`<br>The value doesn't specify many intents and is often blank. |
| AppointmentRecurring | Boolean value that indicates whether the appointment or meeting is recurring. |
| HasAttachment | Boolean value that indicates whether the calendar item has any attachments. |
| IsCancelled | Boolean value that indicates whether the calendar item is canceled. |
| IsAllDayEvent | Boolean value that indicates whether the calendar item is an all-day event. |
| IsSeriesCancelled | Boolean value that indicates whether the entire series of the recurring calendar item is canceled. For nonrecurring calendar items, the value is blank. |
| SendMeetingMessagesDiagnostics | Compound value that provides meeting change metrics that you can use to diagnose why a meeting update wasn't sent to all meeting participants. For example, consider the following value:
`RID=194b9d80-3a78-732c-3365-26041d4e76ec;SMMM=2;OAC=4;NAC=;AC=False;IIOM=;PC=4(Item.Body,Item.Subject)`<br>In the example, the significant metrics are:<br>- **SMMM**:<br>- `0`: A meeting update notification isn't sent to any attendee.<br>- `1`: A meeting update notification is sent to only added or removed attendees.<br>- `2`: A meeting update notification is sent to all attendees.<br>- **OAC**: Original number of meeting attendees.<br>- **NAC**: New number of meeting attendees. If the number is unchanged, the value is blank.<br>- **AC**: Boolean value that indicates whether the attendee list changed.<br>- **PC**: Number of meeting properties that changed, and a partial list of the changed properties. Changed properties such as `Item.Body` or `Item.Subject` are significant enough to trigger a system-generated meeting update notification to all attendees.<br>**Note**: Some compound values might be blank. |
| AttendeeCollection | List of attendees and the details of their responses, such as:<br>- Attendee email address<br>- Attendee type, such as:<br>- `0`: Unspecified<br>- `1`: Required<br>- `2`: Optional<br>- `3`: Resource<br>- Attendee response type, such as:<br>- `0`: None<br>- `1`: Organizer<br>- `2`: Tentative<br>- `3`: Accept<br>- `4`: Decline<br>- `5`: Not responded<br>- UTC timestamp of the attendee response<br>If you don't use the `-TrackingLogs` switch when you run the Get-CalendarDiagnosticObjectsSummary.ps1 script, the value is blank. |
| CalendarLogRequestId | Unique identifier of the calendar log request. |
| CleanGlobalObjectId | Unique immutable meeting ID. |

### Enhanced CDL worksheet filters

Because CDLs often contain a large amount of data, we recommend that you filter out unnecessary information before you begin your analysis. To filter a CDL, follow these steps:

1. Filter the **LogType** column to only show `Core` entries.

2. Filter the **ItemClass** column to remove the following entries:

   - `Meeting.Response`
   - `IPM.Schedule.Meeting.Notification.Forward`

3. Filter the **LogTimestamp** column to remove log entries that are outside the period of interest.
