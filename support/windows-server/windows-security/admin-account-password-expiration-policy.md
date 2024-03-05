---
title: Administrator account password expiration behavior
description: Describes a by-design behavior of the administrator account password expiration policy.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, joramos
ms.custom: sap:account-lockouts, csstroubleshoot
---
# Administrator account password expiration behavior

This article describes a by-design behavior of the administrator account password expiration policy.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2837704

## Summary

The local Administrator (RID -500) account's password on a member server is expired and you're not prompted to change the password at the logon screen. You're allowed to log on and get access to the console. The setting "**User must change the password at next logon**" is checked in the Administrator's account properties. Once logged on, you may see the balloon pop-up with the message "**Consider changing your password**" from time to time.

In the local Administrator's account properties, if you manually uncheck the option "**User must change the password at next logon**", click OK, perform a logoff and then a logon, you'll notice the checkbox for that option is set back again in the user's properties. The checkbox for the setting "**User must change the password at next logon**" will be "checked" regardless until the password is in fact changed using **CTRL+ALT+DEL -> Change Password** while logged on.

A regular account manually created and added to the local Administrators group that has an expired password is in fact prompted to change the password at the logon screen, before you get access to the console.

## More information

This behavior is by design and expected to allow an administrator to log on to the system using the -500 RID account (also known as Administrator) to perform troubleshooting tasks even though the password has been expired. No other accounts are allowed to log on when their passwords have been expired for security reasons.

Any other accounts with an expired password that are members of the Administrators group or any built-in local groups, or that have the "**Allow Logon Locally**" user right aren't allowed to log on and are forced to change their password at the logon screen before getting access to the console.

> [!Note]
> The same behavior is valid for the domain Administrator account (-500 RID) in Active Directory when logging on to domain controllers.
