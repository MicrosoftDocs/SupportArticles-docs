---
title: Can't retrieve Graph API token when integrating Intune and Jamf Pro
description: Troubleshoot Graph API access token error message during the configuration of Microsoft Intune Integration in Jamf Pro.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Mac management Jamf
ms.reviewer: kaushika
---
# Could not retrieve the access token for Microsoft Graph API when configuring Intune integration in Jamf Pro

This article solves the connection failure that occurs when you try to integrate Microsoft Intune with Jamf Pro.

## Symptoms

When you try to [configure Microsoft Intune integration in Jamf Pro](/mem/intune/protect/conditional-access-integrate-jamf#configure-microsoft-intune-integration-in-jamf-pro), you receive the following error message that indicates a connection failure:

> Could not retrieve the access token for Microsoft Graph API. Check the configuration for Microsoft Intune Integration.

:::image type="content" source="media/could-not-retrieve-access-token/jamf-error.png" alt-text="Screenshot of the Jamf error.":::

## Cause

This issue occurs if the ports that are required for communication between Jamf Pro and Intune are blocked by your firewall or proxy server.

## Solution

To fix the issue, make sure that the following TCP ports aren't blocked:

- **Intune**: 443
- **macOS devices**: 2195, 2196, and 5223
- **Jamf Pro**: 80 and 5223

## More information

- [Support Tip: Troubleshooting issues with macOS devices when using Jamf/Intune integration](https://techcommunity.microsoft.com/t5/Intune-Customer-Success/Support-Tip-Troubleshooting-issues-with-macOS-devices-when-using/ba-p/462912)
- [Network endpoints for Microsoft Intune - Apple device network information](/mem/intune/fundamentals/intune-endpoints#apple-device-network-information)
- [Network Ports Used by Jamf Pro](https://www.jamf.com/jamf-nation/articles/34/network-ports-used-by-jamf-pro)
- [TCP and UDP ports used by Apple software products](https://support.apple.com/HT202944)

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]
