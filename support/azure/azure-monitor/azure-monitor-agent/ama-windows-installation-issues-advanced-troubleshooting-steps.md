---
title: Troubleshoot Azure Monitor Agent installation issues on Windows virtual machines
description: Provides advanced steps to troubleshoot complex installation issues with Azure Monitor Agent on Windows virtual machines.
ms.date: 09/18/2024
ms.reviewer: johnsirmon, v-weizhu, neghuman
ms.service: azure-monitor
ms.custom: sap:Windows Extension not installing
---
# Advanced troubleshooting steps for Azure Monitor Agent installation issues on Windows virtual machines

This article provides advanced steps to troubleshoot complex issues when the installation of the Azure Monitor Agent (AMA) fails on Azure Windows virtual machines (VMs).

## Advanced troubleshooting steps

To troubleshoot more complex installation issues, follow these steps:

1. [Test connectivity to Azure Instance Metadata Service (IMDS)](#tect-imds-connectivity)
2. [Test connectivity to handlers](#tect-handlers-connectivity)
3. [Review network trace](#review-network-trace)

### <a id="tect-imds-connectivity"></a>Step 1: Test connectivity to Azure Instance Metadata Service (IMDS)

1. Connect to your VM using Remote Desktop Connection.
2. Open Command Prompt as an administrator.
3. Test connectivity to IMDS:
    ```console
    curl -H Metadata:true --noproxy "*" "http://169.254.169.254/metadata/instance?api-version=2021-01-01"
    ```

If the connection is successful and there are no IMDS errors in the related logs, move to [Step 2: Test connectivity to handlers](#tect-handlers-connectivity). If the connection fails, review the related logs and attempt to mitigate any issues found.

### <a id="tect-handlers-connectivity"></a>Step 2: Test connectivity to handlers

1. Connect to your VM using Remote Desktop Connection.
2. Open Command Prompt as an administrator.
3. Test connectivity to handlers:

    ```console
    curl -H Metadata:true --noproxy "*" "http://169.254.169.254/metadata/instance/compute/resourceId?api-version=2021-01-01"
    ```

If connectivity is successful and there are no errors in the related logs, move to [Step 3: Review network trace](#review-network-trace). If connectivity fails, review common errors and attempt to mitigate any issues found.

### <a id="review-network-trace"></a>Step 3: Review network trace

1. Use a network tracing tool like Wireshark or Fiddler to capture the network trace.
2. Analyze the trace to identify any issues with connectivity to `global.handler.control.monitor.azure.com`.

If issues can't be mitigated, search for known issues or reach out for assistance in the [Microsoft Q&A forums](/answers/tags/133/azure). Before seeking further help, ensure that you have collected the necessary logs.


[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]