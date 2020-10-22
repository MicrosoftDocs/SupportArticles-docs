---
title: Outlook search folders show unexpected mail items with an empty subject
description: Explains why Outlook search folders may include items with a blank subject from the PersonMetadata folder.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- Outlook 2019
- Outlook 2016
- Outlook 2013
---

# Outlook search folders show unexpected mail items with an empty subject

## Summary

When you create a search folder for all mail items in Outlook 2013, Outlook 2016, Outlook 2019 or Outlook for Office 365, the folder may include unexpected items with a blank subject. If you move the mouse over these items, the following information is displayed:

**In folder: PersonMetadata**

## More Information

The PersonMetadata folder is created and used by the [Outlook Customer Manager (OCM)](https://techcommunity.microsoft.com/t5/outlook-customer-manager/faq-frequently-asked-questions-about-outlook-customer-manager/m-p/29680). The folder is normally hidden from other parts of the Outlook user interface. However, search folders include mail items from this folder.

Although these items have a blank subject, they are actively used by OCM and should not be deleted or modified. It is a search folder limitation to include mail items from hidden folders.

> [!NOTE]
> OCM is being deprecated in June 2020.

Even after the deprecation, the PersonMetaData folder and the items in it will be available for a limited time.  If you change or delete the items in this folder, they may be recreated or new ones might appear.  

Service changes coming in the near future will remove the PersonMetaData folder and its items from the service. Until then, use the following workaround to avoid including mail items from hidden folders in your search results:

1. Right-click the Search Folder and select **Customize This Search Folder**.
2. Click **Browse**, and deselect the **Search Subfolders** option.
3. Manually select the folders you wish to include.