---
title: OSD and task sequences fail after a restoration
description: Provides a solution to an issue in which OSD and task sequences no longer function after restoring System Center Configuration Manager 2007 from a backup.
ms.date: 08/18/2020
ms.prod: configuration-manager
ms.prod-support-area-path: 
ms.reviewer: frankroj, timhe
---
# OSD and task sequences fail after restoring a Configuration Manager 2007 central site from a backup

This article provides a solution to an issue in which operating system deployment (OSD) and task sequences no longer function after restoring System Center Configuration Manager 2007 from a backup.

_Original product version:_ &nbsp; System Center Configuration Manager 2007  
_Original KB number:_ &nbsp; 2509330

## Symptoms

When using System Center Configuration Manager 2007 and restoring from a backup created via the **Backup ConfigMgr Site Server** maintenance task, OSD and task sequences no longer function if the restore was performed after a Windows OS reinstall on the server or a restoration to new server hardware. Obtaining SMSTS.log from a failing client computer reveals the following errors:

> Parsing Policy Body. TSMBootstrap  
> (!sNetworkAccessAccount.empty()) && (!sNetworkAccessPassword.empty()), HRESULT=80040101 (e:\nts_sms_fre\sms\framework\tscore\tspolicy.cpp,1518) TSMBootstrap  
> Found empty NetworkAccessUsername/NetworkAccessPassword from NAAConfig CCM_NetworkAccessAccount TSMBootstrap  
> GetEncodedNetworkAccessAccount (sEncodedAccount, sEncodedPassword), HRESULT=80040101 (e:\nts_sms_fre\sms\framework\tscore\tspolicy.cpp,1544)  TSMBootstrap  
> Network Access Account is not set TSMBootstrap  
> GetNetworkAccessAccount( sNetworkAccessAccount, sNetworkAccessPassword ), HRESULT=80040101 (e:\nts_sms_fre\sms\framework\tscore\tspolicy.cpp,1597) TSMBootstrap  
> pTSPolicyManager->GetContentLocations( m_sPackageID, m_lSourceVersion, m_dwContentSourceFlags, slistContentLocations, slistHttpContentLocations, slistMulticastContentLocations, m_dwContentPackageFlags ), HRESULT=80040101 (e:\nts_sms_fre\sms\framework\tscore\tspolicy.cpp,2330) TSMBootstrap  
> (*iTSReference)->Resolve( pTSPolicyManager, dwResolveFlags ), HRESULT=80040101 (e:\nts_sms_fre\sms\framework\tscore\tspolicy.cpp,2862) TSMBootstrap  
> m_pSelectedTaskSequence->Resolve( m_pPolicyManager, TS::Policy::TaskSequence::ResolvePolicy | TS::Policy::TaskSequence::ResolveSource, fpCallbackProc, pv, hCancelEvent), HRESULT=80040101 (e:\nts_sms_fre\sms\client\tasksequence\tsmbootstrap\tsmediawizardcontrol.cpp,1208) TSMBootstrap  
> Failed to resolve selected task sequence dependencies. Code(0x80040101) TSMBootstrap
hrReturn, HRESULT=80040101 (e:\nts_sms_fre\sms\client\tasksequence\tsmbootstrap\tsmediaresolveprogresspage.cpp,408) TSMBootstrap  
> ThreadToResolveAndExecuteTaskSequence failed. Code(0x80040101) TSMBootstrap  
> ThreadToResolveAndExecuteTaskSequence returned code 0x80040101 TSMBootstrap  
> Setting wizard error: Failed to read network access account from machine policy. For more information, please contact your system administrator or helpdesk operator. TSMBootstrap

Reviewing the above SMSTS.log file seems to reveal that the network access account isn't set. The network access account is needed by the task sequence to access network resources since the client computer while in Windows Preinstallation Environment (WinPE) is the equivalent of a non-domain joined workgroup computer.

