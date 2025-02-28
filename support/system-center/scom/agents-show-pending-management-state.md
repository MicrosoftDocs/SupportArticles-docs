---
title: Agents show the Pending Management state
description: Fixes an issue in which Operations Manager agents are still in the Pending Management state even though they don't appear under Pending Management in the Operations Manager console.
ms.date: 04/15/2024
---
# Remove orphaned Operations Management agents using PowerShell

This article helps you fix an issue in which Operations Manager agents are in the **Pending Management** state.

_Original product version:_ &nbsp; Microsoft System Center 2012 Operations Manager  
_Original KB number:_ &nbsp; 2626752

## Symptom

In a System Center Operations Manager command shell, you may see agents that are still in the **Pending Management** state even though they don't appear under **Pending Management** in the Operations Manager console.

## Cause

This issue can occur if there are agent records left behind in the Operations Manager database. At some point, these agents were deployed to a management server manually but later that management server was decommissioned and the agents were never properly removed.

## Resolution

Follow the steps below to resolve this issue.

In this example, we assume we have two agent systems named *Agent1.contoso.msft* and *Agent2.contoso.msft*. Both agents were assigned to a management server named *ManagementServer.Contoso.msft* that no longer exists. In your environment, you would substitute the names for your specific agents and management server.

> AgentName: Agent1.contoso.msft  
> ManagementServerName: ManagementServer.Contoso.msft  
> AgentPendingActionType: PushInstallFailed  
> LastModified: \<date/time>  
> ManagementGroup: Opsmgr-Group  
> ManagementGroupId: 888a2cd4-0db6-f669-32f8-5b08aa25d2e2

> AgentName: Agent2.contoso.msft  
> ManagementServerName: ManagementServer.Contoso.msft  
> AgentPendingActionType: PushInstallFailed  
> LastModified: \<date/time>  
> ManagementGroup: Opsmgr-Group  
> ManagementGroupId: 888a2cd4-0db6-f669-32f8-5b08aa25d2e2

> [!NOTE]
> Before executing any query against the Operations Manager database, be sure that a complete and current backup exists.

1. Run the following queries:

   ```sql
   SELECT AgentPendingActionId
   FROM AgentPendingAction WHERE AgentName like 'Agent1.contoso.msft'
   ```

   Result:

   > 2A5C2E8F-2AD4-1703-D3BE-4755DF1A8E2E

   ```sql
   SELECT AgentPendingActionId
   FROM AgentPendingAction WHERE AgentName like 'Agent2.contoso.msft'
   ```

   Result:

   > 360DB30E-3C2C-50A9-B047-A123A87280C0

2. Execute the following query:

   ```sql
   DECLARE @ActionId uniqueidentifier
   SET @ActionId = (SELECT AgentPendingActionId
   FROM AgentPendingAction WHERE AgentName like 'Agent1.contoso.msft')
   EXEC p_AgentPendingActionDeleteByIdList @AgentPendingActionIdList = @ActionId
   ```

3. Record is deleted successfully. Do the same for the second agent as well.

Now through PowerShell we can confirm no records exist for these two systems.

Following PowerShell command shows us each agent and its assigned primary and failover management server.

```powershell
get-agent|ft -a ComputerName,primarymanagementservername,@{l="secondary";e={$_.getfailovermanagementservers()|foreach{$_.name }} }
```
