---
title: Icon font not loaded
description: Learn how to fix icon font issues on client types.
ms.date: 04/24/2024
ms.reviewer: na
ms.topic: troubleshooting
author: SusanneWindfeldPedersen
---

# Icon font not loaded

When the icon font is missing on the Business Central web client, Business Central tablet client, or Business Central phone client, it causes issues with the user interface.

## Symptoms

The icon font is missing on the Business Central web client, Business Central tablet client, or Business Central phone client preventing you from seeing, for example, the plus sign in front of the **New** action.  
  
## Resolution

Login to Business Central. The reason is that the **Font download** option is disabled in your browser and the resolution is to add the Business Central web site to your trusted sites in Windows 10.  
  
1. Launch **Control Plane** on your device.  
2. Go to **Network and Internet**, and choose **Internet Options**. A pop up window will appear.
3. Select the  **Security** tab, and then choose **Trusted sites** .  
4. Choose the **Sites** button and add the Business Central web site.  
5. Choose the **Close** button and then the **OK** button.  
  
