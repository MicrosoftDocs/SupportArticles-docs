---
title: Common issues with confidential containers in Azure Container Instances
description: Learn how to fix common confidential container issues in Azure Container Instances, including CCE policy failures, base64 errors, and device hash errors.
ms.date: 10/07/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: tysonfreeman, v-weizhu, kennethgp, kaushika
ms.service: azure-container-instances
ms.custom: sap:Management
ai-usage: ai-assisted
---
# Troubleshoot common issues with confidential containers in Azure Container Instances

## Summary

This article helps you troubleshoot and resolve common issues with confidential containers on Azure Container Instances (ACI).

## Common issues

When you deploy confidential containers, you might experience the following issues and errors:

- Policy failures.

    ```output
    Deployment Failed.
    ErrorMessage=failed to create containerd task: failed to create shim task:
    uvm::Policy: failed to modify utility VM configuration: guest modify: guest RPC failure:
    error creating Rego policy: rego compilation failed: rego compilation failed: 4 errors occurred:
    ```

    ```output
    Deployment Failed.
    ErrorMessage=failed to create containerd task: failed to create shim task:
    uvm::Policy: failed to modify utility VM configuration: guest modify:guest RPC failure:
    error creating Rego policy: rego compilation failed: rego compilation failed: 1 error occurred:
    policy.rego:48 rego_parse_error: non-terminated string;
    ```

    ```output
    Container creation denied due to policy: create_container not allowed by policy. 
    Errors: [invalid command].
    ```

    ```output
    Denied by policy: rule for mount_device is missing from policy: unknown.
    ```

    ```output
    Failed to create containerd task: failed to create shim task: failed to mount container storage:
    failed to add LCOW layer: failed to add SCSI layer: failed to modify UVM with new SCSI mount:
    guest modify: guest RPC failure: mounting scsi device controller 3 lun 2 onto /run/mounts/m4
    denied by policy: mount_device not allowed by policy. Errors: [deviceHash not found].
    ```

    ```output
    Container creation denied due to policy: create_container not allowed by policy. 
    ```

- A policy that enforces a new framework.

    ```output
    Failed to create containerd task: failed to create shim task: failed to mount container storage:
    guest modify: guest RPC failure: overlay creation denied by policy: mount_overlay not allowed by policy.
    Errors: [framework_svn is ahead of the current svn: 1.1.0 > 0.1.0].
    ```

- Invalid base64 confidential computing enforcement (CCE) policy.

    ```output
    The CCE Policy is not valid Base64.
    ```

- A 120 KB limitation on the CCE policy.

    ```output
    Failed to create containerd task: failed to create shim task: error while creating the compute system:
    hcs::CreateComputeSystem <compute system id>@vm: The requested operation failed.: unknown.\r\n;
    The container group provisioning has failed. Refer to 'DeploymentFailedReason' event for more details.;
    ```

    ```output
    Failed to create containerd task: failed to create shim task: task with id: '<task id>' cannot be created in pod: '<pod>'
    which is not running: failed precondition.\r\n;The container group provisioning has failed.
    Refer to 'DeploymentFailedReason' event for more details.
    ```

- Device hash not found.

    ```output
    Denied by policy: rule for mount_device is missing from policy: unknown.
    ```

    ```output
    Failed to create containerd task: failed to create shim task: failed to mount container storage:
    failed to add LCOW layer: failed to add SCSI layer: failed to modify UVM with new SCSI mount:
    guest modify: guest RPC failure: mounting scsi device controller 3 lun 2 onto /run/mounts/m4
    denied by policy: mount_device not allowed by policy. Errors: [deviceHash not found]
    ```

- Other issues:
  - Logs don't show up.
  - The exec functionality doesn't work.
  - Subscription deployment times out after 30 minutes.
  - Liveness probe with disallowed policy.
  - Exit code 139.

## Cause

In most cases, these issues occur due to the CCE policy definition.

## Solution

Follow these steps:

- If you experience any policy failures, regenerate the CCE policy and retry the deployment.
- If the CCE policy enforces a framework, revert to an older framework svn.
- If the device hash isn't found or there's an issue with an image, clear the cache and regenerate the CCE policy.

  To clean the cache, run the `docker rmi <image_name>:<tag>` command. To clean all images in the cache, run the `docker rmi $(docker images -a -q)` command. To inspect the missing hash, run the `docker inspect <image_name>:<tag>` command.

