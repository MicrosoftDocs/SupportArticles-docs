---
title: You can't send or receive files or attachments in Skype for Business Online
description: Describes the conditions in which you can't send or receive files from Lync through Skype for Business Online. Provides a solution.
author: Norman-sun
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skype-for-business-online
ms.topic: article
ms.author: v-swei
ms.reviewer: dahans
ms.custom: CSSTroubleshoot
appliesto:
- Skype for Business Online
---

# You can't send or receive files or attachments in Skype for Business Online

## Problem

Assume that in an Office 365 environment, you try to send or receive files or attachments in Lync through Skype for Business Online (formerly Lync Online). In this situation, you may experience the following issues:

- You can't send files to contacts.   
- You can't receive files from contacts.   
- You can't upload file attachments in Skype for Business Online meetings.   
- When you send files to contacts, you receive an error message.   
- You can't send pictures directly in an Instant Messaging (IM) conversation.  

## Solution

### For Skype for Business Online users

If you receive an error message when you send or receive files, make sure that the file type being transferred isn't one of those that is listed in the "More Information" section. 

### For Skype for Business Online administrators

If a user doesn't see the option to transfer files, verify that file transfer capabilities are enabled for that user.

Firewalled networks must meet the network requirements for Skype for Business Online. For more information about Skype for Business Online network requirements, go to the following Microsoft Knowledge Base article:

[2409256 ](https://support.microsoft.com/help/2409256) You can't connect to Skype for Business Online, or certain features don't work, because an on-premises firewall blocks the connection

## More Information

Generally, if the menu option to send a file isn't available, this means that the administrator has disabled file transfer capabilities for that user.

If your attempts to upload attachments to a conference or to send files to a contact generate an error message, this means either that the contact that you're sending the attachment to doesn't have permission to receive files or that the file type is blocked.

In Skype for Business Online, certain files types are blocked by the Intelligent Instant Message Filter (IIMF) application. IIMF helps protect Skype for Business Online users against the most common forms of viruses without degrading the user experience.

Transferring files to Skype contacts isn't supported.

By default, Skype for Business Online is configured to prevent users from sending files through IM that have the following file name extensions: 

ade, adp, app, asp, bas, bat, cer, chm, cmd, com, cpl, crt, csh, exe, fxp, grp, hlp, hta, inf, ins, isp, its, js, jse, ksh, lnk, mad, maf, mag, mam, maq, mar, mas, mat, mau, mav, maw, mda, mdb, mde, mdt, mdw, mdz, msc, msi, msp, mst, ocx, ops, pcd, pif, pl, pnp, prf, prg, pst, reg, scf, scr, sct, shb, shs, tmp, url, vb, vbe, vbs, vsd, vsmacros, vss, vst, vsw, ws, wsc, wsf, wsh

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).