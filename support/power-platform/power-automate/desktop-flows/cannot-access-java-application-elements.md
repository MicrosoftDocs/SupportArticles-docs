---
title: Can't access elements of a Java application
description: Provides resolutions for the issue that Power Automate for desktop can't access the elements of a Java desktop application.
ms.reviewer: pefelesk
ms.date: 09/30/2022
ms.subservice: power-automate-desktop-flows
---
# Can't access the elements of a Java application

This article provides resolutions for the issue that you can't access the elements of a Java desktop application in Microsoft Power Automate for desktop.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 5014922

## Symptoms

Microsoft Power Automate for desktop can't access the elements of a Java desktop application.

## Verifying issue

Make sure that you aren't able to capture an element of the application by using either the Recorder or the "Add UI element" action in the Designer.

## Cause 1: Java isn't installed on your machine

### Resolution

To solve this issue, make sure that you have Java installed. You can check this by:

- Open a command window or terminal and enter: `> java –version`.
- If Java isn't installed on your machine, you'll receive an error message:

  > 'java' is not recognized as an internal or external command, operable program or batch file.

## Cause 2: Java Access Bridge is enabled

### Resolution

To solve this issue, make sure that you've disabled the Java Access Bridge in Control Panel.

Go to **Control Panel** > **Ease of Access** > **Optimize visual display** > **Java Access Bridge from Oracle, Inc. Providing Assistive Technology access to Java applications**, and then disable (uncheck) the **Enable Java Access Bridge** option.

## Cause 3: Some files aren't available in the Java folder(s) of the machine after you install Power Automate for desktop

### Resolution

Specific files should exist in the Java folder(s) of the machine after the Power Automate for desktop installation.

Follow the below steps to check the installed Java version and installation path in your machine:

1. Type _Configure Java_ in the Search bar of Windows.
1. Open Java control panel and go to the **Java** tab.
1. Select **View**.
1. Check values in the **Path** column. The row with **Architecture** equal to x86 refers to 32-bit Java installation, while the row with value x64 refers to 64-bit Java installation.

You may check the below files:

- For 64-bit Java installation:

  - File _Microsoft.Flow.RPA.Desktop.UIAutomation.Java.Bridge.Native.dll_ should have been replaced in folder _C:\Program Files\Java\jre1.8.0_271\bin_. (jre1.8.0_271 could be replaced with your machine's Java installation.)
  - File _accessibility.properties_ should have been replaced in folder _C:\Program Files\Java\jre1.8.0_271\lib_. (jre1.8.0_271 could be replaced with your machine's Java installation.) If you edit the file with a notepad, it should have the following value:  
  `assistive_technologies=com.sun.java.accessibility.AccessBridge, microsoft.flows.rpa.desktop.uiautomation.JavaBridge`
  - File _access-bridge-64_ should have been inserted in folder _C:\Program Files\Java\jre1.8.0_271\lib\ext_. (jre1.8.0_271 could be replaced with your machine's Java installation.)

- For 32-bit Java installation:

  Same actions for the same files as above but in folder path _C:\Program Files (x86) \Java…_.

- Make sure there isn't an _.accessibility.properties_ file present in your user folder.
- Check _C:\Users\user_ if a file with name _.accessibility.properties_ is present. If yes, rename it.
- Ensure that _VC_redist.x64.exe_ and/or _VC_redist.x86.exe_ have been executed.
