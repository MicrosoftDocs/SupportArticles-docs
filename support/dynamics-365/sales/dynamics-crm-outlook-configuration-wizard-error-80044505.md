---
title: Dynamics CRM for Outlook Configuration Wizard error 80044505
description: This article provides a resolution for an issue where the Microsoft Dynamics CRM for Outlook Client Configuration Wizard fails to configure to the CRM organization.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Microsoft Dynamics CRM for Outlook Configuration Wizard Error Code 80044505

This article helps you resolve the problem where the Microsoft Dynamics CRM for Outlook Client Configuration Wizard fails to configure to the CRM organization.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2013  
_Original KB number:_ &nbsp; 2997742

## Symptoms

The error code 80044505 may occur when the Microsoft Dynamics CRM for Outlook Client Configuration Wizard fails to configure to the CRM organization. The user error may show:

> Generic Error Message

## Cause

This error occurs if the username endpoint in Active Directory Federation Services (AD FS) is enabled. This will block the endpoints required by the Microsoft Dynamics CRM for Outlook client.

## Resolution

Disable the username endpoint in Active Directory Federation Services.

1. Open the AD FS Management Console.
2. In the left navigation pane, expand **Service**, and then click **Endpoints**.
3. In the endpoint list, locate and right-click the `/adfs/services/trust/13/username` endpoint.
4. Select disable.
5. Restart the AD FS service.
