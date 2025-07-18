---
title: Troubleshoot Export of Audit Logs to Another Tenant
description: This article provides guidance to resolve permissions-related errors when you export audit logs to another tenant.
ms.date: 07/17/2025
ms.reviewer: v-liuamson; v-gsitser
ms.service: azure-monitor
ms.custom: I can’t configure export of Activity Logs
---

# Troubleshoot export of Audit Logs to another tenant

When users try to export audit logs from one tenant to another by using Microsoft Azure Lighthouse, they might experience permissions-related errors. This article provides guidance to resolve these issues.

## Common issues and solutions

- **Issue**: Permissions errors occur when a user configures diagnostic settings for exporting audit logs.
- **Root cause**: The user lacks the required permissions on the target workspace or has an incorrect role assignment.

### Instructions to resolve export issues

1. **Verify user permissions**:
   - Make sure that the user has the necessary permissions to perform actions on the target workspace.
   - Navigate to the Azure portal, and check the user's role assignments in the **Access Control (IAM)** section.

2. **Reset guest invitation**:
   - If the user is a guest, reset the invitation status to ensure proper linkage between home and resource tenants.
   - Follow the steps in [Reset Guest Invitation Status](https://learn.microsoft.com/entra/external-id/reset-redemption-status).

3. **Check role assignments**:
   - Verify that the user has the appropriate roles assigned, such as **Log Analytics Contributor** or **Reader**.
   - Use the Azure portal to assign roles, if it's necessary.

4. **Review ARM template role definitions**:
   - Make sure that the ARM template that's used for deployment specifies the correct `RoleDefinitionId` value.
   - Adjust the template as necessary to include the required permissions.

5. **Test configuration**:
   - After you make these changes, test the configuration to make sure that logs are exported successfully.
   - Monitor the Azure Activity Logs for any more error messages or warnings.

## References

- [Manage Access to Log Analytics Workspaces](https://learn.microsoft.com/azure/azure-monitor/logs/manage-access?tabs=portal#workspace-permissions)
- [Azure Role Assignments](https://learn.microsoft.com/azure/role-based-access-control/role-assignments-portal)

If the issue persists after you follow these steps, open a support case for further assistance.
