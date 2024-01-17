---
title: Compatibility View is used for Trusted sites
description: Provides options for you to make sure the standards mode will be used for Trusted sites in Internet Explorer.
ms.date: 03/23/2020
ms.reviewer: heikom
---
# Compatibility View is used for Trusted sites in Internet Explorer

[!INCLUDE [](../../../includes/browsers-important.md)]

This article introduces the resolution to solve the issue that Compatibility View instead of standards mode is used for Trusted sites in Internet Explorer.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 2701047

## Symptoms

In Internet Explorer, you have configured the following options:

- Set the **Display intranet websites in Compatibility View** option as **yes**.
- Set the **Intranet Sites: Include all sites that bypass the proxy server** option as **yes**.

Additionally, you have a website that is accessed by Fully Qualified Domain name (FQDN) and is configured as part of the Trusted Sites zone. However, the site is rendered in Compatibility View instead of the expected Internet Explorer Standards Mode.

## Cause

The option **Display intranet websites in Compatibility View** uses the following algorithm in order to determine whether Compatibility View should be used:

1. Check if the page belongs to the local Intranet Security zone.
2. Check if the page would belong to the local Intranet zone, when ignoring the explicit Zone-mappings.
3. Check if the page is not using localhost, 127.0.0.1 or ::1.

The second check with the exclusion of the zone mappings then takes care of the Intranet Option **Intranet Sites: Include all sites that bypass the proxy server**. As the webpage is accessed directly by bypassing the Proxy-server, Compatibility View is used for that website.

## Resolution

Choose one of the following options to ensure the site is opened in Internet Explorer Standards Mode:

1. Disable the **Display intranet websites in Compatibility View** option.

2. Disable the **Intranet Sites: Include all sites that bypass the proxy server** option, and configure all websites that bypass the proxy server to be in the security zone **Local Intranet** manually. Then, put the websites that should use the Internet Explorer Standards Mode into Trusted Sites zone.

3. Add the HTTP-header name `X-UA-Compatible` with a value of **IE=EDGE** to the websites that should run in Standards Mode.

## More information

For more information about defining document compatibility, see [Defining document compatibility](/previous-versions/windows/internet-explorer/ie-developer/compatibility/cc288325(v=vs.85)?).
