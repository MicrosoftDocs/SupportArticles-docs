---
title: Password to modify a presentation is required when you open the presentation
description: Explains that you are prompted to provide a password to open a presentation even though you set a password only to modify the presentation in PowerPoint. To resolve this issue, you can click Read Only when you open the presentation.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: office-perpetual-itpro
ms.custom: CSSTroubleshoot
ms.topic: article
ms.author: v-six
appliesto:
- PowerPoint 2007
- PowerPoint 2003
- PowerPoint 2002
---

# Password to modify a presentation is required when you open the presentation in PowerPoint

## Symptoms

If you save a Microsoft PowerPoint presentation that requires a password to modify the presentation, but not a password to open the presentation, you are still required to type a password the next time that you open the presentation.

When you attempt to open the presentation, you receive the following message regardless of whether you intend to modify or just open the presentation: 

```asciidoc
Password 'Filename.ppt' is reserved by 'username'.

Enter password to modify, or open read only.

You can either type the password, click Cancel to stop the file-open process, or open the file in a read-only format.
```

## Cause

This issue occurs because PowerPoint prompts you for any password applied to a presentation as soon as you open the presentation file, regardless of whether the password is used to modify or just open the file.

## Resolution

To resolve this issue, click Read Only when you are first prompted for a password when you open the file. If you want to modify the presentation, type the password at this time.

## More information

### Methods to protect a presentation from unauthorized users

#### Require a password to modify the document

To allow all users to open the document but allow only authorized users to make changes to it, you can assign a password, which the user is required to type before modifying the document. If a user modifies the document without using the password, that user can save the document only by giving it a different file name.

If you type a password in the **Password to modify** box, users are prompted for a password when they open the presentation. The presentation is opened when the user types the correct password. Or, the user can open the presentation as read-only.

#### Require a password to open the document

To prevent unauthorized users from opening a document at all, you can assign a password to your presentation.

If you type a password in the **Password to open** box, the presentation is opened when the user types the correct password. If the user forgets or loses the password, he or she cannot open the presentation.

### How to require a password

#### How to require a password in Microsoft PowerPoint 2002 and in Microsoft Office PowerPoint 2003

To require a password to modify the document, follow these steps:

1. Open the presentation.
2. On the File menu, click Save As.
3. On the Tools menu, in the Save As dialog box, click Security Options.
4. In the **Password to modify** box, type a password, and then click OK.
5. In the **Re-enter password to modify** box, type the password again, and then click OK.
6. Click Save.

To require a password to open the document, follow these steps:

1. Open the presentation.
2. On the File menu, click Save As.
3. On the Tools menu, in the Save As dialog box, click Security Options.
4. In the **Password to open** box, type a password, and then click OK.
5. In the **Re-enter password to open** box, type the password again, and then click OK.
6. Click Save.

#### How to require a password in Microsoft Office PowerPoint 2007

To require a password to modify or to open the document, follow these steps:

1. Open the presentation.
2. Click the **Microsoft Office Button** ![ Microsoft Office Button](./media/require-password-to-modify-presentation/office2007filebutton.jpg), point to **Save As**, and then click **PowerPoint Presentation**.
3. Click **Tools**, and then click **General Options**.
4. In the **General Options** dialog box, type a password for opening or for modifying the file.
5. Click **OK**, and then click **Save**.
