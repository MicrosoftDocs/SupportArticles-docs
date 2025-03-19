---
title: Press button or click link on web page does not work on file uploader
description: Solves issues related to interaction file uploader in web automation.
ms.custom: sap:Desktop flows\UI or browser automation
ms.reviewer: amitrou
ms.author: amitrou
author: amitrou
ms.date: 03/17/2025
---

# Press button or click link on web page does not work on file uploader

This article provides several workkarounds when try to interact with the file uploader throug web automation actions.

## Symptoms

There are certain cases where using a **Press button on web page** or a **Click link on web page** action does not work as expected if the button or link on the web page is part of a file uploader, for example:

&lt;SPAN style="font-size: 14px;font-style: normal;font-weight: 400"&gt;&ltinput type="file" /&gt;&lt;/SPAN&gt;

## Cause

Web Automation actions create or modify events through scripts, which tells the browser whether the event is trusted (See more info [here](https://developer.mozilla.org/en-US/docs/Web/API/Event/isTrusted)).

For security purposes the browser may not allow pressing a button or clicking a link when those events will trigger a file upload operation.  This means that the button or link needs to be pressed/clicked by the user, instead of simulating the action with JavaScript.

Due to the above **Press button on web page** and **Click link on web page** actions may not work when triggering file uploads.

## Workaround 1

Use a **Press button in window** action to simulate user input and bypass the browser's event validation.

For the above to work, the user needs to capture the element from within the **Press button in window** action or through a Desktop recorder, instead of using a web element that was either captured from a Web Automation action or a Web browser recorder.

## Workaround 2

Use a **Click link on web page** action, with the option **Send physical click** (Advanced) enabled.
