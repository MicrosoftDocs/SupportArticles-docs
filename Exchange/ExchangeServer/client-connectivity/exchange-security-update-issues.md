---
title: Fix Failed Exchange Server Updates
description: Provides resolutions for various errors that might occur during installation of cumulative or security updates in Exchange Server.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom:
  - sap:Plan and Deploy\Exchange Install Issues, Cumulative or Security updates
  - Exchange Server
  - CSSTroubleshoot
  - CI 145217
  - CI 3850
appliesto:
  - Exchange Server 2019
  - Exchange Server 2016
search.appverid: MET150
ms.reviewer: batre, meerak, v-shorestris
ms.date: 02/27/2025
---

# Fix failed Exchange Server updates

If you encounter an error when you try to install a cumulative update (CU) or security update (SU) for Microsoft Exchange Server, select the applicable error description from the list at the top of the article, and follow the appropriate resolution.

## HTTP 500 errors in Outlook on the web or ECP

### Issue

HTTP 500 errors occur in either Outlook on the web or Exchange Control Panel (ECP), or in both applications, after updates are installed. After you provide credentials to sign in to Outlook on the web or ECP, the sign-in process fails and generates the following error message:

> Could not load file or assembly Microsoft.Exchange.Common, Version=15.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35' or one of its dependencies. The system cannot find the file specified.

### Resolution

Reinstall the security update at an elevated command prompt:

1. Select **Start**, and then type **cmd**.

2. Right-click **Command Prompt** in the search results, and then select **Run as administrator**.

3. If the **User Account Control** window appears, select the option to open an elevated Command Prompt window, and then select **Continue**. If the UAC window doesn't appear, go to the next step.

4. Type the full path of the .msp file for the security update, and then press **Enter**.

5. After the update is installed, restart the server.

For more information, see [Outlook on the web or ECP stops working after you install a security update](owa-stops-working-after-update.md).

