---
title: Unresponsive VMs After Cluster Failover Failure
description: Resolves issues that occur if virtual machines become unresponsive after cluster failover failure.
ms.date: 02/12/2026
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap: virtualization and hyper-v\high availability virtual machines
- pcy: Virtualization\high availability virtual machines
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Unresponsive VMs after cluster failover failure

## Summary

This article provides information to help you diagnose and resolve issues that involve cluster failover failures. Such failures can cause virtual machines (VMs) to enter an unresponsive state. The issue can be resolved by restarting the affected VMs. This article also provides guidance to collect logs for further analysis.

## Prerequisites

Before you proceed, make sure that you have the following items:

- Access to Cluster and Hyper-V environments
- Administrative privileges to restart VMs and collect logs
- Knowledge of how to collect cluster logs and Hyper-V TSS logs

## Symptoms

When the issue occurs, you experience the following symptoms:

- All VMs enter a "paused" state.
- The following error codes might appear in Event Viewer:
    - Event ID 1135
    - Event ID 5257
    - Event ID 1795

## Cause

The specific root cause of the issue isn't documented. However, restarting the VMs resolves the problem. Further investigation that uses cluster and Hyper-V logs is recommended to identify the underlying cause.

## Solution 1: Restart the VMs

Follow these steps to resolve the issue by restarting the affected VMs:

1. Open the Hyper-V Manager or the Failover Cluster Manager.
2. Identify the VMs that are in a "paused" state.
3. Right-click on each affected VM and select Restart.
4. Monitor the VMs to make sure they return to an operational state.

## Solution 2: Collect logs for further analysis

To perform a deeper analysis of the issue, collect and share the necessary logs with your support team:

1. Collect Cluster Logs:

    - Open a Command Prompt or PowerShell window that has administrative privileges.
    - Run the following command to generate the cluster logs:
       ```powershell
	   get-clusterlog -uselocaltime -destination C:\Mslog 
       ```
    - Locate the generated logs, typically saved in the %SystemRoot%\Cluster\Reports directory.

2. Collect Hyper-V TSS Logs:

    - Use the TroubleShootingScript toolset (TSS) or any other recommended tool to gather Hyper-V logs.
    - Download the [Setup Report compressed file](https://aka.ms/getTSS).
	- Save and extract this file to a TEMP\TSS directory.
	- Open ADMIN PowerShell window.
	- Navigate to the TEMP\TSS location.
	- Run the following command:
	   ```console
       .\TSS.ps1 -CollectLog SHA_support-all
       ```
    Logs are created here - C:\MS_DATA.
  
## Determine the cause of the problem

After the logs are collected, analyze them to identify potential causes of the failure. Common areas to investigate include:

- Cluster node communication issues
- Resource contention or insufficient system resources
- Configuration errors in the cluster or Hyper-V environment

If it's necessary, contact Microsoft Support for assistance in reviewing the logs and identifying the root cause of the issue.

By following the steps in this article, you can resolve the issue of unresponsive VMs, and gather data for a more thorough investigation to prevent similar occurrences in the future.
