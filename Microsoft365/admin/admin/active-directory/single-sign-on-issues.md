---
title: Use Remote Connectivity Analyzer to troubleshoot single sign-on issues
description: Describes how to use Remote Connectivity Analyzer to diagnose single sign-on (SSO) logon issues in Microsoft 365, Azure, or Microsoft Intune. Also contains information about causes of common SSO failures and links to troubleshooting resources.
author: Cloud-Writer
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: meerak
ms.reviewer: v-jocomf
search.appverid: 
  - MET150
appliesto: 
  - Cloud Services (Web roles/Worker roles)
  - Azure Active Directory
  - Microsoft Intune
  - Azure Backup
  - Microsoft 365
ms.date: 03/31/2022
---

# How to use Remote Connectivity Analyzer to troubleshoot single sign-on issues for Microsoft 365, Azure, or Intune

## Introduction

This article describes how to diagnose single sign-on (SSO) logon issues in a Microsoft cloud service such as Microsoft 365, Microsoft Azure, or Microsoft Intune by using Microsoft Remote Connectivity Analyzer. It also contains information about causes of common SSO failures and lists links to resources for how to troubleshoot the issue.

Remote Connectivity Analyzer is a free connectivity test platform for the cloud-based service. It tests the availability of the required federation service endpoint for expected behavior by acting on those services from the Internet.

## More information

The data flow of any SSO communication is predictable. The expected data flow pattern can be compared to or contrasted with a capture of the actual data flow that occurs during a failing SSO attempt to determine what might be wrong with the process. 

### How to run Remote Connectivity Analyzer to test SSO authentication
 
To run Remote Connectivity Analyzer to test SSO authentication, follow these steps:

1. Open a web browser, and then browse to [https://www.testconnectivity.microsoft.com/tests/SingleSignOn/input](https://www.testconnectivity.microsoft.com/tests/SingleSignOn/input).   
2. Type your user ID and the password, click to select the security acknowledgement check box, type the verification code, and then click **Perform Test**.

    > [!NOTE]
    > - Your user ID is your user principal name (UPN).    
    > - You must enter the actual credentials that are associated with the SSO implementation that you're testing.   
    
    :::image type="content" source="media/single-sign-on-issues/remote-connectivity-analyzer.png" alt-text="Screenshot of the Remote Connectivity Analyzer page.":::

3. If the connectivity test isn't completed successfully, expand the **Test Details** result tree by following the error icons to identify the first error that the test encountered. For any error state that's detected, expand the test result tree to the specific error, and then click **Tell me more about this issue and how to resolve**.

    The following table lists causes of common SSO failures and resources that you can use to help resolve the issue.

    |Test|Common cause and failure sources|Description|Possible resolutions|
    |---|---|---|---|
    |Attempting to retrieve domain registration and to validate federation status information for user. Analyzing the domain registration received for user|An error was found in the domain registration.|This indicates that the domain that's used as the user's UPN suffix hasn't been federated.|Federate the UPN suffix domain. Troubleshoot domain federation and user account problems. For more information, see [Troubleshoot account issues for federated users in Microsoft 365, Azure, or Intune](https://support.microsoft.com/help/2530590 ).  Update the user's UPN to use the correct federated domain suffix. For more information, see [Troubleshoot user name issues that occur for federated users when they sign in to Microsoft 365, Azure, or Intune](https://support.microsoft.com/help/2392130). |
    |Attempting to resolve the host name fed.**contoso**.com in DNS|The host name couldn't be resolved.|Public DNS resolution of AD FS service endpoint is failing.|For more information about how to troubleshoot this issue, see [Troubleshoot single sign-on setup issues in Microsoft 365, Intune, or Azure](https://support.microsoft.com/help/2530569). For more information about the limitations of not exposing AD FS, see [Supported scenarios for using AD FS to set up single sign-on in Microsoft 365, Azure, or Intune ](https://support.microsoft.com/help/2510193).|
    |Testing TCP port 443 on host sts.contoso.com to make sure that it is listening and opened|The specified port is blocked, not listening, or not producing the expected response.|One or more of the services on which AD FS response relies stopped, were stopped, or are unavailable in some way.|Restart the services. For more information, see [Internet browser can't display the AD FS sign-in webpage for federated users](https://support.microsoft.com/help/2419389). Investigate a possible AD FS memory leak. For more information, see [The "500" error code is returned when you send an HTTP SOAP request to the "/adfs/services/trust/mex" endpoint on a computer that is running Windows Server 2008 R2 or Windows Server 2008](https://support.microsoft.com/help/2254265 ). Investigate firewall-published AD FS service problems. For more information, see [How to troubleshoot AD FS endpoint connection issues when users sign in to Microsoft 365, Intune, or Azure](https://support.microsoft.com/help/2712961). |
    |Retrieving AD FS metadata information from metadata exchange URL `https://fed.contoso.com/adfs/services/trust/mex|ExRCA` couldn't retrieve AD FS metadata.|One or more of the services on which AD FS response relies stopped, was stopped, or is unavailable in some way.|Restart the services. For more information, see [Internet browser can't display the AD FS webpage when a federated user tries to sign in to Microsoft 365, Azure, or Intune ](https://support.microsoft.com/help/2419389). Investigate problems with the AD FS proxy server. For more information, see [How to troubleshoot AD FS endpoint connection issues when users sign in to Microsoft 365, Intune, or Azure ](https://support.microsoft.com/help/2712961). Investigate a possible AD FS memory leak. For more information, see [The "500" error code is returned when you send an HTTP SOAP request to the "/adfs/services/trust/mex" endpoint on a computer that is running Windows Server 2008 R2 or Windows Server 2008](https://support.microsoft.com/help/2254265 ).|
    |Validating the certificate name|Certificate name validation failed.|Problems with the SSL certificate are limiting AD FS authentication.|Troubleshoot the problems by using SSL certificate. For more information, see [You receive a certificate warning from AD FS when you try to sign in to Microsoft 365, Azure, or Intune](https://support.microsoft.com/help/2523494).|
    |Certificate Trust is being verified.|Certificate trust validation failed.|Problems with the SSL certificate are limiting AD FS authentication.|Troubleshoot the problems by using SSL certificate. For more information, see  [You receive a certificate warning from AD FS when you try to sign in to Microsoft 365, Azure, or Intune](https://support.microsoft.com/help/2523494 ).|
    |ExRCA is attempting to authenticate to the security token service at https://sts.**contoso**.com/adfs/services/trust/2005/usernamemixed|A SOAP fault response was received from the Security Token service. A web exception occurred because an HTTP 503 - Service Unavailable response was received from Unknown.|The authentication to AD FS endpoints by using the federation trust is malfunctioning.|Check and rebuild the federation trust. For more information, see ["80041317" or "80043431" error when federated users sign in to Microsoft 365, Azure, or Intune](https://support.microsoft.com/help/2647020). Check and repair the token-signing certificate problems. For more information, see ["There was a problem accessing the site" error from AD FS when a federated user signs in to Microsoft 365, Azure, or Intune](https://support.microsoft.com/help/2713898). |

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Entra Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread) website.
