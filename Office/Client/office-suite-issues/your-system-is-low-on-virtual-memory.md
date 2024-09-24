---
title: Your system is low on virtual memory
description: Describes the error message that you may receive when you try to start an Office program.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - DownloadInstall\InstallErrors\AppLaunchErrors
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Office 2010
  - Office 2007
  - Office 2003
ms.date: 06/06/2024
---

# "Your system is low on virtual memory" error message when you try to start an Office program

## Symptoms

When you start any of the Microsoft Office 2010, 2007, or 2003 programs, you may receive an error message that is similar to the following error message:

```adoc
Your system is low on virtual memory. To ensure that Windows runs properly, increase the size of your virtual memory paging file. For more information, see Help.
```

If you click **OK**, you may receive the following error message:

```adoc
Your system is low on virtual memory. Windows is increasing the size of your virtual memory paging file. During this process, memory requests for some applications may be denied. For more information, see Help.
```

## Cause

This behavior may occur if you try to start any of the programs included in Office on a computer where the paging file value setting is too low. 

## Resolution

To resolve this behavior, increase the size of the paging file. To do so, follow these steps as appropriate for your operating system.

Note Microsoft Office 2010 and Office 2007 require Windows XP or later.

### Windows 2000

1. Right-click **My Computer** and then click **Properties**.    
2. In the **System Properties** dialog box, click **Advanced**    
3. Click **Performance Options**.    
4. In the **Virtual memory** pane, click **Change** to increase the paging file.

    Windows 2000 requires an Initial value of 126 MB for debugging.    
5. After you change the setting, click **Set**, and then click **OK**.    
6. In the **System Control Panel Applet** dialog box, click **OK** to the following message: 

    The changes you have made require you to restart your computer before they can take effect.     
7. Click **OK** to close the **Performance Options** dialog box, and then click **OK** to close the **System Properties** dialog box.    
8. When you are prompted to restart your computer, click **Yes**.    
 
### Windows XP

1. Click **Start**, right-click **My Computer**, and then click **Properties**.    
2. In the **System Properties** dialog box, click the **Advanced** tab.    
3. In the **Performance** pane, click **Settings**.    
4. In the **Performance Options** dialog box, click the **Advanced** tab.    
5. In the **Virtual memory** pane, click **Change**.    
6. Change the **Initial size** value and the **Maximum size** value to a higher value, click **Set**, and then click **OK**.    
7. Click **OK** to close the **Performance Options** dialog box, and then click **OK** to close the **System Properties** dialog box.    

## More Information

With virtual memory, the computer can use hard disk space as random access memory (RAM). The computer uses virtual memory to augment the ordinary RAM that is installed on the computer. If you reduce the size of the paging file, the Office program may not start correctly or may not start at all. This behavior may occur even if the computer has lots of RAM. For additional information, see [Tips to free up drive space on your PC](https://support.microsoft.com/help/17421).

### Did this fix the problem?

Check whether the problem is fixed. If the problem is fixed, you are finished with this section. If the problem is not fixed, you can [contact support](https://support.microsoft.com/contactus).
