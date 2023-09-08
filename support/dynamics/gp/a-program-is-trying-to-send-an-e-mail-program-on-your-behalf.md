---
title: A program is trying to send an e-mail program on your behalf message
description: When you send a Word Template document via E-mail in Microsoft Dynamics GP, you may receive a message that states a program is trying to send an e-mail message on your behalf.
ms.reviewer: cwaswick
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# "A program is trying to send an e-mail program on your behalf" message when you send a Word Template document via E-mail

This article provides a workaround for the message **A program is trying to send an e-mail program on your behalf** that occurs when you send a Word Template document via E-mail in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 3091943

## Symptoms

Every time you send a Word Template document via e-mail, you see this message:

> A program is trying to send an e-mail message on your behalf. If this is unexpected, click Deny and verify your antivirus software is up-to-date. For more information about e-mail safety and how you might be able to avoid getting this warning, click Help.

## Cause

When the user selects SEND, the system looks for certain MAPI settings in the Win.ini file that are not there. (You could disable through Programmatic Access on the Trust Center window, but there is an easier fix.)

## Workaround

1. Open a Windows Explorer window and go to C:\Windows.
2. Make a backup of the Win.ini
3. Open the WIN.ini file found in this folder.
4. Look for the MAPIX setting in the file under the [Mail] section of the file.

    1. If the MAPIX setting reads MAPIX=0, change the 0 to a 1 and then save the file.
    2. If there is not a MAPIX setting under the Mail section, add `i. MAPIX=1` under the Mail section of the file:

5. Once you have modified the WIN.ini file, be sure to save the changes and then close the file.
6. Then you can restart both Microsoft Outlook and Microsoft Dynamics GP to ensure that the changes to the file are picked up.

If you run into trouble with editing the Win.ini, you can save this to your desktop and drag and drop it into the C:\Windows folder.

If this still does not work, you will need validate your Registry. The document below will walk you through on how to check your Registry for Mail. Go through steps 1-7 and choose Option A if you are 32-bit or Option B if you are 64-bit.

See [A program is trying to send an e-mail message on your behalf when trying to send a Template via E-mail](https://community.dynamics.com/blogs/post/?postid=87175f05-f890-4f9d-82ce-7ab6a00fdc5a) and select the link at the bottom to download the Registry MAPI Fix.doc.

> [!NOTE]
> As of 1/11/18 we found some situations where the Customer did have MAPIX=1 in the Win.ini file and it still did not work. We removed this line in the Win.ini and it started working. Not sure if there was a certain Windows update that is preventing this setting from being used.
>
> The steps above should resolve this error as a workaround. This is an Outlook message, and is occurring based on how your environment is set up and whether Outlook trusts the Microsoft Dynamics GP application to email on your behalf or not automatically.
>
> If you see side effects of this workaround such as the filename of the document that you are sending containing the path of the file from the user's TEMP folder (C:\\\\User\Username...\BlankInvoiceForm.docx), then remove the MAPIX=1 setting, and properly fix the issue in Outlook itself to prevent that warning by contacting a Microsoft Office resource.
