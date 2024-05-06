---
title: Icon font isn't loaded in the Business Central clients
description: Provides a resolution for an icon font issue that occurs in the Business Central web client, Business Central tablet client, or Business Central phone client.
ms.date: 05/06/2024
ms.reviewer: 
ms.custom: 
author: SusanneWindfeldPedersen
---
# Icon font isn't loaded in the Business Central clients

This article provides a resolution for the user interface issues that might occur when the icon font isn't loaded in the Business Central web client, Business Central tablet client, or Business Central phone client.

## Symptoms

The icon font is missing from the Business Central web client, Business Central tablet client, or Business Central phone client. As a result, some user interface issues occur. For example, you can't see the plus sign in front of the **New** action.

## Cause

This issue occurs because the **Font download** option is disabled in your browser.
  
## Resolution

To sovle this issue, add the Business Central web site to your trusted sites.

1. In Windows 10, launch **Control Panel** on your device.
2. Go to **Network and Internet** > **Internet Options** > **Security** > **Trusted sites**.
3. Select the **Sites** button and add the Business Central web site.
4. Select **Close** > **OK**.
