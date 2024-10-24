---
title: Get the ID of a meeting
description: Discusses how to get the ID of a meeting in Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Calendaring
  - Exchange Online
  - CSSTroubleshoot
  - CI 1020
ms.reviewer: mburuiana, shanefe, meerak, v-trisshores
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
search.appverid: MET150
ms.date: 10/22/2024
---

# Get the ID of a meeting

The meeting ID is a unique identifier that can be used to [get Calendar diagnostic logs](./get-calendar-diagnostic-logs.md#use-the-get-calendardiagnosticobjectssummaryps1-script) (CDLs) for a specific meeting. Although you can use the subject of a meeting to get the CDLs, that approach generates less-detailed CDLs for all the meetings that match the subject. Therefore, we recommend that you use the meeting ID to get CDLs.

> [!TIP]
> The meeting ID is a GUID that starts with `040000008200`, such as `040000008200E00074C5B7101A82E00800000000A0D1E89273EFDA010000000000000000100000002D9427567554FA4AA9162A58A8B968CB`.

You can use [non-admin](#non-admin-methods) or [admin methods](#admin-methods) to get the meeting ID.

## Non-admin methods

Select one of the following methods, depending on your Outlook client:

- [Classic Outlook for Windows](#classic-outlook-for-windows)
- [New Outlook for Windows](#new-outlook-for-windows)
- [Outlook for Mac](#outlook-for-mac)
- [Outlook on the web](#outlook-on-the-web)

### Classic Outlook for Windows

1. Find the meeting in your Outlook calendar, and then open it. If the meeting is a recurring meeting, and you want the meeting ID of the entire series, select **The entire series** when you're prompted. Otherwise, if you want the meeting ID of a single meeting in the series, select **Just this one**.

2. In the meeting window, select **File** > **Save as**, and then select **Save** to save the meeting item as an .ics file.

3. Open the .ics file in a text editor, and then search for `UID:`. The UID value is the meeting ID, as shown in the following example:

   > UID:040000008200E00074C5B7101A82E00800000000A0D1E89273EFDA010000000000000000100000002D9427567554FA4AA9162A58A8B968CB

### New Outlook for Windows

1. Locate one of the following meeting notifications in your Inbox or Deleted Items folder:

   - Meeting invitation
   - Attendee response
   - Meeting update
   - Meeting cancellation

2. Right-click the meeting item, select **Save as**, and then select **Save** to save the meeting item to a folder on your computer as an .eml file.

3. Open the .eml file in a text editor, and then search for `UID=`. If the text exists, the UID value is the meeting ID. If the text doesn't exist, go to the next step.

4. Search for a Base64-encoded text block that begins with `QkVHSU46VkNBTEVOREFS` and ends with `=`, and then decode the text block. You can decode Base64-encoded text by using either of the following methods:

   - Run the following PowerShell code:

      ```PowerShell
      $base64Text = "<Base64-encoded text>"
      $decodedText = [Text.Encoding]::Utf8.GetString([Convert]::FromBase64String($base64Text))
      $decodedText | findstr "UID:"
      ```

      **Note**: The Base64-encoded text block can contain spaces, so make sure that you surround the text block by using quotation marks.

   - Use a desktop app. For example, if you have [MFCMAPI](https://github.com/stephenegriffin/mfcmapi/releases) installed, select **Tools** > **Hex editor** to open the **Hex Editor** window, and then paste the Base64-encoded text into the **Base 64** section of the **Hex Editor** window. The decoded text appears in the **Text (Ansi/Unicode)** section of the **Hex Editor** window.

   The following screenshot shows an example of the Base64-encoded text block in an .eml file.

   :::image type="content" source="media/get-meeting-id/base64-encode-text-block.png" border="true" alt-text="Screenshot of a Base64-encoded text block." lightbox="media/get-meeting-id/base64-encode-text-block-lrg.png":::

5. In the decoded text, search for `UID:`. The UID value is the meeting ID, as shown in the following example:

   > UID:040000008200E00074C5B7101A82E00800000000A0D1E89273EFDA010000000000000000100000002D9427567554FA4AA9162A58A8B968CB

### Outlook for Mac

> [!NOTE]
> This method applies to both the new Outlook for Mac and the classic Outlook for Mac.

1. Find the meeting in your Outlook calendar, and then drag the meeting from your Outlook calendar to a folder on your computer. This action saves the meeting item as an .ics file in the folder.

2. Open the .ics file in a text editor, and then search for `UID:`. The UID value is the meeting ID, as shown in the following example:

   > UID:040000008200E00074C5B7101A82E00800000000A0D1E89273EFDA010000000000000000100000002D9427567554FA4AA9162A58A8B968CB

### Outlook on the web

Use either of the following methods.

> [!TIP]
> Select Method A if your Outlook Inbox or Deleted Items folder contains a meeting notification, such as a meeting invitation, attendee response, meeting update, or meeting cancellation. Otherwise, select Method B.

- Method A: Use the same steps that are provided for the [new Outlook for Windows](#new-outlook-for-windows).
- Method B: Use the [network tool](/microsoft-edge/devtools-guide-chromium/network/) in Microsoft Edge, as described in the following steps:

   1. [Open your calendar](https://outlook.office.com/calendar/view/month) in the Edge browser, but don't select the meeting.

   2. In the browser menu, select **More tools** > **Developer tools** to open the developer tools pane.

   3. On the **Network** tab, select the **Filter** icon, and then enter _GetCalendarEvent_ in the filter box, as shown in the following screenshot.

      :::image type="content" source="media/get-meeting-id/network-devtools.png" border="true" alt-text="Screenshot of the network tool in the Edge browser." lightbox="media/get-meeting-id/network-devtools.png":::

   4. Select (single-click) any day in the calendar, and then select the meeting. A network request entry should appear in the **Name** column.

   5. Select the entry in the **Name** column, and then select the **Response** tab. The **UID** value in the body of the response is the meeting ID.

   > [!NOTE]
   > If you select the wrong meeting and have to start over, refresh the webpage, and then repeat steps 4 and 5.

## Admin methods

Select one of the following methods, depending on whether you know the subject of the meeting:

- [Subject is available](#subject-is-available)
- [Subject isn't available](#subject-isnt-available)

### Subject is available

Run the following commands in [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell) to get the meeting ID for meetings that match the search criteria. The search criteria are the subject of the meeting and the user ID of a meeting participant. The code uses the [Get-CalendarDiagnosticObjects](/powershell/module/exchange/get-calendardiagnosticobjects) cmdlet to get the start time and ID of each meeting.

```PowerShell
$meetingSubject = "<subject of the meeting>"
$userId = "<ID of a user who has the meeting in their calendar>"
$cdls = Get-CalendarDiagnosticObjects -Identity $userId -Subject $meetingSubject -ExactMatch $true
$cdls | Sort -Unique CleanGlobalObjectId | FL SubjectProperty, CleanGlobalObjectId, StartTime
```

For each meeting that's listed in the output, the value of the **CleanGlobalObjectId** parameter is the meeting ID, as shown in the following screenshot.

:::image type="content" source="media/get-meeting-id/get-calendardiagnosticobjects.png" border="true" alt-text="Screenshot of the Get-CalendarDiagnosticObjects cmdlet output." lightbox="media/get-meeting-id/get-calendardiagnosticobjects-lrg.png":::

If the output lists multiple meetings, ask the user to confirm the meeting time.

### Subject isn't available

Select either of the following methods:

- [Use Exchange Online PowerShell](#use-exchange-online-powershell)
- [Use Microsoft Graph PowerShell](#use-microsoft-graph-powershell)

#### Use Exchange Online PowerShell

Run the following commands in [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell) to get the meeting ID for meetings that match the search criteria. The search criteria are the meeting time and the user ID of a meeting participant. The code uses the Get-CalendarViewDiagnostics and [Get-CalendarDiagnosticObjects](/powershell/module/exchange/get-calendardiagnosticobjects) cmdlets to get the subject and ID of each meeting.

```PowerShell
$meetingStartUtc = "MM/DD/YYYY HH:MM:SSZ"  # 'Z' means UTC time.
$userId = "<ID of a user who has the meeting in their calendar>"
$cvds = Get-CalendarViewDiagnostics $userId -WindowStartUtc $([DateTime]$meetingStartUtc).AddHours(-1) -WindowEndUtc $([DateTime]$meetingStartUtc).AddHours(1)
$cdls = $cvds | % {Get-CalendarDiagnosticObjects $userId -MeetingId $_.GlobalObjectId -ShouldBindToItem $true}
$cdls | Group-Object CleanGlobalObjectId, SubjectProperty, {$_.StartTime.ToString()} | %{$_.Group[0]} | FL SubjectProperty, CleanGlobalObjectId, StartTime
```

> [!NOTE]
> The Get-CalendarViewDiagnostics cmdlet finds all meetings that overlap any part of the time range that's defined by the WindowStartUtc and WindowEndUtc parameters. The code example sets a two-hour range.

For each meeting that's listed in the output, the value of the **CleanGlobalObjectId** parameter is the meeting ID, as shown in the following screenshot.

:::image type="content" source="media/get-meeting-id/get-calendarviewdiagnostics.png" border="true" alt-text="Screenshot of the Get-CalendarViewDiagnostics cmdlet output." lightbox="media/get-meeting-id/get-calendarviewdiagnostics-lrg.png":::

If the output lists multiple meetings, ask the user to confirm the subject of their meeting.

#### Use Microsoft Graph PowerShell

Run the following commands in [Microsoft Graph PowerShell](/powershell/microsoftgraph/installation) to get the meeting ID for meetings that match the search criteria. The search criteria are the meeting time and the user ID of a meeting participant. The code uses the [Get-MgUserCalendarView](/powershell/module/microsoft.graph.calendar/get-mgusercalendarview) cmdlet to get the subject and ID of each meeting.

```PowerShell
$meetingStartTime = "<YYYY-MM-DDThh:mm:ssZ>" # ISO 8601 format. 'Z' means UTC time.
$userId = "<ID of a user who has the meeting in their calendar>"
Get-MgUserCalendarView -UserId $userId -StartDateTime $meetingStartTime -EndDateTime $meetingStartTime |  Select-Object -Property Subject, ICalUId -ExpandProperty Start | FL Subject, ICalUId, Datetime, Timezone
```

> [!NOTE]
> The Get-MgUserCalendarView cmdlet finds all meetings that overlap any part of the time range that's defined by the [StartDateTime](/powershell/module/microsoft.graph.calendar/get-mgusercalendarview#-startdatetime) and [EndDateTime](/powershell/module/microsoft.graph.calendar/get-mgusercalendarview#-enddatetime) parameters. For the narrowest range, pass the meeting start time to both parameters.

For each meeting that's listed in the output, the **ICalUId** parameter value is the meeting ID, as shown in the following screenshot.

:::image type="content" source="media/get-meeting-id/get-mgusercalendarview.png" border="true" alt-text="Screenshot of the Get-MgUserCalendarView cmdlet output." lightbox="media/get-meeting-id/get-mgusercalendarview-lrg.png":::

If the output lists multiple meetings, ask the user to confirm the subject of their meeting.
