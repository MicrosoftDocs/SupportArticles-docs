---
title: Power Automate for desktop console not showing any flows
description: Provides a resolution for the issue that the Power Automate for desktop console doesn't show any desktop flows.
ms.reviewer: pefelesk
ms.date: 10/16/2023
ms.subservice: power-automate-desktop-flows
---
# Power Automate for desktop console doesn't show any desktop flows

This article provides steps to make sure Microsoft Power Automate for desktop console can show the desktop flows as expected.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 5003362

## Symptoms

The Power Automate for desktop console doesn't show any desktop flows in the **My flows** list.

## Verifying issue

1. In the Power Automate for desktop console, select the **Refresh** button to make sure that the desktop flows are still not shown.

2. Go to the [Power Automate Portal](https://flow.microsoft.com) and make sure that the desktop flows do exist in the **My flows** > **Desktop flows** section.

3. Make sure that the Proxy server is using automatic authentication with the user's Active Directory account (for example, Kerberos, Negotiate, or NTLM).

4. Make sure that you don't have to input your credentials each time you need to authenticate with the proxy server.

5. Verify that the Proxy server isn't a socks proxy server.

## Resolution and workaround

To solve this issue, follow the steps described in [Proxy server related errors in Power Automate for desktop](proxy-error-console.md).
