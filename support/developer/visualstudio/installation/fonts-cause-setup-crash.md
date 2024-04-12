---
title: Visual Studio setup crashes due to fonts
description: This article works around a problem in which Visual Studio setup crashes. This problem occurs because of a font issue.
ms.date: 04/22/2020
ms.custom: sap:Installation\Setup, maintenance, or uninstall
ms.reviewer: selmai, nahals, shibanib, rflaming
---
# Visual Studio setup crashes with an exception after the splash screen is shown

This article helps you resolve the Microsoft Visual Studio setup crash problem after the splash screen is shown.

_Original product version:_ &nbsp; Visual Studio 2012, 2013  
_Original KB number:_ &nbsp; 2978135

## Summary

This problem may occur because there are issues with certain fonts on your system, such as invalid characters in the font path or invalid file timestamps. You can use this information in this article to determine whether you're hitting this problem and resolve the problem as needed.

## Diagnose whether fonts are causing this crash

To do this, you have to open the Visual Studio setup log file and look for a particular exception near the end of the log. You can find the setup log file in your `%TEMP%` directory. The Visual Studio setup log file is typically one of the latest log files in your `%TEMP%` directory. The name of the Visual Studio setup log file has the following pattern:  
dd_<**EXE name**>_<**Time stamp**>.log

The <**Time stamp**> token in the log name pattern has the time format: yyyymmddhhmmss. The <**EXE name**> token in the log name pattern is the same name as the setup executable. The setup executable name varies by the name of the Visual Studio product that you tried to install. The following are examples of the value in the <**Exe name**> token:

|Visual Studio product short name|\<EXE name> value|
|---|---|
|Ultimate|vs_ultimate|
|Premium|vs_premium|
|Professional|vs_professional|
|Windows Express|winexpress_full|
|Web Express|vns_full|
|Desktop Express|wdexpress_full|
  
As soon as you find the Visual Studio setup log, you have to look for one of the following messages that are logged near the end of the log file:

|Exception type|Messages|
|---|---|
|Invalid font name or path|[70B4:8A7C][<**Time stamp**>]e000: MUX: ERROR: The type initializer for 'System.Windows.Media.FontFamily' threw an exception.<br/><br/>[70B4:8A7C][<**Time stamp**>]e000: MUX: Stack: at System.Windows.Media.Typeface..ctor(FontFamily fontFamily, FontStyle style, FontWeight weight, FontStretch stretch)<br/>at MS.Internal.Text.DynamicPropertyReader.GetTypeface(DependencyObject element)<br/>at MS.Internal.Text.TextProperties.InitCommon(DependencyObject target)<br/>at MS.Internal.Text.TextProperties..ctor(FrameworkElement target, Boolean isTypographyDefaultValue)|
|Invalid font time stamp|[70B4:8A7C][<**Time stamp**>]e000: MUX: ERROR: The type initializer for 'System.Windows.Media.FontFamily' threw an exception.<br/><br/>[70B4:8A7C][<**Time stamp**>]e000: MUX: Stack: at System.Windows.Media.Typeface..ctor(FontFamily fontFamily, FontStyle style, FontWeight weight, FontStretch stretch)<br/>at MS.Internal.Text.DynamicPropertyReader.GetTypeface(DependencyObject element)<br/>at MS.Internal.Text.TextProperties.InitCommon(DependencyObject target)<br/>at MS.Internal.Text.TextProperties..ctor(FrameworkElement target, Boolean isTypographyDefaultValue)|
  
## Workaround

To work around this problem, check whether there are invalid characters in your font paths, and then check whether there are invalid file timestamps in your fonts. To do this, follow these steps:

### Check for invalid characters in the font paths

1. Locate the following registry key by using Registry Editor:  
   `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts`
2. Examine the individual font paths to see whether there are any invalid characters, such as ":." If there are invalid characters, correct them, and then retry the Visual Studio setup.

### Check for invalid file timestamps in the fonts

1. Open a command prompt, and then locate the `%WINDIR%\Font` directory:
2. List the fonts in this directory by using the `DIR` command.
3. Look for any invalid timestamps, such as _01/02/20145_ for font <**Bad font**>.TTF.
4. If there are invalid timestamps, correct them. To do this, follow these steps:
    1. Open an elevated PowerShell window, and then input the following command in order to fix the font with the invalid time stamp, substituting your font file name for <**Bad font**>.TTF:

        ```powershell
        (Get-Item "C:\Windows\Fonts\<Bad font>.TTF").LastWriteTime = "01/01/2014"
        ```

    1. Repeat the steps for all fonts by using invalid timestamps, and then retry the Visual Studio setup.

## Status

Microsoft has confirmed that this is a problem in Visual Studio 2012 and 2013.
