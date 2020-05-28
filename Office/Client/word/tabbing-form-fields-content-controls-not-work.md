---
title: Tabbing between form fields and content controls does not work
description: Provides a workaround for an issue in which you cannot move freely between form fields and content controls by using the TAB key if the "Filling in forms" editing restriction is enabled.
author: lucciz
ms.author: v-zolu
manager: dcscontentpm
audience: ITPro 
ms.topic: article 
ms.prod: office-perpetual-itpro
localization_priority: Normal
ms.reviewer: tomol, larryt, aldox, brandes, clatonh, almah, kfishe, saunderg, dkuy
ms.custom: CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- Word 2016
- Word 2013
- Microsoft Word 2010
---

# Tabbing between form fields and content controls does not work correctly in Word

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

##  Symptoms

Consider the following scenario. In Microsoft Word, you combine form fields (Legacy Tools) and content controls in the same document. Then, you enable the **Filling in forms** editing restriction. In this scenario, you cannot use the TAB key to move freely between the form fields and the content controls. You can tab from a form field to a content control. However, you cannot tab from a content control to a form field. Therefore, when you reach the first content control, you can only move between the content controls.

##  Cause

This issue occurs because the form fields and the content controls cannot work together.

##  Workaround

To work around this issue, use content controls only.

##  Status

This behavior is by design.