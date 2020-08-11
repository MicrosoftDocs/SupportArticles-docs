---
title: Changing an existing Sandbox solution created in Visual Studio
description: Describes how to change an existing Sandbox solution that's created in Visual Studio.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: sharepoint-server-itpro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- SharePoint Online
- SharePoint Server
---

# Remove the assembly reference from your Sandbox solution created in Visual Studio

## Introduction

By default, the Visual Studio 2015 and 2013 templates for SharePoint Sandbox solutions automatically include an assembly-to-Sandbox solution file (wsp). This is true regardless of whether you have added any actual code in the solution. This process can be controlled by the **Include Assembly In Package** setting in the Visual Studio Project Properties view. The default value for this property is **True**. If you have created your Sandbox solution in Visual Studio and it doesn't contain actual code, you should change this setting to **False**. This makes sure that your Sandbox solution is fully declarative and doesn't contain any actual code.

## Procedure

To change an existing Sandbox solution that's created in Visual Studio, follow these steps:

1. Open the existing Visual Studio project for the Sandbox solution.
1. Open the **Properties** dialog box for the project. To do this, open the Visual Studio project in Solution Explorer, and then press the F4 key.
1. Locate and change the **Include Assembly In Package** property setting to ***False***.

   ![Changing the Include Assembly In Package property to False](./media/change-sandbox-solution/properties.png)

1. Recompile and then publish the new version of the Sandbox solution.

## More information

For more information, see [Removing Code-Based Sandbox Solutions in SharePoint Online](https://developer.microsoft.com/office/blogs/removing-code-based-sandbox-solutions-in-sharepoint-online/).

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
