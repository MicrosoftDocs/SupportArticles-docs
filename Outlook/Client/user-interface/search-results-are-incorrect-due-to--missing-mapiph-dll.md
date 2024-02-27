---
title: Wrong search results due to missing MapiPH.dll
description: Provides a resolution for the issue that search results in Outlook are incorrect if the file Mapiph.dll is missing from your computer.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: gregmans
appliesto: 
  - Outlook 2013
  - Microsoft Outlook 2010
search.appverid: MET150
ms.date: 01/30/2024
---
# Search results in Outlook are incorrect because MapiPH.dll is missing

_Original KB number:_ &nbsp; 2739049

## Symptoms

When you use the Search feature in Outlook, nothing is returned in your search results even though there are email messages in your mailbox that match the search criteria.

## Cause

This problem can occur if the file Mapiph.dll is missing from your computer.

## Resolution

To resolve this problem, repair your Office installation.

1. Start Control Panel.
2. Under **Programs**, select **Uninstall a program**. (Note, you will Not be uninstalling Office)
3. Select your Office installation and select **Change**.
4. In the **Office installation** dialog box, select **Repair** and then select **Continue**.
5. When the repair process is finished, select **Finish**.

## More information

Events similar to the following items may be shown in the Application Event log if you are experiencing this problem.

### Outlook 2013

> Log Name: Application  
Source: Microsoft-Windows-Search  
Date: *DateTime*  
Event ID: 3036  
Task Category: Gatherer  
Level: Warning  
Keywords: Classic  
User: N/A  
Computer: *ComputerName*
>
> Description:  
The content source \<mapi15://{S-1-5-21-1004855881-4055995052-3487091797-1137}/> cannot be accessed.
>
> Context: Application, SystemIndex Catalog
>
> Details:  
No protocol handler is available. Install a protocol handler that can process this URL type. (HRESULT : 0x80040d37) (0x80040d37)

> Log Name: Application  
Source: Microsoft-Windows-Search  
Date: *DateTime*  
Event ID: 3083  
Task Category: Gatherer  
Level: Error  
Keywords: Classic  
User: N/A  
Computer: *ComputerName*
>
> Description:  
The protocol handler Mapi15 cannot be loaded. Error description: The specified module could not be found. (HRESULT : 0x8007007e).

### Outlook 2010

> Event Type: Error  
Event Source: Windows Search Service  
Event Category: Gatherer  
Event ID: 3083  
Date: *Date*  
Time: *Time*  
User: N/A  
Computer: *ComputerName*
>
> Description:  
The protocol handler Outlook.Search.MAPIHandler.1 cannot be loaded. Error description: The specified module could not be found.
