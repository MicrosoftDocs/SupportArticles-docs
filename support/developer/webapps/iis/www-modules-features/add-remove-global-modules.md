---
title: Add and remove Global Modules in IIS
description: This article describes how to add and remove global modules at both the server level and child level configuration in Internet Information Services.
ms.date: 03/19/2020
ms.custom: sap:WWW modules and features
ms.reviewer: mlaing
ms.topic: article
ms.subservice: www-modules-features
---
# Global Modules should be added and removed at both the server level and child level configuration in IIS

This article introduces how to add and remove global modules at both the server level and child level configuration in Microsoft Internet Information Services.

_Original product version:_ &nbsp; Internet Information Services 7.0 and later versions  
_Original KB number:_ &nbsp; 2578663

## Add a global native module

When you install and configure a global native module in Internet Information Services 7.0 and later versions, you are required to install it at the server level by choosing the **Configure native modules** option under the **Modules** feature. Once it is installed and configured at the server level, you can then enable it for a site or individual application. This behavior will create a configuration entry inside the web.config file for the site or application.

## Remove a global native module

When you decide to remove this global module, you are again required to remove it from the server level. However, this removal process doesn't ensure that the previous configuration entries written in the *web.config* file(s) for the site or application also get removed. This behavior is by design. When removing a global module, ensure you remove or disable the module from the child level configuration before removing it completely from the server level.

## More information

To learn more about configuring and enabling global native modules, visit [Global Modules should be added and removed at both the server level and child level configuration in Internet Information Services](/iis/configuration/system.webServer/globalModules/).
