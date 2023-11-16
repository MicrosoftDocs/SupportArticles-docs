---
title: Guidance for troubleshooting Network Policy Server
description: Learn how to troubleshoot scenarios related to Network Policy Server (NPS).
ms.date: 05/14/2022
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, v-tappelgate
ms.custom: sap:nps, csstroubleshoot
ms.technology: networking
---

# Network Policy Server troubleshooting guidance

This article provides guidance for troubleshooting Network Policy Server. The article includes a checklist for troubleshooting, a description of known issues, and instructions for resolving specific Network Policy Server events.

## Troubleshooting checklist

Use this checklist to identify and resolve common Network Policy Server issues.

### Step 1: Check that NPS Auditing is enabled

1. Open an administrative Command Prompt window, and then enter the following command:

   ```cmd
   auditpol /get /subcategory:"Network Policy Server"
   ```

   If the result of this command is "Success and Failure" or "Failure," then auditing is enabled.

1. If auditing isn't enabled, you can enable auditing by entering the following command:

   ```cmd
   auditpol /set /subcategory:"Network Policy Server" /success:enable /failure:enable
   ```

### Step 2: Review event logs for authentication failure errors

When NPS auditing is enabled, the event logs record any authentication failure errors. To review this information, follow these steps:

1. Open Event Viewer, and then select **Custom views** > **Server roles** > **Network Policy and Access Services**.

1. Check for events that have Event ID 6273 or 6274. Most authentication failures produce these events.
1. Check the reason codes of the authentication failure events. The reason code indicates the cause of the failure.
1. Check to see if the events are associated with a single user account. If so, check the NPS event log for other references to that user account. Such events may indicate an issue in network policy or connection request policy.

### Step 3: Check the NPS configuration

Make sure of the following:

- The NPS server certificate is valid.

- The **RADIUS Clients and Servers** list includes the radius client in question.
- The shared secret key of the radius client matches the NPS shared secret key.
- The radius ports (1812,1813,1645,1646) are allowed through all firewalls.
- The network and connection request policy includes all appropriate conditions.
- The network policy constraints list the correct authentication method.

### Step 4: Check the request forwarding configuration

If the NPS server must forward the request to another radius server for authentication, then make sure of the following:

- The **Remote Radius Server Groups** list includes the radius server in question.
- The authentication settings for the connection request policy are correct, including the group that is used in forward requests to the remote server.

<a name='step-5-temporarily-remove-azure-ad-mfa-registry-keys'></a>

### Step 5: Temporarily remove Microsoft Entra multifactor authentication registry keys

If you're using NPS and Microsoft Entra multifactor authentication (MFA), try to isolate the behavior by temporarily removing the Microsoft Entra multifactor authentication registry keys. To do this, follow these steps:

1. In Registry Editor, back up the **HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Authsrv\Parameters** subkey.

1. Under this subkey, delete the **AuthorizationDLLs** and **ExtensionDLLs** entries.
1. Test NPS authentication again.
1. If NPS authentication fails, check Event Viewer to see the reason codes for any related events.
1. If NPS authentication succeeds, then the issue might be specific to Microsoft Entra multifactor authentication. To check for related events, open Event Viewer and go to **Applications and Services Logs** > **Microsoft** > **AzureMfa** > **AuthN** > **AuthZ**.

## Common issues and solutions

### Emerging and known issues

For descriptions and summaries of emerging and known issues, see [Windows release health page](https://admin.microsoft.com/adminportal/home?#/windowsreleasehealth) in the Microsoft 365 admin center. The Windows release health page is designed to provide troubleshooting information for known issues that your users may be experience. This page is available to customers who have a Microsoft 365 subscription.

### NPS Event ID 13: A RADIUS message was received from the invalid RADIUS client IP address xx.xx.xx.xx

Check that the IP address listed in the radius client is relevant. If it is, add the radius client to the **Radius Clients** list.

The NPS event log records this event when the NPS server receives a message from a radius client that isn't on the configured list of radius clients. For more information, see [Event ID 13 - RADIUS Client Configuration](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd316135(v=ws.10)).

### NPS Event ID 18: An Access-Request message was received from RADIUS client %1 with a message authenticator attribute that isn't valid

Check the value of both shared secret keys. Additionally, you can generate and configure a new key, and then check to see whether the issue recurs.

The NPS event log records this event when authentication fails because the shared secret key of the radius client doesn't match the shared secret key of the NPS server. For more information, see [Event ID 18 - NPS Server Communication](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc735343(v=ws.10)).

### NPS Event ID 6273, reason code 16: Network Policy Server denied access to a user

To resolve this issue, check each of the following possible causes:

- Check that the username and password for the user are valid.

- Check to see whether the user account is locked in Active Directory.
- Check that the request is targeted to the correct domain controller and that the user account exists.

The NPS event log records this event and reason code when authentication fails because the user's password is incorrect. For more information, see [Event ID 6273 - NPS Authentication Status](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd316172(v=ws.10)).

## References

- [Audit Network Policy Server](/windows/security/threat-protection/auditing/audit-network-policy-server)
- [Network Policy Server Best Practices](/windows-server/networking/technologies/nps/nps-best-practices)
- [Manage Network Policy Server](/windows-server/networking/technologies/nps/nps-manage-top)
