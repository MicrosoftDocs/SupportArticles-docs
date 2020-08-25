---
title: Error 80040217 when ConfigMgr clients load policies
description: Fixes an issue where System Center Configuration Manager 2007 clients fail to load policies if the site has no network access account defined.
ms.date: 08/20/2020
ms.prod-support-area-path:
---
# Configuration Manager 2007 client may fail to load policies with error 80040217 in PolicyEvaluator.log

This article helps you fix an issue where System Center Configuration Manager 2007 clients fail to load policies if the site has no network access account defined.

_Original product version:_ &nbsp; System Center Configuration Manager 2007  
_Original KB number:_ &nbsp; 2217190

## Symptoms

System Center Configuration Manager 2007 clients may fail to load policies with error 80040217 in **PolicyEvaluator.log**:  

> Failed to load policies from XML. Unknown error (Error: 80040217; Source: Unknown)  
> Bad policy dumped to C:\Windows\SysWOW64\CCM\Temp\badpolicy-SMS_P01-{2f76229b-385a-43f3-b281-d295098693ed}-2.00-{913d3bcd-af48-4180-8715-31a2508e4608}.txt  
> Already sent a policy rule application failure status message within the last 6 hours, not sending.  
> Failed to apply policy rule {913d3bcd-af48-4180-8715-31a2508e4608}.  
> The policy CCM_Policy_Policy4.PolicyID="{2f76229b-385a-43f3-b281-d295098693ed}",PolicySource="SMS:P01",PolicyVersion="2.00" failed to compile. State has been set to 'Inactive' and policy will be rolled back.  
> Failed to update policy CCM_Policy_Policy4.PolicyID="{2f76229b-385a-43f3-b281-d295098693ed}",PolicySource="SMS:P01",PolicyVersion="2.00"  

You may also find the following in **PolicyAgent.log**:

> Raising event:
>
> instance of CCM_CcmHttp_Status  
> {  
> ClientID = "GUID:5396B6AF-3376-445F-AEA6-A2A84912AC09";  
> DateTime = "20100505185728.297000+000";  
> HostName = "";  
> HRESULT = "0x00000000";  
> ProcessID = 1804;  
> StatusCode = 0;  
> ThreadID = 4876;  
> };
>
> Raising event:
>
> instance of CCM_PolicyAgent_PolicyDownloadSucceeded  
> {  
> ClientID = "GUID:5396B6AF-3376-445F-AEA6-A2A84912AC09";  
> DateTime = "20100505185728.303000+000";  
> DownloadMethod = "HTTP";  
> DownloadSource = "http:///SMS_MP/.sms_pol?{2f76229b-385a-43f3-b281-d295098693ed}.2_00";  
> PolicyNamespace = "\\\\\\\\\\\ROOT\\\\ccm\\\\Policy\\\\Machine\\\\RequestedConfig";  
> PolicyPath = "CCM_Policy_Policy4.PolicyID=\\"{2f76229b-385a-43f3-b281-d295098693ed}\\", PolicySource=\\"SMS:P01\\",PolicyVersion=\\"2.00\\"";  
> ProcessID = 1804;  
> ThreadID = 4876;  
> };  
> )  
> Failed to trigger policy evaluation for CCM_Policy_Policy4.PolicyID="{2f76229b-385a-43f3-b281-d295098693ed}",PolicySource="SMS:P01",PolicyVersion="2.00"
Policy state for CCM_Policy_Policy4.PolicyID="{2f76229b-385a-43f3-b281-d295098693ed}",PolicySource="SMS:P01",PolicyVersion="2.00" was successfully reset.  
> Policy download will be retried at next evaluation cycle.
>
> Raising event:
>
> instance of CCM_CcmHttp_Status  
> {  
> ClientID = "GUID:5396B6AF-3376-445F-AEA6-A2A84912AC09";  
> DateTime = "20100505191228.383000+000";  
> HostName = "";  
> HRESULT = "0x00000000";  
> ProcessID = 1804;  
> StatusCode = 0;  
> ThreadID = 5016;  
> };
>
> Raising event:
>
> instance of CCM_PolicyAgent_PolicyDownloadSucceeded  
> {  
> ClientID = "GUID:5396B6AF-3376-445F-AEA6-A2A84912AC09";  
> DateTime = "20100505191228.388000+000";  
> DownloadMethod = "HTTP";  
> DownloadSource = "http:///SMS_MP/.sms_pol?{2f76229b-385a-43f3-b281-d295098693ed}.2_00";  
> PolicyNamespace = "\\\\\\\\\\\ROOT\\ccm\\\\Policy\\\\Machine\\\\RequestedConfig";  
> PolicyPath = "CCM_Policy_Policy4.PolicyID=\\"{2f76229b-385a-43f3-b281-d295098693ed}\\",  PolicySource=\\"SMS:P01\\",PolicyVersion=\\"2.00\\"";  
> ProcessID = 1804;  
> ThreadID = 5016;  
> };
>
> Failed to trigger policy evaluation for CCM_Policy_Policy4.PolicyID="{2f76229b-385a-43f3-b281-d295098693ed}",PolicySource="SMS:P01",PolicyVersion="2.00"
Policy state for CCM_Policy_Policy4.PolicyID="{2f76229b-385a-43f3-b281-d295098693ed}",PolicySource="SMS:P01",PolicyVersion="2.00" was successfully reset. Policy download will be retried at next evaluation cycle.

## Cause

This can occur if the site has no network access account defined.

## Resolution

Using WBEMTEST, connect to the client's `root\ccm\policy\machine\actualconfig` namespace and reviewed the `CCM_NetworkAccessAccount` class (`root\ccm\policy\machine\actualconfig\CCM_NetworkAccessAccount`). If no instance is found here, it can confirm bad or missing network access account data.

To resolve the issue, add a new network access account in the Admin console using steps below. Once clients received the change, they should process policy as expected.

1. In the Configuration Manager console, navigate to **System Center Configuration Manager** > **Site Database** > **Site Management** > \<*site code*> - \<*site name*> > **Site Settings** > **Client Agents**.

2. In the results pane, double-click Computer Client Agent.
3. In the Computer Client Agent Properties dialog box, on the **General** tab, for the network access account, click **Set**.
4. In the Windows User Account dialog box, specify an existing Windows domain user account and password, and then click **OK**.
5. Click **OK**.

## More information

- [Client Custom Error Codes](/previous-versions/system-center/configuration-manager-2007/bb632794(v=technet.10)#client-custom-error-codes)
- [About the Network Access Account](/previous-versions/system-center/configuration-manager-2007/bb680398(v=technet.10))
