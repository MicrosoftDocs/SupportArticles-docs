---
title: Potential integration issues with Operations Manager
description: This article describes possible errors and issues you may encounter after configuring Operations Manager integration with System Center 2012 Virtual Machine Manager.
ms.date: 04/09/2024
ms.reviewer: wenca, alvinm
---
# Potential integration issues with System Center Operations Manager

This article presents possible errors and issues you may encounter after configuring Operations Manager integration with System Center 2012 Virtual Machine Manager (VMM 2012).

_Original product version:_ &nbsp; System Center 2012 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2668088

## Error 11808

> Unable to set the Operations Manager root server in VMM because the Operations Manager is not installed on the Virtual Machine Manager management server.
>
> Recommended action:  
> Install the Operations Console for System Center Operations Manger 2007 on the Virtual Machine manager server and then try the operation again.

This error message can be misleading as it also applies to Operations Manager 2012 even though it only specifically mentions Operations Manager 2007. The console required has to match the version you are using on the Operations Manager server, so if you are integrating with Operations Manager 2012 you need to install the Operations Manager 2012 console on the VMM 2012 server.

## Error 25907

> The credentials used to connect to Operations Managers management group do not have the necessary permissions.
>
> Recommended Action:  
> Try operation again with different credentials or add the credentials to the OpsMgr Administrator Role

You will need to add either one of these to the Operations Manager built-in administrators group. Add the account used for integration or add the machine name if local system was selected during integration.

## Error 10218

> Setup could not import the System Center Virtual Machine Manager Management pack into Operations Manger server because one or more required management packs are missing. The VMM management pack cannot be deployed unless the following components management packs are present in Operations Manager 2007...
>
> Recommended action:  
> To provide the missing component management packs, ensure that the following management packs cannot be deployed unless the following component management packs are present in operations manager 2007:...

The minimum required version of the management packs is 6.0.5000.0.

## Error status in the Operations Manager settings

> Error Details:  
> Operations Manager discovery failed with error: "Exception of type 'Microsoft.virtualmanager.enterprisemanagement.common.dicoverydatainvalidrelationshipsourceexception0m10' was thrown.

This is caused by one or more hosts under VMM management not having the Operations Manager agent installed and reporting to an Operations Manager server. The new architecture in VMM 2012 requires that the Operations Manager agent is installed on all hosts so they can send VM information directly and not have to go through VMM.

## Error 25923

> PRO Diagnostics Target is not monitored
>
> Recommended Action  
> Check if Operations manager agent is running on the computer running VMM management server

This is caused by the Operations Manager agent not being installed on the VMM server. It can also occur if the VMM server has the agent installed but it's not monitored (for example, there are problems with health agent). Verify the Operations Manager console and make sure it is in a healthy state.

## More information

For more information, see [Potential issues with VMM 2012/OpsMgr integration](https://techcommunity.microsoft.com/t5/system-center-blog/potential-issues-with-vmm-2012-opsmgr-integration/ba-p/344614).
