---
title: Error in SharePoint "Something went wrong" when configuring SPFx component in a SharePoint Online page
ms.author: v-todmc
author: todmccoy
manager: dcscontentpm
ms.date: 4/16/2020
audience: ITPro
ms.topic: article
ms.service: sharepoint-online
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- SharePoint Online
ms.custom: 
- CI 115576
- CSSTroubleshoot 
ms.reviewer: lucaband 
description: Explains why you receive the error "Something went wrong" when configuring an SPFx component on a page in SharePoint Online.
---

# "Something went wrong" error configuring SPFx component in a SharePoint Online page

## Symptoms

You see the following error message when you configure a SharePoint Framework (SPFx) component on a page in SharePoint Online:

```
Something went wrong

If the problem persists, contact the site administrator and give them the information in Technical Details.
Technical Details
[SPLoaderError.loadComponentError]:
***Failed to load component "11111111-2017-4bc3-9a39-18dfdd167e1b" (DocumentNavigationWebPart).
Original error: ***Failed to load entry point from component "11111111-2017-4bc3-9a39-18dfdd167e1b" (DocumentNavigationWebPart).
Original error: Error loading https://component-id.invalid/11111111-2017-4bc3-9a39-18dfdd167e1b_0.0.1
Cannot redefine non-configurable property 'startsWith'
```

## Cause

This is a known issue when using Internet Explorer 11 with SharePoint Online. It occurs after the addition of a pollyfill.js file to support modern styling in SharePoint Online. As a result, third-party web parts that use polyfill.js will not work on pages in IE 11.

## Resolution

Microsoft is researching this problem and will post more information as it becomes available.


## More information

Still need help? Go to [Microsoft Community](https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fanswers.microsoft.com%2F&data=02%7C01%7Cv-todmc%40microsoft.com%7C98910814456c474880f108d7cf62d97d%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637205895885805857&sdata=9%2FYStDGvrU5ZIYXB7guowmaPlKazab0U%2BTpiBIItDaQ%3D&reserved=0).