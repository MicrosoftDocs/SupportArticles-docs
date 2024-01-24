---
title: Request Restrictions can't be set for ISAPI
description: This article provides resolutions for the problem where the Request Restrictions functionality not working for Wildcard ISAPI extension.
ms.date: 04/17/2020
ms.custom: sap:WWW modules and features
ms.subservice: www-modules-features
ms.reviewer: pphadke, wadeh, bariscag
---
# Request Restrictions can't be set for a wildcard ISAPI in IIS 7.0 and later versions

This article helps you resolve the problem where the **Request Restrictions** feature of handler mappings is not available for a Wildcard Internet Server Application Programming Interface (ISAPI) extension on Microsoft Internet Information Services (IIS) 7.0 and later versions.

_Original product version:_ &nbsp; Internet Information Services 7.0 and later versions  
_Original KB number:_ &nbsp; 2725025

## Symptoms

The **Request Restrictions** functionality of handler mappings cannot be set for a Wildcard ISAPI extension on IIS 7.0 and later versions. The **Request Restrictions** feature and the  **Invoke handler only if the request maps to** option on IIS 7.0 and later versions provide the same functionality of the **Verify that file exists** checkbox on IIS 6.

If the **Request Restrictions** are set by editing the IIS 7.0 or a later version configuration and adding the sections `requireAccess` and `resourceType` for the wildcard ISAPI extension handler, you may experience unexpected behavior browsing pages that are not handled by the Wildcard ISAPI extension, such as `StaticFile` handler requests.

The option to add **Request Restrictions** for a Wildcard ISAPI are not available through the IIS Manager.

## Cause

This behavior is by design on IIS 7.0 and later versions. You cannot add **Request Restrictions** for a Wildcard ISAPI extension on IIS 7.0 and later versions either through the IIS manager or by changing configuration. Adding **Request Restrictions** for a Wildcard ISAPI extension by editing the configuration is not supported on IIS 7.0 and later versions.

## Resolution

If your Wildcard ISAPI extension uses the **Verify that file exists** functionality of IIS 6, you will need to manually perform the **Verify that file exists** functionality inside your wildcard ISAPI extension. This is because the feature to add request restrictions for a Wildcard ISAPI is not available on IIS 7.0 and later versions.

For example, if you intend to run your ISAPI extension on IIS 7.0 or a later version and if the purpose of using the **Verify that file exists** was to deny users who did not have permissions to view a particular file on IIS 6, you will need to perform those same checks manually in your wildcard ISAPI extension and deny users.
