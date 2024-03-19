---
title: Can't display SharePoint pages in iFrame
description: Describes why you're unable to load SharePoint Pages from a different domain inside an iFrame.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - sap:User experience\Other
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - SharePoint Online
search.appverid: MET150
ms.date: 12/17/2023
---
# Unable to display SharePoint pages from a different domain in iFrame

_Original KB number:_ &nbsp; 4531668

## Summary

An error occurs when loading SharePoint pages inside an iFrame that originate in a different domain.

## More information

This is by design. Loading pages in this manner will not work because the HTTP header property `X-FRAME-OPTIONS` is set to the value **SAMEORIGIN**.

Overriding this property by setting the web part to **AllowFraming** isn't recommended for security reasons. There are several functionalities that will not operate correctly when loaded into iFrame. (This behavior will vary from browser to browser.)
