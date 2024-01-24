---
title: Access is denied error occurs with DCPROMO
description: Provides a solution to an Access is denied error that occurs with DCPROMO.
ms.date: 03/24/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, Arrenc
ms.custom: sap:dcpromo-and-the-installation-of-domain-controllers, csstroubleshoot
ms.subservice: active-directory
---
# DCPROMO fails with error "Access is denied" if the user does the promotion isn't granted the "trusted for delegation" user right

This article provides a solution to an Access is denied error that occurs with DCPROMO (Domain Controller Promoter).

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows Server 2016, Windows Server 2019  
_Original KB number:_ &nbsp; 2002413

## Symptoms

DCPROMO promotion of a Windows Server 2008 or later version member computer to a replica domain controller (DC) fails with the following error:

> Title: Windows Security  
> Message Text: Network Credentials  
> The operation failed because: The Active Directory Domain Services Installation Wizard was unable to convert the computer account \<hostname\>$ to an Active Directory Domain Controller account. "Access is denied"

DCPROMO Demotion can fail with the same error:

> Title: Windows Security  
> Message Text: Network Credentials  
> The operation failed because: Active Directory Domain Services could not configure the computer account \<hostname\>$ to the remote Active Directory Domain Controller account \<fully qualified name of helper DC\>. "Access is denied"

## Cause

The user account used to execute DCPROMO hasn't been granted the "Enable computer and user accounts to be trusted for delegation" user right.

## Resolution

1. Verify that the default domain controllers policy exists in Active Directory.

   If the domain controller policy doesn't exist, evaluate whether that condition is because of simple replication latency, an Active Directory replication failure or whether the policy has been deleted from Active Directory. If the policy has been deleted, contact Microsoft Support to recreate the missing policy with the default policy GUID (Globally Unique Identifier). Don't manually recreate the policy with the same name and settings as the default.

   If the default domain controllers policy exists in Active Directory on some domain controllers but not others, evaluate whether that inconsistency is due simple replication latency or a replication failure. Resolve as required.

2. Verify that the server account is not protected from accidental deletion.

   To do this, go to the **Active Directory Administrative Center**, find your server under the **Computers** listing within your domain, open the properties. In the first section, right under the operating system information, make sure the **Protect from accidental deletion** checkbox is unchecked.

   In the process of elevation to Domain Controller, the computer account for the server is deleted, and re-added as a Domain Controller. If this checkbox is clicked, this can't happen.

3. Verify that the user account does the DCPROMO operation has been granted the "Enable computer and user accounts to be trusted for delegation" user right in the default domain controllers policy.

   Run `whoami /all` to verify that the "Enable computer and user accounts to be trusted for delegation" user right exists in the users security token.

   > [!NOTE]
   > By default, this right is granted to members of the Administrators security group in the target domain. The built-in Administrator account is a member of this security group but may have been removed.

   - If a user other than the built-in administrators group is doing DCPROMO promotions, either add that user account to the Administrators security group OR add the user account the "Enable computer and user accounts to be trusted for delegation" user right in the default domain controllers policy.
   - "Enable computer and user accounts to be trusted for delegation" was recently modified, or the policy granting the DCPROMO user account exists on some domain controllers in the domain but not others, check for simple replication latency or a replication failure in both Active Directory and File System Replication (FSR) / Distributed File System Replication (DFSR).
   - If the policy was recently modified, have the DCPROMO user account sign out and sign in.

4. Verify that the default domain controllers policy is linked to the domain controllers OU and that all DC machine accounts stay in that OU.

   If DC machine accounts stay in an alternate OU container, either move all DC machine accounts to the domain controllers OU or link the default domain controllers policy to the alternate OU container.
5. Verify that the file system portion of default domain controllers policy exists in the SYSVOL share of the DC being used to apply policy on the computer being promoted or demoted.

   If not present, it can be because of one or more of the following reasons:
   - Replication latency in FRS / DFSR
   - A replication failure in FRS / DFSR
   - The policy has been deleted from the SYSVOL. If the policy has been deleted, contact Microsoft Support to recreate the missing policy with the default policy GUID. Don't manually recreate the policy with the same name and settings as the default.

6. The default domain policy or policy in general isn't applying to the logged on user

   To check for policy inheritance, Windows Management Instrumentation (WMI) filtering or security descriptor problem that may be preventing policy from applying, run the following command:

   ```console
   gpresult /h result.html
   ```

## More information

