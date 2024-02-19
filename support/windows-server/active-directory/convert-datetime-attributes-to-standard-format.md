---
title: How to convert date/time attributes in Active Directory to standard time format
description: Describes how attributes that contain a date/time value can be converted to standard meaningful date/time formats.
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
# How to convert date/time attributes in Active Directory to standard time format

This article describes how attributes that contain a date/time value can be converted to standard meaningful date/time formats.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 555936

## Summary

The Active Directory stores date/time values as the number of 100-nanosecond intervals that have elapsed since the 0 hour on January 1, 1601 until the date/time that is being stored. The time is always stored in Greenwich Mean Time (GMT) in the Active Directory. Some examples of Active Directory attributes that store date/time values are **LastLogon**, **LastLogonTimestamp**, and **LastPwdSet**. In order to obtain the date/time value stored in these attributes into a standard format, some conversion is required. This article describes how this conversion can be done.

## Procedure

1. Obtain the value of the Active Directory attribute that you want to convert. There are many ways to extract values of Active Directory attributes. Using ADSI Edit is one method.
2. Open the **Command Prompt**.
3. Type the following command:  
    `w32tm.exe /ntte [time in Windows NT time format]`
4. The date/time value is converted to local time and displayed.

## Example

The command `w32tm.exe /ntte 128271382742968750` will yield "148462 05:57:54.2968750 - 6/24/2007 8:57:54 AM (local time)" on a computer that is in a time zone three hours ahead of Greenwich Mean Time (GMT +3:00). Notice that the first half of the output displays the time in GMT (05:57:54) and then converts it by adding the Time Zone Offset (8:57:54).

## Community solutions content disclaimer

Microsoft corporation and/or its respective suppliers make no representations about the suitability, reliability, or accuracy of the information and related graphics contained herein. All such information and related graphics are provided "as is" without warranty of any kind. Microsoft and/or its respective suppliers hereby disclaim all warranties and conditions with regard to this information and related graphics, including all implied warranties and conditions of merchantability, fitness for a particular purpose, workmanlike effort, title, and non-infringement. You specifically agree that in no event shall Microsoft and/or its suppliers be liable for any direct, indirect, punitive, incidental, special, consequential damages or any damages whatsoever including, without limitation, damages for loss of use, data or profits, arising out of or in any way connected with the use of or inability to use the information and related graphics contained herein, whether based on contract, tort, negligence, strict liability or otherwise, even if Microsoft or any of its suppliers has been advised of the possibility of damages.
