---
title: Log files for troubleshooting RDS issues
description: Introduces the logs that you must collect when you troubleshoot RDS issues in Windows Server 2012. Describes how to collect the files.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, rkiran, malladi
ms.custom: sap:administration, csstroubleshoot
---
# Useful log files for troubleshooting RDS issues

This article describes the logs that you must collect when you troubleshoot RDS issues.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2747656

## Introduction

Remote Desktop Management Service (RDMS) is a new feature that is introduced in Windows Server 2012. RDMS simplifies administrative tasks in Remote Desktop and provides a centralized management solution for all Remote Desktop Services (RDS) role services and scenarios.

This article introduces the logs that you have to collect when you troubleshoot issues during one of the following operations:

- RDS installation
- Collection creation
- Virtual machine provisioning

## How to enable logs

Before you collect the logs, you must enable the RDMSDeploymentUI and RDMSUI-trace logs. To do this, follow these steps:

1. On the Remote Desktop (RD) Connection Broker server, create the following registry key:

    `HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\RDMS`

2. Create the following two registry entries under the registry key:

    - Registry key 1
      - Entry: EnableDeploymentUILog
      - Data type: REG_DWORD
      - Value: 1

    - Registry key 2
      - Entry: EnableUILog
      - Data type: REG_DWORD
      - Value: 1

## How to collect logs

To troubleshoot issues during RDS installation and deployment, collect the following RDMS UI log files on the RD Connection Broker server:

- RDMSDeploymentUI.txt

    This file is located in the `%windir%\Logs` folder.

- RDMSUI-trace.log

    This file is located in the`%temp%` folder. Usually, the path of the `%temp%` folder is as follows:

    `C:\Users\<username>\AppData\Local\Temp`

To troubleshoot issues during collection creation and virtual machine provisioning, follow these steps:

1. On the RD Connection Broker server, follow these steps:
    1. Collect the RDMSDeploymentUI.txt and RDMSUI-trace.log files.
    2. Collect the contents of the `%windir%\system32\tssesdir\*.xml` folder. The files in this folder are the VM provisioning job reports.
    3. In Event Viewer, enable the Analytic and Debug logs, expand **Custom Views**, click **Administrative Events**, and then export the event logs.
    4. Expand **Applications and Services Logs**, expand **Microsoft**, expand **Windows**, expand **TerminalServices-SessionBroker**, and then export the event logs.
    5. Expand **Applications and Services Logs**, expand **Microsoft**, expand **Windows**, expand **Rdms-UI**, and then export the event logs.

2. On the Remote Desktop Virtualization Host server, follow these steps:
    1. In Event Viewer, enable the Analytic and Debug logs, expand **Custom Views**, click **Administrative Events**, and then export the event logs.
    2. Expand **Applications and Services Logs**, expand **Microsoft**, expand **Windows**, expand **TerminalServices-TSV-VmHostAgent**, and then export the event logs.
    3. Expand **Applications and Services Logs**, expand **Microsoft**, expand **Windows**, expand the Hyper-V-related nodes, and then export the event logs.
