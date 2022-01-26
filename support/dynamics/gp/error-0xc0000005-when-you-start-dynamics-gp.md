---
title: Error 0xc0000005 when you start Dynamics GP
description: Describes a problem where you receive an error message (The application failed to initialize properly (0xc0000005). Click on OK to terminate the application) when you start Microsoft Dynamics GP. A resolution is provided.
ms.topic: troubleshooting
ms.reviewer: kyouells
ms.date: 03/31/2021
---
# Error message when you start Microsoft Dynamics GP: "The application failed to initialize properly (0xc0000005). Click on OK to terminate the application"

This article provides a solution to the error 0xc0000005 that occurs when you start Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 954631

## Symptoms

When you start Microsoft Dynamics GP, you receive the following error message:

> The application failed to initialize properly (0xc0000005). Click on OK to terminate the application.

This behavior occurs if Symantec Endpoint Protection 11.0 is installed on the computer where you receive the error message.

## Cause

The error is caused by the **Application and Device Control** feature of Symantec Endpoint Protection (SEP) 11.0 or 12.0.

## Resolution

To resolve this problem, apply the Maintenance Release 2 update for Symantec Endpoint Protection 11.0.

## More information

If you continue to receive the error message described in the [Symptoms](#symptoms) section, disable the **Application and Device Control** feature of Symantec Endpoint Protection 11.0 or 10.0. To do this, follow these steps:

1. Click **Start**, and then click **Control Panel**.
2. Double-click **Add or Remove Programs**.
3. Click **Symantec Endpoint Protection**, and then click **Change**.
4. In the Welcome to the InstallShield Wizard for Symantec Endpoint Protection window, click **Next**.
5. Click **Modify**, and then click **Next**.
6. In the **Application and Device Control** area, click **This feature will not be available**, and then click **Next**.
7. Click **Install** to begin the removal process.
8. Click **Finish**.
9. Restart the computer.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

[!INCLUDE [Publishing Disclaimer](../../includes/publishing-disclaimer.md)]
