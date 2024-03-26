---
title: File not found error when you try to open an Office file from a UNC share
description: Resolves an issue in which you cannot open an Office file from a UNC share by using Office Online. Additionally, you receive the error message the URL of the original file is not valid or the document is not publically assessable.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: khutch; arykhus; kemille; richpo; debbiery
search.appverid: 
  - MET150
appliesto: 
  - Office Web Apps Server 2013
  - Office Online Server
ms.date: 03/31/2022
---

# "File not found" error when you try to open an Office file from a UNC share

## Symptoms

Assume that you enable the Open From universal naming convention (UNC) feature in Microsoft Office Web Apps Server or Office Online Server. When you try to open an Office file from a UNC share by using Office Online, you receive the following error message:

> File not found  
> The URL of the original file is not valid or the document is not publically assessable.  Verify the URL is correct, then contact the document owner

## Resolution

To resolve this issue, follow these steps:

1. Make sure that the Office file does not exceed 10 MB. 10 MB is the size limit for files that you can open from the UNC share.   
2. Grant the computer account of the Office Online server read access to the Sharing permissions. Additionally, grant the computer account read and execute access for the Security permissions. To do this, follow these steps:
   1. Right-click the folder that contains the Office file and then click **Properties**.   
   2. On the **Sharing** tab, click **Advanced Sharing**, and then click **Permission**.   
   3. Click **Add**, click **Object Type**, click the **Computers** check box, and then click **OK**.   
   4. In the **Enter the object name to select** box, type the computer account of the Office Online server (for example, type domain\OfficeServer). Then, click **Check Names**, and then click **OK**.   
   5. Grant the **Read** permission to the computer account of the Office Online server that you added, and then click **OK**.   
   6. On the **Security** tab, click **Add**, click **Object Type**, select the **Computers** check box, and then click **OK**.   
   7. In the **Enter the object name to select** box, type the computer account of the Office Online server, click **Check Names**, and then click **OK**.   
   8. Grant the **Read & execute** permission to the computer account of the Office Online server that you added, and then click **OK**.