Reviewing the **Properties** of the **Computer Client Agent** in the ConfigMgr 2007 admin console under **Site Settings** > **Client Agents** reveals that the network access account is set. Resetting the network access account in the **Properties** of the **Computer Client Agent** by reentering the network access account's username and password seems to resolve the error, but then causes a new error in SMSTS.log. Reviewing SMSTS.log on the failed client computer reveals the following error:

> Decompressing reply body. TSMBootstrap  
> ::DecompressBuffer(65536) TSMBootstrap  
> Decompression (zlib) succeeded: original size 476, uncompressed size 2568. TSMBootstrap  
> CryptMsgControl (hMsg, 0, CMSG_CTRL_VERIFY_SIGNATURE, pCert->pCertInfo), HRESULT=8009100e (e:\nts_sms_fre\sms\framework\osdmessaging\libcrypt.cpp,351) TSMBootstrap  
> signature varification failed TSMBootstrap  
> ipCertContext != listpServerCertContext.end(), HRESULT=80004005 (e:\nts_sms_fre\sms\framework\osdmessaging\libsmsmessaging.cpp,2476) TSMBootstrap  
> signature check failed: \<signature> TSMBootstrap  
> DoRequest (sReply, true), HRESULT=80004005 (e:\nts_sms_fre\sms\framework\osdmessaging\libsmsmessaging.cpp,5010) TSMBootstrap  
> Failed to get client identity (80004005) TSMBootstrap  
> ClientIdentity.RequestClientIdentity (), HRESULT=80004005 (e:\nts_sms_fre\sms\client\tasksequence\tsmbootstrap\tsmediawizardcontrol.cpp,815) TSMBootstrap  
> failed to request for Exiting TSMediaWizardControl::GetPolicy. TSMBootstrap  
> failed to request for pWelcomePage->m_pTSMediaWizardControl->GetPolicy(), HRESULT=80004005 (e:\nts_sms_fre\sms\client\tasksequence\tsmbootstrap\tsmediawelcomepage.cpp,280) TSMBootstrap  
> failed to request for Setting wizard error: An error occurred while retrieving policy for this computer  (0x80004005). For more information, please contact your system administrator or helpdesk operator. TSMBootstrap

## Cause

This issue is caused by the backup restoring the **srvacct** folder from the original ConfigMgr 2007 installation instead of keeping the **srvacct** folder from the new ConfigMgr 2007 installation. The **srvacct** folder can be found at the root level of the directory where ConfigMgr 2007 is installed. Normally this folder has a text file in it with the name *srvacct.<site_code>*. The text file has the public keys that along with private keys stored in the Windows OS allow it to decrypt service account information (username/password) which includes the network access account.

When a Windows OS is freshly installed, either via a reinstall of the OS or install on new hardware, new private keys are generated in the Windows OS when ConfigMgr 2007 is installed. The applicable public keys that match up with the private keys are then generated and stored in the **srvacct** folder in the file *srvacct.<site_code>*. If a backup restores the **srvacct** folder from another instance of the Windows OS, the public keys in the *srvacct.<site_code>* folder will no longer match up with the private keys in the Windows OS. This will cause the information for any service account used by ConfigMgr 2007, including the network access account, not to be decrypted and used.

This issue can also cause problems in other areas of ConfigMgr 2007 other than task sequences and OSD. Service accounts aren't normally used in ConfigMgr 2007 since most operations use the SYSTEM/site server's computer account. The only exception to this rule is the network access account that's needed by task sequences when running in WinPE and is the reason why this issue most prominently affects OSD.

Service accounts can be used instead of the SYSTEM/site server's computer account in other areas of ConfigMgr 2007 other than task sequences and OSD. For a list of the different areas in ConfigMgr 2007 that can be optionally configured to use service accounts, and may be affected by this issue.

The two other areas that would most likely be affected by this problem other than OSD would be the use of Site Address Accounts (leading to sites can't communicate with one another) and database access accounts (leading to site roles can't access the database). The issue is mostly seen with OSD since a service account (the network access account) is always needed and used.