[Back to top](#fix-failed-exchange-server-updates)

## HTTP 400 errors in Outlook on the web and ECP and connection error in EMS

### Issue

HTTP 400 errors might occur in Outlook on the web and Exchange Control Panel (ECP) after updates are installed. After you provide credentials to sign in to Outlook on the web or ECP, the sign-in process fails and generates the following error message:

> HTTP 400 - bad request  
> Cannot serialize context

Also, when you start Exchange Management Shell (EMS), you receive the following error message:

> ErrorCode : -2144108477  
> TransportMessage : The WS-Management service cannot process the request because the XML is invalid.  
> ErrorRecord : Connecting to remote server exchange.contoso.com failed with the following error message : For more information, see the about_Remote_Troubleshooting Help topic.

### Cause

This issue occurs if the username ends in a dollar sign `$`. For example, the username `admin$`.

### Resolution

Remove the dollar sign `$` from the username, or use another administrative account that doesn't end in a `$`.

[Back to top](#fix-failed-exchange-server-updates)

## Missing images in ECP

### Issue

After you install the SU, Outlook on the web or Exchange Control Panel (ECP) doesn't display images.

### Cause

This issue occurs if the SU isn't installed correctly.

### Resolution

Uninstall and reinstall the _.msp_ file by running the update at an administrative command prompt. Then, restart the server after the installation is completed.

[Back to top](#fix-failed-exchange-server-updates)

## Blank page in EAC or Outlook on the web

### Issue

A blank page appears when you sign in to the Exchange Admin Center (EAC) or Outlook on the web. When this issue occurs, **Event 15021** might be logged.

### Cause

This issue occurs if the SSL binding on endpoint `0.0.0.0:444` has one or more of the following problems:

- The binding is installed incorrectly
- The binding doesn't have a certificate assigned.
- The binding contains incorrect information.

### Resolution

Follow these steps:

1. Open Internet Information Services (IIS).

2. Expand **Sites**, select **Default Web Site**, and then select **Bindings** on the **Actions** pane.

3. In the **Site Bindings** dialog box, open the binding for the **Type** value `https` and the **Port** value `443`.

4. Check whether a valid SSL certificate is specified for the default website. If not, specify a valid SSL certificate, such as **Microsoft Exchange**, and then select **OK**.

   :::image type="content" source="media/exchange-security-update-issues/front-end-binding.png" border="true" alt-text="Screenshot showing the SSL certificate field in the Edit Site Binding window in IIS Manager.":::

5. Run the following command in an elevated PowerShell window to restart IIS:

   ```PS
   Restart-Service WAS,W3SVC
   ```

6. On the Mailbox server, perform steps 1 through 5 for the **Exchange Back End** site.

   :::image type="content" source="media/exchange-security-update-issues/back-end-binding.png" border="true" alt-text="Screenshot showing the SSL certificate field in the Edit Site Binding window for the Exchange Back End site in IIS Manager.":::

For more information, see [You get a blank page after logging in EAC or Outlook on the web](https://support.microsoft.com/topic/you-get-a-blank-page-after-logging-in-eac-or-owa-in-exchange-2013-or-exchange-2016-a24db2f2-4d67-806b-670b-efb8f08605f7).

[Back to top](#fix-failed-exchange-server-updates)

## Can't sign in to Outlook on the web or EAC

### Issue

When you try to sign in to Outlook on the web or the EAC in Exchange Server, the web browser stops responding or you see a message that states that the redirect limit was reached. Additionally, **Event 1003** is logged in the event viewer.

> Event ID: 1003 Source: MSExchange Front End HTTPS Proxy An internal server error occurred. The unhandled exception was: System.NullReferenceException: Object reference not set to an instance of an object. at Microsoft.Exchange.HttpProxy.FbaModule.ParseCadataCookies(HttpApplication httpApplication)

### Cause

This issue occurs because the Exchange Server Open Authentication (OAuth) certificate is expired.

### Resolution

Follow the steps in [Can't sign in to Outlook on the web or EAC](/exchange/troubleshoot/administration/cannot-access-owa-or-ecp-if-oauth-expired).

[Back to top](#fix-failed-exchange-server-updates)

## Can't access EAC or Outlook on the web after Exchange Server installation

### Issue

When you install Exchange Server, the installation process might fail or be interrupted at some stage, and then resume and finally finish successfully. However, when you try to access EAC or Outlook on the web after the installation, you receive the following error message:

> something went wrong  
> Sorry, we can't get that information right now. Please try again later. If the problem continues, contact your helpdesk.

### Cause

This issue occurs if the _SharedWebConfig.config_ file is missing from one of the following locations:

- _C:\Program Files\Microsoft\Exchange Server\V15\ClientAccess_
- _C:\Program Files\Microsoft\Exchange Server\V15\FrontEnd\HttpProxy_

### Resolution

Follow these steps:

1. On the server on which the error is occurring, identify the location from which the _SharedWebConfig.config_ file is missing.

2. Generate the missing file:

   1. Run `cd %ExchangeInstallPath%\bin` to change the current directory to the bin folder that is under the Exchange installation path.

   2. Use the **DependentAssemblyGenerator** tool to generate the file as appropriate:

      - If the file is missing from _C:\Program Files\Microsoft\Exchange Server\V15\ClientAccess_, run the following command at the command prompt:

         ```CMD
         DependentAssemblyGenerator.exe -exchangePath "%ExchangeInstallPath%\bin" -exchangePath "%ExchangeInstallPath%\ClientAccess" -configFile "%ExchangeInstallPath%\ClientAccess\SharedWebConfig.config"
         ```

      - If the file is missing from _C:\Program Files\Microsoft\Exchange Server\V15\FrontEnd\HttpProxy_, run the following command at the command prompt:

         ```CMD
         DependentAssemblyGenerator.exe -exchangePath "%ExchangeInstallPath%\bin" -exchangePath "%ExchangeInstallPath%\FrontEnd\HttpProxy" -configFile "%ExchangeInstallPath%\FrontEnd\HttpProxy\SharedWebConfig.config"
         ```

3. Run the following command in an elevated PowerShell session to restart the server:

   ```PS
   Restart-Service WAS,W3SVC
   ```

For more information, see [Event ID 1309 and you can't access Outlook on the web and ECP](event-1309-code-3005-cannot-access-owa-ecp.md).

[Back to top](#fix-failed-exchange-server-updates)

## Exchange Server Setup doesn't run

### Issue

You run an unattended installation to upgrade Exchange Server from PowerShell or at a command prompt by using _Setup.exe_. The Setup program runs and then indicates that it has finished successfully. However, Exchange Server isn't updated.

### Cause

You started the unattended installation by running the following command in PowerShell or at the command prompt: `setup.exe /m:upgrade /IAcceptExchangeServerLicenseTerms_DiagnosticDataON`. However, regardless of which drive the installation media is located on, the system runs the _Setup.exe_ file that's located in the _C:\Program Files\Microsoft\Exchange Server\V15\bin_ folder.

When you run a command in PowerShell or at the command prompt, a matching path in the System environment variable **Path** takes precedence over the current path, unless one of the following conditions are true:

- PowerShell: You enter a period (`.`) in front of the command.
- PowerShell: You use the Tab key to automatically add a period in front of the command.
- You specify the absolute path for the program that you want to run, such as _D:\setup.exe_.

### Resolution

Upgrade Microsoft Exchange Server by using either of the following commands:

- PowerShell: `.\setup.exe /m:upgrade /IAcceptExchangeServerLicenseTerms_DiagnosticDataON`
- PowerShell or command prompt: `D:\setup.exe /m:upgrade /IAcceptExchangeServerLicenseTerms_DiagnosticDataON`

For more information, see [Exchange Server 2019 setup doesn't run as expected](../setup/ex2019-setup-does-not-run-correctly-started-powershell.md).

[Back to top](#fix-failed-exchange-server-updates)

## Upgrade patch can't be installed

### Issue

You might see the following error message when you install an SU:

> The upgrade patch cannot be installed by the Windows Installer service because the program to be upgraded might be missing, or the upgrade patch might update a different version of the program. Verify that the program to be upgraded exists on your computer and that you have the correct upgrade patch.

### Cause

This error message appears if the versions of the CU and SU don't match.

### Resolution

Either upgrade to the correct CU or download the correct SU for the intended CU.

[Back to top](#fix-failed-exchange-server-updates)

## Installation fails because services don't stop

### Issue

The installation fails because services don't stop properly.

### Resolution

Use the best practice to restart the server before you install the CU or SU. For any antivirus software that you're running, set proper [exclusions](/exchange/antispam-and-antimalware/windows-antivirus-software) or turn off the program during the setup. If services still don't stop or start as expected, do the following:

1. Rename the _C:\ExchangeSetupLogs_ folder. For example, change the name to `ExchangeSetupLogs-OLD`.

2. [Start all Exchange services that were stopped during the installation, and set them to start automatically](#start-microsoft-exchange-services).

3. Rerun the setup.

[Back to top](#fix-failed-exchange-server-updates)

## Services don't start after SU installation

### Issue

Microsoft Exchange services don't start after you finish installing the SU.

### Resolution

[Start all Exchange services that were stopped during the installation, and set them to start automatically](#start-microsoft-exchange-services).

[Back to top](#fix-failed-exchange-server-updates)

## Error in Exchange Setup log during installation

### Issue

You receive the following error message in the Exchange Setup log during installation:

> Setup encountered a problem while validating the state of Active Directory or Mailbox Server Role isn't installed on this computer.

### Resolution 1

Download the Exchange Setup log reviewer script, [SetupLogReviewer.ps1](https://github.com/microsoft/CSS-Exchange/releases/latest/download/SetupLogReviewer.ps1).

Run the following PowerShell command to run the script:

   ```PS
   .\SetupLogReviewer.ps1 -SetupLog C:\ExchangeSetupLogs\ExchangeSetup.log
   ```

   The script checks the _ExchangeSetup.log_ file and provides guidance about how to resolve the issue.

### Resolution 2

Check for the following error entry in the Exchange Setup log that's located in the _C:\ExchangeSetupLogs_ folder:

> Setup encountered a problem while validating the state of Active Directory: Exchange organization-level objects haven't been created, and setup can't create them because the local computer isn't in the same domain and site as the schema master. Run setup with the `/PrepareAD` parameter on a computer in the domain \<domain_name\> and site \<Default_First_Site_Name\>, and wait for replication to complete.

If you find this error entry, run the following command from a computer that's in the same domain as the schema master:

```PS
.\setup.exe /PrepareAD /IAcceptExchangeServerLicenseTerms_DiagnosticDataON
```

The user who runs the command must be a member of the **Enterprise Admin**, **Domain Admin**, and **Schema Admin** groups.

**Note**: To find the domain controller (DC) that holds the schema master, run the following command at an elevated command prompt on the DC:

```CMD
netdom query fsmo
```

[Back to top](#fix-failed-exchange-server-updates)

## Error during update rollup installation

### Issue

When you install the update rollup on a computer that isn't connected to the internet, you might experience a long installation delay. Additionally, you might receive the following error message:

> Creating Native images for .NET assemblies.

### Cause

This issue is caused by network requests to connect to the following URL:

`http://crl.microsoft.com/pki/crl/products/CodeSigPCA.crl`

The network requests are attempts to access the Certificate Revocation List for each assembly for which Native image generation (Ngen) compiles to native code. Because the server that's running Exchange Server isn't connected to the internet, each request must time out before the process can continue.

### Resolution

Follow these steps:

1. In Internet Explorer, select **Tools** \> **Internet Options**.

2. Select the **Advanced** tab.

3. In the **Security** section, clear the **Check for publisher's certificate revocation** checkbox, and then select **OK**.

   > [!NOTE]
   > Clear this security option only if the computer is in a tightly-controlled environment.

4. After the Setup process finishes, select the **Check for publisher's certificate revocation** checkbox again.

[Back to top](#fix-failed-exchange-server-updates)

## Setup fails with "Cannot start the service" error

### Issue

The CU setup fails and generates the following error message:

> Cannot start the service Microsoft Exchange Service Host

### Cause

Microsoft Exchange Service Host, and possibly other Exchange services, is stopped and in `Disabled` mode.

### Resolution

Follow these steps:

1. Rename the _C:\ExchangeSetupLogs_ folder. For example, change the name to `ExchangeSetupLogs-OLD`.

2. [Start all Exchange services that were stopped during the installation, and set them to start automatically](#start-microsoft-exchange-services).

3. Run the following command at an elevated command prompt to resume setup:

   ```CMD
   D:\setup.exe /m:upgrade /IAcceptExchangeServerLicenseTerms_DiagnosticDataON
   ```

   This command assumes that the Exchange CU media is on the _D:_ drive.

[Back to top](#fix-failed-exchange-server-updates)

## SU installation fails because of existing interim update

### Issue

During the SU installation, you might see the following error message:

> Installation cannot continue. The Setup Wizard has determined that this Interim Update is incompatible with the current Microsoft Exchange Server 2019 Cumulative Update 14 configuration.

### Resolution 1

Because the updates are cumulative, uninstall the previously installed interim update (IU) before you apply this SU. You can find the previous IUs in **Add/Remove Programs**.

### Resolution 2

This error message might also appear on a server that has no IUs installed but isn't connected to the internet. Therefore, the server can't check the Certificate Revocation List. In this situation, follow these steps:

1. In Internet Explorer, select **Tools** \> **Internet Options**.

2. Select the **Advanced** tab.

3. In the **Security** section, clear the **Check for publisher's certificate revocation** checkbox, and then select **OK**.

   > [!NOTE]
   > Clear this security option only if the computer is in a tightly-controlled environment.

4. After the Setup process finishes, reselect the **Check for publisher's certificate revocation** checkbox.

[Back to top](#fix-failed-exchange-server-updates)

## Setup installs old CU or doesn't install language pack

### Issue

When you try to upgrade to the latest CU, you encounter either of the following issues:

- Setup installs an old CU on the server.
- Setup fails and you see the following error message:

   > Couldn't open package 'C:\Program Files\Microsoft\Exchange Server\V15\bin\Setup\\<package name\>'. This installation package could not be opened. Verify that the package exists and that you can access it, or contact the application vendor to verify that this is a valid Windows Installer package. Error code is 1619.

### Cause

These issues occur if you start the installation from Windows PowerShell and use a command that starts in `setup.exe`. For example, `setup.exe /m:upgrade /IAcceptExchangeServerLicenseTerms_DiagnosticDataON`.

### Resolution

Upgrade Microsoft Exchange Server by using a command that starts with `.\setup.exe` or `<drive letter>:\setup.exe`, such as either of the following commands:

- PowerShell: `.\setup.exe /m:upgrade /IAcceptExchangeServerLicenseTerms_DiagnosticDataON`
- PowerShell or command prompt: `D:\setup.exe /m:upgrade /IAcceptExchangeServerLicenseTerms_DiagnosticDataON`

   The command assumes that the Exchange CU media is on the _D:_ drive.

[Back to top](#fix-failed-exchange-server-updates)

## Restart from previous installation is pending

**Issue**

You repeatedly receive the following error message even after you restart the server several times:

> Microsoft Exchange Server setup cannot continue because a restart from a previous installation or update is pending.

**Resolution**

To fix the issue, follow the steps in [Restart from a previous installation is pending](/previous-versions/office/exchange-server-analyzer/cc164360(v=exchg.80)).

If the error message persists, follow these steps:

1. Run the [HealthChecker script](https://aka.ms/exchangehealthchecker).

2. Run the [SetupAssist.ps1](https://aka.ms/ExSetupAssist) script.

[Back to top](#fix-failed-exchange-server-updates)

## Mail flow has stopped

**Issue**

Mail flow stops after you install a CU or an SU.

**Resolution**

To get mail flow working again, make sure that the following requirements are met:

1. [Start all Exchange services that were stopped during the installation, and set them to start automatically](#start-microsoft-exchange-services).

2. The server isn't in [maintenance mode](/exchange/high-availability/manage-ha/manage-dags#performing-maintenance-on-dag-members)

3. There's enough free space available in the [Exchange message queue database](/exchange/back-pressure-exchange-2013-help#free-hard-drive-space-for-the-message-queue-database).

[Back to top](#fix-failed-exchange-server-updates)

## Exchange Setup or PrepareAD error

**Issue**

When you run either Exchange setup or the `PrepareAD` command, the process fails and generates the following error message:

> The well-known object entry B:\<guid\>:CN=Recipient Management\0ADEL:\<guid\>,CN=Deleted Objects,DC=contoso,DC=com on the otherWellKnownObjects attribute in the container object CN=Microsoft Exchange,CN=Services,CN=Configuration,DC=contoso,DC=com points to an invalid DN or a deleted object. Remove the entry, and then rerun the task. at Microsoft.Exchange.Configuration.Tasks.Task.ThrowError(Exception exception, ErrorCategory errorCategory, Object target, String helpUrl)

**Cause**

This issue occurs because the `well-known object` that's referenced in the error message no longer exists in Active Directory.

**Resolution**

Use the following steps to remove the invalid object entry:

1. Download the [SetupAssist.ps1](https://aka.ms/ExSetupAssist) script.

2. Use the following command to run the script:

   ```PS
   .\SetupAssist.ps1 -OtherWellKnownObjects
   ```

   The script writes the object entries from the `otherWellKnownObjects` attribute to a file that's named _ExchangeContainerOriginal.txt_, and then it checks for deleted objects. If deleted objects are found, the script generates a new file that's named _ExchangeContainerImport.txt_, and then uses it to remove the invalid entries.

If the script prompts you to verify the results, follow these steps:

   1. Review the _ExchangeContainerImport.txt_ file for the changes that were made by the script.

   2. Import the _ExchangeContainerImport.txt_ file into Active Directory by following the instructions that are provided by the script.

   3. Rerun the `PrepareAD` command, and then continue the setup.

[Back to top](#fix-failed-exchange-server-updates)

## Exchange installation fails and returns error code 1603

#### Issue

When you try to install an SU, you receive the following error message:

> Installing product F:\exchangeserver.msi failed. Fatal error during installation. Error code is 1603. Last error reported by the MSI package is 'The installer has insufficient privileges to access this directory: C:\Program Files\Microsoft\Exchange Server\V15\FrontEnd\HttpProxy\owa\auth\15.1.2106'.

#### Resolution

Follow these steps:

1. [Start all Exchange services that were stopped during the installation, and set them to start automatically](#start-microsoft-exchange-services).

2. Try again to install the SU.

If the error message persists, follow these steps:

1. Make sure that you use a local administrator account to run the installation.

2. Verify that the following permissions are assigned to the folder that's specified in the error message:

   - Read permission to **Authenticated Users**
   - Full Control permission to **SYSTEM**
   - Full Control permission to **\<local machine\>\Administrators**

3. Verify that inheritance is enabled on the folder that's specified in the error.

4. Try again to install the SU.

If the error message still occurs, follow the steps in [Error 1603 when you try to install a Windows Installer package](/troubleshoot/windows-server/application-management/msi-installation-error-1603).

[Back to top](#fix-failed-exchange-server-updates)

## Update .NET when migrating from an unsupported CU

If you're upgrading Exchange Server from an unsupported CU to the current CU, and no intermediate CUs are available, first upgrade to the latest version of .NET Framework that's supported by your version of Exchange Server, and then immediately upgrade to the current CU. This method doesn't replace the requirement to keep your Exchange servers up to date and on the latest supported CU. Microsoft makes no claim that an upgrade failure won't occur by using this method.

> [!IMPORTANT]
> Versions of .NET Framework that aren't listed in the tables in the [Exchange Server supportability matrix](/exchange/plan-and-deploy/supportability-matrix#exchange-server-supportability-matrix) are not supported on any version of Exchange Server. This includes minor and update-level releases of .NET Framework.

To install the latest version of .NET Framework, follow these steps:

1. Run the following command to put the server into [maintenance mode](/Exchange/high-availability/manage-ha/manage-dags#performing-maintenance-on-dag-members):

   ```PS
   Set-ServerComponentState <server name> -Component ServerWideOffline -State Inactive -Requester Maintenance
   ```

2. Stop all Exchange services by using either the Services snap-in or PowerShell. To use PowerShell, run the following command twice to stop all Exchange services:

   ```PS
   Get-Service -DisplayName "Microsoft Exchange*" | Stop-Service
   ```

   **Note**: We recommend that you don't use the `-Force` command to stop all the services.

3. Download and install the correct version of .NET Framework according to the [Exchange Server supportability matrix](/exchange/plan-and-deploy/supportability-matrix#exchange-server-supportability-matrix).

4. After the installation is finished, restart the server.

5. Update to the latest CU that's available for Exchange Server.

6. After the CU is installed, restart the server.

7. [Start all Exchange services that were stopped during the installation, and set them to start automatically](#start-microsoft-exchange-services).

8. Run the following command to take the server out of [maintenance mode](/exchange/high-availability/manage-ha/manage-dags#performing-maintenance-on-dag-members):

   ```PS
   Set-ServerComponentState <server name> -Component ServerWideOffline -State Active -Requester Maintenance
   ```

[Back to top](#fix-failed-exchange-server-updates)

## Handle customized Outlook on the web or .config files

> [!IMPORTANT]
> Before you apply a CU, make a backup copy of your customized files.

When you apply a CU for Exchange Server, the process updates Outlook on the web files and .config files. Therefore, any customizations that you make to Exchange or Internet Information Server (IIS) settings in Exchange XML application configuration files on the Exchange server will be overwritten when you install an Exchange CU. Examples of such application configuration files include _Web.config_ files, _EdgeTransport.exe.config_ files, and any customized _Logon.aspx_ Outlook on the web files. Make sure that you save this information so that you can easily reapply the settings after the CU is installed.

[Back to top](#fix-failed-exchange-server-updates)

## Install the update for CAS-CAS proxying deployment

If your scenario meets both the following conditions, apply the update rollup on the internet-facing Client Access Server (CAS) before you apply the update rollup on the non-internet-facing CAS:

- You're a CAS Proxy Deployment Guidance customer.
- You deployed [CAS-CAS proxying](/previous-versions/exchange-server/exchange-140/bb310763(v=exchg.140)).

[Back to top](#fix-failed-exchange-server-updates)

## More information

### Start Microsoft Exchange services

Use the following steps to check the state of Microsoft Exchange services and, if necessary, start them and configure them to start automatically on startup:

1. Restart the Exchange server on which the installation failed.

2. Run the following PowerShell command to check the state of Exchange services:

   ```PS
   Get-Service -DisplayName "Microsoft Exchange*" | FT DisplayName, StartType, Status
   ```

   > [!NOTE]
   > By default, the POP3 and IMAP4 services (MSExchangeIMAP4, MSExchangeIMAP4BE, MSExchangePOP3, and MSExchangePOP3BE) are stopped and not set to automatically start. Don't configure POP3 and IMAP4 services to run unless users require them.
   > Check the Exchange log that's located at _C:\ExchangeSetupLogs\ServiceControl.log_ to see which Exchange services were disabled during a CU or SU installation. Restore only the Exchange services that were active before the installation attempt.

3. If the value of the **StartType** parameter for an Exchange service is `Disabled`, run the following commands in PowerShell to restore the value to `Automatic`:​​

   ```PS
   cd "C:\Program Files\Microsoft\Exchange Server\V15\Bin"
   ​​​​​​Add-PSSnapin -Name Microsoft.Exchange.Management.PowerShell.Setup -ErrorAction SilentlyContinue
   .\ServiceControl.ps1 AfterPatch
   ```

   ​​​​​You can confirm that the value of the **StartType** parameter is `Automatic` by running the following PowerShell command:

   ```PS
   Get-Service -DisplayName "Microsoft Exchange*" | FT DisplayName, StartType, Status
   ```

4. Run the following PowerShell command to manually start all Exchange services:

   ```PS
   Get-Service -DisplayName "Microsoft Exchange*" | Start-Service
   ```

   Or, run the following command to manually start all services except POP3 and IMAP4 services:

   ```PS
   Get-Service -DisplayName "Microsoft Exchange*" | Where-Object { $_.DisplayName -notlike "*POP3*" -and $_.DisplayName -notlike "*IMAP4*" } | Start-Service
   ```
