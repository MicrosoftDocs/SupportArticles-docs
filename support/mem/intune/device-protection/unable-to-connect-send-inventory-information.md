---
title: Unable to connect Jamf console to Intune
description: Resolves the Jamf console notification - Unable to connect or send inventory information to Microsoft Intune. Check the status of your Jamf license.
ms.date: 12/05/2023
ms.reviewer: kaushika, taveil
search.appverid: MET150
ms.custom: sap:Set Up Intune\Integrate Jamf Pro with Intune for Compliance
---
# Unable to connect (send inventory information) to Microsoft Intune in the Jamf console

This article solves the notification that occurs in the Jamf console.

## Symptoms

You receive the following notification in the Jamf console:

> Unable to connect to Microsoft Intune  
> Check your Microsoft Intune Integration configuration
>
> Unable to send inventory information to Microsoft Intune  
> Test your Microsoft Intune Integration configuration

:::image type="content" source="media/unable-to-connect-send-inventory-information/notifications.png" alt-text="screenshot of notification." border="false":::

## Cause

This issue occurs because your Jamf license has expired.

## Resolution

To resolve this issue, contact [Jamf Software](https://www.jamf.com/) for assistance.

## More information

You may also notice that the connection status for Jamf is inactive or shows **Terminated** in the Intune Admin console. This is expected behavior once the connector is disabled between Jamf Pro and Intune.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]
