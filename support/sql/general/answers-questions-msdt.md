---
title: Answers questions about the MSDT
description: This article provides the answers and questions about the Microsoft Support Diagnostics Tool.
ms.date: 01/20/2021
ms.prod-support-area-path: 
ms.reviewer: kaushika
---
# Frequently asked questions about the Microsoft Support Diagnostic Tool

This article provides the answers and questions about the Microsoft Support Diagnostics Tool (MSDT).

_Original product version:_ &nbsp; Windows  
_Original KB number:_ &nbsp; 926079

## Introduce

This article answers the frequently asked questions (FAQs) about how to use the Microsoft Support Diagnostics Tool on the following operating systems:

- Windows XP
- Windows Server 2003
- Windows Vista
- Windows Server 2008

The Microsoft Support Diagnostic Tool (MSDT) collects information to send to Microsoft Support. Microsoft Support will then analyze this information and use it to determine the resolution to any problems that you may be experiencing on your computer.

For Windows XP and Windows Server 2003, MSDT runs on a Windows Internet Explorer session through the installation of an ActiveX control. For Windows Vista and Windows Server 2008, MSDT runs by using an inbuilt tool that is named *msdt.exe*.

## More information

There are 9 questions and answers as following:

### Q1: How do I run MSDT on a computer that is running Windows Server 2003 or Windows XP?

You can run MSDT on a computer that is running Windows Server 2003 or Windows XP in two ways. If your computer has an Internet connection, follow these steps:

1. In Internet Explorer, access the URL that was sent to you by Microsoft.
2. On the **Tools** menu, click **Internet Options**.
3. On the **Security** tab, select the **Trusted sites** icon, and then click **Sites**.
4. Add the following URL list of trusted sites:

    https://support.microsoft.com

5. Select **This computer is experiencing the problem**, and then click **Continue**.
6. Make sure that the Microsoft Support Diagnostic Platform ActiveX control is installed. To do this, follow these steps:

   1. Check for the presence of a yellow bar that asks you to install the add-in.
   2. Click the yellow bar, and then follow the instructions to install the control.
   3. Make sure that the **Automatically collect data** option is selected, and then click **Start collection**.

    > [!NOTE]
    > Depending on the speed of your Internet connection, you can expect a delay of 1 to 5 minutes after you clicking **Start collection**.

7. Wait for the diagnostic execution to be completed. (Depending on the diagnostic package executing, the execution can take several minutes.)
8. Select the option to upload data to Microsoft Support.

If your computer has no Internet connection, access the URL that was sent to you by Microsoft on a computer on which an Internet connection is available, and then generate a stand-alone package that you can run on the computer that has no Internet connection. For more information, see "Q3: How do I run MSDT on a computer that has no Internet connection?"

### Q2: How do I run MSDT on a computer that is running Windows Vista or Windows Server 2008?

You can run MSDT on a computer that is running Windows Vista or Windows Server 2008 in two ways. If your computer has an Internet connection, you can run MSDT directly through Internet Explorer or by using the msdt.exe tool. In this case, access the URL that was sent to you by Microsoft, and then follow the instructions that are described on the webpage, either by clicking **Data collection** or by running the MSDT tool and typing the pass key that was provided. Then, follow the instructions to run the diagnostic package.

If your computer has no Internet connection, access the URL that was sent to you by Microsoft on a computer on which an Internet connection is available, and then generate a stand-alone package that you can run on the computer that has no Internet connection. For more information, see "Q3: How do I run MSDT on a computer that has no Internet connection?"

### Q3: How do I run MSDT on a computer that has no Internet connection?

You can run the MSDT tool on a computer that has no Internet connection by using an executable package that was generated on a computer on which an Internet connection is available. This executable (known as the "offline package") can be used to obtain diagnostic information on any computer that is running Windows XP, Windows Server 2003, Windows Vista, or Windows Server 2008 and will generate a CAB file that contains diagnostic data that can be transferred back to Microsoft Support.

