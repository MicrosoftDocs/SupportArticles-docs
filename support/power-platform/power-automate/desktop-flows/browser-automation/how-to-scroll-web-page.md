---
title: How to scroll on a web page
description: Suggestions and methods on how to scroll on a web page.
ms.custom: sap:Desktop flows\UI or browser automation
ms.reviewer: amitrou
ms.author: amitrou
author: amitrou
ms.date: 03/17/2025
---

# How to scroll on a web page

This article provides suggestions on how to scroll on a web page using web automation actions.

## Symptom

Web automation actions like "Click link on web page" or "Populate text field on web page" will scroll to the target element by default, before interacting with it. Additionally, the "Extract data from web page" action will extract only the data that are already loaded on the page.

If for some reason the web automation actions do not scroll or the Extract data does not extract all the results, then you can manually scroll on a web page, with the following Javascript approach.

## Verifying issue

To verify that the Web automation actions are not scrolling on the web page before interacting with an element, or the Extract data action is not extracting all the results, bring the web page to the foreground, watch the Desktop flow running and review the output variables. Use the following workaround to manually scroll on web page.

## Workaround

Please refer to this [article](https://learn.microsoft.com/en-us/power-automate/desktop-flows/how-to/scroll-web-page) or use the below workarounds.

Use the action "Run JavaScript function on web page" as shown below:

:::image type="content" source="media/how-to-scroll-web-page/scroll-js.png" alt-text="Screenshot of javascript code for scrolling on a web page.":::

```js
window.scrollTo(xpos, ypos)
```

In the above command xpos indicates the horizontal scroll and ypos indicates the vertical scroll.

To scroll all the way to the bottom of the web page, modify the command to:


```js
function ExecuteScript()
{
  window.scrollTo(0, document.body.scrollHeight);
}
```

### Load More button

Sometimes, there is a "Load More" element appearing at the bottom.

In order to load all the results, you should click on the "Load more" button and repeat that action as long as the element still exists. You can achieve this with a conditional loop ("Loop condition" action).

### How to scroll inside a web page element

If you want to scroll inside an element of a web page, you can use the HTML DOM property scrollTop.

The scrollTop property sets or returns the number of pixels an element's content is scrolled vertically.

An example of the JavaScript code would be:

```js
function ExecuteScript() {

document.getElementById('id_of_the_target_element').scrollTop -= 50;

}
```
