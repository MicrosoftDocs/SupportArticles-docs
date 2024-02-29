---
title: Management points fail with HTTP 500 errors
description: Describes an issue in which management points associated with System Center 2012 Configuration Manager return HTTP 500 errors to calling clients. This issue occurs after the Client Health Evaluation task runs and triggers a reinstall of the client.
ms.date: 12/05/2023
ms.reviewer: kaushika, keiththo, erinwi
---
# Configuration Manager management points fail after the Client Health Evaluation task runs

This article describes an issue in which Configuration Manager management points fail and return **HTTP 500** errors.

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager  
_Original KB number:_ &nbsp; 2796086

## Symptoms

Microsoft System Center 2012 Configuration Manager management points that are collocated with the client fail daily by returning **HTTP 500** errors to calling clients. This problem occurs after the **Client Health Evaluation** task runs and reinstalls the client. In this situation, the CCMEval.log file contains entries that resemble the following:

> Loading manifest file: C:\Program Files\SMS_CCM\CcmEval.xml  
> Successfully loaded ccmeval manifest file.  
> Begin evaluating client health rules.  
> Successfully retrieved all client health checks.  
> Evaluating health check rule {4AB7D77D-3BB0-4EAB-BEFD-7C0F7DA10296} : Verify WMI service exists.  
> Evaluating health check rule {518C0699-03F8-4F38-85C4-4D319EAEFC05} : Verify/Remediate WMI service startup type.  
> Evaluating health check rule {7F4B6E15-2221-455B-9615-93C379E470D5} : Verify/Remediate WMI service status.  
> Evaluating health check rule {A81778B5-9A1E-4A52-9C6E-6939CEFAA118} : WMI Repository Integrity Test.  
> Windows has an improper shutdown before the latest start up at 20121218093732.000000-000  
> Evaluating health check rule {14E6774A-1795-4E09-B17D-B6F36A124205} : WMI Repository Read/Write Test.  
> Failed to delete class 'CIM_ClassDeletion' (80041002)  
> Failed to delete class 'CIM_ClassCreation' (80041002)  
> Failed to delete class 'CIM_ClassModification' (80041002)  
> Failed to delete class 'CIM_ClassIndication' (80041002)  
> Failed to delete class 'CIM_InstCreation' (80041002)  
> Failed to delete class 'CIM_InstModification' (80041002)  
> Failed to delete class 'CIM_InstDeletion' (80041002)  
> Failed to delete class 'CIM_InstIndication' (80041002)  
> Failed to delete class 'CIM_Indication' (80041002)  
> Failed to delete class 'MSFT_ExtendedStatus' (80041002)  
> Failed to delete class 'MSFT_WmiError' (80041002)  
> Failed to delete class 'CIM_Error' (80041002)  
> Fail to delete namespace (root\cimv2\ccm2) (0x80041002)  
> Checking WMI repository for feature General failed  
> WMI check failed  
> Windows has an improper shutdown before the latest start up at 20121218093732.000000-000  
> Stopped the service 'ccmexec' successfully  
> Stopped dependent services for service 'winmgmt' successfully  
> Stopped the service 'winmgmt' successfully  
> Attempting to launch repository repair.  
> Attempting to remediate client or client prerequisite installation.  
> Client or client prerequisite installation remediation succeeded.  
> Failed to delete class 'CIM_ClassDeletion' (80041002)  
> Failed to delete class 'CIM_ClassCreation' (80041002)  
> Failed to delete class 'CIM_ClassModification' (80041002)  
> Failed to delete class 'CIM_ClassIndication' (80041002)  
> Failed to delete class 'CIM_InstCreation' (80041002)  
> Failed to delete class 'CIM_InstModification' (80041002)  
> Failed to delete class 'CIM_InstDeletion' (80041002)  
> Failed to delete class 'CIM_InstIndication' (80041002)  
> Failed to delete class 'CIM_Indication' (80041002)  
> Failed to delete class 'MSFT_ExtendedStatus' (80041002)  
> Failed to delete class 'MSFT_WmiError' (80041002)  
> Failed to delete class 'CIM_Error' (80041002)  
> Fail to delete namespace (root\cimv2\ccm2) (0x80041002)  
> Checking WMI repository for feature General failed  
> WMI check failed  
> Result: Remediation Failed, ResultCode: 304, ResultType: 202, ResultDetail: root\cimv2\ccm2#CCMEVALPARAMSEP#20121218093732.000000-000*  

## Cause

This issue may occur if Windows Management Framework 3.0 (described in [KB 2506143](https://support.microsoft.com/help/2506143)) has been installed in your System Center 2012 Configuration Manager RTM environment. The System Center 2012 Configuration Manager RTM client is incompatible with Windows Management Framework 3.0. During the daily **Client Health Evaluation**, CCMEval.exe mistakenly finds the WMI repository to be corrupted. Therefore, CCMEval.exe requests a rebuild and then reinstalls the client. The rebuild of the repository by CCMEval causes loss of management point-specific information, methods, and more from WMI. This causes the management point to fail.

System Center 2012 Configuration Manager Service Pack 1 (SP1) provides official support for Windows Management Framework 3.0. Therefore, System Center 2012 Configuration Manager SP1 is not affected by this issue.

## Resolution

To resolve this issue, apply System Center 2012 Configuration Manager SP1 to your environment. For System Center 2012 Configuration Manager RTM environments, you can work around the issue by setting the following registry value to **True** on the affected clients:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CCM\CcmEval\NotifyOnly`

When this registry value is set to **True**, the client still runs the evaluation task daily and then incorrectly reports that the WMI repository is corrupted. However, it does not request the repository rebuild or the daily client reinstallation.

If the management point is already failing because of the evaluation that is being run, you must uninstall and then reinstall the management point to make sure that it is back online. To do this, follow these steps:

1. Under **Servers and Site System Roles**, select the server that is hosting the failing management point.
2. Right-click the management point role, and then select **Remove Role**.
3. Monitor the MPSetup.log on the management point server to make sure that the removal is complete.
4. Right-click the same server, and then select **Add Site System Roles**.
5. In the wizard, select the management point role, and then monitor the MPSetup.log on the management point server to make sure that the reinstallation is complete.
