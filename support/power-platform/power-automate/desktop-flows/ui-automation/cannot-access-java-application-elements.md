---
title: Can't access elements of a Java application
description: Troubleshoot the issue that Power Automate for desktop can't access the elements of a Java desktop application.
ms.reviewer: pefelesk
ms.date: 04/29/2025
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

1. Ensure that you have Java installed on your machine:

   - Open the Command Line tool (cmd) and run the following command:

     ```cmd
     java –version
     ```

   - If Java isn't installed, you receive an error message:

     > 'java' is not recognized as an internal or external command, operable program or batch file.

2. Ensure that the **Enable Java Access Bridge** option is disabled in the Control Panel.

   Go to **Control Panel** > **Ease of Access** > **Optimize visual display** > **Java Access Bridge from Oracle, Inc. Providing Assistive Technology access to Java applications**, and then disable the **Enable Java Access Bridge** option.

   :::image type="content" source="media/cannot-access-java-application-elements/enable-java-access-bridge-option.png" alt-text="Screenshot of the Enable Java Access Bridge option in the Windows Control Panel." lightbox="media/cannot-access-java-application-elements/enable-java-access-bridge-option.png":::

3. Ensure that specific files exist in one or more Java folders of the machine after the Power Automate for desktop installation.

   To check the installed Java version and installation path on your machine:

    1. Type _Configure Java_ in the Windows search bar.
    1. Open Java Control Panel and go to the **Java** tab.
    1. Select **View**.

       :::image type="content" source="media/cannot-access-java-application-elements/java-control-panel.png" alt-text="Screenshot of the Java Control Panel.":::

    1. Check the values in the **Path** column. The **Architecture** row with value x86 refers to 32-bit Java installation, while the row with value x64 refers to 64-bit Java installation.

       :::image type="content" source="media/cannot-access-java-application-elements/java-runtime-environments-settings.png" alt-text="Screnshot of the Java Runtime Environment Settings.":::

   Check that the following files exist:

   - For 64-bit Java installation:

     - File _Microsoft.Flow.RPA.Desktop.UIAutomation.Java.Bridge.Native.dll_ is replaced in folder _C:\Program Files\Java\jre1.8.0_271\bin_. (replace _jre1.8.0_271_ with your machine's Java installation folder.)
     - File _accessibility.properties_ is replaced in folder _C:\Program Files\Java\jre1.8.0_271\lib_. (replace _jre1.8.0_271_ with your machine's Java installation folder.)  
       - If you open the file with Notepad, you should see the following value:  
  `assistive_technologies=com.sun.java.accessibility.AccessBridge, microsoft.flows.rpa.desktop.uiautomation.JavaBridge`
     - File _PAD.JavaBridge.jar_ is inserted in folder _C:\Program Files\Java\jre1.8.0_271\lib\ext_. (replace _jre1.8.0_271_ with your machine's Java installation folder.)

   - For 32-bit Java installation:

     - Check the same files but in folder _C:\Program Files (x86) \Java…_.

4. Check _.accessibility.properties_ file:

    - Ensure there isn't an _.accessibility.properties_ file in your _C:\Users\user_ folder. (replace _user_ with your user name.)
    - If the file exists, rename it.

5. Ensure that _VC_redist.x64.exe_, _VC_redist.x86.exe_, or both are run.

   :::image type="content" source="media/cannot-access-java-application-elements/installed-microsoft-visual-c-plus-plus-redistributable-versions.png" alt-text="Screenshot of the installed Microsoft Visual C++ Redistributable versions.":::
