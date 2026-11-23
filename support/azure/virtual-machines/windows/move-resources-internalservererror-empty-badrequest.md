---
title: Azure resource move fails with InternalServerError or empty BadRequest message
description: Fix Azure resource move failures caused by InternalServerError or empty BadRequest responses. Follow retry, diagnostics, and validation steps.
services: virtual-machines
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/09/2026
ms.reviewer: scotro, jdickson
ms.custom: sap:VM Move and Migration
ai-usage: ai-assisted
---

# Azure resource move fails with InternalServerError or empty BadRequest message

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs :heavy_check_mark: All resource types

## Summary

Azure resource move operations can fail and generate an `InternalServerError` or empty `BadRequest` error message if Azure Resource Manager (ARM) experiences transient issues or limited error reporting. Use this article to retry safely, collect diagnostics, and identify blockers faster.

## Symptoms

A resource move operation fails and returns one of the following error messages.

**InternalServerError**

```output
InternalServerError: Encountered internal server error.
```

**Empty BadRequest**

```output
BadRequest: ""
```

The `InternalServerError` message indicates a transient platform issue. The empty `BadRequest` response indicates that the platform can't provide specific error details about the failure.

## Cause

These errors occur if one of the following conditions is true:

- ARM experiences a transient internal failure during the move operation.
- The move request doesn't include enough context for ARM to return a specific error code.
- A dependent service times out or returns an empty response during ARM move validation.
- The resource is in an inconsistent state, and ARM can't determine the failure reason.

## Resolution

### Quick fix

Follow these steps:

1. Retry by using exponential backoff (don't submit rapid retries).
1. Capture correlation ID for the failed attempt.
1. Run preflight checks on dependent resources before you retry.
1. If repeated failures occur, switch to the Azure Resource Mover validation workflow.

If the quick fix doesn't resolve the error, follow the steps in the next sections.

### Step 1: Retry safely with bounded backoff

Transient errors often resolve on retry. Use Azure PowerShell or Azure CLI to try exponential backoff in order to avoid overloading the service.

# [Azure PowerShell](#tab/powershell)

The following script retries the move up to four times, and increases the delays between attempts.

Run the following commands.

```azurepowershell
$maxAttempts = 4
$delaySeconds = 30

for ($attempt = 1; $attempt -le $maxAttempts; $attempt++) {
  try {
    Move-AzResource -DestinationResourceGroupName "<destination-rg>" `
      -DestinationSubscriptionId "<destination-sub-id>" `
      -ResourceId @("<resource-id>") -ErrorAction Stop

    Write-Host "Move request accepted on attempt $attempt"
    break
  }
  catch {
    Write-Host "Attempt $attempt failed: $($_.Exception.Message)"
    if ($attempt -eq $maxAttempts) { throw }
    Start-Sleep -Seconds $delaySeconds
    $delaySeconds = [Math]::Min($delaySeconds * 2, 300)
  }
}
```

# [Azure CLI](#tab/cli)

Retry the move manually. Wait 30 seconds between attempts, and increase the wait time if the error persists.

Run the following command.

```azurecli
az resource move --destination-group "<destination-rg>" \
  --destination-subscription-id "<destination-sub-id>" \
  --ids "<resource-id>"
```

# [Azure portal](#tab/portal)

Retrying a move operation with automated exponential backoff isn't available in the [Azure portal](https://portal.azure.com). To implement scripted retry logic, use Azure PowerShell or Azure CLI.

---

### Step 2: Collect diagnostics by using the correlation ID

In the Azure activity log, the correlation ID from the failed attempt identifies the specific operation. Use Azure PowerShell, Azure CLI, or the [Azure portal](https://portal.azure.com) to retrieve the activity log entries.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Get-AzActivityLog -StartTime (Get-Date).AddHours(-2) |
  Where-Object { $_.OperationName.Value -like '*MoveResources*' } |
  Select-Object EventTimestamp, ActivityStatus, CorrelationId, Message
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az monitor activity-log list --start-time $(date -u -d '2 hours ago' '+%Y-%m-%dT%H:%M:%SZ') \
  --query "[?contains(operationName.value, 'MoveResources')].{Time:eventTimestamp, Status:status.value, CorrelationId:correlationId}" \
  --output table
```

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to **Resource groups** and then select the source resource group.
1. In the menu, select **Activity log**.
1. Filter by **Timespan** to cover the time of the failed move.
1. Look for entries with **Status** = **Failed** and an operation name that contains **MoveResources**.
1. Select the entry to view the **Correlation ID**, error code, and error message.

For more information, see [View and retrieve the activity log](/azure/azure-monitor/essentials/activity-log#view-and-retrieve-the-activity-log).

---

Review the output to find entries that have a `Failed` status. The `Message` field often contains more details about the root cause that the original error message doesn't include.

### Step 3: Run lightweight preflight checks

Verify the following conditions before retrying the move:

- The source and destination resource groups don't have management locks applied.
- The destination subscription policies don't deny resource creation.
- All required resource providers are registered in the destination subscription.
- All dependent resources are included in the move set.

If any of these conditions aren't met, resolve the blocker before you retry the move. For example, remove management locks by using `Remove-AzResourceLock`, or register a missing provider by using `Register-AzResourceProvider`.

### Step 4: Use Resource Mover if the error message lacks detail

If the error body is empty or contains generic information, use Resource Mover validation to get actionable diagnostic details. Resource Mover performs a deeper validation than the standard move API, and returns specific error codes for each resource.

Use Azure PowerShell or Azure CLI to run Resource Mover validation.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Invoke-AzResourceMoverMoveCollectionValidation -MoveCollectionName "<collection-name>" `
  -ResourceGroupName "<collection-rg>"
```

#### [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az resource-mover move-collection validate \
  --move-collection-name "<collection-name>" \
  --resource-group "<collection-rg>"
```

# [Azure portal](#tab/portal)

Running Resource Mover validation to get detailed per-resource diagnostic codes isn't available in the Azure portal for this workflow. To validate via command line, use Azure PowerShell or Azure CLI.

---

Review the validation results for each resource in the collection. Resources that fail validation include a detail code and message that you can use to determine the exact blocker.

### Prevention

Ensure that you take the following preventative measures:

- Don't send rapid retries after a transient failure. Use bounded exponential backoff to allow the platform time to recover.
- Verify all dependencies before you submit a move operation.
- Use Resource Mover for moves that involve multiple resources or complex dependency chains.

## References

- [Azure resource move fails after provider operations succeed with batch orchestration error](move-resources-batch-orchestration-failed.md)
- [Azure resource move fails with provider-specific validation error](move-resources-provider-validation-failed.md)
- [Azure resource move is blocked by Azure Policy deny rules](move-resources-blocked-by-destination-policy.md)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
