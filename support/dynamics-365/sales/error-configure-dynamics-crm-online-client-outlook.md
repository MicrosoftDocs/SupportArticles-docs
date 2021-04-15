---
title: Error when you configure Microsoft Dynamics CRM Online Client for Outlook
description: This article provides a resolution for the problem that occurs when you try to configure the Microsoft Dynamics CRM Online Client.
ms.reviewer: jadenb, ehagen
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# "Cannot connect to Microsoft Dynamics CRM server because we cannot authenticate your credentials" error when you configure Microsoft Dynamics CRM Online Client for Outlook

_Applies to:_ &nbsp; Microsoft Dynamics CRM  
_Original KB number:_ &nbsp; 2450741

## Symptoms

When you configure the Microsoft Dynamics CRM Online Client for Outlook, you receive the error message:

> Cannot connect to Microsoft Dynamics CRM server because we cannot authenticate your credentials.

## Cause

- Network traffic is being blocked.
- There is a problem with your WLID Password.

## Resolution

1. Add the following URLs to your `firewall/proxy` exceptions list:

    - `https://*.dynamics.com`
    - `https://*.live.com`

2. Add the same URLs to Trusted Sites in Internet Explorer.

    Open Internet Explorer, click on **Tools**, then click on the **Security** tab, click on the **Trusted Sites** icon and then click on the **Sites** button.

    In the Trusted sites window type in each URL (listed below) individually and click the **Add** button.

    - `https://*.dynamics.com`
    - `https://*.live.com`

    Click on **Close** button, then click the **OK** button.

3. Your WLID password has expired or is longer than 15 characters and needs to be [reset or shortened](https://outlook.live.com/owa/).
