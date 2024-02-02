---
title: Error 1058 is displayed when a service suddenly stops
description: Provides a solution to an error that occurs when a service suddenly stops.
ms.date: 12/07/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:applications, csstroubleshoot
---
# Error 1058 is displayed when a service suddenly stops

This article provides a solution to an issue where "Error 1058" occurs when a service suddenly stops.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows 7, Windows Vista, Windows XP  
_Original KB number:_ &nbsp; 241584

## Symptoms

When a service suddenly stops, you may receive the following error message:

> Error 1058: The service cannot be started, either because it is disabled or because it has no enabled devices associated with it.

You may also receive this error message when you try to start a service.

## Cause

This issue can occur if the service is disabled or if the service is disabled for the hardware profile that you're currently using.

### Resolution for Windows 10, Windows 7 and Windows Vista

1. Click **Start**, search for *Services*, and then click **Services** in the search result.
2. Scroll until you find the service, and then double-click the service.

   :::image type="content" source="media/error-1058-displayed-when-service-stops/service-properties-win10.png" alt-text="Screenshot of Startup type option under the General tab of the Routing and Remote Access Properties (Local Computer) dialog box." border="false":::

3. If the service is disabled, click the **Startup type** list, and then select an option other than **Disabled**.
4. Click **Apply**.
5. Click **Start** to try to start the service.
6. Click **OK**.

### Resolution for Windows XP

1. Click **Start**, point to **All Programs**, point to **Administrative Tools**, and then click **Services**.
2. Scroll until you find the service that is stopped or disabled.
3. Double-click the service that did not start.
4. Click the **Log On** tab.

   :::image type="content" source="media/error-1058-displayed-when-service-stops/log-on-tab-shown.png" alt-text="Screenshot of the Log On tab of the Remote Procedure Call (RPC) Locator Properties (Local Computer) dialog box." border="false":::

5. Verify that the service isn't disabled for the hardware profile that you're using. If the service is disabled for the hardware profile, click **Enable**.

6. Click the **General** tab, and then in the **Startup Type** box, verify that the service is not disabled. If the service is disabled, click **Automatic** to have it start when you start the computer.

   :::image type="content" source="media/error-1058-displayed-when-service-stops/verify-service-startup-type.png" alt-text="Screenshot of the startup type box in the General tab." border="false":::

7. Click **OK**.

## More information

If a service is set to start automatically but the service is disabled for the hardware profile that you're using, the service isn't started and no error message is generated.
