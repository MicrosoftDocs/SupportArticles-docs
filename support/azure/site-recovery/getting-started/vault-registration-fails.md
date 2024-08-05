---
title: Vault registration fails in Azure Site Recovery with error
description: Describes an error may occur if you are reinstalling the Azure Site Recovery provider and agent on a Hyper-V server that was previously registered to another vault.
ms.date: 10/10/2020
ms.service: azure-site-recovery
ms.author: genli
author: genlin
ms.reviewer: markstan
ms.custom: sap:I need help getting started with Site Recovery
---
# Vault registration fails in Azure Site Recovery with error: The DRA server is already registered in vault

This article provides a solution to an issue in which Vault registration may fail if you are reinstalling the Azure Site Recovery provider and agent on a Hyper-V server that was previously registered to another vault.

_Original product version:_ &nbsp; Azure Backup  
_Original KB number:_ &nbsp; 3093574

## Symptoms

The Microsoft Azure Site Recovery Registration Wizard may fail on the Vault Settings  page, and you receive an error message that resembles the following:

```
---------------------------
Microsoft Azure Site Recovery Provider Setup
---------------------------
The DRA server is already registered in vault. Either select the registration key associated with this vault, or unregister the server from and then register it with a different vault.
---------------------------
OK
---------------------------
```

> [!NOTE]
> The space after the word "vault." In some cases, you may see the name of a previously registered vault. For example, you may see the following: The DRA server is already registered in vault contosovault01.

## Cause

This error may occur if you are reinstalling the Azure Site Recovery (ASR) provider and agent on a Hyper-V server that was previously registered to another vault.

## Resolution

To fix this error and enable the ASR Provider and agent setup to complete successfully, follow these steps:

1. Cancel the current installation.
2. Make a backup of this registry key: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Azure Site Recovery\Registration`.

3. Delete the registry key that you backed up in step 2.
4. Restart the Provider and agent setup.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
