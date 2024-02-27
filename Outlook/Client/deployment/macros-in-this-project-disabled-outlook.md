---
title: Macros in this project are disabled for macros assigned Digital Signature certificate in Outlook
description: Describes a solution to solve the error (The macros in this project are disabled) in Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: gbratton, gdowling
appliesto: 
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
search.appverid: MET150
ms.date: 01/30/2024
---
# Error when running macros that are assigned a Digital Signature certificate in Outlook: The macros in this project are disabled

_Original KB number:_ &nbsp;4465120

## Symptoms

Considering the following scenario:

- You set the Macro Security to **Notifications for digitally signed macros, all other macros disabled** on the **Developer**  tab in Microsoft Outlook.
- You create a macro and assign a Digital Signature certificate to the macro under **Tools** > **Digital Signature** in Visual Basic.
- You close Visual Basic and Outlook. When you're prompted to save the Visual Basic project, you click **Yes**.
- You start Outlook, and then you start Visual Basic.

 In this scenario, you receive the error message: **An error occurred while attempting to verify the VBA project's signature. Macros will be disabled**.

 When you try to run the macro, you receive the error message: **The macros in this project are disabled. Please refer to the online help or documentation of the host application to determine how to enable macros**.

## Cause

This issue occurs because exiting Visual Basic effectively cancels the changes that you made to the project, so the certificate is no longer assigned to the macro.

## Resolution

Manually save the changes that you made to the project before you close the Visual Basic window by using either of the following methods:

- Go to **File** > **Save VbaProject.OTM**.
- Click the **Save** icon on the toolbar in the Visual Basic window.