## Resolution

To resolve the issue, the ConfigMgr 2007 site will need to be reinstalled from scratch. The current restored ConfigMgr 2007 site can't be used since the original **srvacct** folder no longer exists.

1. Wipe the server and reinstall the Windows OS.

2. Install ConfigMgr 2007 using normal procedures. Don't restore from backup.

3. Before restoring from the backup created via the **Backup ConfigMgr Site Server** maintenance task, manually copy, and backup the **srvacct** folder located at the root level of the ConfigMgr 2007, install location to a location where it can be later restored.

4. Using normal procedures restore from the backup created via the **Backup ConfigMgr Site Server** maintenance task.

5. Once the restore of the backup is complete, rename the restored **srvacct** folder located at the root level of where ConfigMgr 2007 is installed.

6. Copy the **srvacct** folder backed up in Step 3 to the root level of where ConfigMgr 2007 is installed.

7. Perform a site reset on the server.

8. Once the site reset is complete, in the ConfigMgr 2007 Admin console, navigate to **Site Management** \> **<Site_Code>** > **Site Settings** > **Client Agents**. In the right-hand pane, right-click **Computer Client Agent** and choose **Properties**.

9. In the **Computer Client Agent Properties** window, select the **General** tab and examine the account being used under the **Network Access Account** section. Make sure that the account being used is noted and that the password for the account is known.

10. Once the network access account information has been confirmed, in the **Computer Client Agent Properties** window under the **General** tab, select the **Clear** button in the **Network Access Account** section and then select the **Apply** button. Once the information for the network access account has been cleared, select the **Set...** button under the **Network Access Account** section.

11. In the **Windows User Account** window, enter the User name and Password for the network access account as determined in Step 9, and then click the **OK** button.

12. In the **Computer Client Agent Properties** window, click the **OK** button.

> [!NOTE]
> If the above solution is being used to resolve the issue for a component other than OSD (for example, site address accounts or database connection accounts), in steps 8-9, navigate to the appropriate section in the ConfigMgr 2007 Admin console (for example, addresses or properties of the Site Systems roles) and reset the appropriate service accounts using the same same instructions listed in steps 10-12.

## More information

If needed, the above issue can be fixed without having to reinstall Windows and ConfigMgr 2007 on the server. This can be done via a tool called `CryptImportKey.exe`.

To resolve the issue using this tool:

1. Run the `CryptImportKey.exe` tool on the server as SYSTEM.

    > [!NOTE]
    > This tool needs to complete Successfully. If it fails, verify it's running as the local SYSTEM account.

2. Perform a site reset on the server.

3. Once the site reset is complete, in the ConfigMgr 2007 Admin console, navigate to **Site Management** > **<Site_Code>** > **Site Settings** > **Client Agents**. In the right-hand pane, right-click **Computer Client Agent** and choose **Properties**.

4. In the **Computer Client Agent Properties** window, select the **General** tab and examine the account being used under the **Network Access Account** section. Make sure that the account being used is noted and that the password for the account is known.

5. Once the network access account information has been confirmed, in the **Computer Client Agent Properties** window under the **General** tab, select the **Clear** button in the **Network Access Account** section and then select the **Apply** button. Once the information for the network access account has been cleared, select the **Set...** button under the **Network Access Account** section.

6. In the **Windows User Account** window, enter the user name and password for the network access account as determined in step 9 of the [Resolution](#resolution) section, and then click the **OK** button.

7. In the **Computer Client Agent Properties** window, click the **OK** button.

> [!NOTE]
> If the above solution is being used to resolve the issue for a component other than OSD (for example, site address accounts or database connection accounts), in steps 3-4, navigate to the appropriate section in the ConfigMgr 2007 Admin console (for example, addresses or properties of the Site Systems roles) and reset the appropriate service accounts using the same same instructions listed in steps 5-7.
