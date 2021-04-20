---
title: Enabled CRM add-in causes Outlook keyboard shortcuts not working
description: Some Outlook 2010 keyboard shortcuts don't work after switching to the next or previous message when Dynamics CRM 2011 add-in is enabled.
ms.reviewer: debrau
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Outlook 2010 keyboard shortcuts not responding after switching to the next or previous message when Dynamics CRM 2011 add-in is configured

This article provides a resolution for the issue that some Office Outlook 2010 keyboard shortcuts fail to respond if Microsoft Dynamics CRM 2011 add-in has been enabled.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2909813

## Symptoms

After using the Office Outlook 2010 keyboard shortcuts to navigate to the next or previous e-mail message, additional keyboard shortcuts will fail to respond. This issue only occurs when the Microsoft Dynamics CRM 2011 add-in has been enabled and configured.

## Status

Microsoft has confirmed that this is a known issue. This issue will be addressed in the next major release of Microsoft Dynamics CRM.

## Workaround

To work around this issue:

1. Add the Previous Item and Next Item to the Quick Access Toolbar in Outlook using the steps in this article:

   [Customize the Quick Access Toolbar](https://support.microsoft.com/office/customize-the-quick-access-toolbar-43fff1c9-ebc4-4963-bdbd-c2b6b0739e52)

2. When hitting the Alt key, you can see the keyboard shortcut that corresponds to the Previous or Next Item.

   > [!NOTE]
   > This will depend on how many items that exist in the Quick Access Bar.
