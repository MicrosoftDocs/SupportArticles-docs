---
title: Troubleshoot Java UI Element Access in Power Automate for Desktop
description: Learn how to fix Power Automate for desktop when it can't access Java application UI elements. Diagnose with the troubleshooter or configure Java manually now.
ms.reviewer: pefelesk, mitsirak, nimoutzo, iomimtso, v-shaywood
ms.date: 07/06/2026
ms.custom: sap:Desktop flows\UI or browser automation
ai-usage: ai-assisted
---
# Power Automate for desktop can't access the UI elements of a Java application

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 5014922

## Summary

When you [automate Java applications](/power-automate/desktop-flows/how-to/java) by using Power Automate for desktop, it might fail to access the UI elements of the application. This article helps you troubleshoot that problem. It explains how to diagnose the issue with the built-in troubleshooter and how to manually configure Java accessibility for Java 8 and 7, for Java 9 and later, and for custom or jlinked runtimes that don't include the `java.instrument` module.

## Symptoms

Power Automate for desktop can't access the UI elements of a Java desktop application when you use either the [Recorder](/power-automate/desktop-flows/recording-flow) or the [Add UI element](/power-automate/desktop-flows/ui-elements) action in the flow designer.

## Diagnose the issue with the troubleshooter

To resolve this problem, first try the [troubleshooter](/power-automate/desktop-flows/troubleshooter):

1. In Power Automate for desktop, go to **Help** > **Troubleshooter**, and then run the [troubleshooter](/power-automate/desktop-flows/troubleshooter).

1. In the **Troubleshooter** window, select **Run** on the **Troubleshot UI/Web automation issues** panel.

1. If the troubleshooter finds an issue for **Java Automation**, expand the panel to see the details.

1. If a **Fix** button is available, select it to apply the fix. Make sure that you close all running **Java** applications before you apply the fix.

