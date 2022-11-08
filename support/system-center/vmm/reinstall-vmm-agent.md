---
title: Reinstall a VMM agent on a host with service templates
description: Describes how to reinstall the System Center 2012 Virtual Machine Manager agent on a host and restore service templates.
ms.date: 05/07/2020
ms.reviewer: alvinm
---
# Reinstall the System Center 2012 Virtual Machine Manager agent on a host with services deployed

This article describes how to reinstall the System Center 2012 Virtual Machine Manager agent on a host and restore service templates.

_Original product version:_ &nbsp; System Center 2012 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2705504

## Symptoms

Scenario: A Hyper-V host is managed by System Center 2012 Virtual Machine Manager (VMM) and it is hosting service templates. You want to reinstall the VMM agent on the host.

If you remove the host from VMM, it will retain the VM information but all service template information will be lost. This will prevent any updates to service templates as well as scale-out actions.

## Cause

This is a known issue in System Center 2012 Virtual Machine Manager. Removing a host from a VMM console causes all service template information to be removed for that host.

## Resolution

Log on directly to the host where you want to reinstall the agent. Remove the agent and reinstall it manually using the latest agent files. On the VMM server, perform an **add host** action and select **reassociate**. This will re-register the host in VMM and the service templates will be restored.
