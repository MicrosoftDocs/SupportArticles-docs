---
title: Camera pictures are blurry or not focused
description: Improves camera quality in the Dynamics 365 Field Service mobile app on iOS devices by switching to the native iOS camera app.
ms.author: andreo
author: Andrea-Orimoto
ms.reviewer: mhart
ms.date: 12/21/2023
ms.custom: sap:Mobile Application\Issues with performance
---
# Camera pictures are blurry or not focused in the Field Service mobile app

The Microsoft Dynamics 365 Field Service [mobile app](/dynamics365/field-service/mobile-powerapp-windows) uses a custom camera implementation that's activated by default. The custom camera implementation was introduced to prevent the app from reloading due to high memory usage.

## Symptoms

When you take a picture with the camera in the Field Service mobile app on iOS devices, you might find the pictures are blurry and don't meet the quality standard.

## Resolution

The quality of the preview image in the camera is lower by design. To get higher quality pictures, you can use the native iOS camera app instead. Go to the app settings of the Field Service mobile app on your iOS device and turn off the **Use in-app camera** setting.

Because the camera consumes some resources along with the Field Service application, it might lead to some memory issues that can cause the application to crash. In that case, switch back to the Field Service camera.
