---
title: Can't automate webpage with cross-domain iframes in Power Automate
description: Provides a workaround to make sure that web automation actions can interact with a web element that's inside a cross-domain iframe in Microsoft Power Automate.
ms.reviewer: pefelesk, nimoutzo
ms.date: 08/21/2023
ms.custom: sap:Desktop flows\Power Automate for desktop errors
---
# Can't automate webpage with cross-domain iframes

This article provides a workaround to an issue where you can't automate a webpage if a web element is inside a [cross-domain iframe](/power-platform/release-plan/2023wave1/power-automate/use-web-automation-access-cross-domain-iframes) in Microsoft Power Automate.

> [!NOTE]
> Web automation in cross-domain iframes is supported since Power Automate for desktop version 2.31 (April 2023). This article is for versions older than 2.31.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4599053

## Symptoms

Web automation actions can't interact with a web element that is inside a cross-domain iframe. The element may be captured successfully during authoring. However, during runtime you receive an error message that resembles the following message:

> Click link on web page failed.

## Verifying issue

To verify that the web element is indeed inside a cross-domain iframe, follow these steps:

1. Open the web browser and locate the element.
2. Press <kbd>F12</kbd> to open the DOM Explorer window of the browser.
3. Select the element through the DOM Explorer.
4. Within the **DOM Explorer** window, locate its parent iframe element.
5. Check the domain that hosts the iframe element.

The domain should be different than webpage's domain.

## Workaround

Open the source webpage of the iframe element on a new tab or a new browser window and continue the automation on the new webpage.

This procedure can be automated by capturing the embedded webpage's URL using the "Get details of element on web page" action. The attribute's value to be captured is the `src` attribute of the iframe element.

Then, use the "Launch new browser" or "Create new tab" action to open the new webpage.

> [!NOTE]
> There are cases where this workaround might not apply. For example, if the actions to be performed within the iframe window affect other fields of the parent webpage.
