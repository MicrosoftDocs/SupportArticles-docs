--- 
title: AccountEncryptionKeyUnavailable error message in Azure Batch
description: This article describes a known issue in Azure Batch that causes an AccountEncryptionKeyUnavailable error message.  
ms.date: 09/21/2022
editor: v-jsitser
ms.reviewer: biny, v-leedennis
ms.service: batch
#Customer intent: As an Azure Batch user, I want to understand how to proceed when I receive an AccountEncryptionKeyUnavailable error message that prevents me from listing pools so that I can use Azure Batch effectively.
---

# "AccountEncryptionKeyUnavailable" error when you try to list pools in Azure Batch

This article explains how to handle an "AccountEncryptionKeyUnavailable" error message in Azure Batch. This error might occur when you try to view a list of pools.

## Symptoms

When you select **Pools** in the upper-left corner of the Azure portal under **Features**, you can't see the list of Azure Batch pools. Instead, you receive the following error message:

> AccountEncryptionKeyUnavailable message: Account data could not be decrypted as the account encryption key is currently unavailable.

The reason code is AccountKeysNotFound.

## Cause

This is a known issue in Azure Batch. This issue occurs if your subscription was suspended. There are various reasons why a subscription might be suspended, such as fraud and running out of credits.

## Solution

The product team is working on a solution for this issue. We intend to deploy a fix soon. Currently, the only way to mitigate the issue is to delete and re-create the batch account.

To handle a suspended subscription, see [Reactivate a disabled Azure subscription](/azure/cost-management-billing/manage/subscription-disabled).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
