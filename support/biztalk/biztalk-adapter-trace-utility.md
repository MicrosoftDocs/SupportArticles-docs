---
title: How to use Adapter Trace Utility
description: Explains how to install the BizTalk Adapter Trace Utility and enable tracing. Trace files can be useful tools for debugging problems.
ms.date: 03/04/2020
ms.prod-support-area-path:
---
# How to use the BizTalk Adapter Trace Utility in BizTalk Server

This step-by-step article describes how to install the Microsoft BizTalk Adapter Trace Utility. It also discusses how to run the BizTalk Adapter Trace Utility and how to have the generated trace file analyzed.

_Original product version:_ &nbsp; BizTalk Server 2009  
_Original KB number:_ &nbsp; 835451

## Install the BizTalk Adapter Trace Utility

To install the BizTalk Adapter Trace Utility on Windows Server 2008, follow these steps:

1. Download the Tracelog.exe file, install the Microsoft Windows Software Development Kit (SDK) Update for Windows Vista.

    > [!NOTE]
    > The Tracelog.exe file is not included with Windows SDK for Windows Server 2008 and the Microsoft .NET Framework 3.5. Therefore, install the Windows Vista SDK on Windows Server 2008.

    For more information, see [Windows Software Development Kit (SDK) for Windows Server 2008 and .NET Framework 3.5 Release Notes](https://msdn.microsoft.com/windowsserver/bb986638.aspx).

2. When the Installation Options window is displayed, expand **Developer Tools**, expand **Windows Development Tools**, and then click to select the **Win32 Development Tools** check box.

3. Click to clear the other check boxes, and then continue the installation.

4. Locate the following folder, and then copy the Tracelog.exe file to the BizTalk Server installation folder:  
    Drive:\MicrosoftSDKInstallationFolder\Bin

By default, the Tracelog.exe file is in the `C:\Program Files\Microsoft SDKs\Windows\v6.0\Bin` folder. The BizTalk Server installation folder also contains the Trace.cmd file.

To install the BizTalk Adapter Trace Utility on Windows Server 2003, follow these steps:

1. Download the Tracelog.exe file, install the Windows Server 2003 R2 Platform SDK.
2. When the Select An Installation Type window is displayed, click **Custom**.
3. In the **Custom Installation** dialog box, expand **Microsoft Windows Core SDK**, and then expand **Tools**.
4. Click **Tools (Intel 64-bit)**, and then click **Will be installed on local hard drive**.
5. Click **Will not be available** on everything else, and then continue the installation.
6. Locate the following folder, and then copy the Tracelog.exe file to the BizTalk Server installation folder:  
    Drive:\MicrosoftPlatformSDKInstallationFolder\Bin

    By default, the Tracelog.exe file is in the `C:\Program Files\Microsoft Platform SDK for Windows Server 2003 R2\bin` folder. The BizTalk Server installation folder also contains the Trace.cmd file.

## Enable the BizTalk Adapter Trace Utility

To enable the BizTalk Adapter Trace Utility, follow these steps:

1. At a command prompt, change the current directory to the directory where BizTalk Server is installed. By default, BizTalk Server is installed in the Program Files\Microsoft BizTalk Server 200x directory.
2. Type the following command, and then press ENTER:

    ``` console
    trace -tools "Path of the BizTalk Adapter Trace Utility"
    ```

    By default on Windows Server 2003, the Trace Utilities are located in the following directory:  
    C:\Program Files\Microsoft Platform SDK for Windows Server 2003 R2\Bin

    By default on Windows Server 2008, the Trace Utilities are located in the following directory:  
    C:\Program Files\Microsoft SDKs\Windows\v6.0\Bin

    > [!NOTE]
    > You must enclose the path of the Trace Utilities in quotation marks.

    For example, type the following command on Windows Server 2003:

    ``` console
    trace -tools "C:\Program Files\Microsoft Platform SDK for Windows Server 2003 R2\Bin"
    ```

    On Windows Server 2008, type the following command:

    ``` console
    trace -tools "C:\Program Files\Microsoft SDKs\Windows\v6.0\Bin"
    ```

    The tools switch indicates to the Trace.cmd file the location of the Tracelog.exe file.

### Run the BizTalk Adapter Trace Utility

To run the BizTalk Adapter Trace Utility on a scenario, follow these steps:

1. At a command prompt, type the following command, and then press ENTER:

    ``` console
    trace -start -all
    ```

2. Reproduce the scenario that you want to trace.

3. At a command prompt, type the following command, and then press ENTER:

    ``` console
    trace -stop
    ```

After you stop the trace, a binary file for BizTalk Server 2006 and for later versions that is named BtsTrace.bin is generated in the folder where BizTalk Server is installed. In BizTalk Server 2004, a binary file that is named Bts2004.bin is generated in the folder where BizTalk Server is installed.

You can send the BizTalk Server trace .bin file to Microsoft Customer Support Services for analysis.