To run MSDT on a computer that has no Internet connection, follow the instructions in either "Q1: How do I run MSDT on a computer that is running Windows Server 2003 or Windows XP?" or "Q2: How do I run MSDT on a computer that is running Windows Vista or Windows Server 2008?" depending on the operating system. Follow these instructions on a computer on which an Internet connection is available to start to run the diagnostic package. After the diagnostic package execution is started and you see a screen that is titled "Select which computer is experiencing the problem" or "Which computer has a problem?" follow these steps on the computer that is running the diagnostic package.

1. Copy the offline package. To do this, follow these steps, depending on the operating system of the computer that is running the diagnostic package.

   - For Windows XP or Windows Server 2003
      1. Select the **The problem is on another computer** option, and then click **Continue**.
      2. Click **Create File**.
  
      > [!NOTE]
      > You may experience a delay of 1 to 5 minutes, depending on the speed of your Internet connection.

      3. Follow the instructions that are described on the webpage to copy the offline package (MSDT-Portable.exe) to the computer that is being diagnosed.

   - For Windows Vista or Windows Server 2008 
      1. Select the **A different computer** option.
      1. On the **Save diagnostic tools to removable media** screen, click **Download and save**.
      1. Indicate where the offline package (MSDT-Portable.exe) should be saved.

1. Execute the offline package (MSDT-Portable.exe) file to the destination computer, and execute it on the destination computer.
1. Wait for the package execution to be completed. (This step can take several minutes.)
1. After the diagnostic package finishes execution, Click **Save results**, and then indicate a folder to which you want to save the results.
1. Notice that two files are saved. One file is a CAB file that contains the diagnostic results. The other file is a shortcut (.lnk). Move both files to a computer on which an Internet connection is available.
1. On a computer that has an Internet connection, double-click the shortcut file, and then follow the instructions to send the resulting file back to Microsoft Support.

### Q4: Does MSDT change my system configuration?

MSDT may change the configuration of the computer. For example, MSDT may enable debug-related logging and then require you to reproduce the problem that you are experiencing. Some of this logging may be enabled until the diagnostic package uploads the troubleshooting information to Microsoft Support. MSDT may also enable diagnostics that collect additional information about the problem. In addition, MSDT can install run-time packages that can execute certain diagnostic packages such as Windows PowerShell or the Microsoft .NET Framework. Not all configurations that are changed by MSDT will be reverted when the package finishes execution. In particular, for scenarios in which a run-time package such as Windows PowerShell is installed, the run-time package may be kept installed on the computer.

### Q5: Which components and files remain on the computer after MSDT uploads files to Microsoft?

If you are running Windows XP or Windows Server 2003, a DLL Msdcode.dll remains on the computer. This file is an ActiveX control that is used to securely transfer files and diagnostic utilities from Microsoft and to upload information back to Microsoft. This file is stored in the %windir%\Downloaded Program Files folder.

All the files that MSDT creates during diagnostic execution when MSDT is running in Windows XP or Windows Server 2003 are stored in a folder that is named %temp%\~odc during the data-collection process but are deleted after you send the results to Microsoft. These files are also deleted if you stop data collection or select the **No, do not send the files to Microsoft** option on the **Send files to Microsoft** screen.

If you are running Windows Vista or Windows Server 2008, all the files that MSDT creates during diagnostic package execution are stored in a folder that is named %temp%\MSDT_< **GUID** > (where the placeholder < **GUID** > represents a folder that represents a GUID for execution) and are deleted after you send the results to Microsoft. These files are also deleted if you stop data collection or select the **No, do not send the files to Microsoft** option on the **Send files to Microsoft** screen.

In addition, as described in "Q4: Does MSDT change my system configuration?" some run-time components, such as Windows PowerShell and other packages may remain on the computer. Some diagnostic packages may also enable tracing or specific logs that may remain enabled on the computer until the diagnostic uploads troubleshooting information to Microsoft Support.

