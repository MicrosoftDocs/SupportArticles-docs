---
title: Can't create CMMI team project in Chinese or Italian
description: This article provides workarounds for the problem that you can't create CMMI team project in Simplified Chinese or Italian in Team Foundation Server 2017 RTW.
ms.date: 08/14/2020
ms.custom: sap:Server Administration
ms.service: azure-devops-server
---
# Cannot create CMMI team project in Simplified Chinese or Italian in Team Foundation Server 2017 RTW

This article helps you work around the problem that you can't create CMMI team project in Simplified Chinese or Italian in Team Foundation Server 2017 RTW.

_Original product version:_ &nbsp; Team Foundation Server 2017  
_Original KB number:_ &nbsp; 3212690

## Symptoms

Users who install Team Foundation Server 2017 RTM in Simplified Chinese or Italian cannot create a team project by using the built-in CMMI template. When they try to do this, they receive a localized error message that resembles the following:

> VS403080: Group label already exists on the same page

## Workaround

The fix for this issue will be included in Team Foundation Server 2017 Update 1. Customers who require an immediate workaround can download and then reupload the CMMI template as a new template, as follows:

1. Connect to Team Foundation Server from Visual Studio 2017 RC or later.
2. Open Process Template Manager in the following location:

    **Team** -> **Team Project Collection Settings** -> **Process Template Manager**  

3. Download the **CMMI** template locally.
4. Edit the _ProcessTemplate.xml_ file in the downloaded root folder as follows:
      1. Change the type from **27450541-8E31-4150-9947-DC59F998FC01** to a new GUID. For example: **57860870-4ae5-4212-b591-1e4f7d905650**  
      2. Change the name so that it differs from **CMMI**. For example: **CMMI_fixed**.
5. Edit the _Task.xml_ file in the WorkItem `Tracking\TypeDefinitions` folder as follows:

    Search for the following text inside the \<WebLayout> element, and then replace it with the correct string.

    > [!NOTE]
    > There will be two instances of each text snippet in the file, and only the first instance should be updated. Additionally, the text snippets in question will also appear outside the WebLayout element, and these should not be changed.

    | Language| Find| Replace as |
    |---|---|---|
    |CHS|\<Group Label=:::no-loc text="\"计划\"":::>|\<Group Label=":::no-loc text="规划":::">|
    |ITA|\<Group Label="Pianificazione">|\<Group Label="Programmazione">|

6. Reupload the template.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
