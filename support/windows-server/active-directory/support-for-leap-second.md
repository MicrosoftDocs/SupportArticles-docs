---
title: Support for the leap second
description: Summarizes Microsoft support for the leap second.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:windows-time-service, csstroubleshoot
---
# Support for the leap second

This article provides information about Microsoft support for the leap second.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2008 R2 Service Pack 1, Windows 10, version 2004, Windows 10, version 1909, Windows 10, version 1803, Windows 10, version 1709, Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2722715

## Summary

This article contains information about Microsoft support for the leap second. The leap second is a one-second adjustment, which is occasionally applied to Coordinated Universal Time (UTC) in order to keep its time of day close to the mean solar time, or UT1.

> [!NOTE]
> Windows Server 2019 and Windows 10 October 2018 Update do support leap seconds in the platform. However, this article does not apply strictly to these or later operating systems. For more information, see:
>  
> - [Leap Second Announcement](https://techcommunity.microsoft.com/t5/networking-blog/top-10-networking-features-in-windows-server-2019-10-accurate/ba-p/339739)  
> - [Leap Second Validation for IT Pros](https://aka.ms/ITPro-LeapSecond)  
> - [Leap Second Validation for Developers](https://aka.ms/Dev-LeapSecond)  

## More information

### (1) Windows

About the OS  
Leap second processing is not handled separately by the Windows operating system (OS). For example, year, month, date, and time information in the following format is not supported by the Windows OS:

yyyy/mm/dd 08:59:60

Therefore, 2012/7/1 08:59:60 is processed as 2012/7/1 09:00:00, per the ISO 8601 format.

About the Time Synchronization Service (Windows Time Service)  
Windows Time Service does not implement a leap second even though it passes through the Leap Indicator (LI) flag from the NTP server to the server that hosts the Windows Time Service and the down-level clients that synchronize from it. The Windows Time Synchronization Service (W32Time) does not insert a leap second, and instead proceeds with the usual time synchronization process.

During the brief period that follows the introduction of a leap second on an upstream NTP server (including W32time Server), a time difference of about one second occurs between that upstream NTP server and the W32time clients that synchronize from it. The W32time clients correct their local clocks when they subsequently synchronize time from their upstream server.

For more information, see the following Microsoft Knowledge Base (KB) article:

[909614](https://support.microsoft.com/help/909614)  How the Windows Time Service treats a leap second

Additionally, in the Windows Time Service, it's not always possible to prevent the occurrence of marginal time differences, such as one second. The operating system is designed to handle time variations. Leap second variations are handled cleanly, allowing for uninterrupted execution. For more information, see the following KB article:

[939322](https://support.microsoft.com/help/939322) Support boundary to configure the Windows Time service for high-accuracy environments

About the cluster service
As for the cluster configuration, it's same as with the OS: leap second processing is not performed.

### (2) SQL Server 2000, 2005, 2008, 2008 R2, 2012, and 2014  

SQL Server does not use time data for managing internal operations such as transactions. Therefore, even if a one-second deviation occurs in the system time because of the leap second, it does not affect SQL Server operations. As with the Windows OS, SQL Server does not independently recognize the leap second.

Be aware the date data type (for example, datetime) does not support the format in which the seconds value reaches 60 such as 2012/7/1 08:59:60. Therefore, if a connection is established to SQL Server from an application that's running on an OS that supports the leap second, and the OS tries to set a leap second (data in which the second's value is 60) in the column and variable of the date data type, an error is returned. For more information, see the following "Reference information" section.

Reference information

[Example] When the leap second is handled as the date data type in the SQL Server

```sql
create table leap_second(
a int,
b datetime,
)
go
insert into [leap_second] values (1,convert(datetime,'2012/07/01 08:59:60'))
go
select convert(datetime,'2012/07/01 08:59:60')
go
select datediff(day,convert(datetime,'2012/07/01 08:59:60'),getdate())
go
declare @b datetime
set @b='2012/07/01 08:59:60'
go
declare @c time
set @c='08:59:60'
go
declare @d datetime2
set @d='2012/07/01 08:59:60'
go
declare @e datetimeoffset 
set @e='2012/07/01 08:59:60'
go
```

Result  
Message 242, Level 16, Status 3, Row 1  
As a result of conversion from the varchar data type to the datetime data type, the value is set outside the range.  
The statement has ended.

Message 242, Level 16, Status 3, Row 1  
As a result of conversion from the varchar data type to the datetime data type, the value is set outside the range.

Message 242, Level 16, Status 3, Row 1  
As a result of conversion from the varchar data type to the datetime data type, the value is set outside the range.

Message 242, Level 16, Status 3, Row 3  
As a result of conversion from the varchar data type to the datetime data type, the value is set outside the range.

Message 241, Level 16, Status 1, Row 2  
The conversion process failed during conversion from the character string to the date and time, or to either of the two.

Message 241, Level 16, Status 1, Row 2  
The conversion process failed during conversion from the character string to the date and time, or to either of the two.

Message 241, Level 16, Status 1, Row 2  
The conversion process failed during conversion from the character string to the date and time, or to either of the two.

### (3) Exchange Server 2003, 2007, 2010, and 2013  

The time that's used in Exchange Server includes the time that's measured by the system clock and the time that's calculated as the elapsed period since the start of the service. In the processing that uses the system clock, the Exchange server operates without recognizing the leap second. On the other hand (where the elapsed time period is concerned), although a difference of one second occurs with the insertion of the leap second, this deviation can occur even under normal circumstances. As with the Windows OS, Exchange Server is designed to handle minor time variations. Therefore, Exchange Server operations are not affected.

In addition to the internal operation, a schedule in the iCalendar format represents a case in which it's possible to receive (from the outside) a time value to which a leap second has been added. However, when Exchange Server receives schedules in the iCalendar format, the program supports only those formats in which the time notation is defined in compliance with [RFC 5545](https://tools.ietf.org/html/rfc5545). With regard to the leap second, the seconds notation is supported in the 060 range. If a number that's greater than 60 is specified as the seconds value, it is processed as an invalid format and is not recognized as the correct iCalendar format.

In Outlook, 60 seconds is considered 0. Therefore, 2012/07/01 08:59:60 becomes 2012/07/01 08:59:00. It means that there is a possibility of a one-minute deviation at most. In such a case, the order of reception of emails may appear to have deviated, but otherwise there is no effect on operations.

For more information, see the following:

[2.2.36 [RFC5545] Section 3.3.12 Time](/openspecs/exchange_standards/ms-stanxical/192c6400-6de5-4308-b794-b1f541b4b823)  

### (4) Internet Information Services (IIS)  

The leap second has no effect in IIS.

#### (5) Others  

Applications that are running in Windows typically use the system clock. Therefore, they can be used without consideration for the leap second.

However, if a Microsoft product is accessed from an application that manages the time on its own and that supports the leap second, or from an application that's running on an OS that supports the leap second, problems are likely to occur. This is because Microsoft products do not recognize the leap second.

Additionally, applications should not rely on the system time to increase monotonically. Instead, they should use the **GetTickCount64()** function to read the current tick count, which is the time since startup in milliseconds.
