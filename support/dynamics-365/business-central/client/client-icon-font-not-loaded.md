---
title: Troubleshoot icon font not loaded
description: Learn how to fix icon font issues on client types.
ms.custom: na
ms.date: 02/26/2024
ms.reviewer: na
ms.topic: troubleshooting
author: SusanneWindfeldPedersen
---

# Troubleshoot icon font not loaded

When the icon font is missing on the Business Central web client, Business Central tablet client, or Business Central phone client, it causes issues with the user interface.

## Prerequisites

Login to Business Central.

## Symptoms

The icon font is missing on the Business Central web client, Business Central tablet client, or Business Central phone client preventing you from seeing, for example, the plus sign in front of the **New** action.  
  
## Resolution

The reason is that the **Font download** option is disabled in your browser and the resolution is to add the Business Central web site to your trusted sites in Windows 10.  
  
1. Launch **Control Plane** on your device.  
2. Go to **Network and Internet**, and choose **Internet Options**. A pop up window will appear.
3. Select the  **Security** tab, and then choose **Trusted sites** .  
4. Choose the **Sites** button and add the Business Central web site.  
5. Choose the **Close** button and then the **OK** button.  
  
