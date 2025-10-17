---
title: SQL Server Agent Startup Fails with Error 17156 Could Not Initiate the EventLog Service
description: Learn how to troubleshoot error 17156 "Could not initiate the EventLog Service" when you start SQL Server Agent.
ms.reviewer: v-shaywood
ms.date: 10/10/2025
ms.custom: sap:Startup, shutdown, restart issues (instance or database)\Cannot start SQL Server
---

# Error 17156 "Could not initiate the EventLog Service" when starting SQL Server Agent

This article provides troubleshooting guidance for error 17156, "Could not initiate the EventLog Service," that might occur when you start SQL Server Agent. This error can appear after you install or upgrade to Windows Server 2022 or 2025. It prevents SQL Server Agent from starting.

## Symptoms

After you install or upgrade Microsoft SQL Server on Windows Server 2025 or 2022, SQL Server Agent doesn't start. When the startup process fails, it adds an entry to the SQL Server error log that resembles the following example:

```log
2025-10-02 08:24:32.26 Server      Error: 17156, Severity: 16, State: 1.
2025-10-02 08:24:32.26 Server      initeventlog: Could not initiate the EventLog Service for the key 'MSSQL$SQL2022',  or last error code is 5.
2025-10-02 08:24:32.26 Server      Microsoft SQL Server 2022 (RTM-CU21) (KB5065865) - 16.0.4215.2 (X64)
Aug 11 2025 13:24:21
Copyright (C) 2022 Microsoft Corporation
Developer Edition (64-bit) on Windows Server 2025 Datacenter 10.0 <X64> (Build 26100: ) (Hypervisor)
```

## Cause

This error can occur if SQL Server Agent is blocked from writing to the Application event log. During startup, the SQL Server Agent tries to register its own event source to the Application event log. However, without write access, registration fails. If SQL Server Agent doesn't register the event source, the startup process terminates.

An incorrect configuration in the **Configure log access** group policy can prevent SQL Server Agent from writing to the Application event log. If the **Configure log access** policy doesn't grant write access to the account that's used by SQL Server Agent, the agent doesn't start.

This error can appear after you install or upgrade to Windows Server 2025 or 2022 because of a change in how the **Configure log access** policy is enforced. In Windows Server 2019 and earlier versions, the **Configure log access** policy wasn't enforced correctly: SQL Server Agent would be able to write to the Application event log even without being granted access through Group Policy. In Windows Server 2022 and later versions, the **Configure log access** policy is enforced correctly: SQL Server Agent can't write to the Application event log unless it's configured correctly in Group Policy.

## Solution

To resolve this error, either disable the **Configure log access** Group Policy policy or update it to grant write access to the account that's used by SQL Server Agent.

1. Locate the **Configure log access** policy settings:

   1. Open the Local Group Policy Editor.

      :::image type="content" source="./media/error-17156-event-log-service/group-policy-editor.png" alt-text="The Local Group Policy Editor window is shown.":::

   1. Select **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Event Log Service** > **Application**.

      :::image type="content" source="./media/error-17156-event-log-service/event-log-service-policies.png" alt-text="The Local Group Policy Editor window showing the Application folder as selected.":::

1. Open the **Configure log access** setting.

   :::image type="content" source="./media/error-17156-event-log-service/configure-log-access-setting.png" alt-text="The Configure log access settings window.":::

1. Update the policy setting using one of these two methods:

   1. To disable the policy, set its value to either **Disabled** or **Not Configured**.

      :::image type="content" source="./media/error-17156-event-log-service/disable-log-access-policy.png" alt-text="The Configure log access settings window shows the Disabled setting as selected.":::

   1. To update the policy, append the following text to the Security Descriptor Definition Language (SDDL) string in the **Options** panel:

      > (A;;0x7;;;\<SQL-Server-Agent-Account-SID\>)

      :::image type="content" source="./media/error-17156-event-log-service/update-log-access-policy.png" alt-text="The Configure log access settings window showing the additional Security Descriptor Definition Language (SDDL) string that's appended in the Options panel":::

## References

- [How to set event log security locally or by using Group Policy](~/windows-server/group-policy/set-event-log-security-locally-or-via-group-policy.md)
- [View the SQL Server error log](/sql/tools/configuration-manager/viewing-the-sql-server-error-log)
