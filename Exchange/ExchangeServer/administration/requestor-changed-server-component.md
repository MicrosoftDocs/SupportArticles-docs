---
title: Server component state remains Inactive
description: This article provides a resolution for an issue issue in which server components remain inactive after you change their states to Active.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:High Availability, Health, Performance, Content Indexing\Health set unhealthy
  - Exchange Server
  - CSSTroubleshoot
  - CI 9823
  - CI 9948
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server SE
  - Exchange Server 2019
  - Exchange Server 2016
ms.date: 07/28/2026
ms.reviewer: v-six
---

# Server component state remains Inactive after you set it to Active

_Original KB number:_ &nbsp; 2958835

## Summary

This article describes an Exchange Server issue in which a server component state stays Inactive after you set it to Active. This problem can occur if you use a requester name that differs from the requester that last set the component state. The article explains how to identify the correct requester name and resolve the problem.

## Symptoms

In Microsoft Exchange Server, you change the state of a server component to `Active` by using the [Set-ServerComponentState](/powershell/module/exchangepowershell/set-servercomponentstate) PowerShell cmdlet. The command completes without an error, but the component state stays `Inactive`.

## Cause

This issue might occur because the value that you specified for the `Requester` parameter in the [Set-ServerComponentState](/powershell/module/exchangepowershell/set-servercomponentstate) PowerShell cmdlet doesn’t match the value for this parameter that was specified when the component state was last changed.

## Resolution

1. Use an account that has [sufficient permissions](/exchange/permissions/permissions) on your Exchange Server to open the [Exchange Management Shell (EMS)](/powershell/exchange/open-the-exchange-management-shell) or [connect to your Exchange server by using remote PowerShell](/powershell/exchange/connect-to-exchange-servers-using-remote-powershell).

1. Run the [Get-ServerComponentState](/powershell/module/exchangepowershell/get-servercomponentstate) cmdlet to find a list of server components and their states. If you know the name of the component, you can skip this step.

   ```PowerShell
   (Get-ServerComponentState -Identity <server name>
   ```

   In the following example that searches for inactive components, the Monitoring and RecoveryActionsEnabled components are inactive.

   ```PowerShell
   Get-ServerComponentState -Identity Exch1 | ?{$_.state -eq “Inactive”}
   ```

   :::image type="content" source="media/requestor-changed-server-component/inactive-components.png" alt-text="Screenshot of Monitoring and RecoveryActionsEnabled components.":::

1. To find the requester that last changed the state of the component you want to modify, run the [Get-ServerComponentState](/powershell/module/exchangepowershell/get-servercomponentstate) cmdlet with the following parameters:

   ```PowerShell
   (Get-ServerComponentState -Identity <server name> -Component <component name>).LocalStates 
   ```

   In the following example, the output lists Functional as the requestor that last modified the state of the Monitoring component. Make a note of this requestor's name to use in a later step.

   ```PowerShell
   (Get-ServerComponentState -Identity Exch1 -Component Monitoring).LocalStates
   ```

   :::image type="content" source="media/requestor-changed-server-component/find-requestor-changed-state.png" alt-text="Screenshot of finding Requestor that changed state.":::

1. To change the server component state, run the [Set-ServerComponentState](/powershell/module/exchangepowershell/set-servercomponentstate) cmdlet by using the value of the requester you noted in an earlier step.

   ```PowerShell
   Set-ServerComponentState -Identity <server name>-Component <component name> -State Active -Requester <requestor name>
   ```

   In the following example, the [Set-ServerComponentState](/powershell/module/exchangepowershell/set-servercomponentstate) cmdlet changes the state of the Monitoring component to Active by using the Functional requestor:

   ```PowerShell
   Set-ServerComponentState -Identity Exch1 -Component Monitoring -State Active -Requester Functional
   ```

1. To verify the component is active, run the [Get-ServerComponentState](/powershell/module/exchangepowershell/get-servercomponentstate) cmdlet.

   ```PowerShell
   (Get-ServerComponentState -Identity <server name> -Component <component name>.LocalStates
   ```

   In the following example, the [Get-ServerComponentState](/powershell/module/exchangepowershell/get-servercomponentstate) cmdlet shows that the state of the Monitoring component is Active and was last modified by the requester Functional.

   ```PowerShell
   Get-ServerComponentState -Identity exch1 -Component Monitoring).LocalStates
   ```

   :::image type="content" source="media/requestor-changed-server-component/verify-component-state-changed.png" alt-text="Screenshot of showing that the component is active.":::

### Example walkthrough

In this example, the `ServerWideOffline` server component is `Inactive`, which makes all other server components inactive except for Monitoring and Recovery.

```PowerShell
Get-ServerComponentState -Identity Exch1 | ?{$_.state -ne "active"}
```

:::image type="content" source="media/requestor-changed-server-component/inactive-components-b.png" alt-text="Screenshot that demonstrates Monitoring and RecoveryActionsEnabled components.":::

First, check for the name of the requester that set `ServerWideOffline` to be Inactive:

```PowerShell
   (Get-ServerComponentState -Identity Exch1 -Component ServerWideOffline).LocalStates
```

:::image type="content" source="media/requestor-changed-server-component/find-requestor.png" alt-text="Screenshot that demonstrates finding Requestor that changed state.":::

In this example, Maintenance is the Requester that changed state to Inactive.

Next, use the [Set-ServerComponentState](/powershell/module/exchangepowershell/set-servercomponentstate) PowerShell cmdlet to change the state to Active:

```PowerShell
Set-ServerComponentState exch1 -Component ServerWideOffline -State Active -Requester Maintenance
```

:::image type="content" source="media/requestor-changed-server-component/set-component-state-final.png" alt-text="Screenshot  that demonstrates setting the component state to Active.":::

Finally, use the [Set-ServerComponentState](/powershell/module/exchangepowershell/set-servercomponentstate) cmdlet again to verify the state:

```PowerShell
   Get-ServerComponentState -Identity Exch1 | ?{$_.state -eq "active"}
```

:::image type="content" source="media/requestor-changed-server-component/final-state-components.png" alt-text="Screenshot that demonstrates verifying Monitoring and RecoveryActionsEnabled components.":::

## References

For an in-depth understanding of server component states in Exchange Server, see [Server Component States in Exchange 2013](https://techcommunity.microsoft.com/t5/exchange-team-blog/server-component-states-in-exchange-2013/ba-p/591342).
