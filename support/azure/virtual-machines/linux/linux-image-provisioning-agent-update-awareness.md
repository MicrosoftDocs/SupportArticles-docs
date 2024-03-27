---
title: Linux Image Provisioning Agent update awareness
description: Provides the update awareness and frequently asked questions about Linux Image Provisioning Agent.
ms.date: 10/10/2020
ms.service: virtual-machines
ms.subservice: vm-extensions-not-operating
ms.custom: linux-related-content
ms.collection: linux
ms.author: genli
author: genlin
ms.reviewer: 
---
# Linux Image Provisioning Agent update awareness

_Original product version:_ &nbsp; Azure, Virtual Machine running Linux  
_Original KB number:_ &nbsp; 4538386

## Summary

Many Linux Azure Marketplace images contain an **Azure Linux Agent**, which is responsible for completing the setup of the newly created Virtual Machine (VM), such as setting the hostname, username, password/ ssh keys, and mounting an ephemeral disk. This setup process is known as 'provisioning'. In addition, the agent provides support for Azure VM Extensions.

The images themselves will be updated to be provisioned using an open-source provisioning agent, [cloud-init](/azure/virtual-machines/linux/using-cloud-init). cloud- init offers many additional benefits over the Linux Agent, including:

- Performance - Using cloud-init with Azure, you can see improved reduced VM creation times in most cases.
- VM customization - cloud-init allows you to pass down VM configurations to cloud-init via [custom-data](/azure/virtual-machines/linux/using-cloud-init#deploying-a-cloud-init-enabled-virtual-machine), such as running scripts, installing packages, and adding users.
- Migration - If you are migrating from other clouds, you can migrate cloud- init configurations, and modify them where necessary to work with your Azure deployments.

## More information

### What do you need to do?

- If you deploy these Azure Marketplace images, then there is nothing further that you need to do. You can immediately take advantage of the benefits after the update.
- If you are creating custom images that derive from these images, and use the Linux Agent to process custom-data, check that your images still work correctly.

    cloud- init supports multiple input types, including a bash script or a cloud- init config. Review the 'cloud- init'[user-data](https://cloudinit.readthedocs.io/en/latest/topics/format.html) documentation.
- See [this](/azure/virtual-machines/linux/using-cloud-init#cloud-init-overview) page for details on which images will be updated, and the timeline on when the updates will take place.

## Frequently asked questions

Q1. Will the Azure Linux Agent still be installed in the images?  

A1. Yes, the Azure Linux Agent is required for Azure VM extensions. The provisioning functionality will be disabled.  

Q2. Can the Azure Linux Agent and cloud-init be installed in the same image?  

A2. Yes. To ensure that there is no conflict, the Linux Agent provisioning code is disabled and will not run.  

Q3. How can I tell if my image has been provisioned by cloud-init?  

A3. Run `cloud-init status` to see if cloud-init has run.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
