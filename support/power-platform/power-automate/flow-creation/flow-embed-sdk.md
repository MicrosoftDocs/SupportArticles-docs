---
title: Working with Power Automate's JavaScript SDK
description: Description of the recommended usage of the Power Automate's JavaScript Software Developer Kit (JS SDK).
ms.reviewer: hamenon, rymacdow
ms.date: 12/12/2022
ms.custom: sap:Flow creation\Other flow creation issues
ms.topic: how-to
---
# How to use Power Automate's JavaScript Software Developer Kit

The Power Automate team provides the JavaScript Software Developer Kit (JS SDK) to facilitate integrating Flow widgets in third-party applications. The Flow JS SDK is available as a public link in the Flow service. It lets the host application handle events from the widget and interact with the Flow application by sending actions to the widget. Widget events and actions are specific to the widget type.

## How to include the SDK in an application or webpage

The Flow JS SDK reference needs to be added to the host application using the following code:

```html
<script src="https://flow.microsoft.com/Content/msflowsdk-1.1.js"></script>
```

## Including a local copy of the SDK in your application

While it's possible to include a local copy of the SDK in your application or website, it's not the recommended way to include the SDK. If you're using a local copy of the SDK, it's recommended that you ensure that the SDK is up to date with the latest version periodically. Otherwise, the widget won't always function properly.

## What to do if the widget fails to load

If the widget fails to load, ensure that you're using the latest version of the SDK. Then, check the widget parameters and ensure the settings passed to the widget are accurate. As of January 17, 2022, there's a required version update that can cause widgets using local copies to fail. Ensure the widget SDK is up to date to ensure that it functions correctly.
