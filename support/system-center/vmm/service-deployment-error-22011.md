---
title: Service deployment fails with error 22011
description: System Center 2012 Virtual Machine Manager SP1 isn't able to deploy services from the service templates that are configured to enable Windows Server Roles and Features that require a double reboot.
ms.date: 04/09/2024
ms.reviewer: wenca
---
# System Center 2012 Virtual Machine Manager SP1 service deployment fails with error 22011

This article helps you fix an issue where Virtual Machine Manager can't deploy services from the service templates configured to install Windows Server Roles and Features that require a double reboot.

_Original product version:_ &nbsp; System Center 2012 Virtual Machine Manager Service Pack 1  
_Original KB number:_ &nbsp; 2798401

## Symptoms

System Center 2012 Virtual Machine Manager (VMM) Service Pack 1 (SP1) isn't able to deploy services from the service templates that are configured to install Windows Server Roles and Features that require a double reboot. The VMM job fails with some or all of the following errors:

> Error (22042)  
> The service (\<ServiceName>) was not successfully deployed. Review the event log to determine the cause before you take corrective action.  
> Recommended Action  
> The deployment can be restarted by retrying the job.  

> Error (22011)  
> VMM failed to enable the specified server features (Web-Asp-Net;Web-ISAPI-Ext;PowerShell-ISE;Web-Server;Web-Dir-Browsing;Web-Client-Auth;AS-HTTP-Activation;Web-Filtering;Web-Dyn-Compression;Web-WebServer;Web-Request-Monitor;WAS-Process-Model;Web-Url-Auth;Backup-Tools;Web-IP-Security;AS-TCP-Activation;Web-Performance;Web-App-Dev;Web-Http-Errors;Web-Mgmt-Tools;NET-Framework-Core;NET-HTTP-Activation;Web-ISAPI-Filter;AS-Named-Pipes;AS-Web-Support;Web-WMI;Web-Mgmt-Compat;Web-Lgcy-Mgmt-Console;File-Services;Web-Metabase;AS-Dist-Transaction;AS-Ent-Services;Web-Cert-Auth;Web-Security;Web-Common-Http;Web-Mgmt-Service;WAS-Config-APIs;SNMP-Services;FS-FileServer;Ink-Handwriting;MSMQ-Server;Web-CGI;NET-Non-HTTP-Activ;AS-TCP-Port-Sharing;MSMQ-Services;WAS;Backup;MSMQ-DCOM;AS-Outgoing-Trans;Web-Http-Tracing;Web-Mgmt-Console;Web-Log-Libraries;Web-Windows-Auth;Web-Basic-Auth;WinRM-IIS-Ext;Web-ODBC-Logging;IH-Ink-Support;Web-Http-Redirect;Web-Health;AS-NET-Framework;Backup-Features;AS-MSMQ-Activation;WAS-NET-Environment;MSMQ-HTTP-Support;Web-Static-Cont) on the guest virtual machine (\<VMNAME>). For more information, log on to the virtual machine and look in the event logs ().  
>
> Recommended Action  
> Log on to the virtual machine and look in the event logs.  

> Error (20400)  
> 1 parallel subtasks failed during execution.  

> Error (21952)  
> Application deployment failed for one or more tiers or application hosts in the service (\<ServiceName>). Check job logs to get more information on the failed operation.  
> Recommended Action  
> Check error messages and retry the operation if needed.  

> [!NOTE]
> Some Windows Server Roles and Features that require a double reboot include, but are not limited to, the following:
>
> - Desktop Experience
> - Ink and Handwriting Services
> - Media Foundation.

## Cause

When the service is deployed, the Windows Server Roles and Features are installed in bulk. If there is a Role or a Feature that requires a double reboot, Virtual Machine Manager doesn't have the ability to parse the results of the Roles and Features installation to know which ones require another reboot.

## Resolution

VMM cannot be used to deploy services that are configured to install Windows Server Roles or Features that require a double reboot, although there are other options available that can be used after the VMM service is successfully deployed.

1. System Center 2012 Orchestrator or System Center 2012 Orchestrator SP1: Orchestrator Runbooks can be used to install the Windows Server Roles and Features using the PowerShell cmdlets for Windows Server 2012.

    - [Using Runbooks in System Center 2012 - Orchestrator](/previous-versions/system-center/system-center-2012-R2/hh403791(v=sc.12)?redirectedfrom=MSDN)

    - [Adding Server Roles and Features](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc732263(v=ws.11)?redirectedfrom=MSDN)

    - [Install or Uninstall Roles, Role Services, or Features](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831809(v=ws.11)?redirectedfrom=MSDN)

2. The required Windows Server Roles and Features can be installed via Group Policy using a startup script. For more information, see [Assign Computer Startup Scripts](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754995(v=ws.11)?redirectedfrom=MSDN).

3. You can also create a custom script to install Windows Server Roles and Features after the VMM service is successfully deployed.
