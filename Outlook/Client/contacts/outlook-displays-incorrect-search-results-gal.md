---
title: Outlook displays incorrect results when searching for users in GAL in Exchange Server
description: Provides a workaround for an issue in which Outlook displays incorrect search results of a GAL in Exchange Server 2007, Exchange Server 2010, or Exchange Server 2013.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: kazuyou
appliesto: 
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
  - Microsoft Office Outlook 2007
  - Microsoft Outlook 2010
  - Outlook 2013
search.appverid: MET150
ms.date: 01/30/2024
---
# Outlook displays incorrect search results of the GAL in Exchange Server

_Original KB number:_ &nbsp;2497077

## Symptoms  

When you use Microsoft Office Outlook 2007, Outlook 2010, or Outlook 2013 to search for users in a global address list (GAL) in Microsoft Exchange Server 2007, Exchange Server 2010 or Exchange Server 2013, the following issues may occur:

- When you select the option that sorts the search results by using the **[Display Name]**  field under Advanced Find of Outlook Address Book, the results aren't sorted by using the **[Display Name]** column.
- When you search for objects that have a user name or a distribution list name, the search operation doesn't return the correct object if the **[Name only]** option is enabled.

> [!NOTE]
> When the **[More columns]** option is enabled, the search operations return the correct results.

## Cause

This issue occurs because Active Directory Domain Services (AD DS) uses furigana for indexing in Windows Server 2008.

When phonetic display names are set to user or distribution group objects in AD DS in Windows Server 2008, an index of the phonetic display name is generated on the global catalog server. The index is used for searching or arranging a search result of a GAL in the Japanese version of Outlook. When the objects in GAL do not have a phonetic display name, the display name is used for indexing. If the **[name only]** option is selected, the search scope is restricted to objects that have phonetic display names. Therefore, you receive incorrect results when you search an address book in Office Outlook if objects don't have phonetic display names.

For example, you search for a display name that differs from its phonetic display name in a GAL in which some objects don't have phonetic display names. In this scenario, the object that has the matching display name in the **[Display name]** column isn't returned in the search results, and only the objects that have phonetic display names are returned.

If the phonetic display name of all the users and distribution lists on the GAL isn't set, a search that uses the **[Name only]** option returns correct results. Correct results are returned because the index for phonetic display names includes only display names.

## Workaround

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
[322756 How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756)

To work around this issue, use one of the following methods:

To have us fix this problem by using method 1 for you, go to the "[Let me fix it myself](#let-me-fix-it-myself)" section.

### Let me fix it myself

- Method 1

    1. Click **Start**:::image type="icon" source="./media/outlook-displays-incorrect-search-results-gal/vista-start-button.png":::, click **Run**, type *Regedit*, and then press **OK**.
    1. Locate and then click the DisableGALPhonetic registry entry in one of the following registry subkeys:
        - `HKEY_CURRENT_USER\Software\Policies\Microsoft\Exchange\Exchange Provider`
        - `HKEY_CURRENT_USER\Software\Microsoft\Exchange\Exchange Provider`

    > [!NOTE]
    > If the DisableGALPhonetic registry entry doesn't exist, you must create this entry. To do this, follow these steps:

    1. On the **Edit** menu, click **New**, and then click **DWORD(32-bit) Value**.
    1. Type *DisableGALPhonetic*, and then press ENTER.
    1. Right-click **DisableGALPhonetic**, click **Modify**, type *1* in the **Value data** box, and then click **OK**.
    1. Exit Registry Editor, and then restart the computer to apply the change.

- Method 2

    Use the **[More columns]** option instead of the **[Name only]** option when you search the GAL for objects that have furigana and for objects that don't have furigana.

### Did this fix the problem

Check whether the problem is fixed. If the problem is fixed, you're finished with this section. If the problem isn't fixed, you can [contact support](https://support.microsoft.com/contactus/).

## More information

Outlook clients connect to Client Access Server (CAS) in the Exchange Server 2010 organization. However, CAS doesn't support the index of furigana when you search or view the GAL in Outlook in Exchange Server 2010 RTM. When you use the not-cached mode to search the address list in Office Outlook, the matching users aren't returned in the search result. However, the bottom objects of the address list are selected. To resolve this issue, install Exchange Server 2010 Service Pack 1 (SP1).
