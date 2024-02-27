---
title: How to use vCalendar in Outlook
description: Discusses how to create, to distribute, and to process a vCalendar file in Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: aruiz, sercast
appliesto: 
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
  - Microsoft Office Outlook 2003
  - Microsoft Exchange Server 2003 Standard Edition
  - Microsoft Exchange Server 2003 Enterprise Edition
  - Exchange Server 2010 Standard
  - Exchange Server 2010 Enterprise
search.appverid: MET150
ms.date: 01/30/2024
---
# How to use vCalendar in Outlook

_Original KB number:_ &nbsp; 287625

## Summary

Microsoft Outlook supports vCalendar, a powerful approach to electronic Personal Data Interchange (PDI). PDI occurs every time individuals communicate, in either a business or personal context. These interchanges frequently include the exchange of information, such as business cards, telephone numbers, addresses, dates and times of appointments, and such. The vCard and vCalendar features facilitate PDI electronically.

vCalendar files are used to exchange information about appointments and schedules with others who are not in your work group or organization. You can also use them to schedule appointments with those who use scheduling software incompatible with yours.

## How to create a vCalendar file

To create a vCalendar file, follow these steps.

### In Office Outlook 2007 and earlier versions

1. In a Calendar folder, select an appointment for which you want a vCalendar file.
2. On the **File** menu, select **Save As**.
3. In the **Save as type** box, select vCalendar Format (*.vcs).
4. In the **Save In** box, select the folder where you want to save the vCalendar file, and then select **Save**.

### In Outlook 2013 and Outlook 2010

1. In a Calendar folder, select an appointment for which you want a vCalendar file.
2. Select the **File** tab, on the Backstage, select **Save As**.
3. In the **Save as type** list, select vCalendar Format (*.vcs).
4. In the **Save In** list, select the folder where you want to save the vCalendar file, and then select **Save**.

## How to distribute a vCalendar file

You can distribute a vCard file like other computer files. To send it as an e-mail attachment, follow these steps.

### In Office Outlook 2007 and earlier versions

1. Open a new e-mail message, and then address it to the recipient.
2. On the **Insert** menu, select **File**.
3. Select a vCalendar (.vcs) file, and then select **OK**.

### In Outlook 2013 and Outlook 2010

1. Open a new e-mail message, and then address it to the recipient.
2. On the **Insert** tab, select **Attach File**.
3. Select a vCalendar (.vcs) file, and then select **Insert**.

## How to automatically process a vCalendar file

With Outlook, you can automatically convert a vCalendar file received from an external source into an Outlook appointment entry. If the vCalendar file arrives as an e-mail attachment, you can double-click the vCalendar, then select **Save And Close** to add the appointment to your default Calendar folder.

If you receive the vCalendar in the form of a file, perhaps on a disk, you can import it into your default Calendar folder by using the Outlook Import and Export Wizard. To do this:

### In Outlook 2007 and earlier versions

1. On the **File** menu, select **Import and Export**.
2. Select **Import an iCalendar or vCalendar file (*.vcs)**, and then select **Next**.
3. Select the vCalendar file, and then select **Open**.

### In Outlook 2010

1. On the **File** tab, select **Open**, and then select **Import**.
2. Select **Import an iCalendar (.ics) or vCalendar file (.vcs)**, and then select **Next**.
3. Select the vCalendar file, and then select **OK**.

### In Outlook 2013

1. On the **File** tab, select **Open & Export**, and then select **Import/Export**.
2. Select **Import an iCalendar (.ics) or vCalendar file (.vcs)**, and then select **Next**.
3. Select the vCalendar file, and then select **OK**.

## How to manually process a vCalendar file as a text file

A vCalendar record is just a text file. If you do not have an automated facility to process vCalendar records, you can open them with a text editor and use the information. The content of a vCalendar file varies with the information inserted by the file creator, but a typical file created from an Outlook appointment looks like the following example in a text editor:

```console
BEGIN:VCALENDAR
PRODID:-//Microsoft Corporation//Outlook MIMEDIR//EN
VERSION:1.0
BEGIN:VEVENT
DTSTART:19980114T210000Z
DTEND:19980114T230000Z
LOCATION:My office
CATEGORIES:Business
DESCRIPTION;ENCODING=QUOTED-PRINTABLE:This is a note associated with the meeting=0D=0A
SUMMARY:Meeting to discuss salaries
PRIORITY:3
END:VEVENT
END:VCALENDAR
```

> [!NOTE]
> The `DTSTART` and `DTEND` entries are a combination of the date and time in the format, *YYYYMMDDThhmmssZ*, where YYYY=year, MM=month, DD=day of the month, T=start time character, hh=hour, mm=minutes, ss=seconds, Z=end character. This string expresses the time as Greenwich Mean Time (GMT), on a 24-hour clock so must be adjusted to your time zone.

For example, if you are in the Central Time zone, your time is 6 hours behind GMT. So, you would subtract 6 hours from the start and end times to derive the correct time range for the appointment. In the previous appointment example, the start time would be 210000-060000 or 150000 on the 24-hour clock. If you converted the time to A.M or P.M, the start time is 150000-120000 or 3:00 P.M.

> [!IMPORTANT]
> For more information about how Microsoft provides support for public protocols, see [Developer Support limitations for public protocols](/exchange/troubleshoot/development/public-protocols-support-limitations).
