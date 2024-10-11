---
title: The Task Sequence Wizard returns error 80004005
description: Discusses an issue in which the Task Sequence Wizard returns error 80004005 and Smsts.log logs the Sending with winhttp failed error during an OS deployment that uses bootable or prestaged media.
ms.date: 12/05/2023
ms.reviewer: kaushika
ms.custom: sap:Operating Systems Deployment (OSD)\Operating System Image Deployment
---
# Sending with winhttp failed 80072f8f error in Smsts.log during OS deployment by using bootable or prestaged media

This article helps you fix an issue in which the Task Sequence Wizard returns error 80004005 and Smsts.log logs the **Sending with winhttp failed; 80072f8f** error during an OS deployment that uses bootable or prestaged media.

_Original product version:_ &nbsp; Configuration Manager (current branch), Microsoft System Center 2012 R2 Configuration Manager, Microsoft System Center 2012 Configuration Manager  
_Original KB number:_ &nbsp; 4551033

## Symptoms

You create bootable media or prestaged media in Configuration Manager. When the media is used to start the destination computer, the Task Sequence Wizard gets stuck at the **Retrieving policy for this computer** step for about 90 seconds, then returns the following error message:

> **Failed to Run Task Sequence**  
> An error occurred while retrieving policy for this computer (0x80004005). For more information, contact your system administrator or helpdesk operator.

The following error messages are logged in *X:\Windows\Temp\SMSTSLog\smsts.log* on the computer when the task sequence engine first tries to contact the management point to sync the time information:

> TSMBootstrap &nbsp; &nbsp;Current time info:  
> TSMBootstrap &nbsp; &nbsp;Getting MP time information  
> TSMBootstrap &nbsp; &nbsp;Requesting client identity  
> TSMBootstrap &nbsp; &nbsp;Setting the authenticator.  
> TSMBootstrap &nbsp; &nbsp;CLibSMSMessageWinHttpTransport::Send: WinHttpOpenRequest - URL: \<MP>:443  CCM_POST /ccm_system_AltAuth/request  
> TSMBootstrap &nbsp; &nbsp;SSL, using authenticator in request.  
> TSMBootstrap &nbsp; &nbsp;In SSL, but with no client cert.  
> TSMBootstrap &nbsp; &nbsp;[TSMESSAGING] AsyncCallback():  
> \-----------------------------------------------------------------  
> TSMBootstrap &nbsp; &nbsp;[TSMESSAGING] AsyncCallback(): WINHTTP_CALLBACK_STATUS_SECURE_FAILURE Encountered  
> TSMBootstrap &nbsp; &nbsp;[TSMESSAGING] &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;: dwStatusInformationLength is 4  
> TSMBootstrap &nbsp; &nbsp;[TSMESSAGING] &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;: \*lpvStatusInformation is 0x8  
> TSMBootstrap &nbsp; &nbsp;[TSMESSAGING] &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;: WINHTTP_CALLBACK_STATUS_FLAG_INVALID_CA is set  
> TSMBootstrap &nbsp; &nbsp;[TSMESSAGING] AsyncCallback():  
> \-----------------------------------------------------------------  
> TSMBootstrap &nbsp; &nbsp;Error. Received 0x80072f8f from WinHttpSendRequest.  
> TSMBootstrap &nbsp; &nbsp;Sending with winhttp failed; 80072f8f. retrying.  
> TSMBootstrap &nbsp; &nbsp;Retrying and Ignoring date security failures.  
> TSMBootstrap &nbsp; &nbsp;[TSMESSAGING] AsyncCallback():  
> \-----------------------------------------------------------------  
> TSMBootstrap &nbsp; &nbsp;[TSMESSAGING] AsyncCallback(): WINHTTP_CALLBACK_STATUS_SECURE_FAILURE Encountered  
> TSMBootstrap &nbsp; &nbsp;[TSMESSAGING] &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;: dwStatusInformationLength is 4  
> TSMBootstrap &nbsp; &nbsp;[TSMESSAGING] &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;: \*lpvStatusInformation is 0x8  
> TSMBootstrap &nbsp; &nbsp;[TSMESSAGING] &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;: WINHTTP_CALLBACK_STATUS_FLAG_INVALID_CA is set  
> TSMBootstrap &nbsp; &nbsp;[TSMESSAGING] AsyncCallback():  
> \-----------------------------------------------------------------  
> TSMBootstrap &nbsp; &nbsp;hr, HRESULT=80072f8f  
> TSMBootstrap &nbsp; &nbsp;Sending with winhttp failed; 80072f8f

After the initial error, the task sequence engine tries an additional four times to contact the management point, and experiences an increasing pause between each attempt. However, all attempts fail and return the same error messages before some final error messages are returned, as follows:

