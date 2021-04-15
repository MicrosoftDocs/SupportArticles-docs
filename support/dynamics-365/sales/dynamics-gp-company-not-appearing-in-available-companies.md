---
title: GP Company not showing in Dynamics Connector for CRM dropdown
description: A Microsoft Dynamics GP company does not show up in the list of available Companies when creating a new integration in the Microsoft Dynamics Connector for CRM. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# A Microsoft Dynamics GP Company not showing in the Dynamics Connector for CRM dropdown as an available Company for integration

This article provides a resolution to add the Microsoft Dynamics GP Web Services to the Microsoft Dynamics GP company that's not showing in the Microsoft Dynamics Connector for CRM dropdown.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2555058

## Symptoms

When creating a new integration in the Microsoft Dynamics Connector for CRM, a Microsoft Dynamics GP company does not show up in the list of available Companies.

## Cause

Microsoft Dynamics GP Web Services is not added to the Microsoft Dynamics GP company.

## Resolution

To fix this issue, follow these steps:

1. Open the GP Web Services Configuration Wizard by point to the **Start** menu, select **Programs**, select **Microsoft Dynamics**, point to Web Services for Microsoft Dynamics GP, and select **GP Web Services Configuration Wizard**.

2. Complete this wizard to add the Microsoft Dynamics GP Web Services to the company.
