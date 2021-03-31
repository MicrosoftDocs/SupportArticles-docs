---
title: Custom code that is allowed for use
description: Provides a solution to an error that occurs when you try to upload a custom FetchXML report into a Microsoft Dynamics CRM Online organization.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# Custom code that is allowed for use in Microsoft Dynamics CRM Online FetchXML Reports

This article provides a solution to an error that occurs when you try to upload a custom FetchXML report into a Microsoft Dynamics CRM Online organization.

_Applies to:_ &nbsp; Microsoft Dynamics CRM  
_Original KB number:_ &nbsp; 2600639

## Symptoms

You may receive an error when you try to upload a custom FetchXML report into a Microsoft Dynamics CRM Online organization:

> Error Uploading Report  
An error occurred while trying to add the report to Microsoft Dynamics CRM.  
>
> Try this action again. If the problem Continues, check the Microsoft Dynamics CRM Community for solutions or contact your organization's Microsoft Dynamics CRM Administrator. Finally you can contact Microsoft Support.

## Cause

Microsoft Dynamics CRM Online uses RDL Sandboxing that prevents reports from uploading or running if they contain code that uses disallowed methods.

## RDL Sandboxing

Reports in Microsoft Dynamics CRM Online run in sandbox mode, and to do it, RDL sandboxing is enabled in Microsoft SQL Server Reporting Services. So certain features might not be available in Microsoft Dynamics CRM Online. For example, custom code in your report definition won't work. For more information, see [Enable and disable RDL sandboxing for Reporting Services in SharePoint integrated mode](/sql/reporting-services/report-server-sharepoint/enable-and-disable-rdl-sandboxing).

When RDL Sandboxing is enabled, the following features are disabled:

- Custom code in the \<Code> element of a report definition
- RDL backward compatibility mode for SQL Server 2005 Reporting Services custom report items
- Named parameters in expressions such as DateFormat or NameSpace

## Resolution

When RDL Sandboxing is enabled, only certain classes and methods can be used in a custom FetchXML report. The following list is the classes that are allowed, and beneath each class are the available methods for use in Microsoft Dynamics CRM Online reports:

1. Microsoft.VisualBasic.Interaction (For more information, see [Interaction](/dotnet/api/microsoft.visualbasic.interaction))

   - IIF
   - Partition
   - ToString

2. Microsoft.VisualBasic.Information (For more information, see: [Information](/dotnet/api/microsoft.visualbasic.information))

   - IsArray
   - IsDate
   - IsNothing
   - IsNumeric
   - IsReference
   - QBColor
   - RGB
   - ToString
   - TypeName
   - VarType

3. Microsoft.VisualBasic.Strings (For more information, see [Strings](/dotnet/api/microsoft.visualbasic.strings))

   - Asc
   - AscW
   - Chr
   - ChrW
   - Format
   - FormatCurrency
   - FormatDateTime
   - FormatNumber
   - FormatPercent
   - InStr
   - InStrRev
   - Join
   - Lcase
   - Left
   - Len
   - LTrim
   - Mid
   - Replace
   - Right
   - RTrim
   - Space
   - Split
   - StrComp
   - StrReverse
   - ToString
   - Trim
   - UCase

4. Microsoft.VisualBasic.DateInterval (For more information, see [DateInterval Enum](/dotnet/api/microsoft.visualbasic.dateinterval))
   - Year
   - Quarter
   - Month
   - Day
   - WeekOfYear
   - WeekDay
   - Hour
   - Minute
   - Second

5. Microsoft.VisualBasic.DateAndTime  (For more information, see [DateAndTime](/dotnet/api/microsoft.visualbasic.dateandtime))

   - DateAdd
   - DateDiff
   - DateValue
   - Day
   - Hour
   - Minute
   - Month
   - MonthName
   - Second
   - DatePart
   - DateSerial
   - TimeSerial
   - TimeValue
   - ToString
   - Weekday
   - WeekdayName
   - Year

6. Microsoft.VisualBasic.Financial (For more information, see [Financial](/dotnet/api/microsoft.visualbasic.financial))

   - DDB
   - FV
   - IPmt
   - NPer
   - Pmt
   - PPmt
   - PV
   - Rate
   - SLN
   - SYD
   - ToString

7. Microsoft.VisualBasic.Conversion (For more information, see [Conversion](/dotnet/api/system.dbnull/dotnet/api/microsoft.visualbasic.conversion))

   - CTypeDynamic
   - Hex
   - Oct
   - Str
   - ToString
   - Val

8. System.DbNull (For more information, see [DBNull](/dotnet/api/system.dbnull))

   - GetObjectData
   - ToString

9. System.Globalization.CultureInfo (For more information, see [CultureInfo](/dotnet/api/system.globalization.cultureinfo))

   - ClearCachedData
   - Clone
   - CreateSpecificCulture
   - GetConsoleFallbackUICulture
   - GetCultureInfo
   - GetCultureInfoByLeftLanguageTag
   - GetCultures
   - GetFormat
   - ReadOnly
   - ToString

10. System.Math (For more information, see [Math](/dotnet/api/system.math))

    - Abs
    - Atan
    - Cos
    - Exp
    - Floor
    - Log
    - Log10
    - Max
    - Min
    - Round
    - Sign
    - Sin
    - Sqrt
    - Tan

11. System.String (For more information, see [String](/dotnet/api/system.string))

    - Clone
    - CompareOrdinal
    - Concat
    - Contains
    - Copy
    - CopyTo
    - EndsWith
    - Format
    - GetEnumerator
    - IndexOf
    - IndexOfAny
    - Insert
    - Intern
    - IsInterned
    - IsNormalized
    - IsNullOrEmpty
    - IsNullOrWhiteSpace
    - Join
    - LastIndexOf
    - LastIndexOfAny
    - Normalize
    - PadLeft
    - PadRight
    - Split
    - StartsWith
    - Substring
    - ToCharArray
    - ToLower
    - ToLowerInvariant
    - ToString
    - ToUpper
    - ToUpperInvariant
    - Trim
    - TrimEnd
    - TrimStart

12. System.Text.RegularExpressions.Match (For more information, see: [Match](/dotnet/api/system.text.regularexpressions.match))

    - ToString

13. System.Text.RegularExpressions.Regex (For more information, see [Regex](/dotnet/api/system.text.regularexpressions.regex))

    - Match
    - Replace
    - Split
    - ToString
