---
title: SmartScreen cause Internet Explorer no responding
description: This article describes the situation that Internet Explorer no responding when browsing the website with the Smart Screen Selector enabled.
ms.date: 06/09/2020
ms.reviewer: sansom
---
# Internet Explorer may stop responding when access to the SmartScreen Filter Service is blocked

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides solutions to solve the problem that Internet Explorer is not responding when the SmartScreen filtering service is disabled.

_Original product version:_ &nbsp; Internet Explorer 9  
_Original KB number:_ &nbsp; 2729494

## Symptoms

Consider the following scenario. You are using Internet Explorer 8 or Internet Explorer 9 to browse to a web site, and you have that web site set to an Internet Explorer zone that has the SmartScreen Filter enabled. Further, one or both of the following are true:

1. A firewall or network device is blocking communication between your Internet Explorer browser and the SmartScreen Filter Services URL at `https://urs.microsoft.com`.

2. You are browsing the website from within a network that does not have an active connection to the Internet.

In this scenario, Internet Explorer may appear to stop responding.

## Cause

The SmartScreen Filter Services is provided through an active Internet connection to `https://urs.microsoft.com`. Internet Explorer requires access to that service URL in order to validate the web sites for a zone that has the SmartScreen Filter enabled.

## Resolution

To resolve this problem, choose one of the following options:

1. Allow Internet Explorer to communicate with the SmartScreen Filter Service URL by enabling an active Internet connection or by configuring the firewall or network device to not block connections to unblocking `http://urs.microsoft.com`.

2. Reconfigure Internet Explorer so that the web sites you want to view are set to an Internet Explorer zone where the SmartScreen Filter is disabled.

3. Disable the SmartScreen Filter in the Advanced Options section of Internet Explorer, in the event that access to the SmartScreen Filter Service URL is blocked permanently.

## More information

For more information about SmartScreen: FAQ, see [What is SmartScreen and how can it help protect me](https://support.microsoft.com/help/17443/microsoft-edge-smartscreen-faq).
