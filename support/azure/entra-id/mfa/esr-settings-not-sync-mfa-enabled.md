---
title: Enterprise State Roaming settings do not sync with multi-factor authentication enabled
description: Describes a problem in which settings configured to sync between devices with Enterprise State Roaming don't sync, and Event ID 1098 is logged with the description.
ms.date: 06/08/2020
ms.reviewer: 
ms.service: active-directory
ms.subservice: authentication
---
# ESR settings don't sync with multi-factor authentication enabled

_Original product version:_ &nbsp; Windows 10 version 1709 all editions, Windows 10 version 1703 all editions, Windows 10 version 1511 all editions, Windows 10 version 1607 all editions  
_Original KB number:_ &nbsp; 3193683

## Symptoms

You have enabled Enterprise State Roaming (ESR) in the Microsoft Entra admin center and on some Windows 10 clients. Any supported settings for sync, such as the desktop background or task bar position, don't sync between devices for the same user. The following events 1098 and 1097 are logged in the Microsoft-Windows-AAD/Operational event log:

```console
Log Name:      Microsoft-Windows-AAD/Operational
Source:        Microsoft-Windows-AAD
Event ID:      1098
Task Category: AadTokenBrokerPlugin Operation
Level:         Error
Keywords:      Error,
Error Computer:      Win10client.contoso.com
Description: Error: 0xCAA2000C The request requires user interaction. Code: interaction_required Description: AADSTS50076: The user is required to use multi-factor authentication to access this resource. Please retry with a new authorize request for the resource 'https://syncservice.windows.net/*'. Trace ID: <Trace ID GUID> Correlation ID: <Correlation ID GUID> Timestamp: yyyy-mmmm-dddd 01:30:38Z
TokenEndpoint: https://login.microsoftonline.com/common/oauth2/token Authority: https://login.microsoftonline.com/common
Client ID: <Client ID GUID>
Redirect URI: ms-appx-web://Microsoft.AAD.BrokerPlugin/<Client ID GUID>
Resource: https://syncservice.windows.net/*
Correlation ID (request): <Correlation ID GUID>
Log Name:      Microsoft-Windows-AAD/Operational
Source:        Microsoft-Windows-AAD
Event ID:      1097 Task Category: AadTokenBrokerPlugin
Operation Level:         Warning
Keywords:      Operational,
Operational Computer:      Win10client.contoso.com
Description: Error: 0xCAA90004 Getting token by refresh token failed.
Authority: https://login.microsoftonline.com/common
Client ID: <Client ID GUID> Redirect URI: ms-appx-web://Microsoft.AAD.BrokerPlugin/<Client ID GUID>
Resource: https://syncservice.windows.net/*
Correlation ID (request): <Correlation ID GUID>
```

## Cause

Multi-factor authentication (MFA) is enabled, and that's why Enterprise State Roaming won't prompt the user for additional authorization.

## Resolution

If your device is configured to require multi-factor authentication on the Microsoft Entra admin center, you may fail to sync settings while you sign in to a Windows 10 device using a password. This type of multi-factor authentication configuration is intended to protect an Azure administrator account. Admin users may still be able to sync by signing in to their Windows 10 devices with their Microsoft Passport for Work PIN or by completing multi-factor authentication while accessing other Azure services, such as Microsoft Office 365.

Sync can fail if the Microsoft Entra Administrator configures the Active Directory Federation Services multi-factor authentication conditional access policy, and the access token on the device expires. Make sure that you sign in and sign out using the Microsoft Passport for Work PIN, or complete multi-factor authentication when accessing other Azure services like Office 365.

## More Information

Microsoft is investigating how to improve the experience with Enterprise State Roaming and MFA authorization enabled on the device.

For more information, see [Settings and data roaming FAQ](/azure/active-directory/devices/enterprise-state-roaming-faqs).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
