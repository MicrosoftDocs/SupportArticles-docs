---
title: Tools used for Troubleshooting
description: This article lists the tools used for troubleshooting scenarios.  
ms.date: 04/21/2023
author: padmajayaraman
ms.author: v-jayaramanp
ms.custom: sap:Pipelines
ms.service: azure-devops
ms.subservice: ts-pipelines
---

# Tools used for troubleshooting

Many of the troubleshooting scenarios that are discussed in these topics involve the F12 developer tools in your web browser and the Fiddler debugging tool. The following sections discuss these tools.

## F12 developer tools

To capture an F12 trace, follow the steps in [Capture a browser trace for troubleshooting](/azure/azure-portal/capture-browser-trace).

> [!NOTE]
> We recommend that you try to capture a minimum of events in an F12 trace. Start capturing the trace just before the step that is causing the issue instead of starting the trace as soon as you log in to the Azure DevOps portal.

## Fiddler trace

1. Install the [Fiddler](https://docs.telerik.com/fiddler/configure-fiddler/tasks/decrypthttps) tool.

1. Run Fiddler.

1. Press **F12** to stop the traffic capture, and then press **CTRL+X** to clear any traffic log.

> [!IMPORTANT]
> Configure Fiddler to capture and decrypt HTTPS traffic. To do this, select **Tools > Options > HTTPS**. Select both checkboxes on this tab (**Capture HTTPS CONNECTs** and **Decrypt HTTPS traffic**), and then select **YES** to all prompts. For more information, see [Configure Fiddler Classic to Decrypt HTTPS Traffic](https://docs.telerik.com/fiddler/configure-fiddler/tasks/decrypthttps).

[!INCLUDE [third-party-disclaimer](../../includes/third-party-disclaimer.md)]