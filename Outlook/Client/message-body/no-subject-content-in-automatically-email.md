---
title: Automatically generated email messages in Outlook don't contain Subject or contents
description: Describes an issue that prevents Outlook email messages from having a Subject line and a body. This issue concerns the absence of the Mail registry key.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Sending, Receiving, Synchronizing, or viewing email\Blank or incorrectly displayed message body
  - Outlook for Windows
  - CSSTroubleshoot
appliesto: 
  - Microsoft Outlook 2016
  - Microsoft Outlook 2013 Service Pack 1
  - Microsoft Outlook 2013
  - Microsoft Outlook 2010
  - Internet Explorer 10
  - Internet Explorer 11
search.appverid: MET150
ms.reviewer: 
ms.date: 01/30/2024
---
# Automatically generated email messages in Outlook don't contain Subject or contents

_Original KB number:_ &nbsp; 3114786

## Symptoms

When you use an HTML-based page to automatically create email messages in Microsoft Outlook, the message's Subject line and body may not be created.

## Cause

This issue occurs if your computer doesn't have the following registry key:

`HKEY_CURRENT_USER\Software\Clients\Mail`

If you have the most recent versions of Internet Explorer or Microsoft Edge installed, you must have this registry key on your system.

## Resolution

> [!WARNING]
> If you use Registry Editor incorrectly, you may cause serious problems that may require you to reinstall your operating system. Microsoft cannot guarantee that you can solve problems that result from using Registry Editor incorrectly. Use Registry Editor at your own risk.

To resolve this issue, use Registry Editor to manually add the `HKEY_CURRENT_USER\Software\Clients\Mail` registry key. To do this, follow these steps:

1. Exit Outlook and Internet Explorer.

1. Start Registry Editor. To do this, use one of the following procedures, as appropriate for your version of Windows.

    Windows 8 and Windows 10: Press the Windows Key + R to open a **Run** dialog box. Type regedit.exe, and then click **OK**.

    Windows 7 and Windows Vista: Click **Start**, type regedit in the **Start Search**  box, and then press Enter. If you're prompted for an administrator password or for confirmation, type the password, or click **Allow**.

    Windows XP: Click **Start**, click **Run**, type regedit, and then click **OK**.

1. Locate the following registry key:

    `HKEY_CURRENT_USER\Software\Clients`

    1. Select the **Clients** subkey.
    1. On the **Edit** menu, click **New** -> **Key**.
    1. Type **Mail**, and then click **OK**.
    1. Exit Registry Editor.

1. Restart Outlook and Internet Explorer.

## More information

The following HTML sample automatically creates email messages:

```html
<html>
   <head>
      <title>Test</title>
   </head>
   <body>
      <FORM name=USER REGISTER action="mailto:<recipient e-mail address>" method=post target=_self encType=text/plain>
         <TABLE>
            <TBODY>
               <TD><FONT>Text</FONT></TD>
               <TD><INPUT name=Text></TD>
               <TD><INPUT type=submit value=Submit name=User Register></TD>
            </TBODY>
         </TABLE>
      </FORM>
   </body>
</html>
```

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.
