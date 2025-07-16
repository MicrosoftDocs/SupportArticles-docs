---
title: Troubleshoot Export of Audit Logs to Another Tenant
description: This guide provides steps to resolve permission-related errors when exporting audit logs to another tenant.
ms.date: 07/17/2025
ms.reviewer: v-liuamson; v-gsitser
ms.service: azure-monitor
ms.custom: I can’t configure export of Activity Logs
---

# Troubleshoot Export of Audit Logs to Another Tenant

When attempting to export audit logs from one tenant to another using Azure Lighthouse, users may encounter permission-related errors. This guide provides steps to resolve these issues, ensuring a smooth configuration process.

## Common Issues and Solutions

- **Issue**: Permission errors when configuring diagnostic settings for exporting audit logs.
- **Root Cause**: The user lacks necessary permissions on the target workspace or incorrect role assignments.

### Step-by-Step Instructions to Resolve Export Issues

1. **Verify User Permissions**:
   - Ensure the user has the necessary permissions to perform actions on the target workspace.
   - Navigate to the Azure portal and check the user's role assignments under the **Access Control (IAM)** section.

2. **Reset Guest Invitation**:
   - If the user is a guest, reset the invitation status to ensure proper linkage between home and resource tenants.
   - Follow the instructions on [Reset Guest Invitation Status](https://learn.microsoft.com/entra/external-id/reset-redemption-status).

3. **Check Role Assignments**:
   - Confirm that the user has the appropriate roles assigned, such as **Log Analytics Contributor** or **Reader**.
   - Use the Azure portal to assign roles if necessary.

4. **Review ARM Template Role Definitions**:
   - Ensure that the ARM template used for deployment specifies the correct RoleDefinitionId.
   - Adjust the template as needed to include the necessary permissions.

5. **Test Configuration**:
   - After making changes, test the configuration to ensure logs are exported successfully.
   - Monitor the Azure Activity Logs for any further errors or warnings.

## Reference

- [Manage Access to Log Analytics Workspaces](https://learn.microsoft.com/azure/azure-monitor/logs/manage-access?tabs=portal#workspace-permissions)
- [Azure Role Assignments](https://learn.microsoft.com/azure/role-based-access-control/role-assignments-portal)

If the issue persists after following the solution steps, please open a support case for further assistance.
