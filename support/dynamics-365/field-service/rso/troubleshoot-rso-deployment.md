---
title:  Troubleshoot issues with Resource Scheduling Optimization add-in deployments
description: Resolve issues with deployments of the Resource Scheduling Optimization add-in for Dynamics 365 Field Service.
ms.author: feiqiu
author: feifeiqiu
ms.reviewer: mhart
ms.date: 06/15/2023
---

# Troubleshoot issues with Resource Scheduling Optimization add-in deployments

This article helps administrators resolve issues with deployments of the Resource Scheduling Optimization add-in for Dynamics 365 Field Service.

## Symptoms

The deployment or upgrade fails or takes a long time and doesn't complete.

## Resolution

For failed deployments or upgrades, go to the Resource Scheduling Optimization deployment app and select the **Delete Current Deployment** option to delete the existing deployment. Then redeploy the latest version. If it fails again, verify the Dynamics 365 org is not in administration mode.

If your Resource Scheduling Optimization deployment still fails or doesn't complete, contact the Microsoft Support team.

> [!TIP]
> Don’t install the Resource Scheduling Optimization solution from the solution management page. Always use the Resource Scheduling Optimization deployment app, which deploys the Dynamics 365 solution and Azure required resources.
