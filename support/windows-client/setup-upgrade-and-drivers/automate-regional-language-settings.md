---
title: Automate regional and language settings
description: Describes how to automate regional and language settings.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Windows Setup, Upgrade and Deployment\Installing or upgrading Windows, csstroubleshoot
---
# How to Automate Regional and Language settings in Windows Vista, Windows Server 2008, Windows 7 and in Windows Server 2008 R2

This article describes the regional and language settings options and the method to modify the settings.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 2764405

## Summary

This article describes the Regional and Language Settings options in Windows Vista, in Windows Server 2008, in Windows 7 and in Windows Server 2008 R2. Also, in this article you can find the method to modify the settings using an xml based answer file.

### Sample XML answer file

```xml

<gs:GlobalizationServices xmlns:gs="urn:longhornGlobalizationUnattend">

<!-- user list -->  
 <gs:UserList>
 <gs:User UserID="Current" CopySettingsToDefaultUserAcct="true" CopySettingsToSystemAcct="true"/>  
 </gs:UserList>

<!-- GeoID -->
 <gs:LocationPreferences>  
 <gs:GeoID Value="244"/>
 </gs:LocationPreferences>

<gs:MUILanguagePreferences>
 <gs:MUILanguage Value="cy-GB"/>
 <gs:MUIFallback Value="en-GB"/>
 </gs:MUILanguagePreferences>

<!-- system locale -->
 <gs:SystemLocale Name="en-US"/>

<!-- input preferences -->
 <gs:InputPreferences>
 <gs:InputLanguageID Action="add" ID="0409:00000409"/>
 <gs:InputLanguageID Action="remove" ID="0409:00000409"/>
 </gs:InputPreferences>

<!-- user locale -->
 <gs:UserLocale>
 <gs:Locale Name="en-US" SetAsCurrent="true" ResetAllSettings="false">
 <gs:Win32>
 <gs:iCalendarType>1</gs:iCalendarType>
 <gs:iCurrency>3</gs:iCurrency>
 <gs:iCurrDigits>1</gs:iCurrDigits>
 <gs:sList>...</gs:sList>
 <gs:sDecimal>;;</gs:sDecimal>
 <gs:sThousand>::</gs:sThousand>
 <gs:sGrouping>1</gs:sGrouping>
 <gs:iDigits>2</gs:iDigits>
 <gs:iNegNumber>2</gs:iNegNumber>
 <gs:sNegativeSign>(</gs:sNegativeSign>
 <gs:sPositiveSign>=</gs:sPositiveSign>
 <gs:sCurrency>kr</gs:sCurrency>
 <gs:sMonDecimalSep>,,</gs:sMonDecimalSep>
 <gs:sMonThousandSep>...</gs:sMonThousandSep>
 <gs:sMonGrouping>3</gs:sMonGrouping>
 <gs:iNegCurr>3</gs:iNegCurr>
 <gs:iLZero>0</gs:iLZero>
 <gs:sTimeFormat>:HH:m:s tt:</gs:sTimeFormat>
 <gs:s1159>a.m.</gs:s1159>
 <gs:s2359>p.m.</gs:s2359>
 <gs:sShortDate>d/M/yy</gs:sShortDate>
 <gs:sLongDate>dddd, MMMM yyyy</gs:sLongDate>
 <gs:iFirstDayOfWeek>6</gs:iFirstDayOfWeek>
 <gs:iFirstWeekOfYear>2</gs:iFirstWeekOfYear>
 <gs:sNativeDigits>0246813579</gs:sNativeDigits>
 <gs:iDigitSubstitution>1</gs:iDigitSubstitution>
 <gs:iMeasure>0</gs:iMeasure>
 <gs:iTwoDigitYearMax>2021</gs:iTwoDigitYearMax>
 </gs:Win32>
 </gs:Locale>
 </gs:UserLocale>
 </gs:GlobalizationServices>
```

## Syntax

- UserList - This setting specifies the user account for which we need to do the change settings. CopySettingsToDefaultUserAcct and CopySettingsToSystemAcct are the parameters that can be used to copy the settings to all users and also the system account(logonUI screen)
- GeoID/Location Preferences  - Updates the current location field under the location tab. Some software, including Windows may provide additional information passed on this, such as weather
- MUILanguagePreference - Supports setting the display language and, if appropriate, the display language fallbacks for the system. Set by using a child element \<gs:MUILanguage> with an attribute containing the language string. To set the fallback language of the language set using \<gs:MUILanguage>, use the element \<gs:MUIFallback>. Using this XML entity does NOT install the display languages. It should only be used for selecting display languages after they have been installed.
- SystemLocale - This setting enables programs that don't use Unicode to run and display menus and dialog boxes in the localized language. If a localized program doesn't display correctly on the computer, setting the system locale to match the language of the localized program may resolve the problem. However, this setting is system-wide, so it isn't possible to support simultaneously the localized programs that don't use Unicode for multiple languages.
- InputPreferences - This setting specifies the input locale and keyboard layout combinations. Note: Unlike in 2003/XP, for some complex languages, the usage of KLIDs to identify keyboard layouts have been replaced by GUIDs. The following link gives a table for the replacement: [From KLID to GUID (aka KLIDoral stimulation, it feels GUID)](http://archives.miloush.net/michkap/archive/2009/09/15/9894707.html)
- UserLocale - This setting controls the settings for sorting numbers, time, currency, and dates. To use .xml answer file to set language preferences:

1. Create an xml file with the required settings and save it as a file (for example: c:\unattend.xml). The .xml file should at minimum include the following:  

    ```xml
    <gs:GlobalizationServices xmlns:gs="urn:longhornGlobalizationUnattend">
     <gs:UserList>
     <gs:User UserID="Current"/>  
     </gs:UserList>
     </gs:GlobalizationServices>
    ```

2. Create a batch file by using the following command line to apply the answer file settings:  
`control.exe intl.cpl,,/f:"c:\Unattend.xml"`  

## References

Guide to Windows Vista Multilingual User Interface  
 [https://technet.microsoft.com/library/cc721887(WS.10).aspx](https://technet.microsoft.com/library/cc721887%28ws.10%29.aspx)

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
