---
title: Outlook crashes when you call GetProps
description: "Describes a problem in which Outlook crashes when you call IMAPIProp::GetProps on a stale MAPI object."
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Developer Issues\Add-in errors
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: gbratton, catagh
appliesto: 
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Outlook for Microsoft 365
  - Outlook 2019
search.appverid: MET150
ms.date: 01/30/2024
---
# Outlook crashes when you call IMAPIProp::GetProps on a stale MAPIOBJECT

_Original KB number:_ &nbsp; 4131515

## Symptoms

Consider the following scenario:

- You create an email message by using Microsoft Outlook.
- You attach an existing email message to the new message.
- You open the attached message for viewing.
- You use the [NewInspector event](/previous-versions/office/developer/office-2003/aa171301(v=office.11)) to get a reference to the current [Outlook.MailItem](/dotnet/api/microsoft.office.interop.outlook.mailitem) that corresponds to the email attachment that you just opened.
- From the **MailItem** object, you get a reference to the underlying MAPI object by reading the **[MAPIOBJECT](/dotnet/api/microsoft.office.interop.outlook._mailitem.mapiobject)** property in C++.
- You save the message or Outlook initiates an AutoSave operation.
- You start the **[GetProps](/office/client-developer/outlook/mapi/imapiprop-getprops)** method on an **[IMAPIProp](/office/client-developer/outlook/mapi/imapipropiunknown)** reference from the `MAPIOBJECT` reference that you obtained through the NewInspector event.

In this scenario, Outlook crashes.

## Cause

The MAPI object that you obtained from the `MAPIOBJECT` property has become stale and is no longer usable. You should not reuse the property if the corresponding Outlook item has changed.

## Resolution

Every time that you have to run an operation on the MAPI object that maps to an Outlook or Outlook Object Model item, you should get a new reference to the underlying MAPI object. Then, run any MAPI operations on that new reference instead of on a stale reference that might no longer be valid. Using a stale reference might cause unexpected behavior and crash the Outlook client.

## More information

We recommend that you don't hold onto any `MAPIOBJECT` references that you obtained through the Outlook Object Model for longer than necessary. This is because the underlying object is frequently subject to change. Using a stale underlying object might cause unexpected errors.
This applies to all scenarios in which you might have to get a `MAPIOBJECT` reference through the Outlook Object Model, not only the scenario that is mentioned in the "Symptoms" section.
