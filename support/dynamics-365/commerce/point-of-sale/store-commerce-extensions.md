---
title: Troubleshoot Store Commerce extension issues in Dynamics 365 Commerce Store Commerce app
description: Explains how to troubleshoot extension issues in the Microsoft Dynamics 365 Commerce Store Commerce app.
author: josaw1 
ms.author: josaw
ms.reviewer: brstor
ms.date: 09/01/2023
---
# Troubleshoot issues with Store Commerce extension 

This article explains how to troubleshoot extension issues in the Microsoft Dynamics 365 Commerce Store Commerce app.

## Issue 1: Extension packages don't appear on the POS Settings page

Commerce runtime (CRT) triggers might not have been updated to include the extension package, or they aren't deployed. For more information, see [Commerce runtime (CRT) extensibility and triggers](/dynamics365/commerce/dev-itpro/commerce-runtime-extensibility-trigger).

## Issue 2: Extension packages appear on the POS Settings page, but the manifest isn't loaded

Confirm that the extension package exists in the *C:\\Program Files\\Microsoft Dynamics 365\\10.0\\Store Commerce\\Extensions* folder. If the packages exist, there should be a *POS* folder that contains the manifest.

If there's no *POS* folder, confirm that the Store Commerce project correctly references the point of sale (POS) extension project. Validate the project reference path and make sure that it exists.

In the following screenshot, the installer project has issues with the referenced extension project.

:::image type="content" source="media/store-commerce-extensions/reference-not-valid.png" alt-text="Screenshot that shows the invalid Store Commerce installer project reference.":::

If the reference for the extension project is correctly added, there won't be any warning or dependency issue in the installer project, as shown in the following screenshot.

:::image type="content" source="media/store-commerce-extensions/reference-valid.png" alt-text="Screenshot that shows the valid Store Commerce installer project reference.":::
