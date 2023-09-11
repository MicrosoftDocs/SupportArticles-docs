---
title: An in-place edit of an embedded Word document that contains an ActiveX control causes flickering
ms.author: luche
author: helenclu
manager: dcscontentpm
ms.date: 09/09/2020
audience: Admin
ms.topic: troubleshooting
localization_priority: Normal
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Office
ms.custom: 
  - CI 123056
  - CSSTroubleshoot
ms.reviewer: sakris
description: How to resolve a situation where an in-place edit of a Word document in another Office document which contains an ActiveX control causes the Word document to flicker.
---

# In-place edit of an embedded Word document that contains ActiveX control causes flicker

## Symptoms

In an Office document, when you try to perform an in-place edit of an embedded Word document that contains an ActiveX control, the Word document flickers.

## Workaround

This is a known issue. To work around this issue, edit the embedded Word object in open mode. To do this, follow these steps:

1. Right-click the embedded Word document object.
2. Select **Document object**.
3. Select **Open**.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).