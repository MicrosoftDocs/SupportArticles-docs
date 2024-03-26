---
title: Form region cannot be open in the Outlook 2010 preview pane
description: Describes an issue that triggers an error about Form region cannot be open in the Outlook 2010 preview pane after you install Skype for Business 2016.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: v-six
appliesto: 
  - Skype for Business 2016
  - Outlook 2010
ms.date: 03/31/2022
---

# "Form region cannot be open" error in the Outlook 2010 preview pane

## Problem 

After you install Skype for Business 2016 and then start Outlook 2010, you experience the following in the preview pane: 

- Conversation History items are no longer visible.   
- You receive the following error message: 

    **Form region cannot be open**   

## Workaround 

To work around this issue, disable the automatic loading of OcForms on the local computer. To do this, follow these steps.

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration ](https://support.microsoft.com/help/322756) in case problems occur.

1. In Registry Editor, locate the following subkey:  

    **HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\Outlook\Addins\OcOffice.OcForms\LoadBehavior**

2. Right-click the **LoadBehavior** registry key, type 0 for **Value data**, and then click **OK**.

## More information

This is a known issue with Skype for Business 2016 and Outlook 2010. 

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).