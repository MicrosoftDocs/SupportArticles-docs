---
title: Services do not automatically restart on a computer that uses NIC Teaming
description: Resolves a problem in which services do not automatically restart on a computer that uses NIC Teaming.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, jiesun, janotay, v-jesits
ms.custom:
- sap:network connectivity and file sharing\network load balancing (nlb)
- pcy:WinComm Networking
---
# Services do not automatically start after reboot of a computer that uses NIC teaming

This article helps to resolves a problem in which services do not automatically restart on a computer that uses NIC Teaming.

_Applies to:_ &nbsp; Windows Server 2016  , Windows Server 2022
_Original KB number:_ &nbsp; 4552864

## Symptoms

On a computer that is using NIC (network interface card) Teaming, you notice that several services do not automatically start after the computer restarts.

For example, the SQL Server service does not start automatically. The following entry is logged in the System log:  
> Log Name:      System  
Source:        Service Control Manager  
Date:         \<date>  
Event ID:      7038  
Task Category: None  
Level:         Error  
Keywords:      Classic  
User:          N/A  
Computer:     \<computer name>  
Description:  
The MSSQLxxxx service was unable to log on as xxxxx/xxxxx with the currently configured password due to the following error:  
The specified domain either does not exist or could not be contacted.
>  
> To ensure that the service is configured properly, use the Services snap-in in Microsoft Management Console (MMC).  

Breaking the NIC teaming can fix the problem.

## Cause

The following flow shows how the problem occurs:

- NIC Teaming drivers are controlled by Service Control Manager (SCM). This  means that the NIC Teaming drivers are called to start after SCM is started.
- Individual NIC drivers are not controlled by SCM. Therefore, they can be started and initialized before SCM starts.
- If NIC Teaming is not configured, an individual NIC can have an IP address configured before any system services start. This is because the NIC doesn't have any service dependency. This causes the IP address to be ready before any service runs.
- If NIC Teaming is configured, the teaming NIC can be initialized and the IP address and network can be ready only after the services start.
- By default, after an IP address is added to a NIC, regardless of whether an individual NIC or teaming NIC is being used, it takes three seconds to perform DAD (Duplicate Address detection). After that, the IP address and network are ready.
- By default, it takes at least three seconds before the network is ready.
- On a powerful computer, all services can be started within a few seconds (or even one second). Therefore, in a few cases, you might notice that certain services, such as the SQL Server service, cannot start automatically because the network is not yet ready.

## Resolution

To fix this problem, use one of the following methods:

- Set the **Startup** type of the service to **Automatic (Delayed Start)**.
- Create a scheduled task to start SQL server service after a computer restart, and set a one-minute delay for the task.
- Disable DAD on the computer.
  
If the problem involves SQL Server services, change the SQL services' **Recovery** properties to **Take action** on **First failure** and **Restart the Service** on **Second failure**.
