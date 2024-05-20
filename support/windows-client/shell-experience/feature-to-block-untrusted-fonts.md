---
title: The blocking untrusted fonts feature
description: Describes a new feature that blocks untrusted fonts in Windows 10 Technical Preview.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, payalr, jerrycif
ms.custom: sap:Windows Desktop and Shell Experience\DPI and Display Issues, csstroubleshoot
---
# Windows 10 Technical Preview adds a feature that blocks untrusted fonts

This article describes a new feature that blocks untrusted fonts for Windows 10 Technical Preview. Before you use the feature, you can see the [feature introduction](#the-blocking-untrusted-fonts-feature) and the [potential reductions in functionality](#potential-reductions-in-functionality) section. Then, [follow the steps to configure the feature](#how-to-turn-on-and-use-the-feature).

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 3053676

## The blocking untrusted fonts feature

Because fonts use complex data structures and can be embedded into webpages and documents, they can be vulnerable to elevation of privilege (EOP) attacks. EOP attacks mean that a malicious hacker can remotely access a user's computer when users share files or surf the web. To strengthen security against these attacks, we have created a feature to block untrusted fonts. Using this feature, you can turn on a global setting that stops users from loading untrusted fonts that are processed by the Graphics Device Interface (GDI). Untrusted fonts are any fonts that are installed outside the `%windir%/Fonts` directory. The blocking untrusted fonts feature helps stop both remote (web-based or email-based) and local EOP attacks that can occur during the font file-parsing process.

## How does this feature work

There are three ways to use this feature:

- On.  Helps stop any font being loaded that is processed by using GDI and is installed outside the `%windir/Fonts%` directory. It also turns on event logging.

- Audit. Turns on event logging, but does not block fonts from loading, regardless of location. The names of the applications that use untrusted fonts appear in your event log.

    > [!NOTE]
    > If you are not ready to deploy this feature in your organization, you can run it in Audit mode to see if not loading untrusted fonts causes any usability or compatibility issues.

- Exclude apps to load untrusted fonts. You can exclude specific applications. It allows them to load untrusted fonts, even when the feature is turned on.

## Potential reductions in functionality

After you turn on this feature, users might experience reduced functionality in following situations:

- Sending a print job to a shared printer server that uses this feature and where the spooler process has not been excluded. In this situation, any fonts that are not already available in the server's `%windir%/Fonts` folder will not be used.

- Printing using fonts provided by the installed printer's graphics .dll file, outside the `%windir%/Fonts` folder. For more information, see [Introduction to Printer Graphics DLLs](/windows-hardware/drivers/print/introduction-to-printer-graphics-dlls).

- Using first or third-party apps that use memory-based fonts.

- Using Internet Explorer to view websites that use embedded fonts. In this situation, the feature blocks the embedded font, causing the website to use a default font. However, not all fonts have all the characters, so the website might render differently.

- Using desktop Office to view documents that have embedded fonts. In this situation, content is displayed by using a default font picked by Office.

## How to turn on and use the feature

To turn this feature on, off, or to use audit mode, use one of the following methods.

### Use Group Policy

1. Open Local Group Policy Editor.
2. Under **Local Computer Policy**, expand **Computer Configuration**, expand **Administrative Templates**, expand **System**, and then click **Mitigation Options**.
3. In the **Untrusted Font Blocking** setting, you can see the following options:
   - **Block untrusted fonts and log events**
   - **Do not block untrusted fonts**
   - **Log events without blocking untrusted fonts**

### Use Registry Editor

1. Open Registry Editor (regedit.exe) and go to the following registry subkey:

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel\`  

2. If the **MitigationOptions** key is not there, right-click and add a new **QWORD (64-bit) Value**, naming it as **MitigationOptions**.
3. Update the **Value data** of the **MitigationOptions** key, and make sure that you keep your existing value, like the important note below:
   - To turn on this feature, type 1000000000000.
   - To turn off this feature, type 2000000000000.
   - To audit with this feature, type 3000000000000.

    > [!IMPORTANT]
    > Your existing **MitigationOptions** values should be saved during your update. For example, if the current value is 1000, your updated value should be 1000000001000.

4. Restart your computer.

## View the event log

After you turn on this feature, or start using Audit mode, you can check your event logs for detailed information.

### Check the event log

1. Open the Event Viewer (eventvwr.exe) and go to the following path:

    Application and Service Logs/Microsoft/Windows/Win32k/Operational
2. Scroll down to EventID: 260 and review the relevant events.

    - Event example 1 - Microsoft Word

        > [!NOTE]
        > Because the FontType is Memory, there is no associated FontPath.

    - Event example 2 - Winlogon

        > [!NOTE]
        > Because the FontType is File, there is also an associated FontPath.

    - Event example 3 - Internet Explorer running in Audit mode

        > [!NOTE]
        > In Audit mode, the problem is recorded, but the font is not blocked.
  
## Fix apps that have problems because of blocked fonts

Users may still need apps that have problems because of blocked fonts, so we suggest that you first run this feature in Audit mode to determine which fonts are causing the problems. After you figure out the problematic fonts, you can try to fix your apps in one of two ways: by directly installing the fonts into the %windir%/Fonts directory or by excluding the underlying processes and letting the fonts load. As the default solution, we highly recommend that you install the problematic font. Installing fonts is safer than excluding apps because excluded apps can load any font, trusted or untrusted.

### Fix apps by installing the problematic fonts (recommended)

On each computer that has the app installed, right-click the font name, and then click **Install**.

The font should automatically install into your `%windir%/Fonts` directory. If it does not, you have to manually copy the font files into the Fonts directory and run the installation from there.

### Fix apps by excluding processes

1. On each computer that has the app installed, open Registry Editor and go to the following registry subkey:

    `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\<Process_Image_Name>`

    For example, if you want to exclude Microsoft Word processes, you would use `HKEY_LOCAL_MACHINE\ Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Winword.exe`.

2. If the **MitigationOptions** key is not there, right-click and add a new **QWORD (64-bit) Value**, naming it as **MitigationOptions**.
3. Add the value for the setting desired for that process:
   - To turn on this feature, type 1000000000000.
   - To turn off this feature, type 2000000000000.
   - To audit with this feature, type 3000000000000.

    > [!IMPORTANT]
    > Your existing **MitigationOptions** values should be saved during your update. For example, if the current value is 1000, your updated value should be 1000000001000.

4. Add any additional processes that need to be excluded, and then turn font blocking on by using the steps that are provided in the [Fix apps by excluding processes](#fix-apps-by-excluding-processes) section.
