---
title: Cannot perform an Instant Search
description: Provides a resolution to make sure you can do an instant search in Microsoft Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: tmoore, gregmans
appliesto: 
  - Outlook 2013
  - Microsoft Outlook 2010
search.appverid: MET150
ms.date: 01/30/2024
---
# Outlook data not Instant Search indexed with malformed NoOST value

_Original KB number:_ &nbsp; 2984311

## Symptoms

In Microsoft Outlook, you are unable to perform an Instant Search. Instant Search attempts return the following messages:

In Outlook 2010

> No matches found for "*\<search string>*".  
 *Try searching again in All Mail Items*

Selecting Try searching again in All Mail Items returns:

> No matches found for "*\<search string>*".

In Outlook 2013

> We couldn't find what you were looking for.  
 *Find more on the server.*

if your Outlook client is currently connected to Microsoft Exchange Server. If it is working offline, you may receive the following:

> No matches found. Search is limited to the last 12 months because the server is unavailable.

Additionally, in both cases, Windows Search Indexing Options may report Indexing complete.

## Cause

This behavior can occur if the following registry value is configured:

`HKEY_CURRENT_USER \Software\Microsoft\Office\x.0\Outlook\OST`  
Name: NoOST  
Type: any type other than REG_DWORD

Where x.0 is 15.0 for Outlook 2013, or 14.0 for Outlook 2010.

The `NoOST` registry value must be created as a DWORD. If configured incorrectly, Windows Search will fail to index the local Outlook data, resulting in no results returned on search attempts.

## Resolution

Delete the `NoOST` registry value, and if needed, recreate it as a DWORD, using the steps below.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

1. Quit Outlook.
2. Launch the Registry Editor using the appropriate steps below.

    **Windows 7**

    From the **Start** menu, select **Run**, type *regedit* in the Open box, and then select **OK**.

    **Windows 8/8.1**

    From the **Start** screen, type *regedit* and press Enter.

3. Locate and then select the following registry key:

    `HKEY_CURRENT_USER \Software\Microsoft\Office\x.0\Outlook\OST`

    Where x.0 is 15.0 for Outlook 2013, or 14.0 for Outlook 2010.

4. Right-click the NoOST value, select **Delete**, and select **Yes** to confirm the deletion.
5. If needed, from the **Edit** menu select **New** and select DWORD (32-bit) Value.
6. Type *NoOST* and press Enter.
7. From the **File** menu, select **Exit** to close the Registry Editor.
