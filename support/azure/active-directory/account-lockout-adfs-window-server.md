---
title: Troubleshoot account lockout in AD FS on Windows Server
description: Fixes the account lockout issue that occurs in Microsoft Active Directory Federation Services (AD FS) on Windows Server.
ms.date: 06/08/2020
ms.reviewer: 
ms.service: active-directory
ms.subservice: authentication
---
# Troubleshoot account lockout in AD FS on Windows Server

This article provides steps to troubleshoot an account lockout issue in Microsoft Active Directory Federation Services (AD FS) on Windows Server.

_Original product version:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012  
_Original KB number:_ &nbsp; 4471013

You may experience an account lockout issue in AD FS on Windows Server. To troubleshoot this issue, check the following points first:

- If you have [Microsoft Entra Connect Health](/azure/active-directory/connect-health/active-directory-aadconnect-health) configured for AD FS servers, go to the [Use Connect Health to generate data for user login activities](#use-connect-health-to-generate-data-for-user-login-activities) section.
- If you don't have [Microsoft Entra Connect Health](/azure/active-directory/connect-health/active-directory-aadconnect-health) configured for AD FS servers, go to the [Collect AD FS event logs from AD FS and Web Application Proxy servers](#collect-ad-fs-event-logs-from-ad-fs-and-web-application-proxy-servers) section.

## Use Connect Health to generate data for user login activities

You can use Connect Health to generate data about user login activity. Connect Health produces reports about the top bad password attempts that are made on the AD FS farm.

Refer to the information in [this article](/azure/active-directory/connect-health/active-directory-aadconnect-health-adfs#reports-for-ad-fs) to analyze the list of user accounts and IPs of the bad password attempt. Then, go to [Analyze the IP and username of the accounts that are affected by bad password attempts](#analyze-the-ip-and-username-of-the-accounts-that-are-affected-by-bad-password-attempts).

## Collect AD FS event logs from AD FS and Web Application Proxy servers  

### Step 1: Collect AD FS event logs from AD FS and Web Application Proxy servers

To collect event logs, you first must configure AD FS servers for auditing. If you have a load balancer for your AD FS farm, you must enable auditing on each AD FS server in the farm. Auditing does not have to be configured on the Web Application Proxy servers.

To configure AD FS servers for auditing, you can use the following method:

- [Manually configure AD FS servers for auditing](https://technet.microsoft.com/library/cc738766%28v=ws.10%29.aspx)

### Step 2: Search the AD FS logs

For Windows Server 2012 R2 or Windows Server 2016 AD FS, search all AD FS Servers' security event logs for "Event ID 411 Source AD FS Auditing" events. Be aware of the following information about "411 events":

- You can download the [ADFS Account Lockout and Bad Cred Search (AD FSBadCredsSearch.ps1)](#adfs-account-lockout-and-bad-cred-search)PowerShell script to search your AD FS servers for "411" events. The script provides a CSV file that contains the UserPrincipalName, IP address of the submitter, and time of all bad credential submissions to your AD FS farm. Open the CSV file in Excel, and quickly filter by user name, IP address, or time.
- These events contain the user principal name (UPN) of the targeted user.
- These events contain a message "token validation failed" message that states whether the event indicates a bad password attempt or an account lockout.
- If the server has "411" events displayed but the IP address field isn't in the event, make sure that you have the latest AD FS hotfix applied to your servers. For more information, see [MS16-020: Security update for Active Directory Federation Services to address denial of service: February 9, 2016](https://support.microsoft.com/help/3134222/ms16-020-security-update-for-active-directory-federation-services-to-a).

For Windows Server 2008 R2 or Windows Server 2012 AD FS, you won't have the necessary Event 411 details. Instead, download and run the following PowerShell script to correlate security events 4625 (bad password attempts) and 501 (AD FS audit details) to find the details about the affected users.

- You can download the [ADFS Security Audit Events Parser (ADFSSecAuditParse.ps1)](#adfs-security-audit-events-parser) PowerShell script to search your AD FS servers for events. The script provides a CSV file that contains the UserPrincipalName, IP address of the submitter, and time of all bad credential submissions to your AD FS farm.
- You can also use this method to investigate which connections are successful for the users in the "411" events. You can search the AD FS "501" events for more details.
- When you run the PowerShell script to search the events, pass the UPN of the user who is identified in the "411" events, or search by account lockout reports.
- The IP address of the malicious submitters is displayed in one of two fields in the "501" events.
- For web-based scenarios and most application authentication scenarios, the malicious IP will be in the **x-ms-client-ip** field.

## Analyze the IP and username of the accounts that are affected by bad password attempts

After you enumerate the IP addresses and user names, identify the IPs that are for unexpected locations of access.

Are the attempts made from external unknown IPs?

- If the attempts are made from external unknown IPs, go to [Update AD FS servers with latest hotfixes](#update-ad-fs-servers-with-latest-hotfixes).
- If the attempts are not made from external unknown IPs, go to [Make sure that credentials are updated in the service or application](#make-sure-that-credentials-are-updated-in-the-service-or-application).

## Update AD FS servers with latest hotfixes

To make sure that AD FS servers have the latest functionality, apply the latest hotfixes for the AD FS and Web Application Proxy servers. Additionally, hotfix [3134222](https://www.microsoft.com/download/details.aspx?id=51059) is required on Windows Server 2012 R2 to log IP addresses in Event 411 that will be used later.

## Check whether the extranet lockout is enabled

Use [Get-ADFSProperties](https://technet.microsoft.com/library/ee892323.aspx) to check whether the extranet lockout is enabled.

- If the extranet lockout is enabled, go to [Check extranet lockout and internal lockout thresholds](#step-1-check-extranet-lockout-and-internal-lockout-thresholds).
- If the extranet lockout isn't enabled, start the steps below for the appropriate version of AD FS.

### Steps to check the lockout status

#### For Windows Server 2012 R2 or newer version

Smart lockout is a new feature that will be available soon in AD FS 2016 and 2012 R2 through an update. This section will be updated with the appropriate steps for enabling smart lockout as soon as the feature is available. Then, go to [Check extranet lockout and internal lockout thresholds](#step-1-check-extranet-lockout-and-internal-lockout-thresholds).

#### For Windows Server 2008 R2 Windows or older version

We recommend that you upgrade the AD FS servers to Windows Server 2012 R2 or Windows Server 2016. For more information, see [Upgrading to AD FS in Windows Server 2016](/windows-server/identity/ad-fs/deployment/upgrading-to-ad-fs-in-windows-server-2016). Then, follow the steps for Windows Server 2012 R2 or newer version.

##### Step 1: Check extranet lockout and internal lockout thresholds

Make sure that extranet lockout and internal lockout thresholds are configured correctly. For more information, see [Recommended security configurations](/windows-server/identity/ad-fs/deployment/best-practices-securing-ad-fs#recommended-security-configurations). Generally, the **ExtranetLockoutThreshold** should be less than the lockout threshold for AD so that user gets locked out for extranet access only without also getting locked out in Active Directory for internal access.

##### Step 2: Enable modern authentication and Certificate-based authentication

We recommend that you enable modern authentication, certificate-based authentication, and the other features that are listed in this step to lower the risk of brute force attacks.

**Deploy modern authentication**

In addition to removing one of the attack vectors that are currently being used through Exchange Online, deploying modern authentication for your Office client applications enables your organization to benefit from multifactor authentication. Modern authentication is supported by all the latest Office applications across the Windows, iOS, and Android platforms.

For more information, see [How to deploy modern authentication for Office 365](https://support.office.com/article/Using-Office-365-modern-authentication-with-Office-clients-776c0036-66fd-41cb-8928-5495c0f9168a#bk_getstarted).

Because user name and password-based access requests will continue to be vulnerable despite our proactive and reactive defenses, organizations should plan to adopt non-password-based access methods as soon as possible.

The following non-password-based authentication types are available for AD FS and the Web Application Proxy.

- Certificate-based authentication

  When certificate-based authentication is used as an alternative to user name and password-based access, user accounts and access are protected in the following manner:

  - Because users do not use their passwords over the Internet, those passwords are less susceptible to disclosure. User name and password endpoints can be blocked completely at the firewall. This removes the attack vector for lockout or brute force attacks.
  - Even if user name and password endpoints are kept available at the firewall, malicious user name and password-based requests that cause a lockout do not affect access requests that use certificates. Therefore, the legitimate user's access is preserved.

    For more information about certificate-based authentication for Microsoft Entra ID and Office 365, see [this Microsoft Entra identity Blog article](https://blogs.technet.microsoft.com/enterprisemobility/2016/12/14/azuread-certificate-based-authentication-is-generally-available/).

- Azure Multi-Factor Authentication (MFA)

    Azure MFA is another non-password-based access method that you can use in the same manner as certificate-based authentication to avoid using password and user-name endpoints completely.

    Azure MFA can be used to protect your accounts in the following scenarios.

    |Scenarios|Advantage|
    |---|---|
    |Using Azure MFA as additional authentication over the extranet|Adding Azure MFA or any additional authentication provider to AD FS and requiring that the additional method be used for extranet requests protects your accounts from access by using a stolen or brute-forced password. This can be done in AD FS 2012 R2 and 2016.|
    |Using Azure MFA as primary authentication|This is a new capability in AD FS 2016 to enable password-free access by using Azure MFA instead of the password. This guards against both password breaches and lockouts.|

    For more information about how to configure Azure MFA by using AD FS, see [Configure AD FS 2016 and Azure MFA](https://technet.microsoft.com/windows-server-docs/identity/ad-fs/operations/configure-ad-fs-2016-and-azure-mfa)

- Windows Hello for Business  

    Windows Hello for Business is available in Windows 10. Windows Hello for Business enables password-free access from the extranet, based on strong cryptographic keys that are tied to both the user and the device.

    Windows Hello for Business is supported by AD FS in Windows Server 2016. See [Authenticating identities without passwords through Windows Hello for Business](/azure/active-directory/active-directory-azureadjoin-passport).  

##### Step 3: Disable legacy authentication and unused endpoints

Disable the legacy endpoints that are used by EAS clients through Exchange Online, such as the following:

`/adfs/services/trust/13/usernamemixed endpoint`

> [!NOTE]
> Doing this might disrupt some functionality. However, it can help reduce the surface vectors that are available for attackers to exploit. Also, we recommend that you disable unused endpoints.

Check whether the issue is resolved.

## Make sure that credentials are updated in the service or application

If the user account is used as a service account, the latest credentials might not be updated for the service or application. In this situation, the service might keep trying to authenticate by using the wrong credentials. This causes a lockout condition.

To resolve this issue, check the service account configuration in the service or application to make sure that the credentials are correct. If not, follow the next step.

## Clear cached credentials in the application

If user credentials are cached in one of the applications, repeated authentication attempts can cause the account to become locked. To resolve this issue, clear the cached credentials in the application. Check whether the issue is resolved.

## ADFS Account Lockout and Bad Cred Search

```
PARAM ($PastDays = 1, $PastHours)
#************************************************
# ADFSBadCredsSearch.ps1
# Version 1.0
# Date: 6-20-2016
# Author: Tim Springston [MSFT]
# Description: This script will parse the ADFS server's (not proxy) security ADFS
#  for events which indicate an incorrectly entered username or password. The script can specify a
#  past period to search the log for and it defaults to the past 24 hours. Results will be placed into a CSV for 
#  review of UPN, IP address of submitter, and timestamp.
#************************************************

cls
if ($PastHours -gt 0)
 {$PastPeriod = (Get-Date).AddHours(-($PastHours))}
 else
  {$PastPeriod = (Get-Date).AddDays(-($PastDays)) }
$Outputfile = $Pwd.path + "\BadCredAttempts.csv"
$CS = get-wmiobject -class win32_computersystem
$Hostname = $CS.Name + '.' + $CS.Domain
$Instances = @{}
$OSVersion = gwmi win32_operatingsystem
[int]$BN = $OSVersion.Buildnumber 
if ($BN -lt 9200){$ADFSLogName = "AD FS 2.0/Admin"}
 else {$ADFSLogName = "AD FS/Admin"}

$Users = @()
$IPAddresses = @()
$Times = @()
$AllInstances = @()
Write-Host "Searching event log for bad credential events..."
if ($BN -ge 9200) {Get-Winevent  -FilterHashTable @{LogName= "Security"; StartTime=$PastPeriod; ID=411} -ErrorAction SilentlyContinue | Where-Object  {$_.Message -match "The user name or password is incorrect"} |  % {
 $Instance = New-Object PSObject
 $UPN = $_.Properties[2].Value
 $UPN = $UPN.Split("-")[0]
 $IPAddress = $_.Properties[4].Value
 $Users += $UPN
 $IPAddresses += $IPAddress
 $Times += $_.TimeCreated
 add-member -inputobject $Instance -membertype noteproperty -name "UserPrincipalName" -value $UPN
 add-member -inputobject $Instance -membertype noteproperty -name "IP Address" -value $IPAddress
 add-member -inputobject $Instance -membertype noteproperty -name "Time" -value ($_.TimeCreated).ToString()
 $AllInstances += $Instance
 $Instance = $null
 }
}


$AllInstances | select * | Export-Csv -Path $Outputfile -append -force -NoTypeInformation 
Write-Host "Data collection finished. The output file can be found at $outputfile`."
$AllInstances = $null


```

## ADFS Security Audit Events Parser

```
PARAM ($SearchCriteria, $PastDays = 1, $PastHours)
#************************************************
# ADFSSecAuditParse.ps1
# Version 1.0
# Date: 2-2-2016
# Author: Tim Springston [MSFT]
# Description: This script will parse an ADFS Security event log file (EVTX)
#  and search for audit events related to a specific user or other criteria.
#  The script will work for the each ADFS login instance for a given criteria during a stated time frame.
#  If you need to locate a second then filter and save the event log to focus in.
# Return an array of initial instance IDs with the criteria, run the search function against each and output
# a unique text file for each.
#************************************************

cls
if ($PastHours -gt 0)
 {
 $PastPeriod = (Get-Date).AddHours(-($PastHours))
 }
 else
  {$PastPeriod = $PastDays}
 
$CS = get-wmiobject -class win32_computersystem
$Hostname = $CS.Name + '.' + $CS.Domain
$Instances = @()
Get-Winevent -ComputerName $Hostname -LogName Security  | Where-Object {(($_.ID -eq 501) `
-and ($_.Properties.Value -contains $SearchCriteria) -and ($_.TimeCreated -gt $PastPeriod))} | % { $Instances += $_.Properties[0].Value}

function FindADFSAuditEvents  { 
 param ($valuetomatch, $counter, $instance, $PastPeriod)
  $Results = $pwd.Path + "\" + $SearchCriteria + "-ADFSSecAudit" + '-' + $Counter + ".txt" 
  $SearchString = $SearchCriteria + " and instance " + $Instance + " in Security event log."
  "Security Audit Events which match $SearchString" | Out-File $Results -Encoding UTF8 
  Get-WinEvent -ComputerName $Hostname -LogName Security  -WarningAction SilentlyContinue | `
  Where-Object -ErrorAction SilentlyContinue {($_.TimeCreated -gt $PastPeriod) -and (($_.Properties -contains $ValueToMatch) -or ($_.Properties[0].Value -match $Instance))}  | % {
  $Event = New-object PSObject
  add-member -inputobject $Event -membertype noteproperty -name "Event ID" -value $_.ID
  add-member -inputobject $Event -membertype noteproperty -name "Provider" -value $_.ProviderName
  add-member -inputobject $Event -membertype noteproperty -name "Machine Name" -value $_.MachineName
  add-member -inputobject $Event -membertype noteproperty -name "User ID" -value $_.UserID
  add-member -inputobject $Event -membertype noteproperty -name "Time Created " -value $_.TimeCreated  
  $Event | FL *
  $Event | Out-File $Results -Encoding UTF8  -Append
  $_.Properties | FL *
  $_.Properties | Out-File $Results -Encoding UTF8  -Append
  $DateTimeExport = $_.TimeCreated
  }
 $DateTime = (($DateTimeExport.ToShortDateString()).Replace('/','-') + '@' + (($DateTimeExport.ToShortTimeString()).Replace(' ','')))
 $DateTime = $DateTime.Replace(':','')
 $Results2 = $pwd.Path + "\" + $SearchCriteria + '-' + $DateTime + "-ADFSSecAudit" + $Counter + ".txt"
 Rename-Item -Path $Results -NewName $Results2
 } 

$Counter = 1
foreach ($instance in $Instances)
 {
 FindADFSAuditEvents -ValueToMatch $SearchCriteria  -Instance $Instance -PastPeriod $PastPeriod -Counter $Counter
 $Counter++
 }

```

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
