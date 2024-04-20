---
title: install the Microsoft Loopback Adapter
description: This article describes how to install the Microsoft Loopback Adapter. You can use the DevCon utility to quickly install the Microsoft Loopback Adapter at a command prompt, or you can use the Hardware Wizard.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Network Connectivity and File Sharing\TCP/IP Connectivity (TCP Protocol, NLA, WinHTTP), csstroubleshoot
---
# How to install the Microsoft Loopback Adapter

This article describes how to install the Microsoft Loopback Adapter.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 842561

## Introduction

This article describes how to install the Microsoft Loopback Adapter in Microsoft Windows Server 2003. You can install the adapter by using a command prompt or by using the Hardware Wizard.

## More information

### Method 1

To quickly install the Microsoft Loopback Adapter in Microsoft Windows Server 2003, use the DevCon utility at a command prompt. To download and to run the DevCon utility, follow these steps:  

1. Download the DevCon compressed file, and then extract the files:
      1. Visit the following Microsoft Web site:  
      [Windows Device Console (Devcon.exe)](/windows-hardware/drivers/devtest/devcon)  

      2. Save the Devcon.exe file to a folder on your computer, and then open the folder.
      3. Double-click **Devcon.exe**. A **WinZip Self-Extractor** dialog box appears.
      4. In the **Unzip to path** box, type the folder where you want to unzip the files, and then click **Unzip**.
      5. Click **OK**, and then **Close** to complete the unzip process.  

2. Install the Microsoft Loopback Adapter:  

      1. At a command prompt, change directory to the folder where you extracted the DevCon files.
      2. Change directory to the **i386** folder.
      3. Type devcon.exe install %windir%\inf\netloop.inf *msloop, and then press ENTER. You see output that is similar as:  
      Device node created. Install is complete when drivers are updated...  
      Updating drivers for \*msloop from C:\WINDOWS\inf\netloop.inf.  
      Drivers updated successfully.

      4. Close the command prompt.
      5. Click **Start**, click **Control Panel**, and then click **Network Connections** to verify that the Microsoft Loopback Adapter has been installed.

### Method 2

To install the Microsoft Loopback Adapter by using the Hardware Wizard, follow these steps:  

1. In Control Panel, double-click **Add Hardware**, and then click
 **Next**  
2. Click **Yes, I have already connected the hardware**, and then click
 **Next**.

3. At the bottom of the **Installed hardware** list, click **Add a new hardware device**, and then click **Next**.
4. Click **Install the hardware that I manually select from a list**, and then click **Next**  
5. In the **Common hardware types** list, click **Network adapters**, and then click **Next**.
6. In the **Manufacturers** list box, click **Microsoft**.
7. In the **Network Adapter** list box, click **Microsoft Loopback Adapter**, and then click **Next**.

8. Click **Next** to start installing the drivers for your hardware.
9. Click **Finish**.
10. Click **Start**, click **Settings**, and then click **Network Connections** to verify that the Microsoft Loopback Adapter has been installed.

## References

For additional information about the DevCon utility, click the following article number to view the article in the Microsoft Knowledge Base:

[311272](https://support.microsoft.com/help/311272) DevCon command-line utility alternative to Device Manager