### Q6: Will MSDT change the Windows PowerShell Execution Policy?

Some diagnostic packages may alter the Windows PowerShell Script Execution Policy to RemoteSigned" temporarily and may then revert to the original configuration after they collect information. The policy may remain "RemoteSigned" if you cancel diagnostic execution before the package finishes execution.

### Q7: Does MSDT run correctly on a localized version of the Windows operating system?

MSDT runs correctly on localized versions of Windows. However, only some content descriptions are localized. Therefore, some parts of the user interface appear in English.

### Q8: How do you start MSDT on a Server Core installation of Windows Server 2008?

A Server Core installation of Windows Server 2008 does not have browser capability. Therefore, you must start MSDT manually. As long as the Windows Server 2008 Server Core-based computer has access to the Internet, you can follow these steps to execute MSDT and collect diagnostic information from the computer:

1. At a command prompt, type Msdt.exe, and then press Enter.
2. Type your pass key, and then click **OK**.

> [!NOTE]
> To obtain the pass key value, open the URL link in an email message on a Windows Vista- or Windows Server 2008-based system that has Internet access, and then note the 10-digit pass key value.

### Q9: Which URLs have to be configured on a firewall or proxy to let a diagnostic package run in Windows XP, Windows Server 2003, Windows Vista, or Windows Server 2008?

The following URLs are accessed when you run a diagnostic package:

- [Hello from DCUpload on CO1 02](https://dcupload.microsoft.com)
- [Hello from DCodeWS on CO1 02](https://dcodews.partners.extranet.microsoft.com)

## Troubleshooting

This section describes the most common problems that occur when you run MSDT on a computer that is running Windows Server 2008, Windows Vista, Windows Server 2003, or Windows XP.

- **Problem 1: After you open the URL that was sent to you by an engineer to execute MSDT on a computer that is running Windows 7 or Windows Server 2008 R2, the diagnostic package cannot be executed. Your only option is to create an offline package by using the "Create File" button.**

    This problem occurs because the URL that was sent to you executes a diagnostic package that runs on a computer that is running Windows XP, Windows Server 2003, Windows Vista, or Windows Server 2008. If you have to diagnose a Windows 7-based computer, ask the engineer to send you a passkey to execute MSDT on a Windows 7-based computer. If you want to generate an offline package that you can execute on Windows XP, Windows Server 2003, Windows Vista, or Windows Server 2008, click Create File to generate the offline package (MSDT-Portable.exe), and then follow steps 2 through 6 that are described in "Q3: How do I run MSDT on a computer that has no Internet connection?"

- **Problem 2: When you run the offline package (MSDT-Portable.exe) on a computer that is running Windows 7 or Windows Server 2008, you receive the error message "This application is not supported on this Operating System," and the application exits.**

    This problem occurs because the offline package executable (MSDT-Portable.exe) is incompatible with a computer that is running Windows 7 or Windows Server 2008 R2. If you want to obtain data from a Windows 7-based computer, you should ask the engineer to send you a passkey that you can use a on a Windows 7-based computer. Then, you can generate an offline package that is compatible with Windows 7.

- **Problem 3: When you generate an offline package in Windows XP or Windows Server 2003, you see a message that asks you to locate the MSDT-Portable.exe file in a folder that is named "[WinTempFolder]." However, you cannot find the file.**

    This problem occurs when the MSDT ActiveX control was not installed on the computer. To resolve this problem, make sure that `https://support.microsoft.com` is added to the Trusted Sites list and that you let the ActiveX control be installed when you are prompted to do this. For more information, see "Q3: How do I run MSDT on a computer that has no Internet connection?"

- **Problem 4: When you generate an offline package in Windows XP or Windows Server 2003, Internet Explorer seems to stop responding.**

    This problem may occur when the Internet connection to `support.microsoft.com` is slow. Wait several minutes for the ActiveX control to complete downloading the package and generating the executable. If the problem persists after several minutes, contact your support engineer.
