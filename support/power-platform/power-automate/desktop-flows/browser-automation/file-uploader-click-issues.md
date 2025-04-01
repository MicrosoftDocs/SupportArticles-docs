---
title: Press Button or Click Link On Web Page Doesn't Work With File Uploader
description: Solves issues related to interaction file uploader in web automation.
ms.custom: sap:Desktop flows\UI or browser automation
ms.reviewer: amitrou
ms.author: amitrou
author: andreas-mitrou
ms.date: 04/01/2025
---
# Press button or click link on web page doesn't work with a file uploader

This article provides workarounds for scenarios where interacting with a file uploader on a web page using automation actions fails.

## Symptoms

When you use [Press button on web page](/power-automate/desktop-flows/actions-reference/webautomation#pressbuttonbase) or [Click link on web page](/power-automate/desktop-flows/actions-reference/webautomation#clickbase) action in web automation, the action doesn't work as expected if the button or link on the web page is part of a file uploader. For example, the following HTML element is an example of a file uploader:

```html
&lt;SPAN style="font-size: 14px;font-style: normal;font-weight: 400"&gt;&ltinput type="file" /&gt;&lt;/SPAN&gt;
```

## Cause

[Web automation actions](/power-automate/desktop-flows/actions-reference/webautomation) create or modify events through scripts, which inform the browser whether the event is trusted. For more information, see [Event: isTrusted property](https://developer.mozilla.org/en-US/docs/Web/API/Event/isTrusted).

For security reasons, browsers may restrict the simulation of events that trigger file upload operations. This restriction ensures that file upload actions are initiated by the user directly, rather than through programmatic JavaScript events.

As a result, the **Press button on web page** and **Click link on web page** actions may not work when interacting with file uploaders.

## Workaround

Try one of the following workarounds:

1. Use the [Press button in window](/power-automate/desktop-flows/actions-reference/uiautomation#pressbutton) action to simulate user input, bypassing the browser's event validation.

    Capture the element from within the **Press button in window** action or through a desktop recorder, instead of using a web element that's either captured from a web automation action or a web browser recorder.

2. Use the **Click link on web page** action with the [Send physical click](/power-automate/desktop-flows/how-to/send-physical-clicks-web-element) option enabled.
