---
title: Collect Network Monitor trace in O365 Dedicated/ITAR
description: Describes how to troubleshoot a network issue by using Network Monitor in Office 365 Dedicated/ITAR.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Microsoft Business Productivity Online Dedicated
  - Microsoft Business Productivity Online Suite Federal
ms.date: 03/31/2022
---

# How to collect a Network Monitor trace in Office 365 Dedicated/ITAR

## Summary

To help you resolve an issue that you have reported, Microsoft Support may request that you run a network trace by using the Network Monitor (NetMon.exe) tool.  
For example, you might have to use Network Monitor to troubleshoot the following kinds of issues: 

- Outlook cannot connect to the network.    
- Outlook is running very slowly.    
- You receive continual authentication prompts.    

> [!NOTE]
> We prefer NetMon traces, but if your organization uses another capture program like Wireshark you can send that as an alternative. 

## More Information

To install, collect, and send the Network Monitor trace file so that it can be reviewed by Microsoft Support, follow these steps:

1. Get the NetMon.exe tool from the following location:
    
    [Microsoft Network Monitor 3.4](https://www.microsoft.com/download/details.aspx?id=4865)   
2. Download and save **OneClick_Autorun.exe** to your desktop.   
3. Install Network Monitor 1 OneClick. To do this, run the OneClick_Autorun.exe file.

    > [!NOTE]
    > You may have to right-click **OneClick_Autorun.exe**, and then click **Run as administrator**.
4. The **Network Monitor One-Click Traffic Capture** window appears. (This is a Command Prompt window that has a dark red background.) To select the default location in which to save the capture file,**press Enter**.   
5. Close and restart the application that has the reported issue.   
6. Take the relevant actions to reproduce the issue.   
7. Switch back to the Network Monitor Command Prompt window, and then press the **X** key to stop the capture. A Windows Explorer window should open that contains the newly created OneClick.cap file.   
8. Compress the OneClick.cap file to a .zip file, and name the new file. Although you can give the file any name, Microsoft Support prefers that the file name include your escalation number and user name ("123456_\<user name>.zip"). 

    > [!NOTE]
    > Microsoft Support cannot accept .rar files that are compressed by using WinRAR.   
9. Return to the Network Monitor Command Prompt window, and press any key to unload and close Network Monitor.   
10. To send the file to Microsoft Support, either email the file or upload the file to the ticket through your portal. If the file is too large to email, ask a Support agent to create a file share location to which you can upload the zipped file.   
