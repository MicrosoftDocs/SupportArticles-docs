---
title: Agents can't find the primary management server
description: Fixes an issue in which Operations Manager agents can't find the primary management server, and events 20012 and 2000 are logged.
ms.date: 04/15/2024
ms.custom: sap:System Center Operations Manager
ms.reviewer: 
---
# Events 20012 and 2000 when you use Active Directory integration for agent assignment in Operations Manager

This article helps you fix an issue where Operations Manager agents can't find the primary management server, and events 20012 and 2000 are logged.

_Original product version:_ &nbsp; System Center Operations Manager, version 1807, System Center Operations Manager, version 1801, System Center 2016 Operations Manager, System Center 2012 R2 Operations Manager, Microsoft System Center 2012 Operations Manager  
_Original KB number:_ &nbsp; 4503903

## Symptoms

You use Active Directory integration to make agent assignments in Microsoft System Center Operations Manager. However, Operations Manager agents can't find the primary management server through the Active Directory policy.

When this issue occurs, the following events are logged in the Operations Manager event log:

> Log Name:      Operations Manager  
> Source:        OpsMgr Connector  
> Date:          \<Date> \<Time>  
> Event ID:      20012  
> Task Category: None  
> Level:         Information  
> Keywords:      Classic  
> User:          N/A  
> Computer:      scomagent.contoso.com  
> Description:  
> The OpsMgr Connector did not find any connection policy in Active Directory for management group \<Management_Group>

> Log Name:      Operations Manager  
> Source:        HealthService  
> Date:          \<Date> \<Time>  
> Event ID:      2000  
> Task Category: Health Service  
> Level:         Error  
> Keywords:      Classic  
> User:          N/A  
> Computer:      scomagent.contoso.com  
> Description:  
> The Management Group \<Management_Group> failed to start. **The error message is the environment is incorrect.(0x8007000A).**  A previous message with more detail may have been logged.

When [diagnostic tracing](https://support.microsoft.com/help/942864/) is enabled, the following error messages are logged in the TracingGuidsNative.log file:

> 948 [3]6532.7764::03/27/2019-15:36:12.285 [Common] [] [Information] :Common::ADGetSCPInfo{scputil_cpp633} **SCP Not found for primary ManagementServer**  
> 949 [3]6532.7764::03/27/2019-15:36:12.285 [Common] [] [Verbose] :Common::EventLogUtil::LogEvent{eventlogutil_cpp388}Logging informational event 20012 with args "\<Management_Group>", "NULL","NULL", "NULL", "NULL", "NULL", "NULL", "NULL", "NULL"  
> 950 [3]6532.7764::03/27/2019-15:36:12.285 [Common] [] [Information] :Common::EventLogUtil::GetEventCommonFuncAddresses{eventlogutil_cpp164}LoadLibrary("EventCommon.dll") module not found, will continue.  
> 951 [3]6532.7764::03/27/2019-15:36:12.285 [Common] [] [Information] :Common::EventLogUtil::LogEvent{eventlogutil_cpp468}At least one of GetFormattedMessage and FreeMOMMessage function pointers is NULL.  
> 952 [3]6532.7764::03/27/2019-15:36:12.285 [Common] [] [Information] :Common::EventLogUtil::LogEvent{eventlogutil_cpp475}Logging event 20012 from source "OpsMgr Connector" with severity 0x4 and description "NULL".  
> 953 [3]6532.7764::03/27/2019-15:36:12.285 [MOMConnector] [] [Information] :getADManagementGroupsFromEnvironment{momconnectormg_cpp3942} **No SCP was found**  
> 954 [3]6532.7764::03/27/2019-15:36:12.285 [MOMConnector] [] [Error] :CConnectorManagementGroup::UpdateConfigurationFromEnvironment{momconnectormg_cpp4171}AD integration is enabled but primary info was not located. Ignore this MG  
> 955 [3]6532.7764::03/27/2019-15:36:12.285 [MOMConnector] [] [Error] :CConnectorManagementGroup::LoadConfiguration{momconnectormg_cpp1548}To update configuration from environment failed with code 10(**ERROR_BAD_ENVIRONMENT**)

## Cause

Operations Manager agents cannot parse more than 10 service connection points (SCPs). This issue occurs if your management group has more than 10 management servers and the **Automatically manage failover** option is selected in the agent assignment rule.

## Resolution

To fix the issue, follow these steps to limit the number of SCPs:

1. Log on to the computer by using an account that's a member of the Operations Manager Administrators role.
2. In the **Operations** console, select **Administration**.
3. In the **Administration** workspace, select **Management Servers**.
4. Right-click the primary management server, and then select **Properties**.
5. In the **Management Server Properties** dialog box, select the **Auto Agent Assignment** tab, select the existing agent assignment setting, and then select **Edit** to open the Agent Assignment and Failover Wizard.
6. On the **Inclusion Criteria** page, copy the LDAP query, and paste it to a Notepad file.
7. Select **Cancel** to close the Agent Assignment and Failover Wizard.
8. Select **Delete** to delete the agent assignment setting.
9. Select **Add** to open the Agent Assignment and Failover Wizard.
10. On the **Domain** page, select the domain of the computers, and then select **Next**.
11. On the **Inclusion Criteria** page, enter the LDAP query that you copied in step 6, and then select **Next**.
12. On the **Exclusion Criteria** page, type the FQDN of computers that you explicitly want to prevent from being managed by this management server, and then select **Next**.
13. On the **Agent Failover** page, select **Manually configure failover**, select no more than nine (9) management servers, and then select **Create**.
14. In the **Management Server Properties** dialog box, click **OK**.
15. Wait for one hour for the agent assignment setting to propagate in AD DS, and then check whether the issue is fixed.
