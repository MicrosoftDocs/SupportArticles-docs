---
title: Azure virtual machine (VM) is unavailable for 15 minutes
description: Learn what it means when you receive an alert in Resource Health or the activity log stating that your VM is unavailable for 15 minutes. 
ms.date: 08/03/2022
ms.reviewer: v-leedennis
editor: v-jsitser
ms.service: virtual-machines
ms.subservice: vm-common-errors-issues
keywords:
#Customer intent: As an Azure virtual machine (VM) user, I want to understand why my VM becomes unavailable so that the situation doesn't block me from working effectively.
---
# Azure virtual machine (VM) is unavailable for 15 minutes

This article explains why you might receive an alert that states "VM is unavailable for 15 minutes" in either Resource Health or the activity log.

## Symptoms

You receive an alert in Resource Health or the activity log that states, "VM is unavailable for 15 minutes."

## Cause

You might receive this alert when a virtual machine (VM) is being deleted, stopped, de-allocated, or restarted. Although the notification is sent from the platform, the operation isn't necessarily initiated by the platform. In certain cases, when the operation is finished, the platform continues to report poor health. These reports indicate that the VM was unavailable for more than 15 minutes. For more information about activity log and Resource Health data, see the "Missing VM downtimes in activity log" section of [Understand a system reboot for Azure VM](understand-vm-reboot.md#missing-vm-downtimes-in-activity-log).

## More information

Microsoft is investing in better platform health coordination and reporting. This investment is part of [Project Flash](https://azure.microsoft.com/blog/advancing-azure-virtual-machine-availability-monitoring-with-project-flash/). This project is designed to display highly accurate and actionable VM availability information.

For more information about Azure Resource Health, see [Resource Health overview](/azure/service-health/resource-health-overview).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
