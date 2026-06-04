---
title: Troubleshoot shareable links problems in Azure Bastion
description: Troubleshoot shareable links problems in Azure Bastion, including custom domain and password reset limitations. Find resolutions and fix problems quickly.
services: bastion
author: JarrettRenshaw
ms.author: jarrettr
manager: dcscontentpm
ms.service: azure-bastion
ms.topic: troubleshooting
ms.date: 04/06/2026
ms.custom: Usability
---

# Troubleshoot shareable links problems in Azure Bastion

## Summary

This article describes common shareable links problems in Azure Bastion and their resolutions.

## Common problems and resolutions

|Problem  |Description  |Resolution  |
|---------|---------|------|
|Custom domains not supported|Custom domains aren't supported with Bastion shareable links.|Custom domains aren't supported with Bastion shareable links. Users receive a certificate error when they try to add specific domains in the CN/SAN of the Bastion host certificate. This limitation is current.|
|Reset Password not available for shareable link users|Reset Password button appears but doesn't work for local users connecting through a shareable link.|Some organizations have company policies that require a password reset when a user signs in to a local account for the first time. When you use shareable links, you can't change the password, even though a "Reset Password" button might appear. This limitation is known.|

## Resources

- [Azure Bastion FAQ](/azure/bastion/bastion-faq)