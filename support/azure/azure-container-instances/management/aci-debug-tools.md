---
title: Azure Container Instances debugging tools
description: Learn how to use Azure Container Instances debugging tools, such as liveness probes, logs, and exec commands, to troubleshoot and resolve container issues fast.
ms.date: 10/06/2026
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: cssakscic, tysonfms, v-rekhanain, v-weizhu, v-leedennis, kennethgp, andbar, kaushika
ms.service: azure-container-instances
ms.topic: troubleshooting
ms.custom: sap:Management
ai-usage: ai-assisted
---
# Azure Container Instances debugging tools

## Summary

This article lists the Azure Container Instances (ACI) debugging tools that you can use to monitor container health, analyze logs and events, and troubleshoot application and container failures.

## List of debugging tools

The following table summarizes the debugging features available for ACI.

| Feature | Use case | Example |
|--|--|--|
| High availability and resilience | Ensuring that your containers are always available and resilient to failures | Deploying a web application that has multiple instances of containers behind a load balancer. The liveness probe checks whether each container is responsive. If a container becomes unresponsive, ACI automatically restarts the container to maintain high availability. |
| Health monitoring and autorecovery | Monitoring the health of your containers and automatically recovering from failures | Running a microservice that processes messages from a queue. The liveness probe verifies that the container can handle requests. If the service becomes unhealthy (for example, because of memory exhaustion or a deadlock), ACI restarts the container to restore service. |
| Graceful shutdown and cleanup | Ensuring that containers shut down gracefully during scaling events or maintenance | Allowing existing requests to finish before terminating the container while scaling down a service. This action prevents data loss or incomplete transactions. |
| Custom health checks | Implementing custom health checks that are specific to your application | A container that's running a database server using a liveness probe that connects to the database and verifies its responsiveness. If the database becomes unresponsive, ACI can restart the container or trigger an alert. |
| Handling initialization failures | Detecting whether the container initializes correctly after startup | Checking whether the required dependencies are available before the container starts accepting traffic in ACI. |

Make sure to configure a [liveness probe](/azure/container-instances/container-instances-liveness-probe) for your containers. A liveness probe checks whether a container is running and responding within a specified interval.

Also, be sure to check [container logging and events](/azure/container-instances/container-instances-get-logs).

To store and query the logging and event data, use a centralized location, such as a [Log Analytics](/azure/container-instances/container-instances-log-analytics) workspace.

The following table summarizes the troubleshooting features available for ACI.

| Feature | Use case | Example |
|--|--|--|
| Troubleshooting application errors | Identifying and diagnosing application errors or crashes that occur within the container (if application logging is configured) | Analyzing container logs to pinpoint the source of a "500 Internal Server Error" event that's reported by the application. |
| Troubleshooting container events | Detecting container creation failures | Analyzing an event that displays the details of a container not starting because of an image pull failure. |

> [!NOTE]
> Some log entries might be missing if the container is restarted or recreated as soon as container process exits.

Use [Application Insights](/azure/azure-monitor/app/api-custom-events-metrics) to monitor and analyze the performance and health of your applications running in ACI.

Use [the "ping -t" or "tail -f /dev/null" command](/azure/container-instances/container-instances-troubleshooting#container-continually-exits-and-restarts-no-long-running-process) during container creation (if the container continually exists and restarts) to keep the container running for troubleshooting purposes.

The following table lists [commands that are run within a running container](/azure/container-instances/container-instances-exec).

| Feature | Use case | Example |
|--|--|--|
| Command execution | Running commands for troubleshooting inside a container | Accessing the container's Bash shell to investigate application errors and diagnose issues interactively. |
| Troubleshooting performance | Running performance commands to diagnose issues | Running the `free` command in the container to identify memory bottlenecks that cause application slowdowns. |

The [container group updating](/azure/container-instances/container-instances-update) feature allows you to modify the configuration of an existing container group without having to delete and recreate it.