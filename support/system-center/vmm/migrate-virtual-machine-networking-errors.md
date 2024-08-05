---
title: Errors 23801 and 23753 when migrating a virtual machine
description: Describes networking errors when you use System Center Virtual Machine Manager to migrate a virtual machine.
ms.date: 04/09/2024
ms.reviewer: wenca
---
# Networking errors (23801, 23753) when a virtual machine is assigned a static IPv4 address through System Center Virtual Machine Manager

This article helps you fix networking errors when you use System Center Virtual Machine Manager to migrate a virtual machine.

_Original product version:_ &nbsp; Microsoft System Center Virtual Machine Manager  
_Original KB number:_ &nbsp; 2915463

## Symptoms

When you use System Center Virtual Machine Manager to migrate a virtual machine, the job is completed successfully, but one or both of the following errors are returned in the job result information:

> Error (23801)
>
> No available connection to selected VM Network can be found.
>
> Recommended Action
>
> Ensure host NICs have connection to the fabric network on which VM Network is created.

> Error (23753)
>
> The virtual machine or tier load balancer configuration requires an IP pool and there are no appropriate IP pools accessible from the host.
>
> Recommended Action
>
> Select a host with access to an appropriate IP pool and try the operation again.

This issue occurs if the virtual machine's virtual network adapter is connected to a virtual machine network that doesn't have a static IP address pool defined for it. Additionally, the IPv4 address type was changed from dynamic to static by going inside the virtual machine and manually changing the IP address configuration.

> [!NOTE]
> Depending on network configuration of the virtual network adapter, the list of errors in the job result may contain other networking-related errors.

## Cause

When the IP address configuration is modified inside the virtual machine from dynamic to static, Virtual Machine Manager updates the IPv4AddressType of the network adapter from dynamic to static. During migration, the placement engine sees the IPv4 address type as static. Moreover, it expects to find a static IP address pool defined for the virtual machine network to which this virtual network adapter is connected. Therefore, the placement engine generates the errors and adds them to the job result. The migration itself still succeeds without affecting connectivity.

## Resolution

To resolve this issue, follow these steps:

1. Ignore the information messages in this case, as the migration has already been completed. Optionally, have a static IP address pool defined for the VM network.
2. Use Hyper-V to perform the migration.
