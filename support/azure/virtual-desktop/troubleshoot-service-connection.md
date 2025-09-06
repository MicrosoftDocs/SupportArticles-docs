---
title: Troubleshoot Azure Virtual Desktop service connection
description: Helps resolve issues while setting up service connections in an Azure Virtual Desktop tenant environment.
ms.topic: troubleshooting
ms.date: 01/21/2025
ms.reviewer: daknappe
ms.custom: docs_inherited, pcy:wincomm-user-experience
---
# Troubleshoot Azure Virtual Desktop service connections

This article helps resolve issues with Azure Virtual Desktop service connections.

## Provide feedback

You can give us feedback and discuss the Azure Virtual Desktop service with the product team and other active community members at the [Azure Virtual Desktop Tech Community](https://techcommunity.microsoft.com/t5/azure-virtual-desktop/bd-p/AzureVirtualDesktopForum).

## User connects but nothing is displayed (no feed)

A user can start Remote Desktop clients and is able to authenticate. However, the user doesn't see any icons in the web discovery feed.

1. Confirm that the user reporting the issues has been assigned to application groups by using the following cmdlet:

     ```powershell
     Get-AzRoleAssignment -SignInName <userupn>
     ```

2. Confirm that the user is signing in with the correct credentials.
3. If the web client is being used, confirm that there are no cached credentials issues.
4. If the user is part of a Microsoft Entra user group, make sure the user group is a security group instead of a distribution group. Azure Virtual Desktop doesn't support Microsoft Entra distribution groups.

## User loses existing feed and no remote resource is displayed (no feed)

This error usually appears after a user moved their subscription from one Microsoft Entra tenant to another. As a result, the service loses track of their user assignments, since those are still tied to the old Microsoft Entra tenant.

To resolve this, all you need to do is reassign the users to their application groups.

This could also happen if a CSP Provider created the subscription and then transferred to the customer. To resolve this, re-register the Resource Provider.

1. Sign in to the Azure portal.
2. Go to **Subscription**, and then select your subscription.
3. In the menu on the left side of the page, select **Resource provider**.
4. Find and select **Microsoft.DesktopVirtualization**, and then select **Re-register**.

## User sees a conditional access of error of "You don't have access to this"

This error comes from Entra ID Conditional Access, and means that the user is subject to a conditional access policy that is blocking access to a specific Entra ID resource. This usually occurs for one of two reasons:

- User is signing in through the **Windows App** but is not provided access to both the **Azure Virtual Desktop** and **Windows 365** applications.
  > [!NOTE]
  > Windows App will attempt to authenticate the user to both **Azure Virtual Desktop** and **Windows 366** applications, even if the user isn't assigned any Windows 365 Cloud PCs.

- User is signing into a resource with Entra-based single sign-on configured but is not provided access to the **Windows Cloud Login** application.

To verify the issue, check the [Entra ID sign-in logs](/entra/identity/monitoring-health/concept-sign-ins) and walkthrough the steps to [Enforce Microsoft Entra multifactor authentication for Azure Virtual Desktop using Conditional Access](/azure/virtual-desktop/set-up-mfa).

## Next steps

- For an overview on troubleshooting Azure Virtual Desktop and the escalation tracks, see [Troubleshooting overview, feedback, and support](/azure/virtual-desktop/troubleshoot-set-up-overview).
- To troubleshoot issues while creating an Azure Virtual Desktop environment and host pool in an Azure Virtual Desktop environment, see [Environment and host pool creation](/azure/virtual-desktop/troubleshoot-set-up-issues).
- To troubleshoot issues while configuring a virtual machine (VM) in Azure Virtual Desktop, see [Session host virtual machine configuration](/azure/virtual-desktop/troubleshoot-vm-configuration).
- To troubleshoot issues related to the Azure Virtual Desktop agent or session connectivity, see [Troubleshoot common Azure Virtual Desktop Agent issues](/azure/virtual-desktop/troubleshoot-agent).
- To troubleshoot issues when using PowerShell with Azure Virtual Desktop, see [Azure Virtual Desktop PowerShell](/azure/virtual-desktop/troubleshoot-powershell).
- To go through a troubleshoot tutorial, see [Tutorial: Troubleshoot Resource Manager template deployments](/azure/virtual-desktop/../azure-resource-manager/templates/template-tutorial-troubleshoot).
