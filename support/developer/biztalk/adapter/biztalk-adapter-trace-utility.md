---
title: Install and use the Adapter Trace Utility
description: This article explains how to install the BizTalk Adapter Trace Utility and enable tracing. Trace files can be useful tools for debugging problems.
ms.date: 03/04/2020
ms.custom: sap:Adapters
---
# Install and use the BizTalk Adapter Trace Utility in BizTalk Server

This step-by-step article describes how to install the Microsoft BizTalk Adapter Trace Utility. It also discusses how to run the BizTalk Adapter Trace Utility and how to have the generated trace file analyzed.

_Original product version:_ &nbsp; BizTalk Server 2009  
_Original KB number:_ &nbsp; 835451

## Install the BizTalk Adapter Trace Utility

To install the BizTalk Adapter Trace Utility on Windows Server 2008, follow these steps:

1. Download the Tracelog.exe file, and install the Microsoft Windows Software Development Kit (SDK) Update for Windows Vista.

    > [!NOTE]
    > The Tracelog.exe file is not included with the Windows SDK for Windows Server 2008 and the Microsoft .NET Framework 3.5. So, install the Windows Vista SDK on Windows Server 2008.

    For more information, see [Windows Software Development Kit (SDK) for Windows Server 2008 and .NET Framework 3.5 Release Notes](/previous-versions/bb986638(v=msdn.10)).

2. When the **Installation Options window** appears, expand **Developer Tools** and expand **Windows Development Tools**. Then select the **Win32 Development Tools** check box.

3. Clear the other check boxes, and then continue the installation.

4. Find the following folder, and then copy the Tracelog.exe file to the BizTalk Server installation folder:  
    *Drive*:\MicrosoftSDKInstallationFolder\Bin.

By default, the Tracelog.exe file is in the C:\Program Files\Microsoft SDKs\Windows\v6.0\Bin folder. The BizTalk Server installation folder also contains the Trace.cmd file.

To install the BizTalk Adapter Trace Utility on Windows Server 2003, follow these steps:

1. Download the Tracelog.exe file, and install the Windows Server 2003 R2 Platform SDK.
2. When the **Select An Installation Type** window appears, select **Custom**.
3. In the **Custom Installation** dialog box, expand **Microsoft Windows Core SDK**, and then expand **Tools**.
4. Select **Tools (Intel 64-bit)**, and then select **Will be installed on local hard drive**.
5. Select **Will not be available** on everything else, and then continue the installation.
6. Locate the *Drive*:\MicrosoftPlatformSDKInstallationFolder\Bin folder, and then copy the Tracelog.exe file to the BizTalk Server installation folder.

    By default, the Tracelog.exe file is in the C:\Program Files\Microsoft Platform SDK for Windows Server 2003 R2\bin folder. The BizTalk Server installation folder also contains the Trace.cmd file.

## Enable the BizTalk Adapter Trace Utility

To enable the BizTalk Adapter Trace Utility, follow these steps:

1. At a command prompt, change the current directory to the directory where BizTalk Server is installed. By default, BizTalk Server is installed in the Program Files\Microsoft BizTalk Server 200x directory.
2. Enter the following command:

    ``` console
    trace -tools "Path of the BizTalk Adapter Trace Utility"
    ```

By default on Windows Server 2003, the BizTalk Adapter Trace Utility is in the following directory:  
C:\Program Files\Microsoft Platform SDK for Windows Server 2003 R2\Bin.

By default on Windows Server 2008, the BizTalk Adapter Trace Utility is in the following directory:  
C:\Program Files\Microsoft SDKs\Windows\v6.0\Bin.

You must enclose the path of the BizTalk Adapter Trace Utility in quotation marks.

For example, enter the following command on Windows Server 2003:

``` console
trace -tools "C:\Program Files\Microsoft Platform SDK for Windows Server 2003 R2\Bin"
```

On Windows Server 2008, enter the following command:

``` console
trace -tools "C:\Program Files\Microsoft SDKs\Windows\v6.0\Bin"
```

The `-tools` switch indicates to the location of the Tracelog.exe file to the *Trace.cmd* file.

### Run the BizTalk Adapter Trace Utility

To run the BizTalk Adapter Trace Utility on a scenario, follow these steps:

1. At a command prompt, enter the following command:

    ``` console
    trace -start -all
    ```

2. Reproduce the scenario that you want to trace.

3. At a command prompt, enter the following command:

    ``` console
    trace -stop
    ```

After you stop the trace, a binary file for BizTalk Server 2006 and later versions that's named BtsTrace.bin is generated in the folder where BizTalk Server is installed. In BizTalk Server 2004, a binary file that's named Bts2004.bin is generated in the folder where BizTalk Server is installed.

You can send the BizTalk Server trace .bin file to Microsoft Customer Support Services for analysis.
