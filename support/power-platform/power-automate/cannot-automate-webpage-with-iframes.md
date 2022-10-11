---
title: Cannot automate webpage with iframes
description: Provides a workaround to make sure that web automation actions can interact with a web element that's inside a cross-domain iframe in Power Automate.
ms.reviewer: pefelesk
ms.date: 9/21/2022
ms.subservice: power-automate-desktop-flows
---
# Can't automate webpage with iframes

This article provides a workaround to an issue where you can't automate a webpage if a web element is inside a cross-domain iframe in Microsoft Power Automate.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4599053

## Symptoms

Web automation actions can't interact with a web element that is inside a cross-domain iframe. The element may be captured successfully during authoring. However, during runtime you receive an error message that resembles the following message:

> Click link on web page failed.

## Verifying issue

To verify that the web element is indeed inside a cross-domain iframe, follow these steps:

1. Open the web browser and locate the element.
2. Press F12 to open the DOM Explorer window of the browser.
3. Select the element through the DOM Explorer.
4. Within the DOM Explorer window, locate its parent iframe element.
5. Check the domain that hosts the iframe element.

The domain should be different than webpage's domain.

## Workaround

Open the source webpage of the iframe element on a new tab or a new browser window and continue the automation on the new webpage.

This procedure can be automated by capturing the embedded webpage's URL using the "Get details of element on web page" action. The attribute's value to be captured is the `src` attribute of the iframe element.

Then, use the "Launch new browser" or "Create new tab" action to open the new webpage.

> [!NOTE]
> There are cases where this workaround might not apply. For example, if the actions to be performed within the iframe window affect other fields of the parent webpage.
