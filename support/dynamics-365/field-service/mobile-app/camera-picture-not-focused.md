---
title: Camera pictures are blurry or not focused
description: Improves camera quality in the Dynamics 365 Field Service mobile app on iOS devices by switching to the native iOS camera app.
ms.author: andreo
author: Andrea-Orimoto
ms.reviewer: mhart
ms.date: 12/14/2023
ms.custom: sap:issue-performance
---
# Camera pictures are blurry or not focused in the Field Service mobile app

The Microsoft Dynamics 365 Field Service mobile app uses a custom camera implementation that's activated by default. The custom camera implementation was introduced to prevent the app from reloading due to high memory usage.

## Symptoms

The quality of the preview image in the camera is lower by design. When you take a picture with the camera in the Field Service mobile app on iOS devices, it might not meet the quality standard.

## Resolution

Users can use the native iOS camera app instead. Go to the app settings of the Field Service mobile app on your iOS device and turn off the **Use in-app camera** setting.

Because the camera consumes some resources along with the Field Service application, it might lead to some memory issues that can cause the application to crash. In that case, switch back to the Field Service camera.
