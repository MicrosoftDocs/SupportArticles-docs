---
title: Camera pictures are blurry or not focused
description: Improve camera quality in the Field Service mobile app on iOS devices by using the native iOS camera app instead.
ms.author: andreo
author: Andrea-Orimoto
ms.reviewer: mhart
ms.date: 11/20/2023
---

# Camera pictures are blurry or not focused

The Field Service mobile app uses a custom camera implementation, which is activated by default. The custom camera implementation was introduced to prevent the app from reloading due to high memory usage.

## Symptoms

The quality of the preview image in the camera is lower by design. When you take a picture with the camera in the Field Service mobile app on iOS devices, it might not meet the quality bar.

## Resolution

Users can use the native iOS camera app instead. Go to the app settings of the Field Service mobile app on your iOS device and turn off the **Use in-app camera** setting.

Because the camera consumes some resources along with the Field Service application, it might lead to some memory issues that can cause the application to crash. In that case, switch back to the Field Service camera.
