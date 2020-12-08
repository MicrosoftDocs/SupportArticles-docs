---
title: How to convert date/time attributes in Active Directory to standard time format
description: 
ms.date: 12/03/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: 
---
# How to convert date/time attributes in Active Directory to standard time format

_Original product version:_ &nbsp; Microsoft Windows Server 2003 Standard Edition (32-bit x86), Microsoft Windows Server 2003 Web Edition, Microsoft Windows Server 2003 Enterprise Edition for Itanium-based Systems, Microsoft Windows Server 2003 Enterprise Edition (32-bit x86), Microsoft Windows Server 2003 Datacenter Edition (32-bit x86), Microsoft Windows XP Professional  
_Original KB number:_ &nbsp; 555936

## Author:

Shijaz Abdulla MVP

## COMMUNITY SOLUTIONS CONTENT DISCLAIMER

MICROSOFT CORPORATION AND/OR ITS RESPECTIVE SUPPLIERS MAKE NO REPRESENTATIONS ABOUT THE SUITABILITY, RELIABILITY, OR ACCURACY OF THE INFORMATION AND RELATED GRAPHICS CONTAINED HEREIN. ALL SUCH INFORMATION AND RELATED GRAPHICS ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND. MICROSOFT AND/OR ITS RESPECTIVE SUPPLIERS HEREBY DISCLAIM ALL WARRANTIES AND CONDITIONS WITH REGARD TO THIS INFORMATION AND RELATED GRAPHICS, INCLUDING ALL IMPLIED WARRANTIES AND CONDITIONS OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, WORKMANLIKE EFFORT, TITLE AND NON-INFRINGEMENT. YOU SPECIFICALLY AGREE THAT IN NO EVENT SHALL MICROSOFT AND/OR ITS SUPPLIERS BE LIABLE FOR ANY DIRECT, INDIRECT, PUNITIVE, INCIDENTAL, SPECIAL, CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER INCLUDING, WITHOUT LIMITATION, DAMAGES FOR LOSS OF USE, DATA OR PROFITS, ARISING OUT OF OR IN ANY WAY CONNECTED WITH THE USE OF OR INABILITY TO USE THE INFORMATION AND RELATED GRAPHICS CONTAINED HEREIN, WHETHER BASED ON CONTRACT, TORT, NEGLIGENCE, STRICT LIABILITY OR OTHERWISE, EVEN IF MICROSOFT OR ANY OF ITS SUPPLIERS HAS BEEN ADVISED OF THE POSSIBILITY OF DAMAGES.

## SUMMARY

*This article describes how attributes containing a date/time value can be converted to standard meaningful date/time formats.*  

## Abstract

The Active Directory stores date/time values as the number of 100-nanosecond intervals that have elapsed since the 0 hour on January 1, 1601 till the date/time that is being stored. The time is always stored in Greenwich Mean Time (GMT) in the Active Directory. Some examples of Active Directory attributes that store date/time values are **LastLogon**, **LastLogonTimestamp** and **LastPwdSet**. In order to obtain the date/time value stored in these attributes into a standard format, some conversion is required. This article describes how this conversion can be done.

## Procedure


1. Obtain the value of the Active Directory attribute that you want to convert. There are many ways to extract values of Active Directory attributes. Using ADSI Edit is one method.
2. Open the **Command Prompt**.
3. Type the following command: **w32tm.exe /ntte** [time in Windows NT time format]
4. The date/time value is converted to local time and displayed.

## Example

The command

**w32tm.exe /ntte 128271382742968750**  

will yield

**148462 05:57:54.2968750 - 6/24/2007 8:57:54 AM (local time)**  

on a computer that is in a time zone three hours ahead of Greenwich Mean Time (GMT +3:00). Notice that the first half of the output displays the time in GMT (05:57:54) and then converts it by adding the Time Zone Offset (8:57:54).
