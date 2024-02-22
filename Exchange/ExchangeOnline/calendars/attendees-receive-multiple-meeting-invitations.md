---
title: Attendees receive multiple meeting invitations
description: Describes an issue in which multiple attendees receive multiple meeting invites for different occurrences of the same meeting from the meeting organizer.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: jmartin, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Multiple meeting invites are sent to attendees

_Original KB number:_ &nbsp; 3205555

## Problem

Attendees receive multiple meeting invites for different occurrences of the same meeting from the meeting organizer. These invites may also include instances that occurred in the past.

## Cause

This issue occurs because the meeting organizer isn't prompted about whether to update an occurrence or series when they edit a meeting from an Exchange ActiveSync client. Therefore, the client updates the series.

## Status

This is the expected behavior with the Exchange ActiveSync v16.x client. The client must send the InstanceId element when it makes a change to a single occurrence of a meeting. Otherwise, Exchange updates each instance in the series.

For additional investigation of this issue, contact the device manufacturer.

To work around this behavior, use [Microsoft Outlook for iOS](https://itunes.apple.com/us/app/microsoft-outlook/id951937596?mt=8).

## More information

Analysis of the Exchange ActiveSync mailbox logs show the change being sent by the client for the whole series. This is determined by the `InstanceId` element missing from the request.

```xml
<Commands>
    <Change>
     <ServerId>1:1</ServerId>
     <ApplicationData>
      <TimeZone xmlns="Calendar:">aAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAsAAAABAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMAAAACAAIAAAAAAAAAxP///w==</TimeZone>
      <AllDayEvent xmlns="Calendar:">0</AllDayEvent>
      <BusyStatus xmlns="Calendar:">2</BusyStatus>
      <EndTime xmlns="Calendar:">20161103T140000Z</EndTime>
      <Location xmlns="AirSyncBase:" bytes="5"/>
      <Reminder xmlns="Calendar:">15</Reminder>
      <Sensitivity xmlns="Calendar:">0</Sensitivity>
      <Subject xmlns="Calendar:" bytes="4"/>
      <StartTime xmlns="Calendar:">20161103T130000Z</StartTime>
      <MeetingStatus xmlns="Calendar:">1</MeetingStatus>
      <Attendees xmlns="Calendar:">
       <Attendee>
        <Name bytes="6"/>
        <Email bytes="18"/>
        <AttendeeType>1</AttendeeType>
       </Attendee>
       <Attendee>
        <Name bytes="22"/>
        <Email bytes="22"/>
        <AttendeeType>1</AttendeeType>
       </Attendee>
      </Attendees>
      <Recurrence xmlns="Calendar:">
       <Type>1</Type>
       <Interval>1</Interval>
       <DayOfWeek>118</DayOfWeek>
       <Until>20161202T140000Z</Until>
       <FirstDayOfWeek>0</FirstDayOfWeek>
      </Recurrence>
     </ApplicationData>
    </Change>
    <Change>
     <ServerId>1:1</ServerId>
     <InstanceId xmlns="AirSyncBase:">20161126T140000Z</InstanceId>
     <ApplicationData>
      <Body=2 bytes/>
      <StartTime xmlns="Calendar:">20161126T150000Z</StartTime>
      <EndTime xmlns="Calendar:">20161126T160000Z</EndTime>
      <Subject xmlns="Calendar:" bytes="4"/>
      <BusyStatus xmlns="Calendar:">2</BusyStatus>
      <AllDayEvent xmlns="Calendar:">0</AllDayEvent>
      <Location xmlns="AirSyncBase:" bytes="5"/>
      <Reminder xmlns="Calendar:">15</Reminder>
      <Attendees xmlns="Calendar:">
       <Attendee>
        <Name bytes="6"/>
        <Email bytes="18"/>
        <AttendeeType>1</AttendeeType>
       </Attendee>
       <Attendee>
        <Name bytes="22"/>
        <Email bytes="22"/>
        <AttendeeType>1</AttendeeType>
       </Attendee>
      </Attendees>
     </ApplicationData>
    </Change>
   </Commands>
```