If the problem persists after you use the troubleshooter, follow the steps in [Manual troubleshooting](#manual-troubleshooting) to further troubleshoot the issue.

## Manual troubleshooting

> [!NOTE]
> Use these steps only if the troubleshooter finds no Java installations or can't configure the environment.

### Configure Java (for Java 8 and 7)

Use these steps to troubleshoot Java 8 and 7. If you're using Java 9 or a later version, see [Configure Java (for Java 9 and later)](#configure-java-for-java-9-and-later).

#### Locate the Java installation folder

1. Check common paths such as `C:\Program Files\Java\jre7` or `C:\Program Files\Java\jre8`.
1. Some applications use an embedded Java runtime that isn't registered system-wide. To identify the location of an embedded Java runtime:

   1. Start the Java application.

   1. Open Task Manager.

   1. Locate and right-click the `java.exe` process, and then select **Open file location**.
  
   1. Use the selected folder as `<JRE_HOME>\bin`.
  
To avoid this issue in the future, install Java under `Program Files` or enable the option to register Java in the system registry during installation.

#### Copy required files (administrator rights required)

Copy the following files from the Power Automate for desktop installation folder (`C:\Program Files (x86)\Power Automate Desktop\dotnet\java-support`):

- `PAD.JavaBridge.jar` to `<JRE_HOME>\lib\ext\`
- `Microsoft.Flow.RPA.Desktop.UIAutomation.Java.Bridge.Native.dll` to `<JRE_HOME>\bin\` (x86 or x64, depending on the Java architecture)

#### Update accessibility configuration

1. Open `<JRE_HOME>\lib\accessibility.properties` in a text editor. If the file doesn't exist, create it.
1. Add or update the following line:

   `assistive_technologies=microsoft.flows.rpa.desktop.uiautomation.JavaBridge`

   If the line starts with the number sign (`#`), remove the `#` character to uncomment it. If other assistive technologies are listed, append the Microsoft value at the end, separated by a comma.

> [!NOTE]
> Manual file placement works for only Java 8 and 7. Java 9 and later versions don't support using this method to load assistive technologies.

### Configure Java (for Java 9 and later)

For Java 9 and later versions, you can't modify the Java installation in the same way. Instead, use one of the following methods.

#### Set environment variable (recommended)

Set a system or user environment variable named `JDK_JAVA_OPTIONS` with the following value (64-bit example):

`-javaagent:"C:\Program Files (x86)\Power Automate Desktop\dotnet\java-support\PAD.JavaBridge.jar" -Djava.library.path="%PATH%;C:\Program Files (x86)\Power Automate Desktop\dotnet\java-support\x64"`

For 32-bit Java, use the `x86` folder instead of the `x64` folder.

#### Add JVM arguments to the Java application start command

Append the following arguments to the app's Java startup command:

- `-javaagent:"<PAD install path>\dotnet\java-support\PAD.JavaBridge.jar"`
- `-Djava.library.path="<PAD install path>\dotnet\java-support\x64"` (for 32-bit Java, use the `x86` folder instead of the `x64` folder)

### Configure Java (for custom or jlinked runtimes without the java.instrument module)

> [!NOTE]
> This method is available in Power Automate for desktop version 2.70 or later.

Some applications include a custom Java 9 or later runtime that's built with [jlink](https://docs.oracle.com/en/java/javase/17/docs/specs/man/jlink.html) and doesn't contain the `java.instrument` module. The methods in [Configure Java (for Java 9 and later)](#configure-java-for-java-9-and-later) use the `-javaagent` option, which requires this module, so they don't work for these runtimes. Instead, load the agent through the Java Accessibility Provider by using the `PAD.JavaBridge.A11y.jar` file.

#### Confirm that the runtime doesn't include the java.instrument module

Run the following command against the application's Java executable, and then review the listed modules:

`"<app-dir>\runtime\bin\java.exe" --list-modules`

Use this method only if the output doesn't list `java.instrument`. The output must also include the `java.desktop` and `jdk.accessibility` modules. If the output lists `java.instrument`, use one of the methods in [Configure Java (for Java 9 and later)](#configure-java-for-java-9-and-later) instead.

#### Set the environment variable for the application only (recommended)

If you control how the application starts (for example, through a command line or a launch script), set the `JAVA_TOOL_OPTIONS` environment variable only for that session before you start the app. This approach makes sure that no other Java process on the machine is affected. In a Command Prompt window, run the following commands (64-bit example), and then start the app from the same window:

```cmd
set "JAVA_TOOL_OPTIONS=--module-path='C:\Program Files (x86)\Power Automate Desktop\dotnet\java-support\PAD.JavaBridge.A11y.jar' --add-modules=PAD.JavaBridge -Djavax.accessibility.assistive_technologies=JavaBridgeA11y -Dpad.javabridge.dllpath='C:\Program Files (x86)\Power Automate Desktop\dotnet\java-support\x64\Microsoft.Flow.RPA.Desktop.UIAutomation.Java.Bridge.Native.dll'"
"<app-dir>\<target-app>.exe"
```

For 32-bit Java, use the `x86` folder instead of the `x64` folder.

#### Set a system or user environment variable

If the application is started in a way that you can't intercept (for example, from a shortcut or the Start menu), set a system or user environment variable that's named `JAVA_TOOL_OPTIONS` and has the following value (64-bit example):

`--module-path="C:\Program Files (x86)\Power Automate Desktop\dotnet\java-support\PAD.JavaBridge.A11y.jar" --add-modules=PAD.JavaBridge -Djavax.accessibility.assistive_technologies=JavaBridgeA11y -Dpad.javabridge.dllpath="C:\Program Files (x86)\Power Automate Desktop\dotnet\java-support\x64\Microsoft.Flow.RPA.Desktop.UIAutomation.Java.Bridge.Native.dll"`

For 32-bit Java, use the `x86` folder instead of the `x64` folder.

> [!WARNING]
> The `JAVA_TOOL_OPTIONS` variable is read by every Java process that starts on the machine. Set it system-wide or user-wide only on machines that run Java 9 or later exclusively:
>
> - Java 8 and 7 applications don't recognize the `--module-path` option and fail to start.
> - Every Java 9 or later application that uses AWT or Swing loads the agent, even if it doesn't need it.
> - The setting persists across restarts. To remove it, clear the value of the `JAVA_TOOL_OPTIONS` variable.

## Key clarifications and troubleshooting tips

- Always try the Power Automate for desktop troubleshooter first. It's the safest and fastest method to configure Java automation.
- Manual file placement applies only to Java 8 and 7. Use the environment-variable method or JVM-argument method for Java 9 and later.
- If a Java 9 or later application uses a custom or jlinked runtime that doesn't include the `java.instrument` module, use the [Java Accessibility Provider method](#configure-java-for-custom-or-jlinked-runtimes-without-the-javainstrument-module).
- Java versions earlier than 7 aren't supported.
- The attach mechanism might not work reliably for Java 10 or Java 9.
- If an application uses an embedded runtime, use Task Manager to find the Java executable path.
- To insert files into Java installation folders, you must have administrator rights.
- If you insert the files manually, they aren't updated automatically when Power Automate for desktop is updated. To use the latest Java automation files, repeat the manual file placement after each Power Automate for desktop update.
- After you make the changes, close all running Java applications, and then restart the computer.

## Related content

- [Automate Java applications](/power-automate/desktop-flows/how-to/java)
- [Power Automate troubleshooting](../../welcome-power-automate.yml)

[!INCLUDE [Third-party disclaimer](../../../../includes/third-party-disclaimer.md)]
