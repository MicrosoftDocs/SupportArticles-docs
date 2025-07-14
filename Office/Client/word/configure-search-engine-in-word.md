---
title: Configure the default search engine in Word 2013
description: Describes how to change the default search engine for the feature that lets you perform a web search for a word in Word 2013. By default, the search is performed by Bing.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Open
  - CSSTroubleshoot
ms.author: luche
ms.reviewer: mmaxey
appliesto: 
  - Word 2013
ms.date: 06/06/2024
---

# How to configure the default search engine in Word 2013

## Introduction

Microsoft Word 2013 includes a feature that lets you use a search engine to search for a word in a Word document. By default, the search is performed by Bing. However, you can configure the feature to use a different search engine.

## More Information

To change the search engine that used to perform the search, create registry entries named SearchProviderName and SearchProviderURI, and then change these registry entries. For example, to configure Office.com as the default search engine, follow the steps that are described in the "Registry key information" section.

**Note** If the SearchProviderName and SearchProviderURI registry entries already exist, change these registry entries to specify the search engine that you want to use as the default search engine.

### Registry key information

Important This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: 

[322756 ](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows

To configure Office.com as the default search engine, follow these steps: 

1. Click **Start**, click **Run**, type regedit in the **Open** box, and then click **OK**.    
2. Locate and then select the following registry subkey:

   **HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Common\General**   
3. On the **Edit** menu, point to **New**, and then click **String Value**.   
4. Type **SearchProviderName**, and then press **Enter**.   
5. In the **Details** pane, right-click **SearchProviderName**, and then click **Modify**.   
6. In the **Value data** box, type **Office.com**, and then click **OK**.   
7. On the **Edit** menu, point to **New**, and then click **String Value**.    
8. Type **SearchProviderURI**, and then press **Enter**.    
9. In the **Details** pane, right-click **SearchProviderURI**, and then click **Modify**.    
10. In the **Value data** box, type "http://office.microsoft.com/en-us/results.aspx?&ex=2&qu=", and then click **OK**.   
11. Exit Registry Editor.   

**Note** The **SearchProviderNamefield** supports up to 253 characters.
