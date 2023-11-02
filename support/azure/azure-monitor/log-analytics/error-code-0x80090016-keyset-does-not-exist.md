---
title: Error code 0x80090016 Keyset does not exist in event viewer or agent logs
description: Resolve error code 0x80090016 "Keyset does not exist" when you try to connect to your event viewer or agent logs.
ms.date: 01/12/2022
ms.reviewer: irfanr, v-leedennis
editor: v-jsitser
ms.service: azure-monitor
ms.subservice: logs-troubleshoot
keywords: 
#Customer intent: As a Log Analytics user, I want to resolve error code 0x80090016 "Keyset does not exist" so I can connect to my event viewer and agent logs. 
---

# Error code 0x80090016 - Keyset does not exist in event viewer or agent logs

This article explains how to resolve error code 0x80090016 - "Keyset does not exist" when you try to connect to your event viewer or agent logs.

## Symptoms

When you try to connect to a Log Analytics workspace through the Microsoft Monitoring Agent (MMA), the connection fails, and one of the following error entries is logged in the Operations Manager event viewer log:

```output
Event ID:      7022 
Description:   The Health Service has downloaded secure configuration for management
               group AOI-00000000-0000-0000-0000-000000000000, and processing the 
               configuration failed with error code Keyset does not exist(0x80090016). 
```

```output
Event ID:      3009  
Description:   Loading the private key for the client authentication certificate for
               service "Log Analytics - ed4Customer-WorkspaceID" failed with error 
               "Keyset does not exist" (0x80090016). Connections to the service may
               be made without authentication. This can cause failures if the service
               requires the agent to be authenticated. The agent will continue to 
               periodically retry loading the authentication configuration.
```

## Cause

The server was cloned from a golden image (also known as a master image) that already had the Windows Log Analytics agent installed and configured. The connection fails because the certificates include the name of the original server that was cloned instead of the name that's currently used by Windows. (**Note:** Cloning a computer that has the Log Analytics agent already configured is not supported.)

## Solution

To resolve these errors, clean and refresh the MMA certificates, as follows:

1. To open the Services snap-in, select **Start**, enter *services.msc*, and then press Enter.

1. To stop the service, select **Microsoft Monitoring Agent**, and then select the **Stop Service** icon.

1. To open the Microsoft Management Console (MMC), select **Start**, enter *mmc.exe*, and then press Enter.

1. To add the Certificates snap-in, select **File** > **Add/Remove Snap-in** > **Certificates** > **Add** > **Computer account** > **Next** > **Local computer** > **Finish** > **OK**.

1. To view the existing MMA certificates in MMC, navigate to **Certificates** > **Microsoft Monitoring Agent** > **Certificates**.

1. We recommend that you export each certificate so that you have a backup copy for security and auditing. To do this, follow these steps:

     1. Select and right-click each listed certificate individually, and then select **All Tasks** > **Export** > **Next** > **No, do not export the private key**.

     1. On the **Export file format** page, select **Base-64 encoded X.509 (.CER)** > **Next**.

     1. On the **File to Export** page, in the **file name** field, enter the name of the certificate file, and then **Browse** to the location where you want to export the certificate. Then, select **Save** > **Next** > **Finish**.

1. After you export backup copies of the certificates that are listed in the middle pane as described in step 6, delete the certificates from MMC. Keep the console open.

1. In the Services snap-in, select **Microsoft Monitoring Agent**, and then select the **Start Service** icon to restart it.  

1. Wait one minute. Then, in MMC, select the Certificates snap-in, and select the **Refresh** icon or F5 to refresh. You should see new certificates.

Observe the agent, the event logs, and your Log Analytics workspace to determine whether these steps resolved the issue.

## More information

[Microsoft Monitoring Agent setup](/services-hub/health/mma-setup)

[Log Analytics Agent overview: installation options](/azure/azure-monitor/agents/log-analytics-agent#installation-options)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
