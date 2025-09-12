---
title: VMM console crashes after enabling Operations Manager integration
description: Fixes an issue where the Virtual Machine Manager console may crash after enabling Operations Manager integration.
ms.date: 04/09/2024
ms.reviewer: wenca, alvinm
---
# The System Center 2012 Virtual Machine Manager console crashes after enabling Operations Manager integration

This article helps you fix an issue where the Virtual Machine Manager console crashes after enabling System Center Operations Manager integration.

_Original product version:_ &nbsp; System Center 2012 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2679723

## Symptoms

After enabling System Center Operations Manager integration in System Center 2012 Virtual Machine Manager, the console may crash.

## Cause

This can occur if there is a comma (,) in the fully qualified domain name (FQDN) of the Operations Manager server.

## Resolution

If you are able to open the console, perform the following steps:

1. Correct the name by using a period (.) to delineate the FQDN instead of a comma.
1. Remove Operations Manager integration.
1. Run the Operations Manager integration wizard again.

    At this point, the integration should complete successfully.

If the console crashes in a continuous loop, perform the following steps:

1. Close the console or cancel the attempts to connection.
2. Make sure that the System Center Virtual Machine Manager service is running.
3. Open the Virtual Machine Manager command shell.
4. Type `Remove-scOpsMgrConnection -force`.
