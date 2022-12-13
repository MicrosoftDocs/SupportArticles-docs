---
title: Power automate Javascript SDK help
description: Description of the recommended usage of the Power Automate SDK.
ms.reviewer:
ms.topic: troubleshooting
ms.date: 12/12/2022
ms.subservice: power-automate-flows
---
# Power Automate JS SDK

The Power Automate team provides the JS SDK to facilitate integrating Flow widgets in third-party applications. The Flow JS SDK is available as a public link in the Flow service and lets the host application handle events from the widget and interact with the Flow application by sending actions to the widget. Widget events and actions are specific to the widget type.

## How do I include the SDK in my application or webpage.

The Flow JS SDK reference needs to be added to the host application using the following code.

```html
<script src="https://make.powerautomate.com/Content/msflowsdk-1.1.js"></script>
```

## Including a local copy of the SDK in your application

While its possible to include a local copy of the SDK in your application or website, it is not the recommended way to include the SDK. If you are using a local copy of the SDK it is recommended that you ensure that the SDK is up to date with the latest version periodically. Failure to do so can at times result in the widget not functioning properly. 

## What do I do if the widget fails to load?

If the widget fails to load ensure that you are using the latest version of the SDK, followed by checking the widget parameters to ensure the settings passed to the widget are accurate. As of January 17th 2022, there is a required version update which can cause widgets using local copies to fail. Please ensure the widget SDK is up to date to ensure that it functions correctly.