---
title: Troubleshoot Azure Bastion connectivity problems
description: Learn how to troubleshoot common Azure Bastion connectivity problems, including black screens, file transfer problems, and session errors. Find resolutions now.
services: bastion
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
ms.service: azure-bastion
ms.topic: troubleshooting
ms.date: 04/06/2026
ms.custom: Connectivity
---

# Troubleshoot Azure Bastion connectivity problems

## Summary

This article describes common Azure Bastion connectivity problems and their resolutions.

## Common problems and resolutions

|Problem  |Description  |Resolution  |
|---------|---------|---------|
|Unable to connect to virtual machine|You're unable to connect to your virtual machine (and you're not experiencing the other problems listed in this article).|You can troubleshoot your connectivity problems by going to the **Connection Troubleshoot** tab (in the **Help** section) of your Azure Bastion resource in the Azure portal. Network Watcher Connection Troubleshoot provides the capability to check a direct TCP connection from a virtual machine (VM) to a VM, fully qualified domain name (FQDN), URI, or IPv4 address. To start, choose a source to start the connection from, and the destination you wish to connect to and select **Check**. For more information, see [Connection Troubleshoot](/azure/network-watcher/network-watcher-connectivity-overview).<br><br>If just-in-time (JIT) is enabled, you might need to add extra role assignments to connect to Bastion. Add the permissions listed in the [JIT permissions table](#jit-permissions) to the user, and then try reconnecting to Bastion. For more information, see [Enable just-in-time access on VMs](/azure/defender-for-cloud/just-in-time-access-usage).|
|File transfer not working|File transfer isn't working as expected with Azure Bastion.|Azure Bastion supports file transfer between your target VM and local computer by using Bastion and a native RDP or SSH client. At this time, you can't upload or download files by using PowerShell or via the Azure portal. For more information, see [Upload and download files using the native client](/azure/bastion//vm-upload-download-native).|
|Black screen in the Azure portal|When you try to connect by using Azure Bastion, you can't connect to the target VM, and you get a black screen in the Azure portal.|This problem happens when there's either a network connectivity problem between your web browser and Azure Bastion (your client Internet firewall might be blocking WebSockets traffic or similar), or between the Azure Bastion and your target VM. Most cases include an NSG applied either to AzureBastionSubnet, or on your target VM subnet that's blocking the RDP/SSH traffic in your virtual network. Allow WebSockets traffic on your client internet firewall, and check the NSGs on your target VM subnet. See the **Unable to connect to virtual machine** row in this table to learn how to use **Connection Troubleshoot** to troubleshoot your connectivity problems.|
|Session has expired error|You get a "Your session has expired" error message before the Bastion session starts.|If you go to the URL directly from another browser session or tab, this error is expected. It helps ensure that your session is more secure and that the session can be accessed only through the Azure portal. Sign in to the Azure portal and begin your session again.|

### JIT permissions

The following table lists the permissions required for just-in-time (JIT) access:

| Setting | Description|
|---|---|
|Microsoft.Security/locations/jitNetworkAccessPolicies/read|Gets the just-in-time network access policies|
|Microsoft.Security/locations/jitNetworkAccessPolicies/write | Creates a new just-in-time network access policy or updates an existing one |

## Resources

- [Azure Bastion FAQ](/azure/bastion/bastion-faq)