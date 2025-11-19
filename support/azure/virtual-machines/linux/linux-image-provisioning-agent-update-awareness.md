---
title: Linux Image Provisioning Agent Update Awareness
description: Provides the update awareness and frequently asked questions about Linux Image Provisioning Agent.
ms.date: 09/15/2025
ms.service: azure-virtual-machines
ms.custom: sap:VM Extensions not operating correctly, linux-related-content
ms.collection: linux
ms.author: jarrettr
author: JarrettRenshaw
ms.reviewer: 
---
# Linux Image Provisioning Agent update awareness

**Applies to:** :heavy_check_mark: Linux VMs

_Original KB number:_ &nbsp; 4538386

## Summary

Many Linux Azure Marketplace images contain an **Azure Linux Agent** that's responsible for completing the setup of the newly created virtual machine (VM). The setup includes setting the hostname, username, and password/ ssh keys, and mounting an ephemeral disk. This setup process is known as 'provisioning'. Additionally, the agent provides support for Azure VM extensions.

The images themselves are updated to be provisioned by using an open source provisioning agent, [cloud-init](/azure/virtual-machines/linux/using-cloud-init). The cloud- init agent offers many additional benefits over the Linux agent, including:

- Performance - Using cloud-init with Azure, you can see improved reduced VM creation times in most cases.
- VM customization - cloud-init enables you to pass down VM configurations to cloud-init through [custom-data](/azure/virtual-machines/linux/using-cloud-init#deploying-a-cloud-init-enabled-virtual-machine). This process includes such actions as running scripts, installing packages, and adding users.
- Migration - If you're migrating from other clouds, you can migrate cloud-init configurations, and modify them where necessary to work with together your Azure deployments.

[!INCLUDE [VM assist troubleshooting tools](~/includes/azure/vmassist-include.md)]

## More information

### Necessary actions

- If you deploy these Azure Marketplace images, then there is nothing more that you have to do. You can immediately take advantage of the benefits after the update.
- If you create custom images from these images, and use the Linux Agent to process custom data, verify that your images still work correctly.

    cloud-init supports multiple input types, including a bash script or a cloud-init config. Review the 'cloud-init'[user-data](https://cloudinit.readthedocs.io/en/latest/topics/format.html) documentation.
- See [this](/azure/virtual-machines/linux/using-cloud-init#cloud-init-overview) page for details about which images will be updated, and the timeline for when the updates occur.

## Frequently asked questions

Q1. Is the Azure Linux Agent still installed in the images?  

A1. Yes, the Azure Linux Agent is required for Azure VM extensions. The provisioning functionality is disabled.  

Q2. Can the Azure Linux Agent and cloud-init be installed in the same image?  

A2. Yes. To ensure that there is no conflict, the Linux Agent provisioning code is disabled and won't run.  

Q3. How can I tell whether my image is provisioned by cloud-init?  

A3. Run `cloud-init status` to learn whether cloud-init ran.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
