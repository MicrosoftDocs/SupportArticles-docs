---
title: Collect Teams device logs
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
# Collect Teams device logs

If you're having issues with Microsoft Teams devices, you'll need diagnostic logs from them to troubleshoot the issues. Here's how you can collect the device logs.

1. In the [Microsoft Teams admin center](https://admin.teams.microsoft.com/), select **Teams devices** from the navigation menu on the left, and then select the category of devices (such as **Phones**).
2. Select the name of the device from which you want to download logs, and then select **Download device logs**.

   :::image type="content" source="media/collect-device-logs/teams-devices.png" alt-text="Screenshot of the Teams device field. The feature titled Download device logs is highlighted.":::

3. After a few minutes, select the **History** tab, and then select the **Download** link under **Diagnostics file**.

   :::image type="content" source="media/collect-device-logs/history.png" alt-text="Screenshot of the History menu. The Download link is highlighted.":::

4. Extract the downloaded folder, and then look for a file with a name that begins with Skylib. This file is the media log that contains diagnostic data.

   :::image type="content" source="media/collect-device-logs/skylib-file.png" alt-text="Screenshot of the extracted files. The file that's named staring with Skylib is highlighted.":::

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
