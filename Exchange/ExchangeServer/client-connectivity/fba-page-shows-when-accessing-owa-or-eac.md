---
title: FBA page shows when accessing Outlook Web App or EAC
description: Describes a problem in which the forms-based authentication page continues to appear even after the user provides valid credentials. Provides a workaround.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: batre, genli, v-six
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2013 Enterprise
search.appverid: MET150
ms.date: 01/24/2024
---
# The FBA page is displayed when a user accesses Outlook Web App or EAC to sign in to Exchange Server 2016 and 2013

_Original KB number:_ &nbsp; 2871485

## Symptoms

In Microsoft Exchange Server 2013, you have forms-based authentication (FBA) disabled for Outlook Web App (Outlook Web App) and [Exchange admin center](/exchange/architecture/client-access/exchange-admin-center) (EAC). Additionally, you have either Windows Integrated or Basic Authentication enabled. After you upgrade Exchange Server 2013 to a newer build, the FBA page is displayed when a user accesses Outlook Web App or EAC. Additionally, the FBA page continues to appear even after the user provides valid credentials.

This issue also occurs in Exchange Server 2016.

## Cause

This problem occurs because the upgrade process copies the default Web.config file over the existing, customized Web.config file. This results in all existing settings being lost. This includes the HTTP module settings.

## Workaround

To work around this problem, reconfigure the desired authentication mechanism on the Outlook Web App or EAC virtual directories. To do this, follow these steps:

> [!NOTE]
> These steps will reconfigure Windows Integrated Authentication on OWA and EAC virtual directories by using the Exchange Management Shell.

1. Review the authentication configuration. To do this, run the appropriate command:

    For Outlook Web App, run the following command:

    ```powershell
    Get-OwaVirtualDirectory -Server exch3 | fl *auth*
    ```

    For EAC, run the following command:

    ```powershell
    Get-EcpVirtualDirectory -Server exch3 | fl *auth*
    ```

2. Run the appropriate command to disable FBA and to enable Windows-Integrated Authentication:

    For Outlook Web App, run the following command:

    ```powershell
    Set-OwaVirtualDirectory -Identity "EXCH3\owa (Default Web Site)" -FormsAuthentication $false -WindowsAuthentication $true
    ```

    For EAC, run the following command:

    ```powershell
    Set-EcpVirtualDirectory -Identity "EXCH3\ECP (Default Web Site)" -FormsAuthentication $false -WindowsAuthentication $true
    ```

3. Run IISReset to restart Internet Information Services (IIS).

See [View or Configure Outlook Web App Virtual Directories](/exchange/view-or-configure-outlook-web-app-virtual-directories-exchange-2013-help) for information about how to use the EAC or the Exchange Management Shell to view or configure the properties of an Outlook Web App virtual directory.

## More information

To retrieve the settings of Microsoft Office Outlook Web App virtual directories on a computer that is running Exchange Server 2013 and that has the Client Access server role installed, run the command:

```powershell
Get-OwaVirtualDirectory -Server exch3 | fl *auth*
```

Here is an example of the results that are returned by the command:

```powershell
ClientAuthCleanupLevel : High
InternalAuthenticationMethods : {Ntlm, WindowsIntegrated}
BasicAuthentication : False
WindowsAuthentication : True
DigestAuthentication : False
FormsAuthentication : False
LiveIdAuthentication : False
AdfsAuthentication : False
OAuthAuthentication : False
ExternalAuthenticationMethods : {Fba}
```

## References

See [Get-OwaVirtualDirectory](/powershell/module/exchange/get-owavirtualdirectory), for information about how to retrieve all Office Outlook Web App virtual directories on a computer that is running Microsoft Exchange Server 2013 and that has the Client Access server role installed.

See [Set-EcpVirtualDirectory](/powershell/module/exchange/set-ecpvirtualdirectory) for information about how to change the properties of an EAC virtual directory.
