---
title: Remote Desktop Connection for credentials
description: Describes a problem that you may experience after you install the Remote Desktop Connection 6.0 client update. Provides a workaround.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, xiangwu
ms.custom: sap:remote-desktop-sessions, csstroubleshoot
---
# Remote Desktop Connection 6.0 prompts you for credentials before you establish a remote desktop connection

This article provides a workaround for the issue that Remote Desktop Connection 6.0 prompts you for credentials, before you establish a remote desktop connection.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 941641

## Symptoms

After you install the Remote Desktop Connection 6.0 client update (update 925876), you may experience one or more of the following symptoms:  

- Remote Desktop Connection 6.0 prompts you for credentials before you establish a remote desktop connection.
- Remote Desktop Connection 6.0 prompts you to accept the identity of the server if the identity of the server cannot be verified.
- You may be unable to use a smart card to log on to Remote Desktop Connection 6.0, even though you could use a smart card to log on to Remote Desktop Connection 5.x.  

For more information about the Remote Desktop Connection 6.0 client update, click the following article number to view the article in the Microsoft Knowledge Base:

[925876](https://support.microsoft.com/help/925876) Remote Desktop Connection (Terminal Services Client 6.0)  

## Workaround

To work around this problem, turn off the new features in Remote Desktop Connection 6.0 to revert to the features in Remote Desktop Connection 5.x. To implement this workaround, follow these steps:  

1. Click **Start**, click **Run**, type mstsc.exe, and then click **OK**.
2. Click **Options**, and then click the **General** tab.
3. Click **Save As**, and then type a file name in the **File name** box.
4. Select the location where you want to save the remote desktop file, click **Save**, and then click **Cancel**.

   > [!NOTE]
   > The saved file has the .rdp file name extension.
5. Click **Start**, click **Run**, type notepad, and then click **OK**.
6. On the **File** menu, click **Open**.
7. In the **Files of type** list, click **All Files**.
8. In the **Look in** list, locate and then click the file that you saved in step 4. Then, click **Open**.
9. Locate the line that resembles as: authentication level: i: **n**  

   > [!NOTE]
   > The **n** placeholder represents the current authentication level.  

10. Change the authentication level to 0 so that the line becomes:  
   authentication level:i:0  

    > [!NOTE]
    > When you set the authentication level to 0 , RDP 6.0 does not check for server authentication.  

11. Add the following line to the end of the file:enablecredsspsupport:i:0

    > [!NOTE]
    > When this line is present, you do not have to provide credentials before you establish a remote desktop connection.  

12. On the **File** menu, click **Save**.  

To connect by using Remote Desktop Connection, run the file that you saved in step 12.

> [!NOTE]
> After you follow these steps, the new security features that Remote Desktop Connection 6.0 provides are removed. Additionally, Remote Desktop Connection 6.0 becomes incompatible with Windows Vista-based computers that have the **Allow connections only from computers running Remote Desktop with Network Level Authentication** option enabled in the system properties.
