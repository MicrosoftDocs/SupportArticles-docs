---
title: Azure Container Instances debugging tools
description: Learn about debugging tools on Azure Container Instances.
ms.date: 03/13/2024
author: AndreiBarbu95
ms.author: andbar
editor: v-jsitser
ms.reviewer: cssakscic, tysonfms, v-rekhanain, v-weizhu, v-leedennis
ms.service: container-instances
ms.topic: best-practice
---
# Azure Container Instances debugging tools

This article lists the debugging tools that you can use on Microsoft Azure Container Instances.

## List of debugging tools

- [Liveness probe](/azure/container-instances/container-instances-liveness-probe)

  A liveness probe checks whether a container is running and responding within a specified interval.

  | Feature | Use case | Example |
  |--|--|--|
  | High availability and resilience | Making sure that your containers are always available and resilient to failures | Deploying a web application that has multiple instances of containers behind a load balancer. The liveness probe checks whether each container is responsive. If a container becomes unresponsive, Container Instances automatically restarts the container to maintain high availability. |
  | Health monitoring and autorecovery | Monitoring the health of your containers and automatically recovering from failures | Running a microservice that processes messages from a queue. The liveness probe verifies that the container can handle requests. If the service becomes unhealthy (for example, because of memory exhaustion or a deadlock), Container Instances restarts the container to restore service. |
  | Graceful shutdown and cleanup | Making sure that containers shut down gracefully during scaling events or maintenance | Allowing existing requests to finish before terminating the container while scaling down a service. This action prevents data loss or incomplete transactions. |
  | Custom health checks | Implementing custom health checks that are specific to your application | A container that's running a database server using a liveness probe that connects to the database and verifies its responsiveness. If the database becomes unresponsive, Container Instances can restart the container or trigger an alert. |
  | Handling initialization failures | Detecting whether the container initializes correctly after startup | Checking whether the required dependencies are available before the container starts accepting traffic. |

- [Container logging and events](/azure/container-instances/container-instances-get-logs)

  To store and query the logging and event data, we recommend that you use a centralized location, such as a [Log Analytics](/azure/container-instances/container-instances-log-analytics) workspace.

  | Feature | Use case | Example |
  |--|--|--|
  | Troubleshooting application errors | Identifying and diagnosing application errors or crashes that occur within the container (if application logging is configured) | Analyzing container logs to pinpoint the source of a "500 Internal Server Error" event that's reported by the application. |
  | Troubleshooting container events | Detecting container creation failures | Analyzing an event that displays the details of a container not starting because of an image pull failure. |

- [Application Insights](/azure/azure-monitor/app/api-custom-events-metrics)

- [The "ping -t" or "tail -f /dev/null" command](/azure/container-instances/container-instances-troubleshooting#container-continually-exits-and-restarts-no-long-running-process) during container creation (if the container continually exists and restarts)

- [Commands that are run within a running container](/azure/container-instances/container-instances-exec)

  | Feature | Use case | Example |
  |--|--|--|
  | Command execution | Running commands for troubleshooting inside a container | Accessing the container's Bash shell to investigate application errors and diagnose issues interactively. |
  | Troubleshooting performance | Running performance commands to diagnose issues | Running the `free` command in the container to identify memory bottlenecks that cause application slowdowns. |

- [Container group updating](/azure/container-instances/container-instances-update)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