- Table1. Logs from Promotion (example)

  |**DCPROMO.LOG**|**DCPROMOUI.LOG**|
  |---|---|
  |\[INFO\] Creating the NTDS Settings object for this Active Directory Domain Controller on the remote AD DC \<helperDC>.contoso.com...<br/>\[INFO\] Replicating the schema directory partition<br/>...<br/>\[INFO\] Replicated the schema container.<br/>\[INFO\] Active Directory Domain Services updated the schema cache.<br/>\[INFO\] Replicating the configuration directory partition<br/>...<br/>\[INFO\] Replicated the configuration container.<br/>\[INFO\] Error - The Active Directory Domain Services Installation Wizard was unable to convert the computer account \<DC being promoted>$ to an Active Directory Domain Controller account. (5)<br/>\[INFO\] EVENTLOG (Error): NTDS General / Internal Processing: 1168<br/>Internal error: An Active Directory Domain Services error has occurred.<br/><br/>Additional Data<br/><br/>Error value (decimal):<br/>-1073741823<br/><br/>Error value (hex):<br/>c0000001<br/><br/>Internal ID:<br/>300162a<br/><br/>\[INFO\] EVENTLOG (Informational): NTDS General / Service Control: 1004<br/>Active Directory Domain Services was shut down successfully.<br/><br/>\[INFO\] NtdsInstall for a.com returned 5<br/>\[INFO\] DsRolepInstallDs returned 5<br/>\[ERROR\] Failed to install to Directory Service (5)<br/>\[INFO\] Starting service NETLOGON<br/>\[INFO\] Configuring service NETLOGON to 2 returned 0<br/>\[INFO\] The attempted domain controller operation has completed<br/>\[INFO\] DsRolepSetOperationDone returned 0| Calling DsRoleGetDcOperationResults<br/>Error 0x0 (!0 => error)<br/>Operation results:<br/>OperationStatus: 0x5 !0 => error<br/>DisplayString: The Active Directory Domain Services Installation Wizard was unable to convert the computer account \<DC being promoted>$ to an Active Directory Domain Controller account.<br/>ServerInstalledSite: (null)<br/>OperationResultsFlags: 0x0<br/>Enter ProgressDialog::UpdateText The Active Directory Domain Services Installation Wizard was unable to convert the computer account \<dc being promoted>$ to an Active Directory Domain Controller account.<br/>Enter State::SetOperationResultsMessage The Active Directory Domain Services Installation Wizard was unable to convert the computer account \<dc being promoted>$ to an Active Directory Domain Controller account.<br/>Enter State::SetOperationResultsFlags 0x0<br/>Exception caught<br/>catch completed<br/>handling exception<br/>Enter State::ClearHiddenWhileUnattended<br/>Enter EnableConsoleLocking<br/>Enter RegistryKey::Create SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon<br/>Enter RegistryKey::SetValue-DWORD DisableLockWorkstation<br/>Enter State::SetOperationResults result FAILURE<br/>Enter ProgressDialog::UpdateText<br/>Enter State::IsOperationRetryAllowed<br/>true<br/>credentials were invalid, hr=0x80070005<br/>Enter GetErrorMessage 80070005<br/>Enter State::GetOperationResultsMessage The Active Directory Domain Services Installation Wizard was unable to convert the computer account \<dc being promoted>$ to an Active Directory Domain Controller account.<br/>Enter State::GetOperation REPLICA<br/>Enter State::GetReplicaDomainDNSName \<target dns domain name> |

- Table 2. Logs from Demotion (example)

  | **DCPROMO.LOG**| **DCPROMOUI.LOG** |
  |---|---|
  |\[INFO\] Uninstalling the Directory Service<br/>\[INFO\] Invoking NtdsDemote<br/>...<br/>\[INFO\] Removing Active Directory Domain Services objects that refer to the local Active Directory Domain Controller from the remote Active Directory Domain Controller \<DNS domain\>...<br/>\[INFO\] Error - Active Directory Domain Services couldn't configure the computer account \<dc being demoted\>$ on the remote Active Directory Domain Controller \<helper DC\>.\<DNS domain\>. (5)<br/>\[INFO\] NtdsDemote returned 5<br/>\[INFO\] DsRolepDemoteDs returned 5<br/>\[ERROR\] Failed to demote the directory service (5)<br/>....| ....<br/>OperationStatus: 0x5 !0 => error<br/>DisplayString: Active Directory Domain Services couldn't configure the computer account \<dc name>$ on the remote Active Directory Domain Controller \<helper DC\>.\<dns domain\>.<br/>ServerInstalledSite: (null)<br/>OperationResultsFlags: 0x0<br/>Enter ProgressDialog::UpdateText Active Directory Domain Services couldn't configure the computer account \<dc name\>$ on the remote Active Directory Domain Controller VM1-W7.a.com.<br/>Enter State::SetOperationResultsMessage Active Directory Domain Services couldn't configure the computer account \<dc name\>$ on the remote Active Directory Domain Controller \<helper DC\>.\<DNS domain\>.<br/>Enter State::SetOperationResultsFlags 0x0<br/>...<br/>credentials were invalid, hr=0x80070005<br/>Enter GetErrorMessage 80070005<br/>Enter State::GetOperationResultsMessage Active Directory Domain Services couldn't configure the computer account \<dc name\>$ on the remote Active Directory Domain Controller \<helper DC\>.\<DNS domain\>.<br/>Enter State::GetOperation DEMOTE<br/>Enter State::GetParentDomainDnsName|
