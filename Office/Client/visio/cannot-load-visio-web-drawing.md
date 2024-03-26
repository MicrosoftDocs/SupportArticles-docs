---
title: Visio Services was unable to load this Web Drawing
description: Describes an issue in which you receive an error message when you try to load a Visio web drawing that is hosted on a different SharePoint farm. This issue occurs because Visio Services in Microsoft SharePoint does not support federations.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: parida, Arykhus, Kemille, barbway
appliesto: 
  - Visio Premium 2010
  - Visio Professional 2010
  - Visio Standard 2010
  - Visio Services in Microsoft SharePoint Server 2010
  - Visio Professional 2013
  - Visio Standard 2013
ms.date: 03/31/2022
---

# "Visio Services was unable to load this Web Drawing" when you load a Visio web drawing hosted on a different SharePoint farm

## Symptoms

Consider the following scenario:

- You have two server farms that are running Microsoft SharePoint.   
- You host a Visio web drawing on the first SharePoint farm.   
- You try to load the Visio web drawing on the second SharePoint farm.   

In this scenario, you receive the following error message: 

```adoc
Visio Services was unable to load this Web Drawing because the Web Drawing URL web part setting does not refer to an existing .VDW file or you do not have permissions to view it. To resolve this issue, verify that the Web Drawing URL refers to an existing .VDW file that you have permissions to view.
```

## Cause

This issue occurs because Visio Services in Microsoft SharePoint Server does not support federation. You can only display Visio web drawings on the SharePoint farm that hosts the drawing.
