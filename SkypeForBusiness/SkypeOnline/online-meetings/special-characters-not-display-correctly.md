---
title: Special characters don't display correctly in footer of meeting invitations
description: Describes an issue in which special characters don't display correctly in the footer of Lync meeting invitations. Provides a workaround.
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

# Special characters don't display correctly in the footer of Lync meeting invitations

## Problem

Customized meeting invitation footers in Skype for Business Online (formerly Lync Online) that contain special characters, such as the copyright (©) and registered trademark (®) characters, don't display correctly in the footer of Lync meeting invitations when the invitations are viewed in Outlook. This also affects characters of some specific language characters, such as Japanese.

## Workaround

In some cases, you can work around this issue. To do this, create the customized footer by using HTML symbol codes, and then create the online Lync meeting in Outlook Web App.

When you create the customized meeting invitation footer in the Lync Admin Center, you should use specific HTML codes for special characters instead of copying and pasting from another source. For example, you want to add the following message that contains the copyright and registered trademark characters at the bottom of all Lync meeting invitations:

**Contoso © Corporation, Contoso ™ is a registered trademark**

Instead of copying and pasting that message directly into the form in the Lync Admin Center, you would replace the copyright and registered trademark characters with the HTML character codes, such as the following:

**Contoso &copy; Corporation, Contoso &trade; is a registered trademark**

Character codes such as these are standard and are understood by many browsers and applications that display HTML or rich text. When you use such codes, the characters display accurately in meeting invitations, but only when you create the meeting by using Outlook Web App.

For more information about HTML character codes and how to create Skype for Business Online meetings in Outlook Web App, go to the following websites:

- [W3Schools HTML Symbols](https://www.w3schools.com/html/html_symbols.asp)   
- [Set up a Lync Meeting](https://office.microsoft.com/redir/ha102827058.aspx)   
> [!NOTE]
> If you create the meeting in Outlook, even if you include the HTML characters in the footer, the characters won't display correctly either before or after you send the meeting invitation. If you create the meeting in Outlook Web App, the special characters will display correctly both before and after you send the meeting invitation.

## More Information

This issue occurs because the Lync Meeting add-in for Outlook 2013 doesn't encode the meeting invitation and the footer message, and the message is inserted into RTF as an ANSI code. When the add-in transfers the RTF invitation message to Outlook, it changes the invitation message to UTF-8 code. However, UTF-8 code can't display the special characters.

When Outlook tries to read the RTF message, there is no UTF-8 flag before this message. Therefore, Outlook considers the UTF-8 invitation message to be in ANSI code, and the message is garbled.

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-information-disclaimer.md)]

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).