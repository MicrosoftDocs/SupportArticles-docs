---
title: Common errors with Confidential Containers
description: Provides a solution to common issues with confidential containers.
ms.date: 01/16/2024
ms.reviewer: tysonfreeman, v-weizhu
ms.service: container-instances
---
# Common Errors with Confidential Containers

This article provides a solution to common issues with confidential containers.

## Symptoms

- Policy Failures
```
Deployment Failed. ErrorMessage=failed to create containerd task: failed to create shim task: uvm::Policy: failed to modify utility VM configuration: guest modify: guest RPC failure: error creating Rego policy: rego compilation failed: rego compilation failed: 4 errors occurred:
# or
Deployment Failed. ErrorMessage=failed to create containerd task: failed to create shim task: uvm::Policy: failed to modify utility VM configuration: guest modify: guest RPC failure: error creating Rego policy: rego compilation failed: rego compilation failed: 1 error occurred: policy.rego:48: rego_parse_error: non-terminated string;
```
```
Container creation denied due to policy: create_container not allowed by policy. 
Errors: [invalid command].
```
```
Denied by policy: rule for mount_device is missing from policy: unknown.
# or
Failed to create containerd task: failed to create shim task: failed to mount container storage: failed to add LCOW layer: failed to add SCSI layer: failed to modify UVM with new SCSI mount: guest modify: guest RPC failure: mounting scsi device controller 3 lun 2 onto /run/mounts/m4 denied by policy: mount_device not allowed by policy. Errors: [deviceHash not found].
```
```
Container creation denied due to policy: create_container not allowed by policy. 
```
- Policy enforces a new framework
```
Failed to create containerd task: failed to create shim task: failed to mount container storage: guest modify: guest RPC failure: overlay creation denied by policy: mount_overlay not allowed by policy. Errors: [framework_svn is ahead of the current svn: 1.1.0 > 0.1.0].
```
- Invalid base 64 (both base 64 validation and invalid syntax)
```
The CCE Policy is not valid Base64.
```
- Limitation - 120kb limit on policy
```
Failed to create containerd task: failed to create shim task: error while creating the compute system: hcs::CreateComputeSystem b36a43156c5ff1ba72fc9604186bb0151cdd874b6224cd79fe75b9444929d65d@vm: The requested operation failed.: unknown.\r\n;The container group provisioning has failed. Refer to 'DeploymentFailedReason' event for more details.;
# or
Failed to create containerd task: failed to create shim task: task with id: '623325d3aad6b4cc48421700c09368d6be78ecfe2fd660f8b5b8f8d9ffccb907' cannot be created in pod: '8861a5b70b95e816803c07cc9ebebde50268687f3024ddf04c6769a5c1c10029' which is not running: failed precondition.\r\n;The container group provisioning has failed. Refer to 'DeploymentFailedReason' event for more details.
```
- Device hash not found
```
Denied by policy: rule for mount_device is missing from policy: unknown.

# or

Failed to create containerd task: failed to create shim task: failed to mount container storage: failed to add LCOW layer: failed to add SCSI layer: failed to modify UVM with new SCSI mount: guest modify: guest RPC failure: mounting scsi device controller 3 lun 2 onto /run/mounts/m4 denied by policy: mount_device not allowed by policy. Errors: [deviceHash not found]
```
- Logs not showing up
- Exec not working
- Subscription deployment timeout after 30 minutes
- Liveness Probe with disallow policy
- Exit code 139

## Cause

These issues can be due to the CCE policy in most cases.

## Solution

### Solution 1 - Regenerate CCE Policy and retry
This solution may work for any policy failures

### Solution 2 - Revert to older framework svn
This solution may work if the policy is enforcing a framework.

### Solution 3 - Clear cache and regenerate CCE policy
This solution may work if the device hash is not found or there is an issue with an image.

- Clean cache command: `docker rmi <image_name>:<tag>`
- Clean all images in cache: docker rmi $(docker images -a -q)
- Inspect missing hash: `docker inspect <image_name>:<tag>`

## Next Steps
[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
