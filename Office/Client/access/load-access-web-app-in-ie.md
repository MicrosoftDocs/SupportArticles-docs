---
title: An error has occurred when you load an Access web app in Internet Explorer
description: Describes an issue that triggers an Error has occurred. Sorry, something went wrong. Please try again later error. Occurs when you try to load a Microsoft Access web app in Internet Explorer. A resolution is provided.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
search.appverid: 
- MET150
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- Access for Office 365
- Access 2019
- Access 2016
- Access 2013
---

# "An error has occurred" message when you load an Access web app in Internet Explorer

## Symptoms

When you try to load a Microsoft Access web app in Internet Explorer, the app may not load completely, and then you receive an "Error has occurred. Sorry, something went wrong. Please try again later" error message.

![An error has occurred](./media/load-access-web-app-in-ie/error-message.jpg)

> [!NOTE]
> The "TECHNICAL DETAILS" section of the error does not show a value for the Correlation ID.

## Cause

Internet Explorer imposes a time-out limit for the server to return data through the ReceiveTimeout registry key. The value that's specified for this time-out may have been changed to a value that's less than what's needed for the server to respond to the Access app request.

## Resolution

To resolve this issue, follow the steps in the "More Information" section of the following article to increase the time-out setting to 5 minutes or to another value of your choice:

[KB 181050: Internet Explorer "connection timed out" error when server does not respond](https://support.microsoft.com/help/181050)
