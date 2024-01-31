---
title: Common issues with confidential containers
description: Provides a solution to common issues with confidential containers.
ms.date: 01/30/2024
ms.reviewer: tysonfreeman, v-weizhu
ms.service: container-instances
---
# Troubleshoot common issues with confidential containers

This article provides a solution to common issues with confidential containers on Azure Container Instances.

## Common issues

You might experience the following issues and errors when you deploy confidential containers:

- Policy failures:

    ```output
    Deployment Failed. ErrorMessage=failed to create containerd task: failed to create shim task: uvm::Policy: failed to modify utility VM configuration: guest modify: guest RPC failure: error creating Rego policy: rego compilation failed: rego compilation failed: 4 errors occurred:
    ```

    ```output
    Deployment Failed. ErrorMessage=failed to create containerd task: failed to create shim task: uvm::Policy: failed to modify utility VM configuration: guest modify: guest RPC failure: error creating Rego policy: rego compilation failed: rego compilation failed: 1 error occurred: policy.rego:48: rego_parse_error: non-terminated string;
    ```

    ```output
    Container creation denied due to policy: create_container not allowed by policy. 
    Errors: [invalid command].
    ```

    ```output
    Denied by policy: rule for mount_device is missing from policy: unknown.
    ```

    ```output
    Failed to create containerd task: failed to create shim task: failed to mount container storage: failed to add LCOW layer: failed to add SCSI layer: failed to modify UVM with new SCSI mount: guest modify: guest RPC failure: mounting scsi device controller 3 lun 2 onto /run/mounts/m4 denied by policy: mount_device not allowed by policy. Errors: [deviceHash not found].
    ```

    ```output
    Container creation denied due to policy: create_container not allowed by policy. 
    ```

- A policy enforces a new framework:

    ```output
    Failed to create containerd task: failed to create shim task: failed to mount container storage: guest modify: guest RPC failure: overlay creation denied by policy: mount_overlay not allowed by policy. Errors: [framework_svn is ahead of the current svn: 1.1.0 > 0.1.0].
    ```

- Invalid base64 confidential computing enforcement (CCE) policy:

    ```output
    The CCE Policy is not valid Base64.
    ```

- Limitation - 120 Kilobytes (KB) limit on the CCE policy:

    ```output
    Failed to create containerd task: failed to create shim task: error while creating the compute system: hcs::CreateComputeSystem <compute system id>@vm: The requested operation failed.: unknown.\r\n;The container group provisioning has failed. Refer to 'DeploymentFailedReason' event for more details.;
    ```
    
    ```output
    Failed to create containerd task: failed to create shim task: task with id: '<task id>' cannot be created in pod: '<pod>' which is not running: failed precondition.\r\n;The container group provisioning has failed. Refer to 'DeploymentFailedReason' event for more details.
    ```
- Device hash isn't found:

    ```output
    Denied by policy: rule for mount_device is missing from policy: unknown.
    ```

    ```output
    Failed to create containerd task: failed to create shim task: failed to mount container storage: failed to add LCOW layer: failed to add SCSI layer: failed to modify UVM with new SCSI mount: guest modify: guest RPC failure: mounting scsi device controller 3 lun 2 onto /run/mounts/m4 denied by policy: mount_device not allowed by policy. Errors: [deviceHash not found]
    ```
- Other issues
  - Logs aren't showing up.
  - The exec functionality isn't working.
  - Subscription deployment times out after 30 minutes.
  - Liveness probe with disallowed policy.
  - Exit code 139.

## Cause

In most cases, these issues occur due to the CCE policy.

## Solution

- If you're experience any policy failures, regenerate the CCE policy and retry the deployment.

- If the CCE policy is enforcing a framework, revert to an older framework svn.

- If the device hash isn't found or there's an issue with an image, clear cache and regenerate the CCE policy.

  To clean cache, run the command: `docker rmi <image_name>:<tag>`. To clean all images in cache, run the command: `docker rmi $(docker images -a -q)`. To inspect the missing hash, run the command: `docker inspect <image_name>:<tag>`.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
