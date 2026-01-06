---
title: Can't Access Elements of a Java Application
description: Troubleshoot the issue that Power Automate for desktop can't access the elements of a Java desktop application.
ms.reviewer: pefelesk, mitsirak, nimoutzo, iomimtso, v-shaywood
ms.date: 11/26/2025
ms.custom: sap:Desktop flows\UI or browser automation
---
# Can't access the elements of a Java application

When [you automate Java applications](/power-automate/desktop-flows/how-to/java) by using Power Automate for desktop, you experience an issue in which Power Automate can't access the UI elements of the Java application. This article helps you troubleshoot this issue.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 5014922

## Symptoms

Power Automate for desktop can't access the UI elements of a Java desktop application when you use either the [Recorder](/power-automate/desktop-flows/recording-flow) or the [Add UI element](/power-automate/desktop-flows/ui-elements) action in the flow designer.

## Diagnose using the troubleshooter

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
1. Some apps use an embedded Java runtime that isn't registered system-wide. To identify the location of an embedded Java runtime:

   1. Start the Java application.

   1. Open Task Manager.

   1. Locate and right-click the `java.exe` process, and then select **Open file location**.
  
   1. Use the selected folder as `<JRE_HOME>\bin`.
  
To avoid this issue in the future, install Java under `Program Files` or enable the option to register Java in the system registry during installation.

#### Copy required files (administrator rights required)

Copy the following files from the Power Automate for desktop installation folder (`C:\Program Files (x86)\Power Automate Desktop\dotnet\java-support`):

- `PAD.JavaBridge.jar` to `<JRE_HOME>\lib\ext\`
- `Microsoft.Flow.RPA.Desktop.UIAutomation.Java.Bridge.Native.dll` to `<JRE_HOME>\bin\` (x86 or x64 depending on the Java architecture) 

#### Update accessibility configuration

1. Open `<JRE_HOME>\lib\accessibility.properties` in a text editor. If the file doesn't exist, create it.
1. Add or update the following line:

   `assistive_technologies=microsoft.flows.rpa.desktop.uiautomation.JavaBridge`

   If the line starts with the number sign (`#`), remove the `#` character to uncomment it. If other assistive technologies are listed, append the Microsoft value at the end, separated by a comma.

> [!NOTE]
> Manual file placement works for only Java 8 and 7. Java 9 and later versions don't support using this method to load assistive technologies.

### Configure Java (for Java 9 and later)

For Java 9 and later versions, you can't modify the Java installation in the same manner. Instead, use one of the following methods.

#### Set environment variable (recommended)

Set a system or user environment variable that's named `JDK_JAVA_OPTIONS` and has the following value (64-bit example):

`-javaagent:"C:\Program Files (x86)\Power Automate Desktop\dotnet\java-support\PAD.JavaBridge.jar" -Djava.library.path="%PATH%;C:\Program Files (x86)\Power Automate Desktop\dotnet\java-support\x64"`

For 32-bit Java, use the `x86` folder instead of the `x64` folder.

#### Add JVM arguments to the Java application start command

Append the following arguments to the app's Java startup command:

- `-javaagent:"<PAD install path>\dotnet\java-support\PAD.JavaBridge.jar"`
- `-Djava.library.path="<PAD install path>\dotnet\java-support\x64"` (for 32-bit Java, use the `x86` folder instead of the `x64` folder)

## Key clarifications and troubleshooting tips

- Always try the Power Automate for desktop troubleshooter first. It's the safest and fastest method to configure Java automation.
- Manual file placement applies only to Java 8 and 7. Use the environment-variable method or JVM-argument method for Java 9 and later.
- Java versions earlier than 7 aren't supported.
- The attach mechanism might not work reliably for Java 10 or Java 9.
- If an application uses an embedded runtime, use Task Manager to find the Java executable path.
- To be able to insert files into Java installation folders, you must have administrator rights.
- If you insert the files manually, the files aren't updated automatically when Power Automate for desktop is updated. To use the latest Java automation files, repeat the manual file placement after each Power Automate for desktop update.
- After you make the changes, close all running Java applications, and then restart the computer.

## Related content

- [Automate Java applications](/power-automate/desktop-flows/desktop-flows/how-to/java)
- [Troubleshoot UI automation in Power Automate for desktop](/power-automate/desktop-flows/how-to/troubleshoot-ui-automation)

[!INCLUDE [Third-party disclaimer](../../../../includes/third-party-disclaimer.md)]
