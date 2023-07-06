---
title: Update the DST information manually in SharePoint Server
description: Describes how to manually update the DST information in the time zone definition file Timezone.xml in SharePoint Server.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 176042
  - CSSTroubleshoot
ms.reviewer: nirupme,stuartp
appliesto: 
  - SharePoint Server 2016
  - SharePoint Server 2019
  - SharePoint Server Subscription Edition
search.appverid: MET150
ms.date: 7/3/2023
---

# Update the DST information manually in SharePoint Server

You need to update the time zone definition file Timezone.xml in SharePoint Server to include the latest start date and time for daylight-saving time (DST) and standard time for a locale. Usually, this information is updated for most locales when you install the latest cumulative updates for SharePoint Server. However, you might experience one of the following scenarios when the Timezone.xml file can't be updated automatically:

- The specific constraints of your environment make it difficult to install the latest cumulative updates as soon as they become available.
- The updated DST information for your locale isn't available in the latest cumulative update.
- Cumulative updates are no longer available for your version of SharePoint Server.

## Update Timezone.xml manually

If an automatic update isn't possible, update the Timezone.xml file manually on all SharePoint servers in the farm with the DST information and the standard time for the affected locales. Use the following steps:

1. Open the Timezone.xml file in Notepad from the following folder path:

   `%ProgramFiles%\Common Files\Microsoft Shared\Web Server Extensions\16\CONFIG`
1. Locate the time zone information that you want to modify, such as *(UTC+12:00) Auckland, Wellington* as in the following example:

   ```xml
   <TimeZone ID="17" Name="(UTC+12:00) Auckland, Wellington" Hidden="FALSE" KeyName="New Zealand Standard Time">
     <Bias>-720</Bias>
     <StandardTime>
       <Bias>0</Bias>
       <Date>
         <Month>3</Month>
         <Day>3</Day>
         <Hour>2</Hour>
       </Date>
     </StandardTime>
     <DaylightTime>
       <Bias>-60</Bias>
       <Date>
         <Month>10</Month>
         <Day>1</Day>
         <Hour>2</Hour>
       </Date>
     </DaylightTime>
   </TimeZone>
   ```

   When the **DayOfWeek** element isn't specified, its value is assumed to be 0, which indicates Sunday, while the value of 6 indicates Saturday. In this example, since the value of ***DayOfWeek** isn't specified, the standard time begins on the third Sunday in March while DST begins on the first Sunday in October.
1. Add a [History](/sharepoint/dev/schema/history-element-regional-settings) element to the [TimeZone](/sharepoint/dev/schema/timezone-element-regional-settings) element to preserve the existing time zone definition. In the **Year** attribute of the **History** element, specify the last year for which the time zone definition applies.
1. Update the [StandardTime](/sharepoint/dev/schema/standardtime-element-regional-settings) and [DaylightTime](/sharepoint/dev/schema/daylighttime-element-regional-settings) elements with the correct date and time for the current period.

   The following example shows the **TimeZone** element from step 2 with the following updates:

   - The standard time has been modified to the first Sunday in April at 3:00 AM.
   - The DST has been modified to the fifth (or last) Sunday of September at 2:00 AM.
   - The history of these settings is preserved for the calendar year 2006 and its previous years.

   ```xml
   <TimeZone ID="17" Name="(UTC+12:00) Auckland, Wellington" Hidden="FALSE" KeyName="New Zealand Standard Time">
     <Bias>-720</Bias>
     <StandardTime>
       <Bias>0</Bias>
       <Date>
         <Month>4</Month>
         <Day>1</Day>
         <Hour>3</Hour>
       </Date>
     </StandardTime>
     <DaylightTime>
       <Bias>-60</Bias>
       <Date>
         <Month>9</Month>
         <Day>5</Day>
         <Hour>2</Hour>
       </Date>
     </DaylightTime>
     <History Year="2006" Name="nz2007">
       <Bias>-720</Bias>
       <StandardTime>
         <Bias>0</Bias>
         <Date>
           <Month>3</Month>
           <Day>3</Day>
           <Hour>2</Hour>
         </Date>
       </StandardTime>
       <DaylightTime>
         <Bias>-60</Bias>
         <Date>
           <Month>10</Month>
           <Day>1</Day>
           <Hour>2</Hour>
         </Date>
       </DaylightTime>
     </History>
   </TimeZone>
   ```

1. Perform steps 2 to 4 for all time zones that need to be updated and save the Timezone.xml file.  

> [!NOTE]
> After you modify the Timezone.xml file, if you install a SharePoint Server update, your modified version of the Timezone.xml file may be overwritten by the update. You must manually verify that your time zone requirements are still being met and adjust as necessary.
