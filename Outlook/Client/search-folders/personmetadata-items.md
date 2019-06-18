---
title: Outlook search folders show unexpected mail items with an empty subject
description: Explains why Outlook search folders may include items with a blank subject from the PersonMetadata folder.
author: simonxjx
manager: willchen
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
---

# Outlook search folders show unexpected mail items with an empty subject

## Summary

When you create a search folder for all mail items in Outlook 2013, Outlook 2016, Outlook 2019 or Outlook for Office 365, the folder may include unexpected items with a blank subject. If you move the mouse over these items, the following information is displayed: 

**In folder: PersonMetadata**

## More Information

The PersonMetadata folder is created and used by the [Outlook Customer Manager (OCM)](https://support.office.com/article/Outlook-Customer-Manager-FAQ-88e127ca-43a1-4c9d-8d52-6ad3a80f9c32). The folder is normally hidden from other parts of the Outlook user interface. However, search folders include mail items from this folder.

Although these items have a blank subject, they are actively used by OCM and should not be deleted or modified.It is a search folder limitation to include mail items from hidden folders.