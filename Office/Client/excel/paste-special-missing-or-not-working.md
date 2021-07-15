---
title: Paste Special option is missing or not working in Microsoft Office
description: If your Paste Special option is missing,  look here. Paste Special allows you to paste using the formatting of your choice.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro 
ms.topic: article 
ms.prod: office-perpetual-itpro
localization_priority: Normal
ms.custom: CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- office
---

# Paste Special option is missing or not working in Microsoft Office

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

If you have Skype installed, please read: [Text has incorrect format when using paste in Microsoft Office](https://support.microsoft.com/help/2697462).
Paste Special can make the task of pasting text go more smoothly by letting you choose which formatting you want to keep (source or destination) or by stripping all the formatting and just pasting the text. If you are having issues with Paste Special, continue on to the resolutions below:

##  Resolution

To see if the **Paste Special** option is enabled: 
 
1. Go to **File** > **Options** > **Advanced**.    
2. Under **Cut, copy and paste**, ensure the **Show Paste Options button when content is pasted** option is checked. 

 Ensure that all instances of the web browsers that you use are closed and try to use the **Paste Special** option again. Paste special will not function if your web browser is causing the conflict. Windows Internet Explorer (8-9) do not conflict with the Excel 2010 Paste Special option. Third party Add-ins can cause a variety of issues, one of then being, conflicting with the Paste Special option. To determine if an add-in is causing the issue:

1. Find the Microsoft Excel icon.   
2. Press and hold the CTRL key and double-click the application shortcut.
3. Click **Yes** when a window appears asking if you want to [start the application in Safe Mode](https://support.microsoft.com/office/open-office-apps-in-safe-mode-on-a-windows-pc-dedf944a-5f4b-4afb-a453-528af4f7ac72).

   > [!NOTE]
   > If you have an icon on your desktop, hold the CTRL key and click on the icon. This works with any Microsoft Office product.
 
4. If the **Paste Special** option works in the Safe Mode as follows, enable your Add-ins one by one until you hit that one that is causing the conflict. Leave that one disabled or uninstall it.

   > [!NOTE]
   > For more information, see [Adding or Removing Add-ins](https://office.microsoft.com/excel-help/add-or-remove-add-ins-HP010342658.aspx) and [Working with Office Safe Modes.](https://office.microsoft.com/excel-help/work-with-office-safe-modes-HP010354300.aspx).

    ![paste special](./media/paste-special-missing-or-not-working/paste-special.jpg)  
    ![paste special settings](./media/paste-special-missing-or-not-working/paste-special-settings.jpg) |

> [!NOTE]
> Using the `PasteSpecial` method for a `Range` object triggers the `Worksheet.Activate` event. You need to set the value of the `Application.EnableEvents` property to `False` to disable the trigger.

You can also get help from the [Microsoft Community](https://answers.microsoft.com/) online community, search for more information on [Microsoft Support](https://support.microsoft.com/search/) or [Windows Help and How To](https://office.microsoft.com/support/), or learn more about [Assisted Support](https://support.microsoft.com/contactus/) options.
