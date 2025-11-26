---
title: Can't access elements of a Java application
description: Troubleshoot the issue that Power Automate for desktop can't access the elements of a Java desktop application.
ms.reviewer: pefelesk, mitsirak, nimoutzo
ms.author: iomimtso
ms.date: 11/26/2025
ms.custom: sap:Desktop flows\UI or browser automation
---
# Can't access the elements of a Java application

If you encounter issues while [automating Java applications](/power-automate/desktop-flows/how-to/java) with Power Automate for desktop, follow the steps in this article to troubleshoot the issue.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 5014922

## Symptoms

Power Automate for desktop can't access the UI elements of a Java desktop application when you use either the [Recorder](/power-automate/desktop-flows/recording-flow) or the [Add UI element](/power-automate/desktop-flows/ui-elements) action in the flow designer.

## Troubleshooting steps

To solve this issue, try the [troubleshooter](/power-automate/desktop-flows/troubleshooter) first.

1. In Power Automate for desktop, navigate to **Help** > **Troubleshooter**, and then run the [troubleshooter](/power-automate/desktop-flows/troubleshooter).

2. In the **Troubleshooter** window, select **Run** on the **Troubleshot UI/Web automation issues** panel.

3. If an issue is found for **Java Automation**, expand the panel to see the details.

4. If a **Fix** button is available, select it to apply the fix. Ensure all running **Java** applications are closed before applying the fix.

If the issue persists after using the troubleshooter, follow these steps to manually troubleshoot the issue:

## 1. Manually configure Java (only for Java 7 and 8)

Use these steps only if the troubleshooter finds no Java installations or cannot configure the environment.

### A. Locate the Java installation folder

- Check common paths such as `C:\Program Files\Java\jre7` or `C:\Program Files\Java\jre8`.
- Some apps use an embedded Java runtime that is not registered system-wide. Start the Java application, open Task Manager, find the `java.exe` process, right-click it, and choose **Open file location**. Use that folder as `<JRE_HOME>\bin`.
- To avoid this issue in future, install Java under `Program Files` or enable the option to register Java in the system registry during installation.

### B. Copy required files (administrator rights required)

Copy these files from the Power Automate for desktop installation folder (C:\Program Files (x86)\Power Automate Desktop\dotnet\java-support):

- `PAD.JavaBridge.jar` to `<JRE_HOME>\lib\ext\`
- `Microsoft.Flow.RPA.Desktop.UIAutomation.Java.Bridge.Native.dll` (x86 or x64 depending on the Java architecture) to `<JRE_HOME>\bin\`

### C. Update accessibility configuration

1. Open `<JRE_HOME>\lib\accessibility.properties` in a text editor. Create the file if it doesn't exist.
2. Add or update this line:

   assistive_technologies=microsoft.flows.rpa.desktop.uiautomation.JavaBridge

   If the line starts with `#`, remove the `#` to uncomment it. If other assistive technologies are listed, append the Microsoft value at the end, separated by a comma.

Note: Manual file placement works only for Java 7 and 8. Java 9 and later do not support loading assistive technologies by this method.

## 2. Workaround for Java 9 and later (or when file placement is not possible)

For Java 9+ you cannot modify the Java installation in the same way. Use one of these options.

### A. Set environment variable (recommended)

Set a system or user environment variable named `JDK_JAVA_OPTIONS` with this value (64-bit example):

`-javaagent:"C:\Program Files (x86)\Power Automate Desktop\dotnet\java-support\PAD.JavaBridge.jar" -Djava.library.path="%PATH%;C:\Program Files (x86)\Power Automate Desktop\dotnet\java-support\x64"`

For 32-bit Java, use the `x86` folder instead of `x64`.

### B. Add JVM arguments to the Java application start command

Append these arguments to the app's Java startup command:

- `-javaagent:"<PAD install path>\dotnet\java-support\PAD.JavaBridge.jar"`
- `-Djava.library.path="<PAD install path>\dotnet\java-support\x64"` (or `x86`)

## Key clarifications and troubleshooting tips

- Always try the Power Automate for desktop Troubleshooter first. It's the safest and fastest method to configure Java automation.
- Manual file placement applies only to Java 7 and 8. Use the environment-variable or JVM-argument method for Java 9 and later.
- Java versions earlier than 7 are not supported.
- The attach mechanism may not work reliably with Java 9 or Java 10.
- Use Task Manager to find the Java executable path when an application uses an embedded runtime.
- Administrator rights are required to place files in Java installation folders.
- If you placed the files manually, they are not updated automatically when Power Automate for desktop is updated. Repeat the manual file placement after each Power Automate for desktop update to use the latest Java automation files.
- After making changes, close all running Java applications. Restarting the PC is recommended.

## More information

- [Automate Java applications](/power-automate/desktop-flows/desktop-flows/how-to/java)
- [Troubleshoot UI automation in Power Automate for desktop](/power-automate/desktop-flows/how-to/troubleshoot-ui-automation)

[!INCLUDE [Third-party disclaimer](../../../../includes/third-party-disclaimer.md)]