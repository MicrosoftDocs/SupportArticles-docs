---
title: Cannot connect to Dynamics 365 online
description: Provides a solution to an issue where you're unable to connect to Dynamics 365 (online), version 9.0, using SDK tools.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Unable to connect to Dynamics 365 (online), version 9.0 using SDK tools

This article provides a solution to an issue where you're unable to connect to Dynamics 365 (online), version 9.0, using SDK tools.

_Applies to:_ &nbsp; Microsoft Dynamics CRM  
_Original KB number:_ &nbsp; 4077479

## Symptoms

You're unable to connect to Dynamics 365 (online), version 9.0, using SDK tools such as the Plugin Registration Tool or Configuration Migration Tool. After providing the connection information and selecting the **Login** button, you're returned back to the login dialog.

## Cause

It can occur if you are not using the latest version of the SDK tools that use TLS 1.2.  Dynamics 365 (online), version 9.0, requires TLS 1.2 or later. TLS 1.0 and 1.1 are no longer supported.

## Resolution

[Download the latest version of the SDK tools from Nuget](/dynamics365/customerengagement/on-premises/developer/download-tools-nuget).

## More information

For more information about the change to requiring TLS 1.2, see [Microsoft Dynamics 365 Customer Engagement (online) to require TLS 1.2 for connectivity](https://support.microsoft.com/help/4051700).
