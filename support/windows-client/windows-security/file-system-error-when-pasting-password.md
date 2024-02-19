---
title: Fail to paste password into credential dialog box
description: Provides help to fix a File system error that occurs when you paste password into a credential dialog box.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-jeffbo, travisa
ms.custom: sap:kerberos-authentication, csstroubleshoot
---
# "File system error" when pasting password into credential dialog box in Windows 10

This article provides help to fix a File system error that occurs when you paste password into a credential dialog box.

_Applies to:_ &nbsp; Windows 10  
_Original KB number:_ &nbsp; 4092998

## Symptoms

Consider the following scenario:  

- You try to start an application by using elevated permissions. For example, you right-click cmd.exe and select **Run as administrator**.
- A User Account Control (UAC) dialog box prompts you for your user name and password.
- You press Ctrl+V to paste in the password.  

In this scenario, you receive the following error messages:  

> This program does not have a program associated with it for performing this action.

> File system error (-1073741189).

During investigation, you notice that Consent.exe crashes when the issue occurs. The error maps to the following information:

| Code| Symbolic Name| Error Description| Header |
|---|---|---|---|
|Hex: 0xc000027b<br />Dec: -1073741189|STATUS_STOWED_EXCEPTION|An application-internal exception has occurred.|ntstatus.h|
  
> [!NOTE]
> If you right-click the password box, a shortcut menu does not open.  

## Cause

Pasting the contents of the clipboard into a secure input box is intentionally blocked in Windows 10. However, the Consent.exe crash is a software problem.

Windows 10 introduces a security change that blocks clipboard access from the Winlogon desktop (also known as the secure desktop). This change prevents an unauthorized user from seeing information on the clipboard. For example, consider the following scenario:  

- Authorized user A copies some information to the clipboard and then locks the computer.
- Unauthorized user B wakes up the computer (which is at the lock screen) and starts **Narrator -> Narrator Help**. From there, unauthorized user B can paste the clipboard contents into a text box in Narrator Help and then read the clipboard content.  

A side effect of this change is that by default it is no longer possible to paste information into the password text box for UAC elevation.

## Resolution

To fix the consent.exe crashing issue, install the Windows 10 cumulative update that was released on April 23, 2018 or later cumulative updates. For more information, see [April 23, 2018-KB4093105 (OS Build 16299.402)](https://support.microsoft.com/help/4093105).

> [!NOTE]
> This update only fixes the consent.exe crashing issue. Pasting password to secure input box is still blocked.  If you want to paste the password to UAC, see the "Workaround" section.  

## Workaround

To work around this issue, display the UAC elevation prompt on the standard user desktop instead of on the Winlogon desktop. The UAC prompt behavior can be configured by using Group Policy. See [User Account Control: Switch to the secure desktop when prompting for elevation](/windows/security/threat-protection/security-policy-settings/user-account-control-switch-to-the-secure-desktop-when-prompting-for-elevation)  for more information.

## More information

Changing the desktop when UAC is displayed might raise security concerns. However, the copy/paste mechanism of moving the password from password vault software to a UAC prompt invalidates the security protection that is provided by the Winlogon desktop.

The reason why UAC prompts are displayed by default on the Winlogon desktop is that no nonsecure process (for example, one that is not already running as SYSTEM) can spy on passwords or other information that is input into the UAC dialog box. However, as soon as the password is copied and on the clipboard on the standard user desktop, any process that is running in that desktop can read that data in plain text. In effect, the potential security breach has already occurred with no need for any process to try to read the password information from a UAC dialog box.

Microsoft has verified that the security fix that is implemented in Windows 10 to enforce the correct security boundary from the standard desktop to the Winlogon desktop is the desired behavior, and this will likely remain the behavior in future versions of Windows.
