---
title: Can't activate Office 2013 because something on the server isn't configured
description: A user receives an error message when they try to activate Office 2013 if modern authentication isn't enabled.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Azure Active Directory
  - Office 2013
ms.date: 03/31/2022
---

# "We can't sign you into your company portal" when activating Office 2013

## PROBLEM

When a user tries to activate Office 2013, the user receives the following error message:

**We can't sign you into your company portal because something on the server isn't configured correctly.**

The IDCRL log shows the following error:

```asciidoc
<6056,5268,13:40:30:233>: ## SOAP Response: ........
<s:Subcode><s:Value xmlns:a="http://schemas.xmlsoap.org/ws/2005/02/trust">
a:FailedAuthentication</s:Value></s:Subcode></s:Code><s:Reason><s:Text xml:lang="en-US">MSIS7068: Access denied.</s:Text>
```

Additionally, the TCO log shows the following errors:

```asciidoc
<Date><Time>:411::[4228] SignIn: creating new identity (kate@contoso.com)
<Date><Time>:411::[4228] Identity () Sign In requested for (kate@contoso.com)
<Date><Time>:475::[4228] IDCRLLibrary: GetAuthStateEx results: authState (0x80048800), requestStatus (0x800488ff)
<Date><Time>:475::[4228] InstrumentGetTicketFailure: IdP=2, error=0x800488ff
<Date><Time>:475::[4228] InstrumentGetTicketFailure for !error: wrong format for number!: dword3=0x!format error: not enough arguments!
<Date><Time>:475::[4228] AuthStatusFromHresult: 0x800488ff->ADFS Non retryable ADFS config error. Notify admin to check configuration in ADFS
<Date><Time>:475::[4228] InstrumentGetTicketFailure: IdP=2, error=0x800488ff
<Date><Time>:475::[4228] InstrumentGetTicketFailure for !error: wrong format for number!: dword3=0x!format error: not enough arguments!
<Date><Time>:475::[4228] Identity () SignIn failed (kate@contoso.com), error (ADFS Non retryable ADFS config error. Notify admin to check configuration in ADFS
```

## CAUSE

This issue occurs if modern authentication isn't enabled on the user's computer.

## SOLUTION

Enable modern authentication. For more information, see [Enable Modern Authentication for Office 2013 on Windows devices](https://support.office.com/article/enable-modern-authentication-for-office-2013-on-windows-devices-7dc1c01a-090f-4971-9677-f1b192d6c910).

## MORE INFORMATION

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).