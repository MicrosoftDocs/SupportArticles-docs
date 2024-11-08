---
title: Analyze Calendar diagnostic logs for Exchange Online mailboxes
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
  - New Outlook for Windows
  - Outlook for Microsoft 365
  - Outlook 2024
  - Outlook 2021
  - Outlook 2019
  - Outlook 2016
  - Outlook for Mac
  - Outlook for Mac for Microsoft 365
  - Outlook for iOS
  - Outlook for Android
search.appverid: MET150
ms.date: 10/22/2024
---

# Analyze Calendar diagnostic logs for Exchange Online mailboxes

To help diagnose meeting issues for Exchange Online mailboxes, you can analyze Calendar diagnostic logs (CDLs). To get the CDLs for a meeting, see [Get calendar diagnostic logs for Exchange Online mailboxes](./get-calendar-diagnostic-logs.md).

The following sections guide you through the analysis process.

## Prerequisites

[Use the Get-CalendarDiagnosticObjectsSummary.ps1 script](./get-calendar-diagnostic-logs.md#use-the-get-calendardiagnosticobjectssummaryps1-script) to generate the following Microsoft Excel file for a meeting:

*CalLogSummary_\<short meeting ID\>.xlsx*

The file should contain the following set of worksheets for each key participant:

- `<participant SMTP address>_TimeLine`: Contains the timeline
- `<participant SMTP address>`: Contains the enhanced CDLs
- `<participant SMTP address>_Raw`: Contains the raw CDLs

> [!NOTE]
> - The script downloads and processes the raw CDLs to provide enhanced CDLs and a concise timeline of meeting actions.
> - Raw CDL analysis is outside the scope of this article.

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

| | **Column description** |
| - | - |
| **LogRow** | Row values that correspond to row numbers in the raw CDL worksheet but are offset by one because of the raw CDL worksheet header. |
| **LogTimestamp** | UTC date and time that the meeting action was logged. |
| **LogType\*** | Meeting action type:<ul><li>`Core`: An important meeting action.</li><li>`Ignorable`: A routine system action that you can ignore. For example, a meeting action that's performed by a Microsoft event-based assistant (EBA) or time-based assistant (TBA).</li><li>`Cleanup`: A routine maintenance action that you can ignore. For example, an automatic Outlook action that deletes a meeting response.</li></ul> |
| **SubjectProperty\*** | Meeting subject |
| **Client\*** | Short name of the client that performed the action on a calendar item. For example:<ul><li>`Outlook : Desktop : MAPI`: A user used the Outlook desktop client to perform the meeting action.</li><li>`OWA-ModernCalendarSharing`: A user used the Outlook web app to perform the meeting action.</li><li>`Other EBA`: An EBA performed the meeting action.</li><li>`Transport`: The meeting action occurred while the calendar item was in transport.</li></ul> |
| **LogClientInfoString** | Long name of the client that performed the action on a calendar item. |
| **TriggerAction\*** | Upstream action that triggered the meeting action, such as:<ul><li>`Create`: A user creates a calendar item.</li><li>`Update`: A user updates a calendar item.</li><li>`Move`: A user moves a calendar item to a different Outlook folder.</li><li>`MoveToDeletedItems`: A user moves a calendar item to the *Deleted Items* folder in Outlook.</li><li>`SoftDelete`: A user soft-deletes a calendar item.</li><li>`HardDelete`: A user hard-deletes a calendar item.</li></ul>Trigger actions frequently occur in pairs, separated by a few seconds. For example:<ul><li>A `Create` trigger action for a meeting is usually followed by a `Create` or `Update` trigger action on an `IPM.Appointment` meeting item.</li><li>A `Create` trigger action for an acceptance is usually followed by an `Update` trigger action on an `IPM.Appointment` meeting item to set its free/busy status to `Busy`.</li><li>A `Transport` trigger action that occurs when an attendee sends a meeting request response is usually followed by an `Update` trigger action on an `IPM.Appointment` meeting item.</li></ul> |
| **ItemClass\*** | Class of the calendar item, such as:<ul><li>`IPM.Appointment`: Meeting item.</li><li>`IPM.Schedule.Meeting.Request`: Meeting request item.</li><li>`IPM.Schedule.Meeting.Canceled`: Meeting cancellation item. For this item class, only the `Create` trigger action is of interest.</li><li>`IPM.Schedule.Meeting.Notification.Forward`: Meeting forward notification item that's generated when a meeting is forwarded to a new user. For this item class, only the `Create` trigger action is of interest.</li><li>`IPM.Schedule.Meeting.Resp.Pos`: Accepted meeting response item. For this item class, only the `Create` trigger action is of interest.</li><li>`IPM.Schedule.Meeting.Resp.Tent`: Tentative meeting response item. For this item class, only the `Create` trigger action is of interest.</li><li>`IPM.Schedule.Meeting.Resp.Neg`: Declined meeting response item. For this item class, only the `Create` trigger action is of interest.</li></ul>**Note**: Unless you're troubleshooting a response tracking issue, you can ignore the `IPM.Schedule.Meeting.Resp.Pos/Tent/Neg` item classes. |
| **Seq:Exp:ItemVersion** | Compound value that consists of:<ul><li>`AppointmentSequenceNumber`: Sequence number of an appointment or meeting. Updated on major changes to the time, date, or location.</li><li>`ExceptionNumber`: Sequence number of an exception.</li><li>`ItemVersion`: Version of the calendar item.</li></ul> |
| **Organizer\*** | Email address of the organizer of an appointment or meeting. For a meeting response, the organizer is the user that replied. |
| **From** | SMTP address of the organizer of an appointment or meeting. |
| **FreeBusyStatus** | The free/busy status of a calendar item, such as:<ul><li>`Free`</li><li>`Busy`</li><li>`Tentative`</li><li>`Out of office`</li></ul> |
| **ResponsibleUser\*** | User or component that's responsible for the meeting action. |
| **Sender** | SMTP address of the calendar item sender. |
| **LogFolder** | Mailbox folder in which the log entry was found. Typically, you can ignore this column.<br>**Note**: Log entries in the *Calendar Logging* folder are removed after 31 days. |
| **OriginalLogFolder** | Mailbox folder that the calendar item was originally delivered to. |
| **SharedFolderName** | <ul><li>If the folder is shared, the value is the name of the folder owner.</li><li>If the folder isn't shared, the value is `Not Shared`.</li></ul> |
| **IsFromSharedCalendar** | Boolean value that indicates whether the calendar item is from a shared calendar. |
| **ExternalSharingMasterId** | Unique identifier of the master calendar item that is shared externally. If the CDL entry is from another mailbox, the value is `NotFound`. |
| **ReceivedBy** | Email address of the recipient of the calendar item, or a blank value. Typically, you can ignore this column. |
| **ReceivedRepresenting** | Email address of the delegate that received the calendar item on behalf of the recipient. |
| **MeetingRequestType** | Type of meeting request, such as:<ul><li>`NewMeetingRequest`</li><li>`FullUpdate`</li><li>`InformationalUpdate`</li><li>`Response`</li></ul> |
| **StartTime\*** | Start time of the meeting. |
| **EndTime** | End time of the meeting. |
| **OriginalStartDate** | Original start date of the meeting. Unless a meeting is rescheduled, the value is blank. |
| **TimeZone** | Time zone of the meeting. |
| **Location** | Location of the meeting. |
| **CalendarItemType** | Type of calendar item, such as:<ul><li>`Single`: Nonrecurring calendar item.</li><li>`Occurrence`: Recurring calendar item.</li><li>`RecurringMaster`: Parent of a set of recurring calendar items.</li></ul> |
| **IsException** | Boolean value that indicates whether the calendar item is an exception to a recurring calendar series. |
| **RecurrencePattern** | Recurrence frequency of the calendar item, such as:<ul><li>`DailyRecurrence`: Recurrence frequency in days.</li><li>`WeeklyRecurrence`: Recurrence frequency in weeks and days.</li><li>`RelativeMonthlyRecurrence`: Relative monthly recurrence pattern.</li><li>`AbsoluteYearlyRecurrence`: Yearly recurrence pattern.</li></ul>If the calendar item is nonrecurring, the value is blank. |
| **AppointmentAuxiliaryFlags** | Set of flags that provide additional information about the appointment or meeting. If no flags apply, the value is blank. |
| **DisplayAttendeesAll** | List of attendees for a meeting request. For other calendar items, the value is `NotFound`. |
| **AttendeeCount** | Number of attendees. |
| **AppointmentState** | Compound value of appointment or meeting states such as:<ul><li>`Meeting`</li><li>`Received`</li><li>`Cancelled`</li></ul>For example, the value might be `Meeting, Cancelled` to indicate that a meeting was canceled. |
| **ResponseType\*** | Attendee response type, such as:<ul><li>`None`</li><li>`Organizer`</li><li>`Tentative`</li><li>`Accept`</li><li>`Decline`</li><li>`NotResponded`</li></ul> |
| **ClientIntent** | Intent of the client application that performed the action that triggered the log entry, such as:<ul><li>`None`</li><li>`MeetingMessageDelivery`</li></ul>The value specifies only a few intents and is often blank. |
| **AppointmentRecurring** | Boolean value that indicates whether the appointment or meeting is recurring. |
| **HasAttachment** | Boolean value that indicates whether the calendar item has any attachments. |
| **IsCancelled** | Boolean value that indicates whether the calendar item is canceled. |
| **IsAllDayEvent** | Boolean value that indicates whether the calendar item is an all-day event. |
| **IsSeriesCancelled** | Boolean value that indicates whether the entire series of the recurring calendar item is canceled. For nonrecurring calendar items, the value is blank. |
| **SendMeetingMessagesDiagnostics** | Compound value that provides meeting change metrics that you can use to diagnose why a meeting update wasn't sent to all meeting participants. For example, consider the following value:<br>`RID=194b9d80-3a78-732c-3365-26041d4e76ec;SMMM=2;OAC=4;NAC=;AC=False;IIOM=;PC=4(Item.Body,Item.Subject)`<br>In that example, the significant metrics are:<ul><li>**SMMM**<ul><li>`0`: A meeting update notification wasn't sent to any attendee.</li><li>`1`: A meeting update notification was sent to only added or removed attendees.</li><li>`2`: A meeting update notification was sent to all attendees.</li></ul></li><li>**OAC**: Original number of meeting attendees.</li><li>**NAC**: New number of meeting attendees. If the number is unchanged, the value is blank.</li><li>**AC**: Boolean value that indicates whether the attendee list changed.</li><li>**PC**: Number of meeting properties that changed, and a partial list of the changed properties. Changed properties such as `Item.Body` or `Item.Subject` are significant enough to trigger a system-generated meeting update notification to all attendees.</li></ul>**Note**: Some metrics might be blank. |
| **AttendeeCollection** | List of attendees and the details of their responses, such as:<ul><li>Attendee email address</li><li>Attendee type:<ul><li>`0`: Unspecified</li><li>`1`: Required</li><li>`2`: Optional</li><li>`3`: Resource</li></ul></li><li>Attendee response type:<ul><li>`0`: None</li><li>`1`: Organizer</li><li>`2`: Tentative</li><li>`3`: Accept</li><li>`4`: Decline</li><li>`5`: Not responded</li></ul></li><li>UTC timestamp of the attendee response</li></ul>If you don't use the `-TrackingLogs` switch when you run the Get-CalendarDiagnosticObjectsSummary.ps1 script, the value is blank. |
| **CalendarLogRequestId** | Unique identifier of the calendar log request. |
| **CleanGlobalObjectId** | Unique immutable meeting ID. |

### Enhanced CDL worksheet filters

Because CDLs often contain a large amount of data, we recommend that you filter out unnecessary information before you begin your analysis. To filter a CDL, follow these steps:

1. Filter the **LogType** column to only show `Core` entries.

2. Filter the **ItemClass** column to remove the following entries:

   - `Meeting.Response`
   - `IPM.Schedule.Meeting.Notification.Forward`

3. Filter the **LogTimestamp** column to remove log entries that are outside the period of interest.
