--- 
title: Invalid Azure credentials error when setting up CycleCloud server
description: This article describes how to add role assignments to resolve an invalid Azure credentials error. This error might occur when you're setting up a CycleCloud server. 
ms.date: 10/27/2022
editor: v-jsitser
ms.reviewer: arrhpcglobal, v-leedennis
ms.service: azure-common-issues-support
#Customer intent: As an Azure CycleCloud user, I want to resolve an invalid Azure credentials error message that I received while I was setting up a CycleCloud server. I want to resolve this error so that I can set up my server successfully.
---

# "Invalid Azure credentials provided" error when setting up CycleCloud server

This article describes how to resolve an "invalid Azure credentials provided" error that might occur when you set up a CycleCloud server.

## Background

When you set up CycleCloud, you can use either [Service Principal](/azure/cyclecloud/how-to/service-principals) or [Managed Identities](/azure/cyclecloud/how-to/managed-identities) for permissions management. In either scenario, you must assign a Contributor role for the subscription. The Contributor role is required to authorize either a service principal or managed identities to take subscription actions, such as creating a storage account or creating virtual machines (VMs).

## Symptoms

When you try to set up CycleCloud server together with either a service principal or managed identities, you receive the following error message:

> Invalid Azure credentials provided: The client '\<tenant-guid>' with object id '\<application-guid>' does not have authorization to perform action 'Microsoft.Storage/storageAccounts/read' over scope '/subscriptions/\<subscription-guid>' or the scope is invalid. If access was recently granted, please refresh your credentials.

## Cause

The role hasn't been correctly assigned to the service principal or the managed identities.

> [!NOTE]
> 
> The Contributor role is the simplest option that includes sufficient permissions for management of CycleCloud resources in a subscription, such as VMs, network, and storage. However, the Contributor role has a higher privilege level than CycleCloud requires. Therefore, you could use a custom role in more complex scenarios. If you're considering using a custom role, we recommend that you take a deeper look at the [Azure role definitions and specific actions](/azure/role-based-access-control/role-definitions-list).

## Solution for service principal

### Service principal setup

During the initial CycleCloud setup, you create a service principal by following the instructions in [Using Service Principal](/azure/cyclecloud/how-to/service-principals). You use a CLI command to create the service principal and to assign a Contributor role for the subscription.

### Check subscription permissions

1. Log in to the Azure portal, and search on **Subscriptions**.
1. Locate the subscription that you want to use for CycleCloud (if more than one subscription is listed).
1. Select **Access Control (IAM)**, select the **Role assignments** tab, and then locate the **Contributor** role listing.
1. Check to verify that the service principal (not the user who is deploying CycleCLoud) is missing from the **Contributor** role.

The service principal is most likely to be missing in scenarios that involve multiple users and tenants. This situation is also likely if you're trying to use an existing service principal for CycleCloud development instead of creating a new one.

### Add role assignments

#### Prerequisites

In order to add role assignments, you must have Microsoft.Authorization/roleAssignments/write permission for the subscription, such as User Access Administrator or Owner. By default, the Write permission isn't granted to a Contributor.

To add a Contributor role to the service principal that's being used for CycleCloud development, follow the steps in [Assign Azure roles using the Azure portal](/azure/role-based-access-control/role-assignments-portal?tabs=current).

## Solution for managed identity

### Managed Identities setup

As you set up managed identities, you enable managed identities during or after CycleCloud VM creation, as described in [Configure managed identities using the Azure portal](/azure/active-directory/managed-identities-azure-resources/qs-configure-portal-windows-vm).

After managed identities are enabled, the Contributor subscription role must be assigned to the managed identity.

Follow these steps to add a Contributor role to the subscription:

1. Log in to the Azure portal, and locate the CycleCloud server VM.
1. In the left panel, select **Settings** > **Identity**.
1. Select **Azure role assignments** > **Add role assignments**, and then select **Subscription** and **Contributor** on the menu.
1. It might take one to two minutes for the new assignment to be created. After it's created, make sure to verify the credential in CycleCloud.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
