---
title: The Adapter is not of type GPAdapter error when activating a map in Connector
description: When you run a map in the Connector for Microsoft Dynamics GP, you receive an error message that states the Adapter is not of type GPAdapter. Provides a resolution.
ms.reviewer: ehagen
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# "The Adapter is not of type GPAdapter" error when activating a map in the Connector for Microsoft Dynamics GP

This article provides a resolution to solve the **Adapter is not of type GPAdapter** error that occurs when activating a map in the Connector for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2508778

## Symptoms

The following error occurs when running a map in the Connector for Microsoft Dynamics GP:

> The Adapter is not of type GPAdapter

## Cause

1. A Microsoft Dynamics GP 2010 map is being used for a Microsoft Dynamics GP 10 environment.
2. A Microsoft Dynamics GP 10 map is being used for a Microsoft Dynamics GP 2010 environment.

## Resolution

Delete the map and import the correct version by following the steps below:

1. Right-click on the map within the Connector for Microsoft Dynamics GP, and select **Delete**.
2. After deleting, right-click on your GP\CRM integration, and choose **Create New Map** from **File**.
3. When browsing to your maps, be sure you are selecting from the GP2010Maps folder if you are using GP2010, and the Maps folder when using GP10.
4. Select the proper `.map` file and select **Open**.
