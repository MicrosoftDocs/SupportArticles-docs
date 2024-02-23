---
title: Repair failed installations of Exchange Cumulative and Security updates
description: Fix issues that occur during CU or SU installations for Exchange Server.
author: genlin
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: mbro; robwhal; batre
ms.custom: 
  - CI 145217
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2019
  - Exchange Server 2016
  - Exchange Server 2013
  - Exchange Server 2010 Service Pack 3
ms.date: 01/24/2024
---

# Repair failed installations of Exchange Cumulative and Security updates

<a id="summary"></a>

This article describes the methods to verify the installation of Microsoft Exchange Server Cumulative Updates (CUs) and Security Updates (SUs) on your servers, lists known issues that might occur when installing CUs and SUs, and provides resolutions to fix the issues.

## Resolve errors during CU or SU installation

- [HTTP 500 errors in OWA or ECP](#http-500-errors-in-owa-or-ecp)
- [HTTP 400 errors in OWA and ECP and Connection Failure error in PowerShell](#http-400-errors-in-owa-and-ecp-and-connection-failure-error-in-powershell)
- [Missing images in ECP](#missing-images-in-ecp)
- [Blank page in EAC or OWA](#blank-page-in-eac-or-owa)
- [Can't sign in to OWA or EAC](#cant-sign-in-to-owa-or-eac)
- [Can't access EAC or OWA after Exchange installation](#cant-access-eac-or-owa-after-exchange-installation)
- [Exchange Server setup does not run](#exchange-server-setup-does-not-run)
- [Upgrade patch can't be installed](#upgrade-patch-cant-be-installed)
- [Installation fails due to services not stopping](#installation-fails-due-to-services-not-stopping)
- [Services don't start after SU installation](#services-dont-start-after-su-installation)
- [Error during Setup in Setup log](#error-during-setup-in-setup-log)
- [Error during update rollup installation](#error-during-update-rollup-installation)
- [Setup fails with "Cannot start the service" error](#setup-fails-with-cannot-start-the-service-error)
- [SU installation fails because of existing IU](#su-installation-fails-because-of-existing-iu)
- [Setup installs older CU or fails to install language pack](#setup-installs-older-cu-or-fails-to-install-language-pack)
- [Restart from previous installation is pending](#restart-from-previous-installation-is-pending)
- [Mail flow has stopped](#mail-flow-has-stopped)
- [Exchange Setup or PrepareAD error](#exchange-setup-or-preparead-error)
- [Exchange setup fails with error code 1603](#exchange-setup-fails-with-error-code-1603)
- [Update .NET when migrating from an unsupported CU](#update-net-when-migrating-from-an-unsupported-cu)
- [Handle customized OWA or .config files](#handle-customized-owa-or-config-files)
- [Install the update for CAS-CAS Proxying deployment](#install-the-update-for-cas-cas-proxying-deployment)
- [Install the update on DBCS version of Windows Server 2012](#install-the-update-on-dbcs-version-of-windows-server-2012)

## Additional information

- [Update .NET when migrating from an unsupported CU](#update-net-when-migrating-from-an-unsupported-cu)
- [Handle customized OWA or .config files](#handle-customized-owa-or-config-files)
- [Install the update for CAS-CAS Proxying deployment](#install-the-update-for-cas-cas-proxying-deployment)
- [Install the update on DBCS version of Windows Server 2012](#install-the-update-on-dbcs-version-of-windows-server-2012)

### HTTP 500 errors in OWA or ECP

**Issue:**

HTTP 500 errors might occur in Outlook on the Web (OWA) and Exchange Control Panel (ECP) after updates are installed. After you provide credentials to log on to OWA or ECP, the login process may fail with the following error message:

> Could not load file or assembly Microsoft.Exchange.Common, Version=15.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35' or one of its dependencies. The system cannot find the file specified.

**Resolution:**

Reinstall the security update from an elevated command prompt.

1. Select **Start**, and then type **cmd**.
1. Right-click **Command Prompt** from the search results, and then select **Run as administrator**.
1. If the **User Account Control** window appears, select the option to open an elevated Command Prompt window, and then select **Continue**.
   If the UAC window doesn't appear, continue to the next step.
1. Type the full path of the .msp file for the security update, and then press **Enter**.
1. After the update installs, restart the server.

For more information, see [OWA or ECP stops working after you install a security update](./owa-stops-working-after-update.md).

[Back to top](#summary)

### HTTP 400 errors in OWA and ECP and Connection Failure error in PowerShell

**Issue:**

HTTP 400 errors might occur in Outlook on the Web (OWA) and Exchange Control Panel (ECP) after updates are installed. After you provide credentials to log on to OWA or ECP, the login process may fail with the following error message:

> HTTP 400 - bad request  
> Cannot serialize context

Also when you start Exchange Management Shell, you receive the following error message:

> ErrorCode                   : -2144108477  
> TransportMessage            : The WS-Management service cannot process the request because the XML is invalid.  
> ErrorRecord                 : Connecting to remote server exchange.contoso.com failed with the following error message :  For more information, see the about_Remote_Troubleshooting Help topic.

**Cause:**

This issue occurs if the username ends with the dollar sign ($), such as *admin$*.

**Resolution:**

Remove the dollar sign ($) from the username, or use another administrative account that doesn't end with the dollar sign ($).

[Back to top](#summary)

### Missing images in ECP

**Issue:**

After installing the SU, OWA or ECP may not display images.

**Cause:**

This issue occurs if the SU is not installed properly.

**Resolution:**

Uninstall and reinstall the .msp file by running the update from an administrative command prompt. Then reboot the server after the installation is complete.

[Back to top](#summary)

### Blank page in EAC or OWA

**Issue:**

A blank page displays when you log in to the Exchange Admin Center (EAC) or OWA from Exchange Server 2016 or Exchange Server 2013. When this issue occurs, event ID 15021 may be logged.  

**Cause:**

This issue occurs if the SSL binding on 0.0.0.0:444 has one or more of the following problems:  

- The binding is installed incorrectly  
- The binding doesn't have a certificate assigned.  
- The binding contains incorrect information.  

**Resolution:**

1. On the Client Access Server (CAS), open Internet Information Services (IIS).  

2. Expand **Sites**, select **Default Web Site**, and then click **Bindings** on the **Actions** pane.

3. In the **Site Bindings** dialog box, open the binding for the following values: </br>
   **Type**: **https**; **Port**: **443**.  

4. Check whether a valid SSL certificate is specified for the default web site. If not, specify a valid SSL certificate, such as **Microsoft Exchange**, and select **OK**.

   :::image type="content" source="./media/exchange-security-update-issues/front-end-binding.png" alt-text="Screenshot that shows Microsoft Exchange is selected as the S S L certificate for the S S L binding for the default web site.":::

5. Run the following command in an elevated PowerShell window to restart IIS:

   ```Powershell
   Restart-Service WAS,W3SVC  
   ```

6. On the Mailbox server, perform the verification steps 1 through 5 for the **Exchange Back End** site.

    :::image type="content" source="./media/exchange-security-update-issues/back-end-binding.png" alt-text="Screenshot that shows Microsoft Exchange is selected as the S S L certificate for the S S L binding for the Exchange Back End site on the Mailbox server.":::

For more information, see [this article](https://support.microsoft.com/topic/you-get-a-blank-page-after-logging-in-eac-or-owa-in-exchange-2013-or-exchange-2016-a24db2f2-4d67-806b-670b-efb8f08605f7).

[Back to top](#summary)

### Can't sign in to OWA or EAC

**Issue:**

When you try to sign in to OWA or the EAC in Exchange Server, the web browser freezes or you see a message that the redirect limit was reached. Additionally, Event 1003 is logged in the event viewer.

> Event ID: 1003
> Source: MSExchange Front End HTTPS Proxy
> An internal server error occurred. The unhandled exception was: System.NullReferenceException: Object reference not set to an instance of an object.
> at Microsoft.Exchange.HttpProxy.FbaModule.ParseCadataCookies(HttpApplication httpApplication)

**Cause:**

This issue occurs because the Exchange Server Open Authentication (OAuth) certificate has expired.

**Resolution:**

Follow the steps in this [article](../administration/cannot-access-owa-or-ecp-if-oauth-expired.md?preserve-view=true#resolution) to fix the issue.

[Back to top](#summary)

### Can't access EAC or OWA after Exchange installation

**Issue:**

When installing Exchange Server 2016 or Exchange Server 2013, the installation process might have failed or been interrupted at some stage, then resumed and finally completed successfully. However, when you try to access EAC or OWA, you receive the following error message:

> something went wrong
>
> Sorry, we can't get that information right now. Please try again later. If the problem continues, contact your helpdesk.

**Cause:**

This issue occurs if the SharedWebConfig.config file is missing from one of the following locations:

- C:\Program Files\Microsoft\Exchange Server\V15\ClientAccess
- C:\Program Files\Microsoft\Exchange Server\V15\FrontEnd\HttpProxy

**Resolution:**

Do the following:

1. On the server in which the error is occurring, identify the location where the SharedWebConfig.config file is missing.
2. Generate the missing file:

    1. Run `cd %ExchangeInstallPath%\bin` to change the current directory to the bin folder that is under the Exchange installation path.
    2. Use the DependentAssemblyGenerator.exe tool to generate the file as appropriate:

        - If the file is missing from *C:\Program Files\Microsoft\Exchange Server\V15\ClientAccess*, run the following command:

        ```console
        DependentAssemblyGenerator.exe -exchangePath "%ExchangeInstallPath%\bin" -exchangePath "%ExchangeInstallPath%\ClientAccess" -configFile "%ExchangeInstallPath%\ClientAccess\SharedWebConfig.config"
        ```

        - If the file is missing from *C:\Program Files\Microsoft\Exchange Server\V15\FrontEnd\HttpProxy*, run the following command:

        ```console
        DependentAssemblyGenerator.exe -exchangePath "%ExchangeInstallPath%\bin" -exchangePath "%ExchangeInstallPath%\FrontEnd\HttpProxy" -configFile "%ExchangeInstallPath%\FrontEnd\HttpProxy\SharedWebConfig.config"
        ```

3. Restart the server or open an elevated PowerShell session and run the following command:

    ```Powershell
    Restart-Service WAS,W3SVC
    ```

    For more information, see [this article](./event-1309-code-3005-cannot-access-owa-ecp.md).

[Back to top](#summary)

### Exchange Server setup does not run

**Issue:**

You run an unattended installation to upgrade Microsoft Exchange Server 2019, Microsoft Exchange Server 2016, or Microsoft Exchange Server 2013 from PowerShell or command prompt by using setup.exe. The Setup program starts and may indicate that it has completed successfully. However, Exchange isn't updated.

The Setup media is located on D: drive and the unattended installation is started by using one of the following commands:</br>
"`setup.exe /m:upgrade /IAcceptExchangeServerLicenseTerms`" (from PowerShell or command prompt) instead of</br>
"`.\setup.exe /m:upgrade /IAcceptExchangeServerLicenseTerms`" (from PowerShell) or</br>
"`D:\setup.exe /m:upgrade /IAcceptExchangeServerLicenseTerms`" (from PowerShell or command prompt).

**Cause:**  

When you run a command in PowerShell or command prompt, the paths in the System environment variable "Path" are checked first to verify the command to be executed, before the current path in PowerShell or command prompt is checked. This order of checks is used unless the following conditions are true:

- ".\" is entered in front of the command or program being executed in PowerShell.
- The Tab key is used to automatically add ".\" in front of the command or program being executed in PowerShell.
- The full path is used to run setup.exe (for example "`D:\setup.exe /m:upgrade /IAcceptExchangeServerLicenseTerms`") in PowerShell or command prompt.

In the absence of these conditions, another setup.exe file located in `C:\Program Files\Microsoft\Exchange Server\V15\bin` is found and executed by PowerShell instead of the setup.exe in the correct path.

**Resolution:**  

Run the upgrade by using "`.\setup.exe /m:upgrade /IAcceptExchangeServerLicenseTerms`" (PowerShell) or "`D:\setup.exe /m:upgrade /IAcceptExchangeServerLicenseTerms`" (PowerShell and command prompt).

For more information, see [this article](../setup/ex2019-setup-does-not-run-correctly-started-powershell.md).

[Back to top](#summary)

### Upgrade patch can't be installed

**Issue:**

You might see the following error message when installing the SU:

> The upgrade patch cannot be installed by the Windows Installer service because the program to be upgraded may be missing, or the upgrade patch may update a different version of the program. Verify that the program to be upgraded exists on your computer and that you have the correct upgrade patch.

**Cause:**

This error message displays if the versions of the CU and SU don't match.

**Resolution:**

Either upgrade to the correct CU or download the correct SU for the intended CU.

[Back to top](#summary)

### Installation fails due to services not stopping

**Issue:**

The installation fails because services didn't stop properly.

**Resolution:**

Use the best practice to reboot the server before installing the CU or SU. For the antivirus software you're running, set proper [exclusions](/Exchange/antispam-and-antimalware/windows-antivirus-software?preserve-view=true&view=exchserver-2019) or consider turning it off during the setup. In some cases where services still don't stop or start as expected, do the following.

1. Rename the C:\ExchangeSetupLogs folder (for example, ExchangeSetupLogs-OLD).
2. Change the startup type for Exchange services in the services.msc console to **Automatic**.

    **Note**: Do so only for the Exchange services that were active before the setup attempt. The POP3 and IMAP4 services are stopped by default. They need to run only if there are users who need them.

Then run the setup again.

[Back to top](#summary)

### Services don't start after SU installation

**Issue:**

Exchange services don't start after you complete installing the SU installation.

**Resolution:**

Check the state of the services. If they are **Disabled**, set them to **Automatic** and start them manually.

**Note**: The services **MSExchangeIMAP4**, **MSExchangeIMAP4BE**, **MSExchangePOP3**, and **MSExchangePOP3BE** are typically disabled by default. Check the Exchange log located at `C:\ExchangeSetupLogs\ServiceControl.log` to see which services were disabled during the SU installation.

[Back to top](#summary)

### Error during Setup in Setup log

**Issue:**

You receive the following error message during Setup in the Setup logs:

> Setup encountered a problem while validating the state of Active Directory or Mailbox Server Role isn't installed on this computer.

**Resolution:**

Download and run the Exchange Setup log reviewer script [SetupLogReviewer.ps1](https://github.com/microsoft/CSS-Exchange/releases/latest/download/SetupLogReviewer.ps1). This script reviews the ExchangeSetup.log, determines whether this error is a known issue and presents an action you can take to resolve the issue.
After you download the script, point it to the Exchange Setup log as shown below and review the output.

````powershell
.\SetupLogReviewer.ps1 -SetupLog C:\ExchangeSetupLogs\ExchangeSetup.log
````

Alternatively you can review the log located at `C:\ExchangeSetupLogs\ExchangeSetup.log` for the following error:

"Setup encountered a problem while validating the state of Active Directory: Exchange organization-level objects have not been created, and setup cannot create them because the local computer is not in the same domain and site as the schema master. Run setup with the /prepareAD parameter on a computer in the domain \<domain_name> and site \<Default_First_Site_Name>, and wait for replication to complete."

If you find this error, run the following command from a machine that is in the same domain as the schema master.

`.\setup.exe /PrepareAD /IAcceptExchangeServerLicenseTerms`

**Note**: The user who runs the command must be a member of the **Enterprise Admin**, **Domain Admin**, and **Schema Admin** groups.

To find the Domain Controller (DC) which holds the schema master, run the following command from administrative command prompt on the DC:

`netdom query fsmo`

[Back to top](#summary)

### Error during update rollup installation

**Issue:**

When you install the update rollup on a computer that isn't connected to the internet, you may experience a long installation delay. Additionally, you may receive the following error message:

> Creating Native images for .Net assemblies.

**Cause:**

This issue is caused by the network requests to connect to the following URL:

``http://crl.microsoft.com/pki/crl/products/CodeSigPCA.crl``

The network requests are attempts to access the Certificate Revocation List for each assembly for which Native image generation (Ngen) compiles to native code. Because the server that's running Exchange Server isn't connected to the internet, each request must wait to time out before the process can continue.

**Resolution:**

Do the following:

1. In Internet Explorer, select **Tools** > **Internet Options**.
2. Select the **Advanced** tab.
3. In the **Security** section, clear the **Check for publisher's certificate revocation** check box, and then select **OK**.

    > [!NOTE]
    > Clear this security option only if the computer is in a tightly-controlled environment.
  
4. After the Setup process completes, select the **Check for publisher's certificate revocation** check box again.

[Back to top](#summary)

### Setup fails with "Cannot start the service" error

**Issue:**

The CU setup might fail with the following error message:

> Cannot start the service Microsoft Exchange Service Host

You might find that the Microsoft Exchange Service Host and/or all other Exchange services are stopped and in **Disabled** mode.

**Resolution:**

Do the following:

1. Rename the C:\ExchangeSetupLogs folder (for example, ExchangeSetupLogs-OLD).
2. Change the startup type for all Exchange services in the services.msc console to **Automatic**.
3. Assuming that the Exchange CU media is on D: drive, open a command prompt as administrator and resume setup by using the following command:

   `D:\setup.exe /m:upgrade /IAcceptExchangeServerLicenseTerms`

[Back to top](#summary)

### SU installation fails because of existing IU

**Issue:**

During the SU installation, you might see the following error message:

> Installation cannot continue. The Setup Wizard has determined that this Interim Update is incompatible with the current Microsoft Exchange Server 2013 Cumulative Update 23 configuration.

**Resolution 1:**

Uninstall the previously installed Interim Update (IU) before applying this SU because the updates are cumulative. You can find the previous IUs in **Add/Remove Programs**.

**Resolution 2:**

This error message may also display on a server that has no IUs installed but is not connected to the internet. So it can't check the Certificate Revocation List. In this situation, do the following:

1. In Internet Explorer, select **Tools** > **Internet Options**.
2. Select the **Advanced** tab.
3. In the **Security** section, clear the **Check for publisher's certificate revocation** check box, and then select **OK**.

    > [!NOTE]
    > Clear this security option only if the computer is in a tightly-controlled environment.
  
4. After the Setup process completes, select the **Check for publisher's certificate revocation** check box again.

[Back to top](#summary)

### Setup installs older CU or fails to install language pack

**Issue:**

You're upgrading to the latest CU but Setup either displays that it is installing an existing CU on the server OR fails with the following error message:

> Couldn't open package **'C:\Program Files\Microsoft\Exchange Server\V15\bin\Setup\\\<package name>**. This installation package could not be opened. Verify that the package exists and that you can access it, or contact the application vendor to verify that this is a valid Windows Installer package. Error code is 1619.

**Cause:**

These issues occur if you start the installation from Windows PowerShell and use the Setup.EXE command.

**Resolution:**

If the Exchange CU media is on D: drive, run an upgrade using PowerShell by using either of the following commands:
"`.\setup.exe /m:upgrade /IAcceptExchangeServerLicenseTerms`" (PowerShell) or "`D:\setup.exe /m:upgrade /IAcceptExchangeServerLicenseTerms`" (PowerShell and command prompt)

[Back to top](#summary)

### Restart from previous installation is pending

**Issue:**

You keep getting the following error message even after restarting the server several times:

> Microsoft Exchange Server setup cannot continue because a restart from a previous installation or update is pending.

**Resolution:**

Follow the information provided in [A Restart from a Previous Installation is Pending](/previous-versions/office/exchange-server-analyzer/cc164360(v=exchg.80)) to fix the issue.

If you still see the error message, do the following:

1. Run the [HealthChecker script](https://aka.ms/exchangehealthchecker).
1. Run the [SetupAssist.ps1](https://aka.ms/ExSetupAssist) script.

[Back to top](#summary)

### Mail flow has stopped

**Issue:**

Mail flow stops after you install a CU or an SU.

**Resolution:**

To get mail flow working again, make sure that the following requirements are met:

1. All Exchange services are enabled and running.
2. The server is not in [Maintenance mode](/exchange/high-availability/manage-ha/manage-dags?view=exchserver-2019#performing-maintenance-on-dag-members&preserve-view=true)
3. There is enough free space available in the [Exchange message queue database](/exchange/back-pressure-exchange-2013-help#free-hard-drive-space-for-the-message-queue-database&preserve-view=true).

[Back to top](#summary)

### Exchange Setup or PrepareAD error

**Issue:**

When you run either Exchange setup or the PrepareAD command, the process fails with the following error message:

> The well-known object entry B:\<guid\>:CN=Recipient Management\0ADEL:\<guid\>,CN=Deleted Objects,DC=contoso,DC=com on the otherWellKnownObjects attribute in the container object CN=Microsoft Exchange,CN=Services,CN=Configuration,DC=contoso,DC=com points to an invalid DN or a deleted object. Remove the entry, and then rerun the task. at Microsoft.Exchange.Configuration.Tasks.Task.ThrowError(Exception exception, ErrorCategory errorCategory, Object target, String helpUrl)

**Cause:**

This issue occurs because "otherWellKnownObjects", the object referenced in the error, is no longer in Active Directory. So the link to the object needs to be removed.

**Resolution:**

Download and run the [SetupAssist.ps1](https://aka.ms/ExSetupAssist) script.

````powershell
.\SetupAssist.ps1 -OtherWellKnownObjects
````

The script will dump the otherWellKnownObjects attribute into a file named ExchangeContainerOriginal.txt. Then it will check the file for deleted objects. If any are found, the script will generate a new file named ExchangeContainerImport.txt and use it to remove the bad values.

If the script asks you to verify the results, do the following:

1. Review the ExchangeContainerImport.txt file for the changes made by the script.
2. Import the ExchangeContainerImport.txt file into Active Directory by following the instructions provided by the script.
3. Rerun the PrepareAD command.

Now you should be able to continue with the setup.

[Back to top](#summary)

### Exchange setup fails with error code 1603

**Issue:**

You see the following error message during Exchange installation:

> Installing product F:\exchangeserver.msi failed. Fatal error during installation. Error code is 1603. Last error reported by the MSI package is 'The installer has insufficient privileges to access this directory: C:\Program Files\Microsoft\Exchange Server\V15\FrontEnd\HttpProxy\owa\auth\15.1.2106'.

**Resolution:**

1. Make sure that the setup is run by using a local administrator account.
2. Check whether the following permissions are assigned to the folder specified in the error:
    1. Read permission to Authenticated users
    1. Full Control permission to System
    1. Full Control to <local_machine>\administrators>
3. Make sure that inheritance is enabled on the folder. If it isn't, then enable inheritance.

After updating folder permissions, resume setup.

If the error message still occurs, follow the steps provided in [this article](/troubleshoot/windows-server/application-management/msi-installation-error-1603).

[Back to top](#summary)

### Update .NET when migrating from an unsupported CU

If you're upgrading Exchange Server from an unsupported CU to the current CU and no intermediate CUs are available, you should first upgrade to the latest version of .NET that's supported by your version of Exchange Server and then immediately upgrade to the current CU. This method doesn't replace the need to keep your Exchange servers up to date and on the latest supported CU. Microsoft makes no claim that an upgrade failure will not occur by using this method.

> [!IMPORTANT]
> Versions of the .NET Framework that aren't listed in the tables in the [Exchange Server supportability matrix](/Exchange/plan-and-deploy/supportability-matrix?view=exchserver-2019#exchange-2019&preserve-view=true) are not supported on any version of Exchange. This includes minor and patch-level releases of the .NET Framework.  

Follow these steps to install the latest version of the .NET Framework:

1. Put the server into [Maintenance Mode](/Exchange/high-availability/manage-ha/manage-dags?redirectedfrom=MSDN&view=exchserver-2019#performing-maintenance-on-dag-members&preserve-view=true).
    Run the following command:

    `set-servercomponentstate \<server_name\> -Component serverwideoffline -State inactive -Requester Maintenance`

2. Stop all Exchange Services by using either the Services MMC or PowerShell. If you want to use PowerShell, run the following command twice to stop all Exchange services:

    `Get-service \*exch\* \| stop-service`

    **Note**: It is not recommended to use the -Force command to stop all the services.

3. Download and install the correct version of the .NET Framework according to the [Exchange Server supportability matrix](/exchange/plan-and-deploy/supportability-matrix?view=exchserver-2019#exchange-2019&preserve-view=true).

4. After the installation is complete, reboot the server.

5. Update to the newest CU available for Exchange 2013, 2016, or 2019.

6. Reboot the server after the CU is installed.

7. Ensure all Exchange services are in their normal start mode and have started. You can use PowerShell to run the following command to start them:

    `Get-service \*exch\*`

8. Take the server out of [Maintenance Mode](/Exchange/high-availability/manage-ha/manage-dags?redirectedfrom=MSDN&view=exchserver-2019#performing-maintenance-on-dag-members&preserve-view=true). Run the following command:

    `set-servercomponentstate \<server_name\> -Component serverwideoffline -State active - Requester Maintenance`

[Back to top](#summary)

### Handle customized OWA or .config files

> [!IMPORTANT]
> Before you apply a CU, make a backup copy of your customized files.

When you apply a CU (for Exchange Server 2013, 2016 or 2019) or Rollup package (for Exchange Server 2010), the process updates OWA files and .config files if necessary. As a result, any customization that you may have made to Exchange or Internet Information Server (IIS) settings in Exchange XML application configuration files on the Exchange server will be overwritten when you install an Exchange CU. Examples of such application configuration files include web.config files, EdgeTransport.exe.config files, and any customized logon.aspx Outlook on the web files. Make sure to save this information so you can easily reapply the settings after the CU is installed.

[Back to top](#summary)

### Install the update for CAS-CAS Proxying deployment

If your scenario meets both the following conditions, apply the update rollup on the internet-facing CAS before you apply the update rollup on the non–internet-facing CAS:

- You're a CAS Proxy Deployment Guidance customer.
- You have deployed [CAS-CAS proxying](/previous-versions/exchange-server/exchange-140/bb310763(v=exchg.140)).

> [!NOTE]
> For other Exchange Server 2010 configurations, you don't have to apply the update rollup on your servers in a specific order.

[Back to top](#summary)

### Install the update on DBCS version of Windows Server 2012

To install or uninstall Update Rollup 32 for Exchange Server 2010 SP3 on a Double Byte Character Set (DBCS) version of Windows Server 2012, the language preference for non-Unicode programs should not be set to the default language. If it is, then you must change this setting before beginning the installation.

1. In Control Panel, select **Clock, Region, and Language** > **Region** > **Administrative**.
2. In the **Language for non-Unicode programs** area, select **Change system locale**.
3. In the **Current system locale** list, select **English (United States)**, and then select **OK**.

Now you can install or uninstall Update Rollup 32 as needed. After the process completes, revert the language setting as appropriate.

[Back to top](#summary)
