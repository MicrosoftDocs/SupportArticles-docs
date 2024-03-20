---
title: Return Code 2 error when running depreciation in Fixed Assets
description: When you run depreciation in Fixed Assets in Microsoft Dynamics GP, you receive a Return Code 2 error. Provides a resolution.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Financial - Fixed Assets
---
# "Return Code 2" error when you run depreciation in Fixed Assets in Microsoft Dynamics GP

This article provides a resolution for the issue that you can' run depreciation in Fixed Assets in Microsoft Dynamics GP due to the **Return Code 2** error.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 853283

## Symptoms

When you run depreciation in Fixed Assets in Microsoft Dynamics GP, the depreciation of all assets or a single asset is not completed. Additionally, a **Return Code 2** error occurs.

## Cause

This issue may occur if the Fixed Assets Calendar is damaged or if there are missing days.

## Resolution

To resolve this issue, build and then replace the Fixed Assets Calendar. For more information about how to do this, see [How to rebuild the Fixed Assets calendar in Microsoft Dynamics GP](https://support.microsoft.com/topic/how-to-rebuild-the-fixed-assets-calendar-in-microsoft-dynamics-gp-f388b6fd-d740-1d5b-25fb-facbd099da75).
