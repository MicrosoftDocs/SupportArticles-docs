---
title: How to collect device logs
description: Describes the detailed steps to collect device logs in Teams admin center.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro 
ms.topic: article 
ms.service: msteams
localization_priority: Normal
ms.custom: 
- CI 160238
- CSSTroubleshoot
ms.reviewer: miaitelh
appliesto:
- Microsoft Teams
search.appverid: 
- MET150
---
# How to collect device logs in Teams admin center

Microsoft Teams released the device log feature that can help you troubleshoot Teams issues. This article provides the detailed steps to collect the device logs.

1. Open [Microsoft Teams admin center](https://admin.teams.microsoft.com/).
2. In the left navigation, go to **Teams devices**, and then select the category of devices (such as **Phones**).
3. Select the name of the device from which you want to download logs, and then select **Download device logs**.

   :::image type="content" source="media/collect-device-logs/teams-devices.png" alt-text="Screenshot of the Teams device field. The feature titled Download device logs is highlighted.":::

4. After a few minutes, select the **History** tab, and then select the **Download** link under **Diagnostics file**.

   :::image type="content" source="media/collect-device-logs/history.png" alt-text="Screenshot of the History menu. The Download link is highlighted.":::

5. Extract the downloaded folder, and then check the file that's named staring with **Skylib**. This file is the media log that contains diagnostic data.

   :::image type="content" source="media/collect-device-logs/skylib-file.png" alt-text="Screenshot of the extracted files. The file that's named staring with Skylib is highlighted.":::

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
