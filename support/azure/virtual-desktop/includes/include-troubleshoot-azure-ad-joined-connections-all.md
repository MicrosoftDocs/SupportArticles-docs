---
ms.reviewer: daknappe
ms.topic: include
ms.date: 01/21/2025
---
### Your account is configured to prevent you from using this device

If you come across an error saying:

> Your account is configured to prevent you from using this device. For more information, contact your system administrator.

Ensure the user account was given the [Virtual Machine User Login role](/entra/identity/devices/howto-vm-sign-in-azure-ad-windows#azure-role-not-assigned) on the virtual machines (VMs).

### The user name or password is incorrect

If you can't sign in and keep receiving an error message that says your credentials are incorrect, first make sure you're using the right credentials. If you keep seeing error messages, check to make sure you've fulfilled the following requirements:

- Have you assigned the Virtual Machine User Login role-based access control (RBAC) permission to the VM or resource group for each user?
- Does your Conditional Access policy exclude multifactor authentication requirements for the Azure Windows VM sign-in cloud application?

If you've answered no to either of those questions, you'll need to reconfigure your multifactor authentication. To reconfigure your multifactor authentication, follow the instructions in [Enforce Microsoft Entra multifactor authentication for Azure Virtual Desktop using Conditional Access](/azure/virtual-desktop/set-up-mfa#azure-ad-joined-session-host-vms).

> [!IMPORTANT]
> VM sign-ins don't support per-user enabled or enforced Microsoft Entra multifactor authentication. If you try to sign in with multifactor authentication on a VM, you won't be able to sign in and will receive an error message.

If you have [integrated Microsoft Entra logs with Azure Monitor logs](/entra/identity/monitoring-health/howto-integrate-activity-logs-with-azure-monitor-logs) to access your Microsoft Entra sign-in logs through Log Analytics, you can see if you've enabled multifactor authentication and which Conditional Access policy is triggering the event. The events shown are non-interactive user login events for the VM, which means the IP address will appear to come from the external IP address from which your VM accesses Microsoft Entra ID.

You can access your sign-in logs by running the following Kusto query:

```kusto
let UPN = "userupn";
AADNonInteractiveUserSignInLogs
| where UserPrincipalName == UPN
| where AppId == "372140e0-b3b7-4226-8ef9-d57986796201"
| project ['Time']=(TimeGenerated), UserPrincipalName, AuthenticationRequirement, ['MFA Result']=ResultDescription, Status, ConditionalAccessPolicies, DeviceDetail, ['Virtual Machine IP']=IPAddress, ['Cloud App']=ResourceDisplayName
| order by ['Time'] desc
```