- If the media is configured as dynamic media, the following final error messages are logged in Smsts.log:

    > TSMBootstrap &nbsp; &nbsp;Send (pReply, nReplySize), HRESULT=80072f8f  
    > TSMBootstrap &nbsp; &nbsp;failed to send the request  
    > TSMBootstrap &nbsp; &nbsp;DoRequest (sReply, true), HRESULT=80072f8f  
    > TSMBootstrap &nbsp; &nbsp;Failed to get client identity (80072f8f)  
    > TSMBootstrap &nbsp; &nbsp;ClientIdentity.RequestClientIdentity (), HRESULT=80072f8f  
    > TSMBootstrap &nbsp; &nbsp;failed to request for client  
    > TSMBootstrap &nbsp; &nbsp;SyncTimeWithMP() failed. 80072f8f.  
    > TSMBootstrap &nbsp; &nbsp;Failed to get time information from MP: `https://<MP>`.  
    > TSMBootstrap &nbsp; &nbsp;MpCnt > 0, HRESULT=80004005  
    > TSMBootstrap &nbsp; &nbsp;QueryMPLocator: no valid MP locations are received  
    > TSMBootstrap &nbsp; &nbsp;TSMBootstrapUtil::QueryMPLocator ( true, sSMSTSLocationMPs.c_str(), sMediaPfx.c_str(), sMediaGuid.c_str(), sAuthenticator.c_str(), sEnterpriseCert.c_str(), sServerCerts.c_str(), nHttpPort, nHttpsPort, bUseCRL, m_bWinPE, httpS, http, accessibleMpCnt), HRESULT=80004005  
    > TSMBootstrap &nbsp; &nbsp;Failed to query Management Point locator  
    > TSMBootstrap &nbsp; &nbsp;Exiting TSMediaWizardControl::GetPolicy.  
    > TSMBootstrap &nbsp; &nbsp;pWelcomePage->m_pTSMediaWizardControl->GetPolicy(), HRESULT=80004005  
    > TSMBootstrap &nbsp; &nbsp;Setting wizard error: An error occurred while retrieving policy for this computer &nbsp;(0x80004005). For more information, contact your system administrator or helpdesk operator.

- If the media is configured as site-based, the following final error messages are logged in Smsts.log:

    > TSMBootstrap &nbsp; &nbsp;Send (pReply, nReplySize), HRESULT=80072f8f  
    > TSMBootstrap &nbsp; &nbsp;failed to send the request  
    > TSMBootstrap &nbsp; &nbsp;DoRequest (sReply, true), HRESULT=80072f8f  
    > TSMBootstrap &nbsp; &nbsp;Failed to get client identity (80072f8f)  
    > TSMBootstrap &nbsp; &nbsp;ClientIdentity.RequestClientIdentity (), HRESULT=80072f8f  
    > TSMBootstrap &nbsp; &nbsp;failed to request for client  
    > TSMBootstrap &nbsp; &nbsp;SyncTimeWithMP() failed. 80072f8f.  
    > TSMBootstrap &nbsp; &nbsp;Failed to get time information from MP: `https://<MP>`.  
    > TSMBootstrap &nbsp; &nbsp;sMP.length() > 0, HRESULT=80004005  
    > TSMBootstrap &nbsp; &nbsp;TSMBootstrapUtil::SelectMP ( sSMSTSMP.c_str(), sMediaPfx.c_str(), sMediaGuid.c_str(), sAuthenticator.c_str(), sEnterpriseCert.c_str(), sServerCerts.c_str(), nHttpPort, nHttpsPort, bUseCRL, m_bWinPE, sSiteCode, sAssignedSiteCode, sMP, sCertificates, sX86UnknownMachineGUID, sX64UnknownMachineGUID), HRESULT=80004005  
    > TSMBootstrap &nbsp; &nbsp;Failed to select MP  
    > TSMBootstrap &nbsp; &nbsp;Exiting TSMediaWizardControl::GetPolicy.  
    > TSMBootstrap &nbsp; &nbsp;pWelcomePage->m_pTSMediaWizardControl->GetPolicy(), HRESULT=80004005  
    > TSMBootstrap &nbsp; &nbsp;Setting wizard error: An error occurred while retrieving policy for this computer &nbsp;(0x80004005). For more information, contact your system administrator or helpdesk operator.

The following detail information applies to error 80072F8F:

> Error Code: 0x80072F8F (2147954575)  
> Error Name: WININET_E_DECODING_FAILED  
> Error Source: Windows  
> Error Message: Content decoding has failed

## Cause

This issue occurs if the following conditions are true:

- You use PKI in your Configuration Manager environment.
- You create the bootable media or prestaged media at the central administration site.
- You configure your management points to use HTTPS.

If you use PKI in your Configuration Manager environment, the root certificate authority (CA) is specified at the primary site but not at the central administration site. Because the central administration site doesn't have the root CA information, the created media doesn't contain the root CA information. Therefore, requests that are sent to an HTTPS-enabled management point fail without the root CA information.

## Resolution

To fix the issue, create the bootable media or prestaged media at a primary site instead of at the central administration site.

## More information

For media that will be used across multiple sites, configure the media as dynamic media. You can create dynamic media at any site. You are not limited to creating it at the central administration site.
