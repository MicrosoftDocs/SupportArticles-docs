---
title: Changing an existing Sandbox solution created in Visual Studio
description: Describes how to change an existing Sandbox solution that you create in Visual Studio.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Administration\Other
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
  - SharePoint Server
ms.date: 12/17/2023
---

# Remove the assembly reference from your Sandbox solution created in Visual Studio

## Introduction

By default, the Visual Studio 2015 and 2013 templates for SharePoint Sandbox solutions automatically include an assembly-to-Sandbox solution file (.wsp). It's true regardless of whether you added any actual code in the solution. This process can be controlled by the **Include Assembly In Package** setting in the Visual Studio Project Properties view. The default value for this property is **True**. If you create your Sandbox solution in Visual Studio and it doesn't contain actual code, you should change this setting to **False**. It makes sure that your Sandbox solution is fully declarative and doesn't contain any actual code.

## Procedure

To change an existing Sandbox solution that you create in Visual Studio, follow these steps:

1. Open the existing Visual Studio project for the Sandbox solution.
1. Open the **Properties** dialog box for the project. To do so, open the Visual Studio project in Solution Explorer, and then press the F4 key.
1. Locate and change the **Include Assembly In Package** property setting to ***False***.

   :::image type="content" source="media/change-sandbox-solution/properties.png" alt-text="Screenshot of the Properties dialog box, changing the Include Assembly In Package property to False." border="false":::

1. Recompile and then publish the new version of the Sandbox solution.

## More information

For more information, see [Removing Code-Based Sandbox Solutions in SharePoint Online](https://developer.microsoft.com/office/blogs/removing-code-based-sandbox-solutions-in-sharepoint-online/).

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
