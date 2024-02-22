---
title: Troubleshoot ActiveSync with Exchange Server
description: Resolves ActiveSync issues with Exchange Server.
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Server
search.appverid: MET150
---
# Troubleshoot ActiveSync with Exchange Server

_Original KB number:_ &nbsp; 10047

**Who is it for?**

Administrators who help diagnose ActiveSync issues for their users.

**How does it work?**

We'll begin by asking you the issue you are facing. Then we'll take you through a series of troubleshooting steps that are specific to your situation.

**Estimated time of completion:**

60-90 minutes.

## What is the issue you are facing

> [!NOTE]
> Reference [this article](https://support.microsoft.com/help/2563324) for a list of current known issues.

- [Unable to create a profile on the device](#exchange-remote-connectivity-analyzer-cant-create-a-profile-on-the-device)
- [Unable to connect to the server](#determine-impact)
- [Mail issues](#mail-issues)
- [Calendaring issues](#calendaring-issues)
- [Delays on device/CAS performance](#check-for-file-level-anti-virus-delays-on-devicecas-performance)

### Exchange Remote Connectivity Analyzer (can't create a profile on the device)

Verify that Autodiscover is working for Microsoft Exchange ActiveSync. To do this, follow these steps:

1. Browse to the [Microsoft Remote Connectivity Analyzer](https://testconnectivity.microsoft.com/tests/o365) site.
2. Select **Exchange ActiveSync Autodiscover** from the **Microsoft Exchange ActiveSync Connectivity Tests** and select **Next**.
3. Enter all the required fields and select **Perform Test**.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/enter-required-fields.png" alt-text="Screenshot to enter all the required fields in the Remote Connectivity Analyzer window." lightbox="media/troubleshoot-activesync-with-exchange-server/enter-required-fields.png":::

**Did the Connectivity Test fail?**

- If yes, see [Analyze Exchange Remote Connectivity Analyzer Results](#analyze-exchange-remote-connectivity-analyzer-results-if-connectivity-test-fails).
- If no, see [User Principal Name Check](#user-principal-name-check).

### Analyze Exchange Remote Connectivity Analyzer results (if connectivity test fails)

To resolve this issue, review the results of the test and address any found issues. To do this, follow these steps:

1. Select **Expand All**.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/connectivity-test-fails-error.png" alt-text="Screenshot of the Expand All option in the Remote Connectivity Analyzer window.":::

2. Locate the error within the results (should be near the end) and address the issue.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/additional-details.png" alt-text="Screenshot shows the additional details of the Connectivity test fails error." lightbox="media/troubleshoot-activesync-with-exchange-server/additional-details.png":::

**Was the issue resolved using the results of the Exchange Remote Connectivity Analyzer results?**

- If yes, congratulations, your ActiveSync issue is resolved.
- If no, see [User Principal Name Check](#user-principal-name-check).

### User principal name check

Most Exchange ActiveSync devices request the email address and password to set up the device. This combination only works when the user principal name value matches the email address for the user. Verify these two attributes have the same value. To do this, follow these steps:

1. Open the [Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell).
2. Run the following cmdlet to retrieve the attribute values:

    ```powershell
    Get-Mailbox user | fl UserPrincipalName,PrimarySmtpAddress
    ```

    :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/get-mailbox-example.png" alt-text="Screenshot shows an example of running the Get-Mailbox cmdlet.":::

**Does the UserPrincipalName match the PrimarySmtpAddress for the user?**

- If yes, see [Policy error](#policy-error).
- If no, see [Domain suffix check](#domain-suffix-check).

### Domain suffix check

Verify that the appropriate domain suffix is available for the UserPrincipalName attribute. To do this, follow these steps:

1. Open **Active Directory Users and Computers**.
2. Locate the user object and double-click to view the properties.
3. Go to the **Account** tab and select the drop-down list for the **User logon name**.

    :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/user-logon-name-account.png" alt-text="Screenshot of the drop-down list for the User logon name section under the Account tab." border="false":::

**Is the SMTP address domain listed in drop-down?**

- If yes, see [Modify the User Principal Name](#modify-the-user-principal-name).
- If no, see [Add UPN suffix; Modify the User Principal Name](#add-upn-suffix-modify-the-user-principal-name).

### Add UPN suffix; Modify the User Principal Name

#### Add UPN suffix

To resolve this issue, you will need to add the primary SMTP address domain to the UPN suffix list. To do this, follow these steps:

1. Open **Active Directory Domains and Trusts**.
2. Right-click on **Active Directory Domains and Trusts** and select **Properties**.
3. Enter the primary SMTP address domain and select **Add** and then select **OK**.

    :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/upn-suffixes.png" alt-text="Screenshot of the U P N Suffixes tab in the Active Directory Domains and Trusts window." border="false":::

#### Modify User Principal Name

To resolve this issue, modify the UserPrincipalName attribute for the user. To do this, follow these steps:

1. Open the [Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell).
2. Run the following cmdlet to modify the UserPrincipalName:

    ```powershell
    Set-Mailbox user -UserPrincipalName user@fabrikam.com
    ```

**Did modifying the UserPrincipalName resolve the issue?**

- If yes, congratulations, your ActiveSync issue is resolved.
- If no, see [Policy error](#policy-error).

### Modify the User Principal Name

To resolve this issue, modify the UserPrincipalName attribute for the user. To do this, follow these steps:

1. Open the [Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell).
2. Run the following cmdlet to modify the UserPrincipalName:

    ```powershell
    Set-Mailbox user -UserPrincipalName user@fabrikam.com
    ```

**Did modifying the UserPrincipalName resolve the issue?**

- If yes, congratulations, your ActiveSync issue is resolved.
- If no, see [Policy error](#policy-error).

### Policy error

Exchange ActiveSync includes the use of ActiveSync mailbox policies. The available device settings are dependent on each device and not all settings work with all devices. To determine if the ActiveSync mailbox policy is an issue, create a new ActiveSync mailbox policy and assign it to the user. To do this, follow these steps:

1. Open the [Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell).
2. Run the following cmdlet to create a new ActiveSync mailbox policy:

    ```powershell
    New-ActiveSyncMailboxPolicy -Name "Test ActiveSync Policy"
    ```

3. Run the following cmdlet to assign this new policy to the mailbox:

    ```powershell
    Set-CASMailbox user -ActiveSyncMailboxPolicy "Test ActiveSync Policy"
    ```

**Did creating a new ActiveSync mailbox policy resolve the issue?**

- If yes, congratulations, your ActiveSync issue is resolved.
- If no, sorry, we cannot resolve the issue by using this guide. For more help resolving this issue contact [Microsoft Support](https://support.microsoft.com/). Please have all of the data collected from this troubleshooting available when you contact support.

### Determine impact

You must identify the impact in your environment before you begin to troubleshoot this issue.

How many users are unable to connect to Exchange ActiveSync?

- If One or more users, see [Check Active Directory permissions](#check-active-directory-permissions).
- If Entire site or organization, see [Exchange Remote Connectivity Analyzer](#exchange-remote-connectivity-analyzer).

### Check Active Directory permissions

Verify the user object permissions are not preventing connectivity issues. To do this, follow these steps:

1. Open **Active Directory Users and Computers**.
2. Go to the **View** menu and select **Advanced Features**.
3. Locate the user object and double-click to view the properties.
4. Go to the **Security** tab and select the **Advanced** button.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/advanced-security-settings-for-mailbox.png" alt-text="Screenshot of the Advanced Security Settings for Mailbox window.":::

Is the **Include inheritable permissions from this object's parent** enabled?

- If yes, see [Enable ActiveSync Mailbox Logging; Capture Fiddler Trace; Analyze ActiveSync Mailbox Log](#enable-activesync-mailbox-logging-capture-fiddler-trace-analyze-activesync-mailbox-log).
- If no, see [Update Active Directory Permissions](#update-active-directory-permissions).

### Update Active Directory permissions

To resolve this issue, modify the user object permissions to inherit permissions from the object's parent. To do this, follow these steps:

1. Open **Active Directory Users and Computers**.
2. Go to the **View** menu and select **Advanced Features**.
3. Locate the user object and double-click to view the properties.
4. Go to the **Security** tab and select the **Advanced** button.
5. Enable the **Include inheritable permissions from this object's parent** and select **OK** twice.

    :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/advanced-security-settings-for-mailbox.png" alt-text="Screenshot to enable the Include inheritable permissions from this object's parent option.":::

**Did modifying the user object's permissions resolve the issue?**

- If yes, congratulations, your ActiveSync issue is resolved.
- If no, [Enable ActiveSync Mailbox logging; Capture Fiddler trace; Analyze ActiveSync Mailbox Log](#enable-activesync-mailbox-logging-capture-fiddler-trace-analyze-activesync-mailbox-log).

### Enable ActiveSync mailbox logging; Capture fiddler trace; Analyze ActiveSync mailbox Log

#### Enable ActiveSync mailbox logging

You need to enable ActiveSync mailbox logging on the Client Access Server and the mailbox to collect more detailed logging. Additional information on mailbox logging can be found [here](/archive/blogs/jasonsla/exchange-activesync-mailbox-logging). To do this, follow these steps: 

> [!NOTE]
> This change should be made on Exchange 2013 mailbox servers.

1. Open Windows Explorer and browse to the Sync folder (C:\Program Files\Microsoft\Exchange Server\V14\ClientAccess\Sync).
2. Make a copy of the web.config file.
3. Open the web.config file in Notepad and modify the following sections with the values below:

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/open-web-config-file-in-notepad.png" alt-text="Screenshot to modify the web.config file in Notepad.":::

4. Open [IIS Manager](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc770472(v=ws.10)).
5. Expand the server and select **Application Pools**.
6. Right-click on the **MSExchangeSyncAppPool** and select **Stop**.
7. Right-click on the **MSExchangeSyncAppPool** and select **Start**.
8. Open the [Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell).
9. Run the following cmdlet to enable the mailbox logging for a user:

    ```powershell
    Set-CASMailbox user -ActiveSyncDebugLogging:$True
    ```

#### Capture fiddler trace

ActiveSync device requests do not always reach the destination as desired. To ensure the device request and response is being sent and received as expected, route the device through an HTTP proxy and review the data. To do this, follow these steps:

1. Download and install [Fiddler](https://www.telerik.com/download/fiddler) onto a workstation.
2. Download [EAS Inspector for Fiddler](https://archive.codeplex.com/?p=easinspectorforfiddler).
3. Extract **EASInspectorFiddler.dll** into the **c:\Program Files\Fiddler2\Inspectors** folder.
4. Launch the Fiddler application.
5. Select the **Tools** menu and select **Fiddler Options**.
6. Go to the **HTTPS** tab and select **Decrypt HTTPS traffic**, select **Yes** to all prompts.
7. Go to the Connections tab and select **Allow remote computers to connect**, select **OK** to any prompt.
8. Select **OK** and close the Fiddler application.
9. Configure the ActiveSync device to use this workstation as a proxy server(This is typically done under the WiFi settings for the device).
10. Launch the Fiddler application.
11. Attempt to **send** one or more messages from the ActiveSync client.
12. Select the **File** menu and select **Capture Traffic** to stop the trace.

#### Analyze ActiveSync mailbox Log

We now have the data collected and we are ready to begin troubleshooting. The first step we will take is to look at the mailbox log and check if the item was captured. To do this, follow these steps:

1. Open the [Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell).
2. Run the following cmdlet to retrieve the mailbox log for a user:

    ```powershell
    Get-ActiveSyncDeviceStatistics -Mailbox user -GetMailboxLog:$True -NotificationEmailAddresses admin@contoso.com
    ```

    > [!NOTE]
    > This will send the ActiveSync mailbox log to the specified email address for analysis. Additional information on mailbox logging can be found [here](/archive/blogs/jasonsla/exchange-activesync-mailbox-logging).

3. Download [MailboxLogParser](https://github.com/search?q=MailboxLogParser) and extract the files.
4. Launch the utility by opening **MailboxLogParser.exe**.
5. Select **Import Mailbox Logs to Grid** to open the mailbox log.
6. Enter **SendMail** under **Search raw log data for strings** and select **Search**.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/search-send-mail.png" alt-text="Screenshot to enter SendMail under the Search raw log data for strings section and select the Search option.":::

**Do you see the SendMail command in the log?**

- If yes, see [SendMail status code check](#sendmail-status-code-check-if-you-see-sendmail-logged).
- If no, see [Fiddler Trace Analysis](#fiddler-trace-analysis).

### SendMail status code check (if you see SendMail logged)

The following is an example search result from an ActiveSync mailbox log:

:::image type="content" source="media/troubleshoot-activesync-with-exchange-server/example-search-result.png" alt-text="Screenshot of an example search result in the ActiveSync mailbox log.":::

**What status code value do you see for the SendMail command in your log?**

- If 120 or 129, see [Exchange ActiveSync organization settings](#exchange-activesync-organization-settings-if-status-code-is-120-or-129).
- If None or other, see [Fiddler Trace Analysis](#fiddler-trace-analysis).

### Exchange ActiveSync organization settings (if status code is 120 or 129)

> [!NOTE]
> This feature is not available in Exchange 2007. If your organization is running Exchange 2007, click "I'm running Exchange 2007" at the end of the page. The Exchange ActiveSync organization settings allow administrators the ability to set the default access level for ActiveSync devices. These default settings include **Block**, **Quarantine**, and **Allow**. Check the current organization settings to determine the current default access level in the environment. To do this, follow these steps:

1. Open the [Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell).
2. Run the following cmdlet to determine the current organization settings:

    ```powershell
    Get-ActiveSyncOrganizationSettings | ft DefaultAccessLevel
    ```

    :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/get-active-sync-organization-settings.png" alt-text="Screenshot shows an example of running the Get-ActiveSyncOrganizationSettings cmdlet.":::

**Is the default access level set to Allow?**

- [The default access level is set to Allow](#exchange-activesync-device-access-rules)
- [The default access level isn't set to Allow](#modify-exchange-activesync-organization-settings)
- [I'm running Exchange 2007](#mailbox-blocked-device-id)

### Modify Exchange ActiveSync organization settings

To resolve this issue, modify the ActiveSync organization settings. To do this, follow these steps:

1. Open the Exchange Management Shell.
2. Run the following cmdlet to determine the current organization settings:

    ```powershell
    Set-ActiveSyncOrganizationSettings -DefaultAccessLevel Allow
    ```

**Did changing the DefaultAccessLevel setting for the ActiveSync organization settings resolve the issue?**

- If yes, congratulations, your ActiveSync issue is resolved.
- If no, see [Exchange ActiveSync Device Access Rules](#exchange-activesync-device-access-rules).

### Exchange ActiveSync device access rules

The Exchange ActiveSync device access rules allow an administrator to create access groups based on device characteristics. Check the current configuration for any device access rules that would allow the device to connect. To do this, follow these steps:

1. Open the Exchange Management Shell.
2. Run the following cmdlet to find any device access rules with the access level set to Allow:

    ```powershell
    Get-ActiveSyncDeviceAccessRule | Where { $_.AccessLevel -eq "Allow" }
    ```

    :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/get-active-sync-device-access-rule.png" alt-text="Screenshot shows an example of running the Get-ActiveSyncDeviceAccessRule cmdlet.":::

**Are there any device access rules that match the user's device with the access level set to Block or Quarantine?**

- If yes, see [Modify ActiveSync device access rules](#modify-activesync-device-access-rules-if-match)
- If no, see [Mailbox blocked device ID](#mailbox-blocked-device-id).

### Modify ActiveSync device access rules (if match)

There are two ways to resolve this issue. The first method is to remove the device access rule. To do this, follow these steps:

1. Open the [Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell).
2. Run the following cmdlet to create a device access rule:

    ```powershell
    Remove-ActiveSyncDeviceAccessRule 'WindowsMail (DeviceType)'
    ```

    :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/remove-active-sync-device-access-rule.png" alt-text="Screenshot shows an example of running the Remove-ActiveSyncDeviceAccessRule cmdlet.":::

The second way is to modify the AccessLevel for the existing device access rule. To do this, follow these steps:

1. Open the [Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell).
2. Run the following cmdlet to modify the access level:

    ```powershell
    Set-ActiveSyncDeviceAccessRule 'WindowsMail (DeviceType)' -AccessLevel Allow
    ```

    :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/set-active-sync-device-access-rule.png" alt-text="Screenshot shows an example of running the Set-ActiveSyncDeviceAccessRule cmdlet.":::

**Did updating the device access rules in your organization resolve the issue?**

- If yes, congratulations, your ActiveSync issue is resolved.
- If no, see [Mailbox blocked device ID](#mailbox-blocked-device-id).

### Mailbox blocked device ID

An administrator can configure a list of devices that are not allowed to synchronize with the mailbox. Check the user configuration to determine if the device has been blocked from synchronizing. To do this, follow these steps:

1. Open the [Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell).
2. Run the following cmdlet to find any devices that are not allowed to synchronize:

    ```powershell
    Get-CASMailbox user | fl ActiveSyncBlockedDeviceIDs
    ```

    :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/get-cas-mailbox.png" alt-text="Screenshot shows an example of running the Get-CASMailbox cmdlet.":::

**Is the user's device blocked from synchronizing with the user's mailbox?**

- If yes, see [Modify mailbox settings](#modify-mailbox-settings).
- If no, see [Fiddler Trace Analysis](#fiddler-trace-analysis).

### Modify mailbox settings

To resolve this issue, remove the device ID from the block list for the mailbox. To do this, follow these steps:

1. Open the [Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell).
2. Run the following cmdlet to find any devices that are not allowed to synchronize:

    ```powershell
    Set-CASMailbox user -ActiveSyncBlockedDeviceIDs $null
    ```

For more information, see [Set-CASMailbox](/powershell/module/exchange/set-casmailbox) to see additional information on this cmdlet and available options.

**Did removing this device ID from the block list for the mailbox resolve the issue?**

- If yes, congratulations, your ActiveSync issue is resolved.
- If no, see [Fiddler trace analysis](#fiddler-trace-analysis).

### Fiddler trace analysis

You attempted to send a message from the device so you should see the request in the Fiddler trace. You can use the Fiddler trace to see the request sent by the client and the response from the server. To do this, follow these steps:

1. Open the Fiddler trace.
2. Go to the Edit menu and select Find Sessions.
3. Enter **ActiveSync** and select Find Sessions.
4. Review the Result column for any HTTP response values that do not equal 200.
5. Select requests where the **Body** column has a value.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/requsets-body-column-value.png" alt-text="Screenshot of the requests where the Body column has a value.":::

6. Select the TextView tab to view the response for additional details.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/text-view-tab.png" alt-text="Screenshot of the TextView tab, which shows the response for additional details.":::

**Were there any HTTP errors found in the Fiddler trace?**

- If yes, see [Install Log Parser Studio; Log Parser Studio Query – SendMail; Query Results Analysis](#install-log-parser-studio-log-parser-studio-query---sendmail-query-results-analysis).
- If no, see [SendMail Status Code Check](#sendmail-status-code-check).

### SendMail status code check

You did not find any HTTP errors, so you should find a status code for the ActiveSync response. You can use the Fiddler trace locate these responses. To do this, follow these steps:

1. Open the Fiddler trace.
2. Go to the Edit menu and select Find Sessions.
3. Enter **ActiveSync** and select Find Sessions.
4. Review the **Body** column and look for small values.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/small-values-in-body-column.png" alt-text="Screenshot of the small values shown in the Body column.":::

5. View the EAS XML tab for the request from the device and response received

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/eas-xml-tabs.png" alt-text="Screenshot to view the E A S X M L tab for the request from the device and response received.":::

**What status code do you see in the response window?**

- [126](#activesync-enabled-mailbox)
- [Other](#exchange-activesync-protocol-document-review)

### Install Log Parser Studio; Log Parser Studio Query - SendMail; Query results analysis

#### Install Log Parser Studio

The ActiveSync client may have encountered errors while attempting to communicate with the Exchange server. Now we need to determine where these errors originated. We will start by checking the IIS logs on the Client Access Server. Before these logs can be analyzed, the workstation where the analysis will be completed should have Log Parser Studio installed. To do this, follow these steps:

1. Download and install [LogParser](https://www.microsoft.com/download/details.aspx?id=24659).

   - Double-click the **LogParser.msi** to begin the installation.
   - Select **Run** if the **Open File - Security Warning** is displayed.
   - On the Welcome screen, select **Next**.
   - On the End-User license agreement screen, review and accept the license agreement, and select **Next**.
   - On the Choose Setup Type screen, select **Complete**.
   - On the Ready to Install screen, select **Install**.
   - On the Completion screen, select **Finish**.

2. Download [Log Parser Studio](https://gallery.technet.microsoft.com/Log-Parser-Studio-cd458765) and extract the files.

Once LogParser is installed and Log Parser Studio has been extracted, copy the IIS logs from the Exchange server(s) to the local workstation for analysis.

#### Log Parser Studio Query – SendMail

To determine if any of these ActiveSync requests are resulting in an error, query the IIS logs for the device traffic. To do this, follow these steps:

1. Launch Log Parser Studio by double-clicking LPS.exe.
2. Select the Log folder icon to select files to process.

   :::image type="icon" source="media/troubleshoot-activesync-with-exchange-server/log-folder-icon.png":::

3. Select the **Add Files** or **Add Folder** button, then locate and select the file(s) copied earlier.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/log-file-manager.png" alt-text="Screenshot of the Log File Manager window in the SendMail section.":::

4. Verify the file/folder is selected and select OK.
5. Double-click **ActiveSync: SendMail** from the Library.
6. Select the exclamation point icon to execute the query.

   :::image type="icon" source="media/troubleshoot-activesync-with-exchange-server/exclamation-point-icon.png":::

7. Analyze the results for this query by reviewing the Status, Error, ABQ, and sc-status columns.

#### Query results analysis

The following example shows the results from the previous query:

:::image type="content" source="media/troubleshoot-activesync-with-exchange-server/query-results-analysis.png" alt-text="Screenshot of the query results analysis example.":::

You need to review the results from your query for any issues. To do this, follow these steps:

1. Review the **Status** column and locate any request where there is a value. Use the [Exchange ActiveSync protocol document](/openspecs/exchange_server_protocols/ms-ascmd/95cb9d7c-d33d-4b94-9366-d59911c7a060) to investigate these values and if any corrective action can be taken.

2. Review the **Error** column and locate any request where there is a value in this column. Many of these error messages are self-explanatory and corrective action can be taken accordingly.

3. Review the **sc-status** column and locate any request where there is a value other than 200. This is the HTTP status response from IIS and additional information can be found in [The HTTP status code in IIS 7 and later versions](https://support.microsoft.com/help/943891).

**Were you able to resolve the issue after analyzing the IIS logs?**

- If yes, congratulations, your ActiveSync issue is resolved.
- If no, sorry, we cannot resolve the issue by using this guide. For more help resolving this issue contact [Microsoft Support](https://support.microsoft.com/). Please have all of the data collected from this troubleshooting available when you contact support.

### Exchange Remote Connectivity Analyzer

To determine if the user can successfully connect to Exchange, run the Exchange Remote Connectivity Analyzer with the user account. To do this, follow these steps:

1. Browse to the [Microsoft Remote Connectivity Analyzer](https://testconnectivity.microsoft.com/tests/o365) site.

1. Select **Exchange ActiveSync** from the **Microsoft Exchange ActiveSync Connectivity Tests** and select **Next**.
1. Enter all the required fields and select **Perform Test**.

    :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/required-fields.png" alt-text="Screenshot to enter all the required fields in the Microsoft Remote Connectivity Analyzer window." lightbox="media/troubleshoot-activesync-with-exchange-server/required-fields.png":::

    > [!NOTE]
    > If needed, manually specify the server settings to bypass the Autodiscover user settings request.

**Did the Exchange Remote Connectivity Analyzer test fail?**

- If yes, see [Analyze Exchange Remote Connectivity Analyzer Results](#analyze-exchange-remote-connectivity-analyzer-results).
- If no, see [Exchange ActiveSync Organization settings](#exchange-activesync-organization-settings).

### Analyze Exchange Remote Connectivity Analyzer results

To resolve this issue, review the results of the test and address any found issues. To do this, follow these steps:

1. Select **Expand All**.

    :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/connectivity-test-fails-error.png" alt-text="Screenshot of the Expand All option in the Microsoft Remote Connectivity Analyzer window.":::

2. Locate the error within the results (should be near the end) and address the issue

    :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/error-addition-details.png" alt-text="Screenshot shows the details of the Connectivity test fails error.":::

**Was the issue resolved using the results of the Exchange Remote Connectivity Analyzer results?**

- If yes, Congratulations, your ActiveSync issue is resolved.
- If no, see [Check for File Level Anti-Virus](#check-for-file-level-anti-virus).

### Exchange ActiveSync application pool

Verify that the MSExchangeSyncAppPool is started and that it is running under the LocalSystem. To do this, follow these steps:

1. [Open IIS Manager](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc770472(v=ws.10)).
2. Expand the server and select Application Pools.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/application-pools.png" alt-text="Screenshot shows that the status of MSExchangeSyncAppPool is Started in the Application Pools window.":::

**Is the MSExchangeSyncAppPool started using the LocalSystem account?**

- If yes, see [ActiveSync Virtual Directory authentication settings](#activesync-virtual-directory-authentication-settings).
- If no, see [Modify MSExchangeSyncAppPool](#modify-msexchangesyncapppool).

### Modify MSExchangeSyncAppPool

To resolve this issue, modify the MSExchangeSyncAppPool to use the LocalSystem account. To do this, follow these steps:

1. [Open IIS Manager](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc770472(v=ws.10)).
2. Expand the server and select **Application Pools**.
3. Right-click on the **MSExchangeSyncAppPool** and select **Advanced Settings**.
4. Modify the Identity value by select **LocalSystem**.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/local-system.png" alt-text="Screenshot to modify the Identity value by selecting the LocalSystem item.":::

5. Right-click on the **MSExchangeSyncAppPool** and select **Stop**.
6. Right-click on the **MSExchangeSyncAppPool** and select **Start**.

**Did updating the MSExchangeSyncAppPool resolve the issue?**

- If yes, congratulations, your ActiveSync issue is resolved.
- If no, see [ActiveSync Virtual Directory Authentication Settings](#activesync-virtual-directory-authentication-settings).

### ActiveSync Virtual Directory authentication settings

Verify the authentication settings on the ActiveSync virtual directory. To do this, follow these steps:

1. Open the [Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell).
2. Run the following cmdlet to check the virtual directory settings:

    ```powershell
    Get-ActiveSyncVirtualDirectory | ft server,basic*
    ```

**Is the ActiveSync virtual directory configured to use Basic authentication?**

- If yes, see [ActiveSync default domain](#activesync-default-domain).
- If no, see [Modify ActiveSync Virtual Directory Authentication Settings](#modify-activesync-virtual-directory-authentication-settings).

### Modify ActiveSync Virtual Directory Authentication settings

To resolve this issue, configure the ActiveSync virtual directory to use basic authentication. To do this, follow these steps:

1. [Open IIS Manager](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc770472(v=ws.10)).
2. Run the following cmdlet to enable basic authentication on the virtual directory:

    ```powershell
    Set-ActiveSyncVirtualDirectory ServerName\Microsoft* -BasicAuthEnabled:$True
    ```

**Did enabling basic authentication for the ActiveSync virtual directory resolve the issue?**

- If yes, congratulations, your ActiveSync issue is resolved.
- If no, see [ActiveSync Default Domain](#activesync-default-domain).

### ActiveSync default domain

Some devices send only the username value for the credentials, which will cause an authentication failure. Verify that the default domain value is configured on the ActiveSync virtual directory. To do this, follow these steps:

1. [Open IIS Manager](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc770472(v=ws.10)).
2. Expand the server, expand **Sites**, expand the **Default Web Site**, and select **Microsoft-Server-ActiveSync**.
3. In **Features View**, double-click **Authentication**.
4. Select **Basic authentication**, and select **Edit** in the **Actions** pane.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/edit-basic-authentication-settings.png" alt-text="Screenshot of the Edit Basic Authentication Settings window.":::

**Is there a value present in the Default domain field?**

- If yes, see [ActiveSync Virtual Directory SSL settings](#activesync-virtual-directory-ssl-settings).
- If no, see [Add default domain for ActiveSync Virtual Directory](#add-default-domain-for-activesync-virtual-directory).

### Add default domain for ActiveSync Virtual Directory

To resolve this issue, configure a default domain for the ActiveSync virtual directory. To do this, follow these steps:

1. [Open IIS Manager](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc770472(v=ws.10)).
2. Expand the server, expand **Sites**, expand the **Default Web Site**, and select **Microsoft-Server-ActiveSync**.
3. In **Features View**, double-click **Authentication**.
4. Select **Basic authentication**, and select **Edit** in the **Actions** pane.
5. Enter a value for the **Default domain** and select **OK**.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/enter-value-default-domain.png" alt-text="Screenshot to enter a value in the Default domain box.":::

**Did enabling a default domain for the ActiveSync virtual directory resolve the issue?**

- If yes, congratulations, your ActiveSync issue is resolved.
- If no, see [ActiveSync Virtual Directory SSL Settings](#activesync-virtual-directory-ssl-settings).

### ActiveSync Virtual Directory SSL settings

Verify that the ActiveSync virtual directory is not configured to require client certificates. To do this, follow these steps:

1. [Open IIS Manager](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc770472(v=ws.10)).
2. Expand the server, expand **Sites**, expand the **Default Web Site**, and select **Microsoft-Server-ActiveSync**.
3. In **Features View**, double-click **SSL Settings**.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/ssl-settings.png" alt-text="Screenshot of the S S L Settings page in the I I S Manager window.":::

**Is the SSL Setting for Client certificates set to Ignore?**

- If yes, see [ActiveSync Virtual Directory HTTP Redirect](#activesync-virtual-directory-http-redirect).
- If no, see [Modify ActiveSync Virtual Directory SSL settings](#modify-activesync-virtual-directory-ssl-settings).

### Modify ActiveSync Virtual Directory SSL settings

To resolve this issue, set the client certificates setting to Ignore. To do this, follow these steps:

1. [Open IIS Manager](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc770472(v=ws.10)).
2. Expand the server, expand **Sites**, expand the **Default Web Site**, and select **Microsoft-Server-ActiveSync**.
3. In **Features View**, double-click **SSL Settings**.
4. Under **Client certificates**, select **Ignore**

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/ssl-settings-ignore.png" alt-text="Screenshot of the S S L Settings page with the Ignore option selected.":::

**Did changing the SSL setting for Client certificates to Ignore resolve the issue?**

- If yes, congratulations, your ActiveSync issue is resolved.
- If no, see [ActiveSync Virtual Directory HTTP redirect](#activesync-virtual-directory-http-redirect).

### ActiveSync Virtual Directory HTTP redirect

When an HTTP redirect is configured in IIS 7, the redirect setting is inherited by all virtual directories underneath that web site. Check the ActiveSync virtual directory for an HTTP redirect. To do this, follow these steps:

1. [Open IIS Manager](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc770472(v=ws.10)).
2. Expand the server, expand **Sites**, expand the **Default Web Site**, and select **Microsoft-Server-ActiveSync**.
3. In **Features View**, double-click **HTTP Redirect**.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/http-redirect.png" alt-text="Screenshot of the H T T P Redirect page in the I I S Manager window.":::

**Is a redirect configured for the ActiveSync virtual directory?**

- If yes, see [Modify ActiveSync Virtual Directory HTTP redirect](#modify-activesync-virtual-directory-http-redirect).
- If no, see [Install Log Parser Studio; Log Parser Studio Query - Count Syncs with SyncKey of Zero Per User](#install-log-parser-studio-log-parser-studio-query---count-syncs-with-synckey-of-zero-per-user).

### Modify ActiveSync Virtual Directory HTTP redirect

To resolve this issue, remove the HTTP redirect from the ActiveSync virtual directory. To do this, follow these steps:

1. [Open IIS Manager](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc770472(v=ws.10)).
2. Expand the server, expand **Sites**, expand the **Default Web Site**, and select **Microsoft-Server-ActiveSync**.
3. In **Features View**, double-click **HTTP Redirect**.
4. Clear the check box for **Redirect requests to this destination**.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/redirect-requests-to-this-destination.png" alt-text="Screenshot to clear the Redirect requests to this destination check box.":::

**Did removing the HTTP redirect from the ActiveSync virtual directory resolve the issue?**

- If yes, congratulations, your ActiveSync issue is resolved.
- If no, see [Install Log Parser Studio; Log Parser Studio Query - Count Syncs with SyncKey of Zero Per User](#install-log-parser-studio-log-parser-studio-query---count-syncs-with-synckey-of-zero-per-user).

### ActiveSync enabled mailbox

Verify the mailbox is enabled for ActiveSync. To do this, follow these steps:

1. Open the [Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell).
2. Run the following cmdlet to check the mailbox settings:

    ```powershell
    Get-CASMailbox user | fl ActiveSyncEnabled
    ```

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/get-cas-mailbox-cmdlet.png" alt-text="Screenshot shows the example of running the Get-CASMailbox cmdlet.":::

**Is the user enabled for ActiveSync?**

- If yes, see [Install Log Parser Studio; Log Parser Studio Query – SendMail; Query Results Analysis](#install-log-parser-studio-log-parser-studio-query---sendmail-query-results-analysis).
- If no, [Enable User for ActiveSync](#enable-user-for-activesync).

### Enable user for ActiveSync

To resolve this issue, enable the user for ActiveSync. To do this, follow these steps:

1. Open the [Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell).
2. Run the following cmdlet to enable the mailbox for ActiveSync:

    ```powershell
    Set-CASMailbox user -ActiveSyncEnabled:$True
    ```

    :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/set-cas-mailbox.png" alt-text="Screenshot shows an example of running the Set-CASMailbox cmdlet.":::

**Did enabling the mailbox for ActiveSync resolve the issue?**

- If yes, congratulations, your ActiveSync issue is resolved.
- If no, see [Install Log Parser Studio; Log Parser Studio Query – SendMail; Query Results Analysis](#install-log-parser-studio-log-parser-studio-query---sendmail-query-results-analysis).

### Exchange ActiveSync protocol document review

Your SendMail command received an unexpected status code response from Exchange. To understand what error was encountered, you must review the Exchange ActiveSync Command Reference Protocol document to troubleshoot the issue.

Were you able to resolve the issue by reviewing the status code in the response?

- If yes, congratulations, your ActiveSync issue is resolved.
- If no, sorry, we cannot resolve the issue by using this guide. For more help resolving this issue contact [Microsoft Support](https://support.microsoft.com/). Please have all of the data collected from this troubleshooting available when you contact support.

### Exchange ActiveSync organization settings

> [!NOTE]
> This feature is not available in Exchange 2007. If your organization is running Exchange 2007, select **I'm running Exchange 2007** at the end of this section.

The Exchange ActiveSync organization settings allow administrators the ability to set the default access level for ActiveSync devices. These default settings include **Block**, **Quarantine**, and **Allow**. Check the current organization settings to determine the current default access level in the environment. To do this, follow these steps:

1. Open the [Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell).
2. Run the following cmdlet to determine the current organization settings:

    ```powershell
    Get-ActiveSyncOrganizationSettings | ft DefaultAccessLevel
    ```

    :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/get-active-sync-organization-settings.png" alt-text="Screenshot shows the example of running the Set-ActiveSyncOrganizationSettings cmdlet.":::

**Is the default access level set to Allow?**

- [The default access level is set to Allow](#exchange-activesync-device-access-rules).
- [The default access level isn't set to Allow](#modify-activesync-organization-settings).
- [I'm running Exchange 2007](#mailbox-blocked-device-id).

### Modify ActiveSync organization settings

To resolve this issue, modify the ActiveSync organization settings. To do this, follow these steps:

1. Open the [Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell).
2. Run the following cmdlet to determine the current organization settings:

    ```powershell
    Set-ActiveSyncOrganizationSettings -DefaultAccessLevel Allow
    ```

**Did changing the DefaultAccessLevel setting for the ActiveSync organization settings resolve the issue?**

- If yes, congratulations, your ActiveSync issue is resolved.
- If no, see [Exchange ActiveSync Device Access rules](#exchange-activesync-device-access-rules).

### Install Log Parser Studio; Log Parser Studio Query - Count Syncs with SyncKey of Zero Per User

#### Install Log Parser Studio

The ActiveSync client may have encountered errors while attempting to communicate with the Exchange server. Now we need to determine where these errors originated. We will start by checking the IIS logs on the Client Access Server. Before these logs can be analyzed, the workstation where the analysis will be completed should have Log Parser Studio installed. To do this, follow these steps:

1. Download and install [LogParser](https://www.microsoft.com/download/details.aspx?id=24659).

   - Double-click the **LogParser.msi** to begin the installation.
   - Select **Run** if the **Open File - Security Warning** is displayed.
   - On the Welcome screen, select **Next**.
   - On the End-User license agreement screen, review and accept the license agreement, and select **Next**.
   - On the Choose Setup Type screen, select **Complete**.
   - On the Ready to Install screen, select **Install**.
   - On the Completion screen, select **Finish**.

2. Download [Log Parser Studio](https://gallery.technet.microsoft.com/Log-Parser-Studio-cd458765) and extract the files.

Once LogParser is installed and Log Parser Studio has been extracted, copy the IIS logs from the Exchange server(s) to the local workstation for analysis.

#### Log Parser Studio Query – Count Syncs with SyncKey of Zero Per User

To determine if devices are resynchronizing with Exchange, run the Log Parser query to find the users. To do this, follow these steps:

1. Launch Log Parser Studio by double-clicking LPS.exe.
2. Select the Log folder icon to select files to process.

   :::image type="icon" source="media/troubleshoot-activesync-with-exchange-server/log-folder-icon.png":::

3. Select the Add Files or Add Folder button, then locate and select the file(s) copied earlier.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/log-file-manager.png" alt-text="Screenshot of the Log File Manager window in the Count Syncs with SyncKey of Zero Per User section.":::

4. Verify the file/folder is selected and select **OK**.
5. Double-click **ActiveSync: Count Syncs with SyncKey of Zero Per User** from the Library.
6. Select the exclamation point icon to execute the query.

   :::image type="icon" source="media/troubleshoot-activesync-with-exchange-server/exclamation-point-icon.png":::

7. Analyze the results for this query.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/query-results.png" alt-text="Screenshot to analyze the results for the query.":::

**Are there any devices with multiple requests using the SyncKey value of 0?**

- If yes, see [Log Parser Studio Query - Device Query](#log-parser-studio-query---device-query-if-using-synckey-value-of-0)
- If no, see [Log Parser Studio Query - Count all Syncs per SyncKey](#log-parser-studio-query---count-all-syncs-per-synckey).

### Check for file level anti-virus (delays on device/CAS performance)

In many cases file-level anti-virus impacts ActiveSync traffic by delaying the processing of the request or response. Stopping these services does not disable the kernel mode filter driver used by these services. To disable file level anti-virus follow the steps from [How to temporarily deactivate the kernel mode filter driver in Windows](https://support.microsoft.com/help/816071). Verify the kernel mode filter driver is no longer active after the Client Access Server has been restarted. To do this, follow these steps:

1. Open a command prompt.
2. Run the following command:

    ```console
    fltmc
    ```

3. Compare the results to the example filter drivers from [this article](https://support.microsoft.com/kb/816071) or search the web for the Filter Name.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/fltmc-output.png" alt-text="Screenshot shows the output of the fltmc command.":::

**Did disabling the anti-virus kernel mode filter driver resolve the issue?**

- If yes, congratulations, your ActiveSync issue is resolved.
- If no, see [Prepare for Data Analysis; Log Parser Studio Query - Count Syncs with SyncKey of Zero Per User](#prepare-for-data-analysis-log-parser-studio-query---count-syncs-with-synckey-of-zero-per-user).

### Mail issues

Select the type of mail issue that the ActiveSync client is experiencing.

- [Items are present on only Outlook or the ActiveSync client](#items-present-on-only-one-client).
- [Unable to open attachments](#install-log-parser-studio-locate-deviceid-for-user-log-parser-studio-query---device-query-query-results-analysis).
- [Unable to send a message](#unable-to-send-a-message).

### Items present on only one client

The reported issue is a message that appears in the mailbox within Outlook but not on the ActiveSync client or vice versa. Before we begin troubleshooting this issue, we need to know if the issue can be reproduced on the ActiveSync client. If we can reproduce the issue, then we can capture data during the process to get a better understanding of the issue. Otherwise we will need to examine existing logs to attempt to determine what happened.

**Can you reproduce the Calendar issue on the device?**

- If yes, see [Enable ActiveSync Mailbox Logging; Capture Fiddler Trace; Locate Item Using MfcMapi; Search for Item in Mailbox Log](#enable-activesync-mailbox-logging-capture-fiddler-trace-locate-item-using-mfcmapi-search-for-item-in-mailbox-log).
- If no, see [Install Log Parser Studio; Log Parser Studio Query - DeviceId Query; Query Results Analysis; Re-Sync the Folder](#install-log-parser-studio-log-parser-studio-query---deviceid-query-query-results-analysis-resync-the-folder).

### Install Log Parser Studio; Log Parser Studio Query - DeviceId Query; Query results analysis; Resync the Folder

#### Install Log Parser Studio

#### Log Parser Studio Query – DeviceId Query

To determine if any of these ActiveSync requests are resulting in an error, query the IIS logs for the device traffic. To do this, follow these steps:

1. Open the [Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell).
2. Run the following cmdlet to find any devices that are not allowed to synchronize:

    ```powershell
    Get-ActiveSyncDevice -Mailbox | fl DeviceId,DeviceType
    ```

3. Launch Log Parser Studio by double-clicking LPS.exe.
4. Select the Log folder icon to select files to process.

    :::image type="icon" source="media/troubleshoot-activesync-with-exchange-server/log-folder-icon.png":::
5. Select the **Add Files** or **Add Folder** button, then locate and select the file(s) copied earlier.

    :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/log-file-manager.png" alt-text="Screenshot of the Log File Manager window in the DeviceId Query section.":::
6. Verify the file/folder is selected and select **OK**.
7. Double-click ActiveSync: Device query from the Library.
8. Modify the `DeviceId` value in the WHERE clause at the end of the query with the value from step 2.
9. Select the exclamation point icon to execute the query.

    :::image type="icon" source="media/troubleshoot-activesync-with-exchange-server/exclamation-point-icon.png":::
10. Analyze the results for this query by reviewing the Error and sc-status columns.

    :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/error-and-sc-status-columns.png" alt-text="Screenshot to analyze the results of the Device query." lightbox="media/troubleshoot-activesync-with-exchange-server/error-and-sc-status-columns.png":::

#### Query results analysis

Now we want to review the results from your query for any issues. To do this, follow these steps:

1. Review the **Status** column and locate any request where there is a value. Use the [Exchange ActiveSync protocol document](/openspecs/exchange_server_protocols/ms-ascmd/95cb9d7c-d33d-4b94-9366-d59911c7a060) to investigate these values and if any corrective action can be taken.

2. Review the **Error** column and locate any request where there is a value in this column. Many of these error messages are self-explanatory and corrective action can be taken accordingly.

3. Review the **sc-status** column and locate any request where there is a value other than 200. This is the HTTP status response from IIS and additional information can be found in [The HTTP status code in IIS 7 and later versions](https://support.microsoft.com/help/943891).

Unfortunately the review of the IIS logs does not show us any identifier for the item in question. Your best effort will be locating a request within the IIS logs around the time the last item change occurred. You can also use the article [Understanding Exchange ActiveSync Reporting Services](/previous-versions/office/exchange-server-2010/bb201675(v=exchg.141)) to help you better understand some of the elements found with the IIS log entry.

#### Resync the folder

The previous steps taken help to identify why the issue occurred with the item. The ActiveSync client may still not have the item in the correct state. To resolve this issue, remove the folder from the list of folders to synchronize, wait approximately five minutes, and then add the folder to the list of folders to synchronize.

**Is the item in the correct state on the ActiveSync client?**

- If yes, congratulations, your ActiveSync issue is resolved.
- If no, sorry, we cannot resolve the issue by using this guide. For more help resolving this issue contact [Microsoft Support](https://support.microsoft.com/). Please have all of the data collected from this troubleshooting available when you contact support.

### Enable ActiveSync mailbox logging; Capture fiddler trace; Locate item using MfcMapi; Search for item in mailbox log

#### Enable ActiveSync mailbox logging

The first troubleshooting step is enabling mailbox logging on the Client Access Server and the mailbox. Additional information on mailbox logging can be found [Exchange ActiveSync Mailbox Logging](/archive/blogs/jasonsla/exchange-activesync-mailbox-logging). To do this, follow these steps:

> [!NOTE]
> This change should be made on Exchange 2013 mailbox servers.

1. Open Windows Explorer and browse to the Sync folder (C:\Program Files\Microsoft\Exchange Server\V14\ClientAccess\Sync).
2. Make a copy of the web.config file.
3. Open the web.config file in Notepad and modify the following sections with the values below:

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/open-web-config-file-in-notepad.png" alt-text="Screenshot to modify the values of the web.config file in Notepad.":::

4. [Open IIS Manager](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc770472(v=ws.10)).
5. Expand the server and select **Application Pools**.
6. Right-click on the **MSExchangeSyncAppPool** and select **Stop**.
7. Right-click on the **MSExchangeSyncAppPool** and select **Start**.
8. Open the [Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell).
9. Run the following cmdlet to enable the mailbox logging for a user:

    ```powershell
    Set-CASMailbox user -ActiveSyncDebugLogging:$True
    ```

#### Capture fiddler trace

ActiveSync device requests do not always reach the destination as desired. To ensure the device request and response is being sent and received as expected, route the device through an HTTP proxy and review the data. To do this, follow these steps:

1. Download and install [Fiddler](https://www.telerik.com/download/fiddler) onto a workstation.
2. Download [EAS Inspector for Fiddler](https://archive.codeplex.com/?p=easinspectorforfiddler).
3. Extract **EASInspectorFiddler.dll** into the **c:\Program Files\Fiddler2\Inspectors** folder.
4. Launch the Fiddler application.
5. Select the **Tools** menu and select **Fiddler Options**.
6. Go to the **HTTPS** tab and select **Decrypt HTTPS traffic**, select **Yes** to all prompts.
7. Go to the Connections tab and select **Allow remote computers to connect**, select **OK** to any prompt.
8. Select **OK** and close the Fiddler application.
9. Configure the ActiveSync device to use this workstation as a proxy server (This is typically done under the WiFi settings for the device).
10. Launch the Fiddler application.
11. Attempt to **send** one or more messages from the ActiveSync client.
12. Select the **File** menu and select **Capture Traffic** to stop the trace.

#### Locate item using MfcMapi

We need to determine the ConversationID for the item before we search the mailbox log. To do this, follow these steps:

1. Download and install [MfcMapi](https://github.com/stephenegriffin/mfcmapi/releases/).
2. Launch MfcMapi.
3. Go to the **Session** menu and select **Logon**.
4. Select the Outlook profile for the mailbox and select **OK**.
5. Double-click the mailbox to open.
6. Expand the **Root Container**, expand **Top of Information Store**, then right-click on the **Inbox** (or other folder where the item is located) and select **Open contents table**.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/open-contents-table.png" alt-text="Screenshot shows steps to select the Open contents table item.":::

7. Select the item within the table, right-click on the tag 0x00710102 and select **Edit property**.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/edit-property.png" alt-text="Screenshot shows steps to select the Edit property item.":::

8. Copy the **Binary** value.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/copy-the-binary-value.png" alt-text="Screenshot to copy the Binary value using the MfcMapi tool.":::

#### Search for item in mailbox log

We now have the data collected and we are ready to begin troubleshooting. The first step we will take is to look at the mailbox log and check if the item was captured.

To do this, follow these steps:

1. Open the [Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell).
2. Run the following cmdlet to retrieve the mailbox log for a user:

    ```powershell
    Get-ActiveSyncDeviceStatistics -Mailbox user -GetMailboxLog:$True -NotificationEmailAddresses admin@contoso.com
    ```

    > [!NOTE]
    > This will send the ActiveSync mailbox log to the specified email address for analysis. Additional information on mailbox logging can be found here.

3. Download [MailboxLogParser](https://github.com/search?q=MailboxLogParser) and extract the files.
4. Launch the utility by opening **MailboxLogParser.exe**.
5. Select **Import Mailbox Logs to Grid** to open the mailbox log.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/import-mailbox-logs-to-grid.png" alt-text="Screenshot of the Import Mailbox Logs to Grid button in the Mailbox Log Parser window.":::

#### Search for item in mailbox log

1. Remove the first byte (or two characters) from the binary value copied earlier. Then use the next 5 bytes (or 10 characters) for your search value.  
   Example: 01**CEC1E829ED**44997723AC344564BBEEF22D3A1A3373

2. Enter the value from Step 1 in **Search raw log data for strings** and select **Search**

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/search-raw-log-data-for-strings.png" alt-text="Screenshot to enter the value in the Search raw log data for strings box.":::

3. Take the next 16 bytes (or 32 characters) from the binary value and compare the value with the ConversationId in the search results.  
   Example: 01**CEC1E829ED44997723AC344564BBEEF22D3A1A3373**

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/raw-log-data-for-strings-search-results.png" alt-text="Screenshot of the raw log data for the strings search results.":::

4. Make note of the ServerId value for the item. The value for the example above is 5:11.

**Were you able to locate the item in the mailbox log using the ConversationId?**

- If yes, see [Analyze Mailbox Log for Item; Check the Final Status of the Item](#analyze-mailbox-log-for-item-check-the-final-status-of-the-item).
- If no, see [Fiddler Trace Analysis for Errors](#fiddler-trace-analysis-for-errors-if-the-result-doesnt-meet-the-expected-state).

### Analyze mailbox log for item; Check the final status of the item

#### Analyze mailbox log for item

Now that we know we have the item in our mailbox log, we need to track the actions taken against the appointment. To do this, follow these steps:

1. Search for the ServerId value found earlier.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/serverid-value-found-earlier.png" alt-text="Screenshot to search for the ServerId value found earlier.":::

2. Scroll up the log and look for either RequestBody or ResponseBody. If the item appears in the response body, then the item was updated from the server. Otherwise the item appears in the request body, which means the item was updated from the client.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/max-document-data-size-value.png" alt-text="Screenshot to modify the MaxDocumentDataSize value.":::

3. Make note of the action (Add, Change, or Delete) and whether the server or client sent the action.
4. Repeat steps 2-4 until you cannot find any further entries.

> [!NOTE]
> For more information about Exchange ActiveSync mailbox logging analysis, see [Under The Hood: Exchange ActiveSync Mailbox Log Analysis](https://techcommunity.microsoft.com/t5/exchange-team-blog/under-the-hood-exchange-activesync-mailbox-log-analysis/ba-p/591224).

#### Check the final status of the item

We verified that one or more actions were taken against the item within the mailbox log. The end result of the item is dependent on the final action. The following describes the expected status of the item based on that action:

 **Add** - The item should be in the folder on the ActiveSync client.
 **Change** - The item should be updated in the folder on the ActiveSync client.
 **Delete** - The item should be removed from the folder on the ActiveSync client.

**Does the result of the final action meet the expected state of the item?**

- If yes, see [Fiddler Trace Analysis for Item; Check the Final Status of the Item](#fiddler-trace-analysis-for-item-check-the-final-status-of-the-item).
- If no, see [Mailbox Log Analysis for Errors](#mailbox-log-analysis-for-errors-if-final-action-doesnt-meet-the-expected-state).

### Fiddler trace analysis for item; Check the final status of the item

#### Fiddler trace analysis for item

The activity on the Exchange server indicates that the device should have the correct status for this appointment. We can use the Fiddler trace to verify that the response was received by the client. To do this, follow these steps:

1. Open the Fiddler trace.
2. Go to the **Edit** menu and select **Find Sessions**.
3. Enter the namespace for ActiveSync (Example: mail.contoso.com) and select **Find Sessions**.
4. Select requests where the **Body** column has a value.

    :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/requsets-body-column-value.png" alt-text="Screenshot shows the requests where the Body column has a value":::

5. Select the **EAS XML** tab to view the request and response.

    :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/request-and-response.png" alt-text="Screenshot to select the E A S X M L tab to view the request and response.":::

6. Locate all requests and responses for the ServerId found earlier.

#### Check the final status of the item

We verified that one or more actions were taken against the item within the Fiddler trace. The end result of the item is dependent on the final action. The following describes the expected status of the item based on that action:

 **Add** - The item should be in the folder on the ActiveSync client.
 **Change** - The item should be updated in the folder on the ActiveSync client.
 **Delete** - The item should be removed from the folder on the ActiveSync client.

**Does the result of the final action meet the expected state of the item?**

- If yes, sorry, we cannot resolve the issue by using this guide. Based on the results of these troubleshooting steps, it is recommended you contact the device vendor for further support. You can also contact [Microsoft Support](https://support.microsoft.com/) for more help resolving this issue.
- If no, see [Fiddler Trace Analysis for Errors](#fiddler-trace-analysis-for-errors-if-the-result-doesnt-meet-the-expected-state).

### Fiddler trace analysis for errors (if the result doesn't meet the expected state)

We expect the device to send one or more requests to obtain the latest updates for the folder. We can use the Fiddler trace to verify that the request was sent by the client and a response was received by the server. To do this, follow these steps:

1. Open the Fiddler trace.
2. Go to the **Edit** menu and select **Find Sessions**.
3. Enter the namespace for ActiveSync (Example: mail.contoso.com) and select **Find Sessions**.
4. Review the Result column for any HTTP response values that do not equal 200.
5. Select requests where the **Body** column has a value.

     :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/requsets-body-column-value.png" alt-text="Screenshot of the requests where the Body column has the value.":::

6. Select the **TextView** tab to view the response for additional details.

     :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/text-view-tab.png" alt-text="Screenshot of the TextView tab, showing the response for additional details.":::

**Were there any errors found in the Fiddler trace?**

- If yes, see [Install Log Parser Studio; Log Parser Studio Query - Device Query; Query Results Analysis; Re-Sync the Folder](#install-log-parser-studio-log-parser-studio-query---device-query-query-results-analysis-resync-the-folder).
- If no, sorry, we cannot resolve the issue by using this guide. For more help resolving this issue contact [Microsoft Support](https://support.microsoft.com/). Please have all of the data collected from this troubleshooting available when you contact support.

### Install Log Parser Studio; Log Parser Studio Query - Device Query; Query results analysis; Resync the folder

#### Install Log Parser Studio

1. Download and install [LogParser](https://www.microsoft.com/download/details.aspx?id=24659).

   - Double-click the **LogParser.msi** to begin the installation.
   - Select **Run** if the **Open File - Security Warning** is displayed.
   - On the Welcome screen, select **Next**.
   - On the End-User license agreement screen, review and accept the license agreement, and select **Next**.
   - On the Choose Setup Type screen, select **Complete**.
   - On the Ready to Install screen, select **Install**.
   - On the Completion screen, select **Finish**.

2. Download [Log Parser Studio](https://gallery.technet.microsoft.com/Log-Parser-Studio-cd458765) and extract the files.

Once LogParser is installed and Log Parser Studio has been extracted, copy the IIS logs from the Exchange server(s) to the local workstation for analysis.

#### Log Parser Studio Query - Device Query

To determine if any of these ActiveSync requests are resulting in an error, query the IIS logs for the device traffic. To do this, follow these steps:

1. Launch Log Parser Studio by double-clicking LPS.exe.
2. Select the Log folder icon to select files to process.

   :::image type="icon" source="media/troubleshoot-activesync-with-exchange-server/log-folder-icon.png":::

3. Select the **Add Files** or **Add Folder** button, then locate and select the file(s) copied earlier.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/log-file-manager.png" alt-text="Screenshot of the Log File Manager window in the Device Query section.":::

4. Verify the file/folder is selected and select **OK**.
5. Double-click **ActiveSync: Device query** from the Library.
6. Modify the DeviceId value in the WHERE clause at the end of the query with the value from the previous step.
7. Select the exclamation point icon to execute the query.

   :::image type="icon" source="media/troubleshoot-activesync-with-exchange-server/exclamation-point-icon.png":::

8. Analyze the results for this query by reviewing the Error and sc-status columns.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/error-and-sc-status-columns.png" alt-text="Screenshot of analyzing the Device query results." lightbox="media/troubleshoot-activesync-with-exchange-server/error-and-sc-status-columns.png":::

#### Query results analysis

Now we want to review the results of the previous query for any errors. To do this, follow these steps:

1. Review the **Status** column and locate any request where there is a value. Use the [Exchange ActiveSync protocol document](/openspecs/exchange_server_protocols/ms-ascmd/95cb9d7c-d33d-4b94-9366-d59911c7a060) to investigate these values and if any corrective action can be taken. (You can ignore Ping commands from this review.)

2. Review the **Error** column and locate any request where there is a value in this column. Many of these error messages are self-explanatory and corrective action can be taken accordingly.

3. Review the **sc-status** column and locate any request where there is a value other than 200. This is the HTTP status response from IIS and additional information can be found in [The HTTP status code in IIS 7 and later versions](https://support.microsoft.com/help/943891).

Unfortunately the review of the IIS logs does not show us any identifier for the item in question. Your best effort will be locating a request within the IIS logs around the time the last item change occurred.

> [!NOTE]
> You can also see [Understanding Exchange ActiveSync Reporting Services](/previous-versions/office/exchange-server-2010/bb201675(v=exchg.141)) to better understand some of the elements found with the IIS log entry.

#### Resync the folder

The previous steps taken help to identify why the issue occurred with the item. The ActiveSync client may still not have the item in the correct state. To resolve this issue, remove the folder from the list of folders to synchronize, wait approximately five minutes, and then add the folder to the list of folders to synchronize.

**Is the item in the correct state on the ActiveSync client?**

- If yes, congratulations, your ActiveSync issue is resolved.
- If no, sorry, we cannot resolve the issue by using this guide. For more help resolving this issue contact [Microsoft Support](https://support.microsoft.com/). Please have all of the data collected from this troubleshooting available when you contact support.

### Mailbox log analysis for errors (if final action doesn't meet the expected state)

The ActiveSync traffic for this item does not result in the item being in the correct state on the device. Now we need to review the mailbox log further for issues with ActiveSync requests for the folder. To do this, follow these steps:

1. Review the search results from the previous step.
2. Check the **Status** code value in the response and if the value does not equal **1**, review the [ActiveSync protocol document](/openspecs/exchange_server_protocols/ms-ascmd/08151746-faf7-40a3-832b-b42e88a0b729) for more information on the status code.
3. Also check the log entry for any exception messages.
4. Repeat steps 2-4 for each log entry for the Calendar.

> [!NOTE]
> For more information about Exchange ActiveSync mailbox logging analysis, see [Under The Hood: Exchange ActiveSync Mailbox Log Analysis](https://techcommunity.microsoft.com/t5/exchange-team-blog/under-the-hood-exchange-activesync-mailbox-log-analysis/ba-p/591224).

**Were there any Status codes that did not equal 1 in the response or any exceptions found in the mailbox log?**

- If yes, see [Install Log Parser Studio; Log Parser Studio Query - Device Query; Query Results Analysis; Re-Sync the Folder](#install-log-parser-studio-log-parser-studio-query---device-query-query-results-analysis-resync-the-folder).
- If no, see [Fiddler Trace Analysis for Errors](#fiddler-trace-analysis-for-errors-if-the-result-doesnt-meet-the-expected-state).

### Install Log Parser Studio; Locate DeviceId for User; Log Parser Studio Query - Device query; Query results analysis

#### Install Log Parser Studio

The ActiveSync client may have encountered errors while attempting to communicate with the Exchange server. Now we need to determine where these errors originated. We will start by checking the IIS logs on the Client Access Server. Before these logs can be analyzed, the workstation where the analysis will be completed should have Log Parser Studio installed. To do this, follow these steps:

1. Download and install [LogParser](https://www.microsoft.com/download/details.aspx?id=24659).

   - Double-click the **LogParser.msi** to begin the installation.
   - Select **Run** if the **Open File - Security Warning** is displayed.
   - On the Welcome screen, select **Next**.
   - On the End-User license agreement screen, review and accept the license agreement, and select **Next**.
   - On the Choose Setup Type screen, select **Complete**.
   - On the Ready to Install screen, select **Install**.
   - On the Completion screen, select **Finish**.

2. Download [Log Parser Studio](https://gallery.technet.microsoft.com/Log-Parser-Studio-cd458765) and extract the files.

Once LogParser is installed and Log Parser Studio has been extracted, copy the IIS logs from the Exchange server(s) to the local workstation for analysis.

#### Locate DeviceId for user

We need to obtain the DeviceId for the ActiveSync client experiencing the issue. To do this, follow these steps:

1. Open the [Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell).
2. Run the following cmdlet to retrieve the DeviceId:

    ```powershell
    Get-ActiveSyncDeviceStatistics -Mailbox clt | fl DeviceId,DeviceType
    ```

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/get-active-sync-device-statistics.png" alt-text="Screenshot shows an example of running the Get-ActiveSyncDeviceStatistics cmdlet.":::

3. Make note of the `DeviceID` value.

#### Log Parser Studio Query - Device Query

To determine if any of these ActiveSync requests are resulting in an error, query the IIS logs for the device traffic. To do this, follow these steps:

1. Launch Log Parser Studio by double-clicking LPS.exe.
2. Select the Log folder icon to select files to process.

   :::image type="icon" source="media/troubleshoot-activesync-with-exchange-server/log-folder-icon.png":::

3. Select the **Add Files** or **Add Folder** button, then locate and select the file(s) copied earlier.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/log-file-manager.png" alt-text="Screenshot of the Log File Manager window in the Log Parser Studio Query - Device Query section.":::

4. Verify the file/folder is selected and select **OK**.
5. Double-click **ActiveSync: Device query** from the Library.
6. Modify the DeviceId value in the WHERE clause at the end of the query with the value from the previous step.
7. Select the exclamation point icon to execute the query.

   :::image type="icon" source="media/troubleshoot-activesync-with-exchange-server/exclamation-point-icon.png":::

8. Analyze the results for this query by reviewing the Error and sc-status columns.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/error-and-sc-status-columns.png" alt-text="Screenshot of the result of the Device query.":::

#### Query results analysis

Now we want to review the results of the previous query for any errors.

What error message did you find in the results from the query?

- [AttachmentTooBig](#check-activesync-mailbox-policy-for-error-attachmenttoobig)
- [AttachmentNotFound, BadAttachment, or InvalidAttachmentName](#enable-activesync-mailbox-logging-analyze-activesync-mailbox-log-locate-attachment-using-mfcmapi)
- [AttachmentsNotEnabled](#check-activesync-mailbox-policy)
- If None, sorry, we cannot resolve the issue by using this guide. For more help resolving this issue contact [Microsoft Support](https://support.microsoft.com/). Please have all of the data collected from this troubleshooting available when you contact support.

### Check ActiveSync mailbox policy for error AttachmentTooBig

To determine if there is an ActiveSync mailbox policy setting causing the AttachmentTooBig error, check the ActiveSync mailbox policy assigned to this mailbox. To do this, follow these steps:

1. Open the [Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell).
2. Run the following cmdlet to retrieve the ActiveSync mailbox policy settings for this user:

    ```powershell
    Get-ActiveSyncMailboxPolicy (Get-Mailbox alias ).ActiveSyncMailboxPolicy | ft name,*Attach* -AutoSize
    ```

    > [!NOTE]
    > This cmdlet should only return one result. If you receive more than one policy in the results, use the settings from the Default.

    :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/get-activesyncmailboxpolicy.png" alt-text="Screenshot of the example output of Get-ActiveSyncMailboxPolicy command.":::

**Is the MaxAttachmentSize setting set to unlimited?**

- If yes, see [Check Message Size Limits](#check-message-size-limits).
- If no, see [Modify ActiveSync Mailbox Policy](#modify-activesync-mailbox-policy-if-maxattachmentsize-isnt-unlimited).

### Check message size limits

To determine if maximum message size restrictions may be causing the AttachmentTooBig error, check the transport settings for the Exchange organization. To do this, follow these steps:

1. Open the [Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell).
2. Run the following cmdlet to retrieve the message size limits:

    ```powershell
    Get-TransportConfig | fl *size
    ```

    :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/get-transportConfig.png" alt-text="Screenshot of the example output of Get-TransportConfig command.":::

**Is either the MaxReceiveSize or MaxSendSize limits greater than 10 MB?**

- If yes, see [Modify Exchange ActiveSync Settings](#modify-exchange-activesync-settings).
- If no, sorry, we cannot resolve the issue by using this guide. For more help resolving this issue contact [Microsoft Support](https://support.microsoft.com/). Please have all of the data collected from this troubleshooting available when you contact support.

### Modify Exchange ActiveSync settings

To resolve this issue, increase the maximum amount of data transfer for the ActiveSync virtual directory. To do this, follow these steps:

> [!IMPORTANT]
> The following changes may result in increased data charges on mobile devices.

1. Open Windows Explorer.
2. Browse to the Exchange Install Path (%**ExchangeInstallPath**%) then browse to the **ClientAccess** and **Sync** directories.
3. Make a copy of the web.config file.
4. Open the web.config file in Notepad.
5. Locate the MaxDocumentDataSIze and modify the value as needed.

    :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/max-document-data-size-value.png" alt-text="Screenshot of the MaxDocumentDataSIze value.":::

    > [!NOTE]
    > This value is in bytes.

6. Locate the MaxRequestLength and modify the value as needed.

    :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/requests-example.png" alt-text="Screenshot of the MaxRequestLength value.":::

    > [!NOTE]
    > This value is in kilobytes.

7. [Open IIS Manager](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc770472(v=ws.10)).
8. Expand the server and select **Application Pools**.
9. Right-click on the **MSExchangeSyncAppPool** and select **Stop**.
10. Right-click on the **MSExchangeSyncAppPool** and select **Start**.

**Did modifying the ActiveSync setting resolve the issue?**

- If yes, congratulations, your ActiveSync issue is resolved.
- If no, sorry, we cannot resolve the issue by using this guide. For more help resolving this issue contact [Microsoft Support](https://support.microsoft.com/). Please have all of the data collected from this troubleshooting available when you contact support.

### Modify ActiveSync mailbox policy (if MaxAttachmentSize isn't unlimited)

To resolve this issue, increase the maximum attachment size limit in the ActiveSync mailbox policy. To do this, follow these steps:

1. Open the [Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell).
2. Run the following cmdlet to modify the ActiveSync mailbox policy:

    ```powershell
    Set-ActiveSyncMailboxPolicy Default -MaxAttachmentSize 20971520
    ```

    > [!NOTE]
    > The `MaxAttachmentSize` value is in bytes. Modify the policy name and size in the cmdlet above to meet your needs.

**Did increasing the maximum attachment size in the ActiveSync mailbox policy resolve the issue?**

- If yes, congratulations, your ActiveSync issue is resolved.
- If no, see [Check Message Size Limits](#check-message-size-limits).

### Enable ActiveSync mailbox logging; Analyze ActiveSync mailbox log; Locate attachment using MfcMapi

#### Enable ActiveSync mailbox logging

To determine the ActiveSync response that is causing the failure, mailbox logging must be enabled. Additional information on mailbox logging can be found [Exchange ActiveSync Mailbox Logging](/archive/blogs/jasonsla/exchange-activesync-mailbox-logging). To do this, follow these steps:

> [!NOTE]
> This change should be made on Exchange 2013 mailbox servers.

1. Open Windows Explorer and browse to the Sync folder (C:\Program Files\Microsoft\Exchange Server\V14\ClientAccess\Sync).
2. Make a copy of the web.config file.
3. Open the web.config file in Notepad and modify the following sections with the values below:

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/open-web-config-file-in-notepad.png" alt-text="Screenshot of the values you need to modify with in the Enable ActiveSync mailbox logging; Analyze mailbox log; Locate attachment section.":::

4. [Open IIS Manager](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc770472(v=ws.10)).
5. Expand the server and select **Application Pools**.
6. Right-click on the **MSExchangeSyncAppPool** and select **Advanced Settings**.
7. Right-click on the **MSExchangeSyncAppPool** and select **Stop**.
8. Right-click on the **MSExchangeSyncAppPool** and select **Start**.
9. Open the [Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell).
10. Run the following cmdlet to enable the mailbox logging for a user:

    ```powershell
    Set-CASMailbox user -ActiveSyncDebugLogging:$True
    ```

11. Attempt to open the attachment from the ActiveSync client

#### Analyze ActiveSync mailbox log

Review the mailbox log to determine that attachment the user is attempting to open. To do this, follow these steps:

1. Open the [Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell).
2. Run the following cmdlet to retrieve the mailbox log for a user:

    ```powershell
    Get-ActiveSyncDeviceStatistics -Mailbox user -GetMailboxLog:$True -NotificationEmailAddresses admin@contoso.com
    ```

    > [!NOTE]
    > This will send the ActiveSync mailbox log to the specified email address for analysis. Additional information on mailbox logging can be found in [Exchange ActiveSync Mailbox Logging](/archive/blogs/jasonsla/exchange-activesync-mailbox-logging).

3. Download [MailboxLogParser](https://github.com/search?q=MailboxLogParser) and extract the files.
4. Launch the utility by opening **MailboxLogParser.exe**.
5. Select **Import Mailbox Logs to Grid** to open the mailbox log.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/import-mailbox-logs-to-grid.png" alt-text="Screenshot of Import Mailbox Logs to Grid button in Mailbox Log Parser in the Analyze ActiveSync mailbox log section.":::

6. Enter **ObjectNotFound** under **Search raw log data for strings** and select **Search**.

7. Review the search results by finding the error in the log entry. Make note of the attachment number in the FileReference. This is the last number in the value: **5%3a12%3a0**. (The full value is 5:12:0, which is attachment 0 for ServerId 5:12.)

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/search-objectnotfound.png" alt-text="Screenshot of the results of searching ObjectNotFound.":::

> [!NOTE]
> For more information about Exchange ActiveSync mailbox logging analysis, see [Under The Hood: Exchange ActiveSync Mailbox Log Analysis](https://techcommunity.microsoft.com/t5/exchange-team-blog/under-the-hood-exchange-activesync-mailbox-log-analysis/ba-p/591224).

#### Locate attachment using MfcMapi

We need to determine if the attachment exists within the message. To do this, follow these steps:

1. Download and install [MfcMapi](https://github.com/stephenegriffin/mfcmapi/releases/).
2. Launch MfcMapi.
3. Go to the **Session** menu and select **Logon**.
4. Select the Outlook profile for the mailbox and select **OK**.
5. Double-click the mailbox to open.
6. Expand the **Root Container**, expand **Top of Information Store**, then right-click on the **Inbox** (or other folder where the item is located) and select **Open contents table**.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/open-contents-table.png" alt-text="Screenshot of the Open contents table option of Inbox.":::

7. Right-click on the message and select **Attachments** > **Display attachment table**.
8. You should see a list of attachments within the message

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/list-of-attachments.png" alt-text="Screenshot of an example list of attachments.":::

**Do you see an attachment with the FileReference number found in the mailbox log?**

- If yes, see [View Attachment Using Outlook](#view-attachment-using-outlook).
- If no, sorry, we cannot resolve the issue by using this guide. For more help resolving this issue contact [Microsoft Support](https://support.microsoft.com/). Please have all of the data collected from this troubleshooting available when you contact support.

### View attachment using outlook

To determine if the attachment is corrupt, ask the user to open the attachment in either Outlook or Outlook Web Access.

**Is the user able to open the attachment from another client?**

- If yes, see [Check ActiveSync Mailbox Policy](#check-activesync-mailbox-policy).
- If no, sorry, we cannot resolve the issue by using this guide. For more help resolving this issue contact [Microsoft Support](https://support.microsoft.com/). Please have all of the data collected from this troubleshooting available when you contact support.

### Check ActiveSync mailbox policy

To determine if there is an ActiveSync mailbox policy setting causing the AttachmentTooBig error, check the ActiveSync mailbox policy assigned to this mailbox. To do this, follow these steps:

1. Open the [Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell).
2. Run the following cmdlet to retrieve the ActiveSync mailbox policy settings for this user:

    ```powershell
    Get-ActiveSyncMailboxPolicy (Get-Mailbox alias ).ActiveSyncMailboxPolicy | ft name,*Attach* -AutoSize
    ```

    > [!NOTE]
    > This cmdlet should only return one result. If you receive more than one policy in the results, use the settings from the Default.

    :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/get-activesyncmailboxpolicy.png" alt-text="Screenshot of the output of Get-ActiveSyncMailboxPolicy command.":::

**Is the AttachmentsEnabled setting set to True?**

- If yes, sorry, we cannot resolve the issue by using this guide. For more help resolving this issue contact [Microsoft Support](https://support.microsoft.com/). Please have all of the data collected from this troubleshooting available when you contact support.
- If no, see [Modify ActiveSync Mailbox Policy](#modify-activesync-mailbox-policy).

### Modify ActiveSync mailbox policy

To resolve this issue, increase the maximum attachment size limit in the ActiveSync mailbox policy. To do this, follow these steps:

1. Open the [Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell).
2. Run the following cmdlet to modify the ActiveSync mailbox policy:

    ```powershell
    Set-ActiveSyncMailboxPolicy Default -AttachmentsEnabled:$True
    ```

**Did increasing the maximum attachment size in the ActiveSync mailbox policy resolve the issue?**

- If yes, congratulations, your ActiveSync issue is resolved.
- If no, sorry, we cannot resolve the issue by using this guide. For more help resolving this issue contact [Microsoft Support](https://support.microsoft.com/). Please have all of the data collected from this troubleshooting available when you contact support.

### Unable to send a message

We are going to troubleshoot the issue where a user is unable to send a message from an ActiveSync client.

Can the user reproduce the issue?

- If yes, see [Enable ActiveSync Mailbox Logging; Capture Fiddler Trace; Mailbox Log Analysis for Errors](#enable-activesync-mailbox-logging-capture-fiddler-trace-mailbox-log-analysis-for-errors).
- If no, see [Install Log Parser Studio; Log Parser Studio Query - SendMail; Query Results Analysis](#install-log-parser-studio-log-parser-studio-query---sendmail-query-results-analysis-if-no-user-can-reproduce-the-issue).

### Enable ActiveSync mailbox logging; Capture Fiddler Trace; mailbox log analysis for errors

#### Enable ActiveSync mailbox logging

The first step is to enable mailbox logging on the Client Access Server(s) and the user mailbox. Additional information on mailbox logging can be found here. To do this, follow these steps:

> [!NOTE]
> This change should be made on Exchange 2013 mailbox servers.

1. Open Windows Explorer and browse to the Sync folder (C:\Program Files\Microsoft\Exchange Server\V14\ClientAccess\Sync).
2. Make a copy of the web.config file.
3. Open the web.config file in Notepad and modify the following sections with the values below:

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/open-web-config-file-in-notepad.png" alt-text="Screenshot of the values you need to modify with in the Enable ActiveSync mailbox logging; Capture Fiddler Trace; mailbox log analysis section.":::

4. [Open IIS Manager](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc770472(v=ws.10)).
5. Expand the server and select **Application Pools**.
6. Right-click on the **MSExchangeSyncAppPool** and select **Advanced Settings**.
7. Right-click on the **MSExchangeSyncAppPool** and select **Stop**.
8. Right-click on the **MSExchangeSyncAppPool** and select **Start**.
9. Open the [Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell).
10. Run the following cmdlet to enable the mailbox logging for a user:

    ```powershell
    Set-CASMailbox user -ActiveSyncDebugLogging:$True

#### Capture fiddler trace

ActiveSync device requests do not always reach the destination as desired. To ensure the device request and response is being sent and received as expected, route the device through an HTTP proxy and review the data. To do this, follow these steps:

1. Download and install [Fiddler](https://www.telerik.com/download/fiddler) onto a workstation.
2. Download [EAS Inspector for Fiddler](https://archive.codeplex.com/?p=easinspectorforfiddler).
3. Extract **EASInspectorFiddler.dll** into the **c:\Program Files\Fiddler2\Inspectors** folder.
4. Launch the Fiddler application.
5. Select the **Tools** menu and select **Fiddler Options**.
6. Go to the **HTTPS** tab and select **Decrypt HTTPS traffic**, select **Yes** to all prompts.
7. Go to the Connections tab and select **Allow remote computers to connect**, select **OK** to any prompt.
8. Select **OK** and close the Fiddler application.
9. Configure the ActiveSync device to use this workstation as a proxy server (This is typically done under the WiFi settings for the device).
10. Launch the Fiddler application.
11. Attempt to **send** one or more messages from the ActiveSync client.
12. Select the **File** menu and select **Capture Traffic** to stop the trace.

#### Mailbox log analysis for errors

The request from the ActiveSync client to send this message is not successful. We need to verify that the Exchange server received the request and determine if the server sent any response. To do this, follow these steps:

1. Open the [Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell).
2. Run the following cmdlet to retrieve the mailbox log for a user:

    ```powershell
    Get-ActiveSyncDeviceStatistics -Mailbox user -GetMailboxLog:$True -NotificationEmailAddresses admin@contoso.com
    ```

    > [!NOTE]
    > This sends the ActiveSync mailbox log to the specified email address. Additional information on mailbox logging can be found in [Exchange ActiveSync Mailbox Logging](/archive/blogs/jasonsla/exchange-activesync-mailbox-logging).

3. Download [MailboxLogParser](https://github.com/search?q=MailboxLogParser) and extract the files.
4. Launch the utility by opening **MailboxLogParser.exe**.
5. Select **Import Mailbox Logs to Grid** to open the mailbox log.
6. Enter **SendMail** under **Search raw log data for strings** and select **Search**.
7. Review the search results by checking the **Satus** column for any values

> [!NOTE]
> For more information about Exchange ActiveSync mailbox logging analysis, see [Under The Hood: Exchange ActiveSync Mailbox Log Analysis](https://techcommunity.microsoft.com/t5/exchange-team-blog/under-the-hood-exchange-activesync-mailbox-log-analysis/ba-p/591224).

**Were there any errors or exceptions found in the mailbox log?**

- If yes, see [Install Log Parser Studio; Log Parser Studio Query - SendMail; Query Results Analysis](#install-log-parser-studio-log-parser-studio-query---sendmail-query-results-analysis).
- If no, see [Fiddler Trace Analysis for Errors](#fiddler-trace-analysis-for-errors-if-no-errors-in-mailbox-log).

### Fiddler trace analysis for errors (if no errors in mailbox log)

We expect the device to send one or more requests to obtain the latest updates for the folder. We can use the Fiddler trace to verify that the request was sent by the client and a response was received by the server. To do this, follow these steps:

1. Open the Fiddler trace.
2. Go to the **Edit** menu and select **Find Sessions**.
3. Enter the namespace for ActiveSync (Example: mail.contoso.com) and select **Find Sessions**.
4. Review the Result column for any HTTP response values that do not equal 200.
5. Select requests where the **Body** column has a value.

     :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/requsets-body-column-value.png" alt-text="Screenshot to select the requests where the Body column has a value.":::

6. Select the **TextView** tab to view the response for additional details.

     :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/text-view-tab.png" alt-text="Screenshot of the TextView tab in the Fiddler trace analysis for errors section, which shows the response for additional details.":::

**Were there any errors found in the Fiddler trace?**

- If yes, see [Install Log Parser Studio; Log Parser Studio Query - SendMail; Query Results Analysis](#install-log-parser-studio-log-parser-studio-query---sendmail-query-results-analysis).
- If no, sorry, we cannot resolve the issue by using this guide. For more help resolving this issue contact [Microsoft Support](https://support.microsoft.com/). Please have all of the data collected from this troubleshooting available when you contact support.

### Install Log Parser Studio; Log Parser Studio Query - SendMail; Query results analysis (if no user can reproduce the issue)

#### Install Log Parser Studio

The ActiveSync client may have encountered errors while attempting to communicate with the Exchange server. Now we need to determine where these errors originated. We will start by checking the IIS logs on the Client Access Server. Before these logs can be analyzed, the workstation where the analysis will be completed should have Log Parser Studio installed. To do this, follow these steps:

1. Download and install [LogParser](https://www.microsoft.com/download/details.aspx?id=24659).

   - Double-click the **LogParser.msi** to begin the installation.
   - Select **Run** if the **Open File - Security Warning** is displayed.
   - On the Welcome screen, select **Next**.
   - On the End-User license agreement screen, review and accept the license agreement, and select **Next**.
   - On the Choose Setup Type screen, select **Complete**.
   - On the Ready to Install screen, select **Install**.
   - On the Completion screen, select **Finish**.

2. Download [Log Parser Studio](https://gallery.technet.microsoft.com/Log-Parser-Studio-cd458765) and extract the files.

Once LogParser is installed and Log Parser Studio has been extracted, copy the IIS logs from the Exchange server(s) to the local workstation for analysis.

#### Log Parser Studio Query – SendMail

To determine if any of these ActiveSync requests are resulting in an error, query the IIS logs for the device traffic. To do this, follow these steps:

1. Launch Log Parser Studio by double-clicking LPS.exe.
2. Select the Log folder icon to select files to process.

   :::image type="icon" source="media/troubleshoot-activesync-with-exchange-server/log-folder-icon.png":::

3. Select the **Add Files** or **Add Folder** button, then locate and select the file(s) copied earlier.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/log-file-manager.png" alt-text="Screenshot of the Log file manager window with the file copied earlier selected in the Install LPS; SendMail query; Query results analysis (if no user can reproduce) section.":::

4. Verify the file/folder is selected and select OK.
5. Double-click **ActiveSync: SendMail** from the Library.
6. Select the exclamation point icon to execute the query.

   :::image type="icon" source="media/troubleshoot-activesync-with-exchange-server/exclamation-point-icon.png":::

7. Analyze the results for this query by searching for any value in the Status or Error columns. Also look for any HTTP status codes that do not equal 200.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/analyze-results.png" alt-text="Screenshot of the result for the SendMail query.":::

#### Query results analysis

Now we want to review the results of the previous query for any errors.

**What error did you find in the query results?**

- [QutoaExceeded Error](#qutoaexceeded-error)
- [MailSubmissionFailed](#mailsubmissionfailed-error)
- [oRecipients](#norecipients-error)
- Error not listed or HTTP error, sorry, we cannot resolve the issue by using this guide. For more help resolving this issue contact [Microsoft Support](https://support.microsoft.com/). Please have all of the data collected from this troubleshooting available when you contact support.

### QutoaExceeded error

This error is reporting that the user has exceeded their mailbox quota and cannot send any messages. To resolve this issue, either increase the user's mailbox storage quota or inform the user to reduce their mailbox size.

Does one of these options resolves the issue?

- If yes, congratulations, your ActiveSync issue is resolved.
- If no, sorry, we cannot resolve the issue by using this guide. For more help resolving this issue contact [Microsoft Support](https://support.microsoft.com/). Please have all of the data collected from this troubleshooting available when you contact support.

### NoRecipients error

This error is reporting that the user attempted to send a message without any recipients. The device should not allow this behavior. You may want to review the mailbox logs and/or Fiddler trace for this device to verify that the SendMail command included one or more recipients.

Were you able to verify the device sent one or more recipients in the request?

- If yes, sorry, we cannot resolve the issue by using this guide. For more help resolving this issue contact [Microsoft Support](https://support.microsoft.com/). Please have all of the data collected from this troubleshooting available when you contact support.
- If no, sorry, we cannot resolve the issue by using this guide. Based on the results of these troubleshooting steps, it is recommended you contact the device vendor for further support. You can also contact [Microsoft Support](https://support.microsoft.com/) for more help resolving this issue.

### MailSubmissionFailed error

The MailSubmissionFailed error is essentially a catch all error message for SendMail failures. The user should attempt to send the message again. Check the Mailbox server event log for any errors or warnings at the time of this message submission.

Were you able to resolve the issue using the event logs on the Mailbox server?

- If yes, congratulations, your ActiveSync issue is resolved.
- If no, sorry, we cannot resolve the issue by using this guide. For more help resolving this issue contact [Microsoft Support](https://support.microsoft.com/). Please have all of the data collected from this troubleshooting available when you contact support.

### Calendaring issues

Before we begin troubleshooting, we need to know if the issue can be reproduced on the device. If we can reproduce the issue, then we can capture data during the process to get a better understanding of the issue. Otherwise we will need to examine existing logs to attempt to determine what happened.

**Can you reproduce the Calendar issue on the device?**

- If yes, see [Enable ActiveSync Mailbox Logging; Capture Fiddler Trace; Locate Appointment within the Mailbox; Search for UID](#enable-activesync-mailbox-logging-capture-fiddler-trace-locate-appointment-within-the-mailbox-search-for-uid).
- If no, see [Install Log Parser Studio; Log Parser Studio Query - Device Calendar requests; Query Results Analysis; Re-Sync the Calendar Folder](#install-log-parser-studio-log-parser-studio-query---device-calendar-requests-query-results-analysis-resync-the-calendar-folder).

### Enable ActiveSync mailbox logging; Capture fiddler trace; Locate appointment within the mailbox; Search for UID

#### Enable ActiveSync Mailbox Logging

The first step is to enable mailbox logging on the Client Access Server(s) and the user mailbox. Additional information on mailbox logging can be found here. To do this, follow these steps:

> [!NOTE]
> This change should be made on Exchange 2013 mailbox servers.

1. Open Windows Explorer and browse to the Sync folder (C:\Program Files\Microsoft\Exchange Server\V14\ClientAccess\Sync).
2. Make a copy of the web.config file.
3. Open the web.config file in Notepad and modify the following sections with the values below:

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/open-web-config-file-in-notepad.png" alt-text="Screenshot of the values you need to modify with in the Enable ActiveSync mailbox logging; Capture fiddler trace; Locate appointment; Search for UID section.":::

4. [Open IIS Manager](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc770472(v=ws.10)).
5. Expand the server and select **Application Pools**.
6. Right-click on the **MSExchangeSyncAppPool** and select **Stop**.
7. Right-click on the **MSExchangeSyncAppPool** and select **Start**.
8. Open the [Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell).
9. Run the following cmdlet to enable the mailbox logging for a user:

    ```powershell
    Set-CASMailbox user -ActiveSyncDebugLogging:$True
    ```

#### Capture fiddler trace

ActiveSync device requests do not always reach the destination as desired. To ensure the device request and response is being sent and received as expected, route the device through an HTTP proxy and review the data. To do this, follow these steps:

1. Download and install [Fiddler](https://www.telerik.com/download/fiddler) onto a workstation.
2. Download [EAS Inspector for Fiddler](https://archive.codeplex.com/?p=easinspectorforfiddler).
3. Extract **EASInspectorFiddler.dll** into the **c:\Program Files\Fiddler2\Inspectors** folder.
4. Launch the Fiddler application.
5. Select the **Tools** menu and select **Fiddler Options**.
6. Go to the **HTTPS** tab and select **Decrypt HTTPS traffic**, select **Yes** to all prompts.
7. Go to the Connections tab and select **Allow remote computers to connect**, select **OK** to any prompt.
8. Select **OK** and close the Fiddler application.
9. Configure the ActiveSync device to use this workstation as a proxy server (This is typically done under the WiFi settings for the device).
10. Launch the Fiddler application.
11. Attempt to **send** one or more messages from the ActiveSync client.
12. Select the **File** menu and select **Capture Traffic** to stop the trace.

#### Locate appointment within the mailbox

We need to determine the UID for the appointment within the mailbox before we search the mailbox log. To do this, follow these steps:

1. Download and install [MfcMapi](https://github.com/stephenegriffin/mfcmapi/releases/).
2. Launch MfcMapi.
3. Go to the **Session** menu and select **Logon**.
4. Select the Outlook profile for the mailbox and select **OK**.
5. Double-click the mailbox to open.
6. Expand the **Root Container**, expand **Top of Information Store**, then right-click on the **Calendar** and select **Open contents table**.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/open-contents-table-on-calendar.png" alt-text="Screenshot of the Open contents table option of Calender.":::

7. Select the appointment within the table, then right-click on the tag 0x80000102 and select **Edit property**.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/edit-property-on-tab.png" alt-text="Screenshot of the Edit property option of the tag 0x80000102.":::

8. Copy the **Binary** value (this will be used to search for the UID in the mailbox log).

      :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/copy-binary-value.png" alt-text="Screenshot of the Binary value of the tag 0x80000102.":::

#### Search for UID

We now have the data collected and we are ready to begin troubleshooting. The first step we will take is to look at the mailbox log and check if the appointment was captured. To do this, follow these steps:

1. Open the [Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell).
2. Run the following cmdlet to retrieve the mailbox log for a user:

    ```powershell
    Get-ActiveSyncDeviceStatistics -Mailbox user -GetMailboxLog:$True -NotificationEmailAddresses admin@contoso.com
    ```

    > [!NOTE]
    > This will send the ActiveSync mailbox log to the specified email address for analysis. Additional information on mailbox logging can be found [Exchange ActiveSync Mailbox Logging](/archive/blogs/jasonsla/exchange-activesync-mailbox-logging).

3. Download [MailboxLogParser](https://github.com/search?q=MailboxLogParser) and extract the files.
4. Launch the utility by opening **MailboxLogParser.exe**.
5. Select **Import Mailbox Logs to Grid** to open the mailbox log.
6. Enter the UID value you copied earlier under **Search raw log data for strings** and select **Search**.

      :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/search-uid-value.png" alt-text="Screenshot of Search raw log data for strings box in Mailbox Log Parser.":::

7. Review the search results and make note of the ServerId value for this appointment if found

      :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/make-note-of-serverid-value.png" alt-text="Screenshot of the search result, which shows the ServerId.":::

**Were you able to locate the appointment in the mailbox log using the UID?**

- If yes, see [Analyze Mailbox Log for UID; Check the Final Status of the Appointment](#analyze-mailbox-log-for-uid-check-the-final-status-of-the-appointment).
- If no, see [Fiddler Trace Analysis for Errors](#fiddler-trace-analysis-for-errors).

### Analyze mailbox log for UID; Check the final status of the appointment

#### Analyze mailbox log for UID

Now that we know we have the appointment within our mailbox log, we need to track the actions taken against the appointment. To do this, follow these steps:

1. Search for the UID value found earlier.

      :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/search-for-the-UID-value.png" alt-text="Screenshot of the search box in Mailbox Log Parser.":::

2. Review the results and analyze the log entries. Check the logs and look for either RequestBody or ResponseBody. If the item appears in the response body, then the item was updated from the server. Otherwise the item appears in the request body, which means the item was updated from the client.

      :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/analyze-mailbox-log-for-UID.png" alt-text="Screenshot of the example log entries. The item appears in the Response Body.":::

3. Make note of the action (Add, Change, or Delete) and whether the server or client sent the action.
4. Repeat steps 2-4 until you cannot find any further entries.

    > [!NOTE]
    > For more information about Exchange ActiveSync mailbox logging analysis, see [Under The Hood: Exchange ActiveSync Mailbox Log Analysis](https://techcommunity.microsoft.com/t5/exchange-team-blog/under-the-hood-exchange-activesync-mailbox-log-analysis/ba-p/591224).

#### Check the final status of the appointment

We verified that one or more actions were taken against the appointment within the mailbox log. The end result of the appointment is dependent on the final action. The following describes the expected status of the appointment based on that action:

- **Add** - The appointment should be in the Calendar on the ActiveSync client.
- **Change** - The appointment should be updated in the Calendar on the ActiveSync client.
- **Delete** - The appointment should be removed from the Calendar on the ActiveSync client.

**Does the result of the final action meet the expected state of the appointment?**

- If yes, see [Fiddler Trace Analysis for UID; Check the Final Status of the Appointment](#fiddler-trace-analysis-for-uid-check-the-final-status-of-the-appointment).
- If no, see [Mailbox Log Analysis for Errors](#mailbox-log-analysis-for-errors-for-appointment)).

### Fiddler trace analysis for UID; Check the final status of the appointment

#### Fiddler trace analysis for UID

We expect the device to send requests related to this appointment. We can use the Fiddler trace to verify that the request was sent by the client and a response was received by the server. To do this, follow these steps:

1. Open the Fiddler trace.
2. Go to the Edit menu and select Find Sessions.
3. Enter the namespace for ActiveSync (Example: mail.contoso.com) and select Find Sessions.
4. Select requests where the **Body** column has a value and the HTTP response values that do not equal 200.

      :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/verify-request-1.png" alt-text="Screenshot of the requests in fiddler trace result.":::

5. Select the EAS XML tabs to view the request and response.

      :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/verify-request-2.png" alt-text="Screenshot of the EAS XML tab, which shows the request and response details.":::

6. Locate all requests and responses for the ServerId found earlier.

#### Check the final status of the appointment

We need to verify that the actions taken against the appointment within Fiddler trace align with the mailbox log. The final action should match the mailbox log action found earlier. The following describes the expected status of the appointment based on that action:

- **Add** - The appointment should be in the Calendar on the ActiveSync client.
- **Change** - The appointment should be updated in the Calendar on the ActiveSync client.
- **Delete** - The appointment should be removed from the Calendar on the ActiveSync client.

**Does the result of the final action meet the expected state of the appointment?**

- If yes, sorry, we cannot resolve the issue by using this guide. Based on the results of these troubleshooting steps, it is recommended you contact the device vendor for further support. You can also contact [Microsoft Support](https://support.microsoft.com/) for more help resolving this issue.
- If no, see [Fiddler Trace Analysis for Errors](#fiddler-trace-analysis-for-errors).

### Mailbox log analysis for errors (for appointment)

The ActiveSync traffic for this appointment does not result in the appointment being in the correct state on the device. Now we need to review the mailbox log further for issues with ActiveSync requests for the Calendar folder. To do this, follow these steps:

1. Review the search results from earlier.

    :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/mailbox-log-analysis-for-errors.png" alt-text="Screenshot of the search results from earlier.":::

2. Check the **Status** column for the response and if the value does not equal **1**, review the [ActiveSync protocol document](/openspecs/exchange_server_protocols/ms-ascmd/08151746-faf7-40a3-832b-b42e88a0b729) for more information on the status code.

3. Also check the log entry for any exception messages.

> [!NOTE]
> For more information on Exchange ActiveSync mailbox logging analysis, see [Under The Hood: Exchange ActiveSync Mailbox Log Analysis](https://techcommunity.microsoft.com/t5/exchange-team-blog/under-the-hood-exchange-activesync-mailbox-log-analysis/ba-p/591224).

**Were there any Status codes that did not equal 1 in the response or any exceptions found in the mailbox log?**

- If yes, sorry, we cannot resolve the issue by using this guide. Based on the results of these troubleshooting steps, it is recommended you contact the device vendor for further support. You can also contact [Microsoft Support](https://support.microsoft.com/) for more help resolving this issue.
- If no, see [Fiddler Trace Analysis for Errors](#fiddler-trace-analysis-for-errors).

### Fiddler trace analysis for errors

Based on the results of the mailbox log, the client did not encounter any errors with ActiveSync traffic between the client and Exchange. Next we need to verify that all of the requests from the device did not encounter an error. To do this, follow these steps:

We expect the device to send one or more requests to obtain the latest updates for the folder. We can use the Fiddler trace to verify that the request was sent by the client and a response was received by the server. To do this, follow these steps:

1. Open the Fiddler trace.
2. Go to the Edit menu and select Find Sessions.
3. Enter the namespace for ActiveSync (Example: mail.contoso.com) and select Find Sessions.
4. Review the Result column for any HTTP response values that do not equal 200.
5. Select requests where the **Body** column has a value.

     :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/requsets-body-column-value.png" alt-text="Screenshot to select the requests where the Body column has the value.":::

6. Select the **TextView** tab to view the response for additional details.

     :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/text-view-tab.png" alt-text="Screenshot of the TextView tab in the Fiddler trace analysis for errors section, showing the response for additional details.":::

**Were there any errors found in the Fiddler trace for the Calendar requests?**

- If yes, see [Install Log Parser Studio; Log Parser Studio Query - Device Calendar requests; Query Results Analysis; Re-Sync the Calendar Folder](#install-log-parser-studio-log-parser-studio-query---device-calendar-requests-query-results-analysis-resync-the-calendar-folder).
- If no, sorry, we cannot resolve the issue by using this guide. For more help resolving this issue contact [Microsoft Support](https://support.microsoft.com/). Please have all of the data collected from this troubleshooting available when you contact support.

### Install Log Parser Studio; Log Parser Studio Query - Device Calendar requests; Query results analysis; Resync the Calendar folder

#### Install Log Parser Studio

The ActiveSync client may have encountered errors while attempting to communicate with the Exchange server. Now we need to determine where these errors originated. We will start by checking the IIS logs on the Client Access Server. Before these logs can be analyzed, the workstation where the analysis will be completed should have Log Parser Studio installed. To do this, follow these steps:

1. Download and install [LogParser](https://www.microsoft.com/download/details.aspx?id=24659).

   - Double-click the **LogParser.msi** to begin the installation.
   - Select **Run** if the **Open File - Security Warning** is displayed.
   - On the Welcome screen, select **Next**.
   - On the End-User license agreement screen, review and accept the license agreement, and select **Next**.
   - On the Choose Setup Type screen, select **Complete**.
   - On the Ready to Install screen, select **Install**.
   - On the Completion screen, select **Finish**.

2. Download [Log Parser Studio](https://gallery.technet.microsoft.com/Log-Parser-Studio-cd458765) and extract the files.

Once LogParser is installed and Log Parser Studio has been extracted, copy the IIS logs from the Exchange server(s) to the local workstation for analysis.

#### Log Parser Studio Query – Device Calendar requests

We need to determine if the requests from this ActiveSync client encountered any issues while being processed on the Client Access Server. To do this, follow these steps:

1. Launch Log Parser Studio by double-clicking LPS.exe.
2. Select the Log folder icon to select files to process.

   :::image type="icon" source="media/troubleshoot-activesync-with-exchange-server/log-folder-icon.png":::

3. Select the Add Files or Add Folder button, then locate and select the file(s) copied earlier.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/log-file-manager.png" alt-text="Screenshot of the Log file manager window with the file copied earlier selected in the Install LPS; Device Calendar requests; Query results analysis; Resync the Calendar folder section.":::

4. Verify the file/folder is selected and select **OK**.
5. Double-click **ActiveSync: Count Syncs with SyncKey of Zero Per User** from the Library.
6. Select the exclamation point icon to execute the query.

   :::image type="icon" source="media/troubleshoot-activesync-with-exchange-server/exclamation-point-icon.png":::

   **Example results:**

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/example-results.png" alt-text="Screenshot of the example results of the Count Syncs with SyncKey of Zero Per User query.":::

#### Query results analysis

Now we want to review the results from your query for any issues. To do this, follow these steps:

1. Review the **Status** column and locate any request where there is a value. Use the [Exchange ActiveSync protocol document](/openspecs/exchange_server_protocols/ms-ascmd/95cb9d7c-d33d-4b94-9366-d59911c7a060) to investigate these values and if any corrective action can be taken.

2. Review the **Error** column and locate any request where there is a value in this column. Many of these error messages are self-explanatory and corrective action can be taken accordingly.

3. Review the **sc-status** column and locate any request where there is a value other than 200. This is the HTTP status response from IIS and additional information can be found in [The HTTP status code in IIS 7 and later versions](https://support.microsoft.com/help/943891).

Unfortunately, the review of the IIS logs does not show us any identifier for the appointment in question. Your best effort will be locating a request within the IIS logs around the time the last appointment change occurred. You can also use this article [Understanding Exchange ActiveSync Reporting Services](/previous-versions/office/exchange-server-2010/bb201675(v=exchg.141)) to help you better understand some of the elements found with the IIS log entry.

#### Resync the Calendar folder

The previous steps taken help to identify why the issue occurred with the appointment. The ActiveSync client may not have the appointment in the correct state. To resolve this issue, remove the Calendar from the list of folders to synchronize, wait approximately five minutes, and then add the Calendar to the list of folders to synchronize.

**Is the appointment in the correct state on the ActiveSync client?**

- If yes, congratulations, your ActiveSync issue is resolved.
- If no, sorry, we cannot resolve the issue by using this guide. For more help resolving this issue contact [Microsoft Support](https://support.microsoft.com/). Please have all of the data collected from this troubleshooting available when you contact support.

### Prepare for Data Analysis; Log Parser Studio Query - Count Syncs with SyncKey of Zero Per User

#### Prepare for Data analysis

The ActiveSync client may have encountered errors while attempting to communicate with the Exchange server. Now we need to determine where these errors originated. We will start by checking the IIS logs on the Client Access Server. Before these logs can be analyzed, the workstation where the analysis will be completed should have Log Parser Studio installed. To do this, follow these steps:

1. Download and install [LogParser](https://www.microsoft.com/download/details.aspx?id=24659).

   - Double-click the **LogParser.msi** to begin the installation.
   - Select **Run** if the **Open File - Security Warning** is displayed.
   - On the Welcome screen, select **Next**.
   - On the End-User license agreement screen, review and accept the license agreement, and select **Next**.
   - On the Choose Setup Type screen, select **Complete**.
   - On the Ready to Install screen, select **Install**.
   - On the Completion screen, select **Finish**.

2. Download [Log Parser Studio](https://gallery.technet.microsoft.com/Log-Parser-Studio-cd458765) and extract the files.

Once LogParser is installed and Log Parser Studio has been extracted, copy the IIS logs from the Exchange server(s) to the local workstation for analysis.

#### Log Parser Studio Query - Count Syncs with SyncKey of Zero Per User

To determine if devices are resynchronizing with Exchange, run the Log Parser query to find the users. To do this, follow these steps:

1. Launch Log Parser Studio by double-clicking LPS.exe.
2. Select the Log folder icon to select files to process.

   :::image type="icon" source="media/troubleshoot-activesync-with-exchange-server/log-folder-icon.png":::

3. Select the Add Files or Add Folder button, then locate and select the file(s) copied earlier.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/log-file-manager.png" alt-text="Screenshot of the Log file manager window with the file copied earlier selected in the Prepare for Data Analysis; Count Syncs with SyncKey of Zero Per User section.":::

4. Verify the file/folder is selected and select **OK**.
5. Double-click **ActiveSync: Count Syncs with SyncKey of Zero Per User** from the Library.
6. Select the exclamation point icon to execute the query.

   :::image type="icon" source="media/troubleshoot-activesync-with-exchange-server/exclamation-point-icon.png":::

7. Analyze the results for this query.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/query-results.png" alt-text="Screenshot of the Count Syncs with SyncKey of Zero Per User Query results.":::

**Are there any devices with multiple requests using the SyncKey value of 0?**

- If yes, see [Log Parser Studio Query - Device Query](#log-parser-studio-query---device-query-if-using-synckey-value-of-0).
- If no, see [Log Parser Studio Query - Count all Syncs per SyncKey](#log-parser-studio-query---count-all-syncs-per-synckey).

### Log Parser Studio Query - Device Query (if using SyncKey value of 0)

To determine why the device sent a SyncKey of 0, analyze the device activity prior to the resync request. To do this, follow these steps:

1. Launch Log Parser Studio by double-clicking LPS.exe.
2. Select the Log folder icon to select files to process.

   :::image type="icon" source="media/troubleshoot-activesync-with-exchange-server/log-folder-icon.png":::

3. Select the Add Files or Add Folder button, then locate and select the file(s) copied earlier.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/log-file-manager.png" alt-text="Screenshot of the Log file manager window with the file copied earlier selected in the Prepare for Data Analysis; Log Parser Studio Query - Count Syncs with SyncKey of Zero Per User section.":::

4. Verify the file/folder is selected and select **OK**.
5. Double-click **ActiveSync: Device query** from the Library.
6. Modify the DeviceId value in the WHERE clause at the end of the query with the value from the previous step.
7. Select the exclamation point icon to execute the query.

   :::image type="icon" source="media/troubleshoot-activesync-with-exchange-server/exclamation-point-icon.png":::


8. Analyze the results for this query by locating the request where the value in the **SyncKey** column is 0. Then look at the previous requests where the **Cmd=Sync** and check if the sc-status value is 5xx.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/previous-requests.png" alt-text="Screenshot of the query result when you select the request where the value in the SyncKey column is 0.":::

**Example**: In the above image, there are multiple Sync requests prior to the request containing the SyncKey value of 0. None of these requests received an HTTP 500 response from IIS. There is a [known issue](https://support.apple.com/HT203719) where multiple HTTP 500 responses will cause a device to resync.

**Does this Sync request result in an HTTP status code of 500?**

- If yes, see [Enable Failed Request Tracing; Failed Request Trace Logging Analysis](#enable-failed-request-tracing-failed-request-trace-logging-analysis).
- If no, see [Device Activity Analysis](#device-activity-analysis).

### Enable failed request tracing; Failed request trace logging analysis

#### Enable failed request tracing

To determine the cause of the HTTP 500 errors, enable failed request tracing on the Microsoft-Server-ActiveSync virtual directory. To do this, follow these steps:

1. [Open IIS Manager](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc770472(v=ws.10)).
2. Expand the server, expand **Sites**, and select the **Default Web Site**.
3. Select **Failed Request Tracing** in the **Actions** pane.
4. Select **Enable** and enter a different directory path if needed and select **OK**.
5. Expand the **Default Web Site** and select the **Microsoft-Server-ActiveSync** virtual directory.
6. In **Features View**, double-click **Failed Request Tracing Rules**.
7. Select **Add** in the **Actions** pane.
8. Select **All** content and select **Next**.
9. Enter the HTTP status code found earlier when parsing the IIS log and select **Next**.
10. Select **Finish**.

Once failed request tracing has been enabled, reproduce the connection issue by attempting another Sync on the device.

#### Failed request trace logging analysis

To resolve this issue, review the failed request tracing logs to determine the cause. Here is an example set of logs and the request summary gives basic information on the error:

:::image type="content" source="media/troubleshoot-activesync-with-exchange-server/failed-request-tracing-logs.png" alt-text="Screenshot of the failed request tracing logs.":::

Then when reviewing the Compact View tab, additional details including the username supplied are available.

:::image type="content" source="media/troubleshoot-activesync-with-exchange-server/review-the-compact-view-tab.png" alt-text="Screenshot of the Compact View tab including the username supplied." lightbox="media/troubleshoot-activesync-with-exchange-server/review-the-compact-view-tab.png":::

**Was the issue resolved using the failed request tracing logs?**

- If yes, congratulations, your ActiveSync issue is resolved.
- If no, see [Capture Fiddler Trace](#capture-fiddler-trace-if-issue-isnt-resolved).

### Device activity analysis

To determine if a previous request caused the device to send the SyncKey value of 0, review the results from the previous query. To do this, follow these steps:

1. Launch Log Parser Studio by double-clicking LPS.exe.
2. Select the Log folder icon to select files to process.

   :::image type="icon" source="media/troubleshoot-activesync-with-exchange-server/log-folder-icon.png":::

3. Select the Add Files or Add Folder button, then locate and select the file(s) copied earlier.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/log-file-manager.png" alt-text="Screenshot of the Log file manager window with the file copied earlier selected in the Enable failed request tracing; Failed request trace logging analysis section.":::

4. Verify the file/folder is selected and select **OK**.
5. Double-click **ActiveSync: Request with ActiveSync errors** from the Library.
6. Select the exclamation point icon to execute the query.

    :::image type="icon" source="media/troubleshoot-activesync-with-exchange-server/exclamation-point-icon.png":::

7. Analyze the results for this query by referencing the **Status** response with the device **Cmd**. Use the [ActiveSync protocol documentation](/openspecs/exchange_server_protocols/ms-ascmd/3bc7cad1-daa7-4a18-965b-b5fbf2a3b510) as a reference. For example, any [Ping](/openspecs/exchange_server_protocols/ms-ascmd/cec19b0e-b7f9-4967-9569-39c73746efc4) request that results in a status greater than 2 is an error and should be investigated further. Any [Sync](/openspecs/exchange_server_protocols/ms-ascmd/08151746-faf7-40a3-832b-b42e88a0b729) request that results in a status greater than 1 is an error and should be investigated further.

**Are there any requests that result in an error status code?**

- If yes, see [Review Protocol Document](#review-protocol-document).
- If no, see [Capture Fiddler Trace](#capture-fiddler-trace-if-issue-isnt-resolved).

### Review protocol document

To determine what that status response code represents, use the [ActiveSync Command Reference Protocol Specification](/openspecs/exchange_server_protocols/ms-ascmd/3bc7cad1-daa7-4a18-965b-b5fbf2a3b510). To do this, follow these steps:

1. Open the [ActiveSync Command Reference Protocol Specification](/openspecs/exchange_server_protocols/ms-ascmd/3bc7cad1-daa7-4a18-965b-b5fbf2a3b510).
2. Review the results from the previous query for any errors and research the Status value.
3. Address the issues based on the cause shown in the protocol documentation.

Example results from query executed in the previous step:

:::image type="content" source="media/troubleshoot-activesync-with-exchange-server/results-details-1.png" alt-text="Screenshot of the Request with ActiveSync errors query results details." border="false":::

These results show that a Ping command resulted in a status code of 3. Using the ActiveSync protocol document, this error is caused by the request sent by the device. The device should send another Ping request.

:::image type="content" source="media/troubleshoot-activesync-with-exchange-server/results-details-2.png" alt-text="Screenshot of the result shows that a Ping command resulted in a status code of 3." border="false":::

The results also show a Sync command that received a response with a status code of 4. Once again, this error is caused by the request sent by the device.

:::image type="content" source="media/troubleshoot-activesync-with-exchange-server/results-details-3.png" alt-text="Screenshot of the result shows a Sync command that received a response with a status code of 4." border="false":::

**Was the issue resolved using the ActiveSync status in the response?**

- If yes, congratulations, your ActiveSync issue is resolved.
- If no, see [Log Parser Studio Query - Count all Syncs per SyncKey](#log-parser-studio-query---count-all-syncs-per-synckey).

### Capture fiddler trace (if issue isn't resolved)

ActiveSync device requests do not always reach the destination as desired. To ensure the device request and response is being sent and received as expected, route the device through an HTTP proxy and review the data. To do this, follow these steps:

1. Download and install [Fiddler](https://www.telerik.com/download/fiddler) onto a workstation.
2. Download [EAS Inspector for Fiddler](https://archive.codeplex.com/?p=easinspectorforfiddler).
3. Extract **EASInspectorFiddler.dll** into the **c:\Program Files\Fiddler2\Inspectors** folder.
4. Launch the Fiddler application.
5. Select the **Tools** menu and select **Fiddler Options**.
6. Go to the **HTTPS** tab and select **Decrypt HTTPS traffic**, select **Yes** to all prompts.
7. Go to the Connections tab and select **Allow remote computers to connect**, select **OK** to any prompt.
8. Select **OK** and close the Fiddler application.
9. Configure the ActiveSync device to use this workstation as a proxy server.
10. Launch the Fiddler application.
11. Attempt to Sync the ActiveSync device.
12. Select the **File** menu and select **Capture Traffic** to stop the trace.

    :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/capture-fiddler-trace.png" alt-text="Screenshot of the HTTPS Traffic captured in Fiddler.":::

**Do you see the ActiveSync request receive a 500 HTTP response?**

- If yes, see [Fiddler Trace Analysis](#fiddler-trace-analysis-receive-500-http-response).
- If no, see [Reprovision the ActiveSync Client](#reprovision-the-activesync-client-if-see-500-http-response).

### Reprovision the ActiveSync client (if see 500 HTTP response)

To resolve this issue, reprovision the ActiveSync client. To do this, follow these steps:

1. Remove the current ActiveSync profile for the mailbox following the device guidelines
2. Create an ActiveSync profile for the mailbox following the device guidelines

**Did reprovisioning the ActiveSync client resolve the issue?**

- If yes, congratulations, your ActiveSync issue is resolved.
- If no, see [Log Parser Studio Query - Count all Syncs per SyncKey](#log-parser-studio-query---count-all-syncs-per-synckey).

### Fiddler trace analysis (receive 500 HTTP response)

The Fiddler trace shows the ActiveSync device did not receive a successful response from its destination. Further analysis of the trace is required to determine where the response originated. To do this, follow these steps:

**Example: User is using the Windows Mail App to access e-mail. Currently the device is not receiving new messages and there is an error message in the upper right-hand corner stating the mailbox is unavailable:

:::image type="content" source="media/troubleshoot-activesync-with-exchange-server/fiddler-trace-analysis-4.png" alt-text="Screenshot of the mailbox is unavailable error message.":::

Analysis of the Fiddler trace shows the connection to the Exchange server resulted in an HTTP 500 error.

:::image type="content" source="media/troubleshoot-activesync-with-exchange-server/fiddler-trace-analysis-5.png" alt-text="Screenshot of the analysis of the Fiddler trace.":::

Analysis of the HTTP response show an internal server error and the details of the error give an indication to the issue. In this example, all of the servers in the TMG server farm were drained so TMG had no available destination for the request.

:::image type="content" source="media/troubleshoot-activesync-with-exchange-server/fiddler-trace-analysis-3.png" alt-text="Screenshot of the TextView of the HTTP response analysis.":::

**Did the Fiddler trace analysis help resolve the issue?**

- If yes, congratulations, your ActiveSync issue is resolved.
- If no, see [Log Parser Studio Query - Count all Syncs per SyncKey](#log-parser-studio-query---count-all-syncs-per-synckey).

### Log Parser Studio Query - Count all Syncs per SyncKey

To determine if devices are sending the same SyncKey to Exchange for the same folder, run the Log Parser query associated with this issue. To do this, follow these steps:

1. Launch Log Parser Studio by double-clicking LPS.exe.
2. Select the Log folder icon to select files to process.

   :::image type="icon" source="media/troubleshoot-activesync-with-exchange-server/log-folder-icon.png":::

3. Select the Add Files or Add Folder button, then locate and select the file(s) copied earlier.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/log-file-manager.png" alt-text="Screenshot of the Log file manager window with the file copied earlier selected in the Log Parser Studio Query - Count all Syncs per SyncKey section.":::

4. Verify the file/folder is selected and select OK.
5. Double-click **ActiveSync: Count all Syncs per SyncKey** from the Library.
6. Select the exclamation point icon to execute the query.

   :::image type="icon" source="media/troubleshoot-activesync-with-exchange-server/exclamation-point-icon.png":::

7. Analyze the results for this query.

**Are there any devices sending the same SyncKey multiple times for the same folder?**

- If yes, see [Log Parser Studio Query – Device Query](#log-parser-studio-query---device-query-devices-send-same-synckey-multiple-times).
- If no, see [Log Parser Studio Query - High RPC counts or latency](#log-parser-studio-query---high-rpc-counts-or-latency).

### Log Parser Studio Query - Device Query (devices send same SyncKey multiple times)

To determine if the client should be sending the same SyncKey, check the status code in the ActiveSync response. To do this, follow these steps:

1. Launch Log Parser Studio by double-clicking LPS.exe.
2. Select the Log folder icon to select files to process.

    :::image type="icon" source="media/troubleshoot-activesync-with-exchange-server/log-folder-icon.png":::

3. Select the Add Files or Add Folder button, then locate and select the file(s) copied earlier.

    :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/log-file-manager.png" alt-text="Screenshot of the Log file manager window with the file copied earlier selected in the Device Query (devices send same SyncKey multiple times) section.":::

4. Verify the file/folder is selected and select **OK**.
5. Double-click **ActiveSync: Device query** from the Library.
6. Select the exclamation point icon to execute the query.

    :::image type="icon" source="media/troubleshoot-activesync-with-exchange-server/exclamation-point-icon.png":::

7. Analyze the results for this query.

Are there any requests where the **Status** value does not equal **1**?

- If yes, see [Review Protocol Document](#review-protocol-document-status-equals-1).
- If no, see [Reprovision the ActiveSync Client](#reprovision-the-activesync-client).

### Reprovision the ActiveSync client

To resolve this issue, reprovision the ActiveSync client. To do this, follow these steps:

1. Remove the current ActiveSync profile for the mailbox following the device guidelines
2. Create an ActiveSync profile for the mailbox following the device guidelines

**Did reprovisioning the ActiveSync client resolve the issue?**

- If yes, congratulations, your ActiveSync issue is resolved.
- If no, see [Log Parser Studio Query - High RPC counts or latency](#log-parser-studio-query---high-rpc-counts-or-latency).

### Review protocol document (Status equals 1)

To determine what that status response code represents, use the [ActiveSync Command Reference Protocol Specification](/openspecs/exchange_server_protocols/ms-ascmd/3bc7cad1-daa7-4a18-965b-b5fbf2a3b510). To do this, follow these steps:

1. Open the [ActiveSync Command Reference Protocol Specification](/openspecs/exchange_server_protocols/ms-ascmd/3bc7cad1-daa7-4a18-965b-b5fbf2a3b510).
2. Review the results from the previous query for any errors and research the Status value.
3. Address the issues based on the cause shown in the protocol documentation.

Example results from query executed in the previous step:

:::image type="content" source="media/troubleshoot-activesync-with-exchange-server/results-details-1.png" alt-text="Screenshot of query results details example." border="false":::

These results show that a Ping command resulted in a status code of 3. Using the ActiveSync protocol document, this error is caused by the request sent by the device. The device should send another Ping request.

:::image type="content" source="media/troubleshoot-activesync-with-exchange-server/results-details-2.png" alt-text="Screenshot of the result shows that a Ping command resulted in a status code of 3." border="false":::

The results also show a Sync command that received a response with a status code of 4. Once again, this error is caused by the request sent by the device.

:::image type="content" source="media/troubleshoot-activesync-with-exchange-server/results-details-3.png" alt-text="Screenshot of the result shows a Sync command that received a response with a status code of 4." border="false":::

**Was the issue resolved by addressing the ActiveSync errors?**

- If yes, congratulations, your ActiveSync issue is resolved.
- If no, see [Log Parser Studio Query - High RPC counts or latency](#log-parser-studio-query---high-rpc-counts-or-latency).

### Log Parser Studio Query - High RPC counts or latency

To determine if ActiveSync requests are causing resource consumption, run the associated Log Parser query. To do this, follow these steps:

1. Launch Log Parser Studio by double-clicking LPS.exe.
2. Select the Log folder icon to select files to process.

    :::image type="icon" source="media/troubleshoot-activesync-with-exchange-server/log-folder-icon.png":::

3. Select the Add Files or Add Folder button, then locate and select the file(s) copied earlier.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/log-file-manager.png" alt-text="Screenshot of the Log file manager window with the file copied earlier selected in the Log Parser Studio Query - High RPC counts or latency section.":::

4. Verify the file/folder is selected and select **OK**.
5. Double-click **ActiveSync: High RPC counts or latency** from the Library.
6. Select the exclamation point icon to execute the query.
   :::image type="icon" source="media/troubleshoot-activesync-with-exchange-server/exclamation-point-icon.png":::

7. Analyze the results for this query.

**Are there any requests with high RPC counts or latency?**

- If yes, see [Disable Exchange ActiveSync for User](#disable-exchange-activesync-for-user).
- If no, see [Log Parser Studio Query - Report [Top 20]; Log Parser Studio Query - Device Query](#log-parser-studio-query---report-top-20-log-parser-studio-query---device-query).

### Disable Exchange ActiveSync for user

To resolve this issue, disable ActiveSync for the user causing the high RPC counts. To do this, follow these steps:

1. Open the [Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell).
2. Run the following cmdlet to disable ActiveSync for the mailbox:

    ```powershell
    Set-CASMailbox user -ActiveSyncEnabled:$False
    ```

**Did disabling ActiveSync for this mailbox resolve the issue?**

- If yes, see [Reprovision the ActiveSync Client](#reprovision-the-activesync-client-if-disabling-activesync-solves-the-issue).
- If no, see [Log Parser Studio Query - Report [Top 20]; Log Parser Studio Query - Device Query](#log-parser-studio-query---report-top-20-log-parser-studio-query---device-query).

### Reprovision the ActiveSync client (if disabling ActiveSync solves the issue)

To resolve this issue, reprovision the ActiveSync client. To do this, follow these steps:

1.Remove the current ActiveSync profile for the mailbox following the device guidelines.
2.Create an ActiveSync profile for the mailbox following the device guidelines.

**Did reprovisioning the ActiveSync client resolve the issue?**

- If yes, congratulations, your ActiveSync issue is resolved.
- If no, see [Enable ActiveSync Mailbox Logging; Analyze ActiveSync Mailbox Log](#enable-activesync-mailbox-logging-analyze-activesync-mailbox-log).

### Enable ActiveSync mailbox logging; Analyze ActiveSync mailbox log

#### Enable ActiveSync mailbox logging

To determine the ActiveSync response that is causing the failure, mailbox logging must be enabled. Additional information on mailbox logging can be found [Exchange ActiveSync Mailbox Logging](/archive/blogs/jasonsla/exchange-activesync-mailbox-logging). To do this, follow these steps:

> [!NOTE]
> This change should be made on Exchange 2013 mailbox servers.

1. Open Windows Explorer and browse to the Sync folder (C:\Program Files\Microsoft\Exchange Server\V14\ClientAccess\Sync).
2. Make a copy of the web.config file.
3. Open the web.config file in Notepad and modify the following sections with the values below:

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/open-web-config-file-in-notepad.png" alt-text="Screenshot of the values you need to modify with in the Enable ActiveSync mailbox logging; Analyze ActiveSync mailbox log section.":::

4. [Open IIS Manager](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc770472(v=ws.10)).
5. Expand the server and select **Application Pools**.
6. Right-click on the **MSExchangeSyncAppPool** and select **Advanced Settings**.
7. Right-click on the **MSExchangeSyncAppPool** and select **Stop**.
8. Right-click on the **MSExchangeSyncAppPool** and select **Start**.
9. Open the [Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell).
10. Run the following cmdlet to enable the mailbox logging for a user:

    ```powershell
    Set-CASMailbox user -ActiveSyncDebugLogging:$True
    ```

#### Analyze ActiveSync mailbox log

To resolve this issue, review the mailbox log after attempting another Sync request. To do this, follow these steps:

1. Open the [Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell).
2. Run the following cmdlet to retrieve the mailbox log for a user:

    ```powershell
    Get-ActiveSyncDeviceStatistics -Mailbox user -GetMailboxLog:$True -NotificationEmailAddresses admin@contoso.com
    ```

    > [!NOTE]
    > This will send the ActiveSync mailbox log to the specified email address for analysis. Additional information on mailbox logging can be found [here](https://blogs.technet.com/b/jasonsla/archive/2013/03/19/exchange-activesync-mailbox-logging.aspx).

3. Download [MailboxLogParser](https://github.com/search?q=MailboxLogParser) and extract the files.
4. Launch the utility by opening **MailboxLogParser.exe**.
5. Select **Import Mailbox Logs to Grid** to open the mailbox log.
6. Enter **Cmd=Sync** under **Search raw log data for strings** and select **Search**.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/mailbox-log-parser.png" alt-text="Screenshot of the Search raw log data for strings box in Mailbox Log Parser.":::

7. Review any entry where the Status column value is not empty or **1**.

> [!NOTE]
> For more information on Exchange ActiveSync mailbox logging analysis, see [Under The Hood: Exchange ActiveSync Mailbox Log Analysis](https://techcommunity.microsoft.com/t5/exchange-team-blog/under-the-hood-exchange-activesync-mailbox-log-analysis/ba-p/591224).

**Did reviewing the ActiveSync mailbox log resolve the issue?**

- If yes, congratulations, your ActiveSync issue is resolved.
- If no, see [Log Parser Studio Query - Report [Top 20]; Log Parser Studio Query - Device Query](#log-parser-studio-query---report-top-20-log-parser-studio-query---device-query).

### Log Parser Studio Query - Count all errors

To determine if devices are generating errors, run the associated Log Parser query. To do this, follow these steps:

1. Launch Log Parser Studio by double-clicking LPS.exe.
2. Select the Log folder icon to select files to process.

    :::image type="icon" source="media/troubleshoot-activesync-with-exchange-server/log-folder-icon.png":::

3. Select the Add Files or Add Folder button, then locate and select the file(s) copied earlier.

    :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/log-file-manager.png" alt-text="Screenshot of the Log file manager window with the file copied earlier selected in the Log Parser Studio Query - Count all errors section.":::

4. Verify the file/folder is selected and select **OK**.
5. Double-click **ActiveSync: Count all errors** from the Library
6. Select the exclamation point icon to execute the query

    :::image type="icon" source="media/troubleshoot-activesync-with-exchange-server/exclamation-point-icon.png":::

7. Analyze the results for this query.

    :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/count-all-errors.png" alt-text="Screenshot of the result of Count all errors query in the Log Parser Studio Query - Report [Top 20]; Device Query section.":::

    > [!NOTE]
    > The following errors can be safely ignored: MissingCscCacheEntry, PingCollisionDetected, SyncCollisionDetected

8. Address the errors found in the results.

**Was the issue resolved by addressing the ActiveSync errors in the IIS logs?**

- If yes, see [Log Parser Studio Query for Errors](#log-parser-studio-query-for-errors).
- If no, see [Capture Performance Data; Analyze Performance Data](#capture-performance-data-analyze-performance-data).

### Log Parser Studio Query - Report [Top 20]; Log Parser Studio Query - Device Query

#### Log Parser Studio Query - Report [Top 20]

To determine if one or more users are contributing to the performance issue, run the associated Log Parser query to identify these users. To do this, follow these steps:

1. Launch Log Parser Studio by double-clicking LPS.exe.
2. Select the Log folder icon to select files to process.

    :::image type="icon" source="media/troubleshoot-activesync-with-exchange-server/log-folder-icon.png":::

3. Select the Add Files or Add Folder button, then locate and select the file(s) copied earlier.

    :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/log-file-manager.png" alt-text="Screenshot of the Log file manager window with the file copied earlier selected in the Log Parser Studio Query - Report [Top 20] section.":::

4. Verify the file/folder is selected and select **OK**.
5. Double-click **ActiveSync: Report [Top 20]** from the Library.
6. Select the exclamation point icon to execute the query.

    :::image type="icon" source="media/troubleshoot-activesync-with-exchange-server/exclamation-point-icon.png":::


7. Analyze the results for this query

    :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/query-results-for-report-top-20.png" alt-text="Screenshot of the query results example for Report [Top 20].":::

These results must be analyzed to determine what type of traffic users are sending to the Exchange server(s).

#### Log Parser Studio Query - Device Query

To determine device traffic, analyze the device activity using the associated Log Parser query. To do this, follow these steps:

1. Launch Log Parser Studio by double-clicking LPS.exe.
2. Select the Log folder icon to select files to process.

    :::image type="icon" source="media/troubleshoot-activesync-with-exchange-server/log-folder-icon.png":::

3. Select the Add Files or Add Folder button, then locate and select the file(s) copied earlier.

    :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/log-file-manager.png" alt-text="Screenshot of the Log file manager window with the file copied earlier selected in the Log Parser Studio Query - Device Query section.":::

4. Verify the file/folder is selected and select **OK**.
5. Double-click **ActiveSync: Device query** from the Library
6. Modify the DeviceId value in the WHERE clause at the end of the query with the value from the previous step.
7. Select the exclamation point icon to execute the query.

    :::image type="icon" source="media/troubleshoot-activesync-with-exchange-server/exclamation-point-icon.png":::

8. Analyze the results for this query and look for any trends.

    :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/device-query-results.png" alt-text="Screenshot of the Device Query results.":::

**Were you able to resolve the issue by identifying a pattern in user activity?**

- If yes, congratulations, your ActiveSync issue is resolved.
- If no, see [Log Parser Studio Query - Count all errors](#log-parser-studio-query---count-all-errors).

### Capture performance data; Analyze performance data

#### Capture performance data

To determine if the Exchange server(s) are experiencing performance issue, capture performance data from each of the Exchange servers. To do this, follow these steps:

1. Download [ExPerfwiz](https://archive.codeplex.com/?p=experfwiz) and extract the contents to the *%ExchangeInstallPath%\Scripts* folder.
2. Open the [Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell).
3. Run the following to change the folder path:

    ```powershell
    cd $exscripts
    ```

4. Run the following cmdlet to allow the script to run:

    ```powershell
    Set-ExecutionPolicy unrestricted
    ```

5. Enter **Y** to change the execution policy.
6. Run the following command to create the data collector set:

    ```console
    .\ExPerfwiz.ps1 -duration 04:00:00 -full -filepath c:\Temp -interval 5
    ```

7. Enter **R** to run the script.
8. Enter **Y** to start the data collector set.

#### Analyze performance data

To resolve this issue, analyze the performance data and address any issues found. To do this, follow these steps:

1. Wait for the data collector set to complete the data collection from the previous step (command syntax collects data for 4 hours).
2. Open Performance Monitor.
3. In the console pane toolbar, select the **Add Log Data** button. The **Performance Monitor properties** page will open at the **Source** tab.
4. In the Data Source section, select **Log files** > **Add**.
5. Browse to the log file you want to view and select **Open**. To add multiple log files to the Performance Monitor view, select **Add** again.
6. When you are finished selecting log files, select **OK**.
7. Right-click in the Performance Monitor display and select **Add Counters**. The **Add Counters** dialog box will open. Only the counters included in the log file or files you selected in step 4 will be available.
8. Select the counters you want to view in the **Performance Monitor** graph and select **OK**.
9. Use the [Performance and Scalability Counters and Thresholds](/previous-versions/office/exchange-server-2010/dd335215(v=exchg.141)) article to validate the performance data from your environment.

**Was the issue resolved by address server performance issue?**

- If yes, congratulations, your ActiveSync issue is resolved.
- If no, sorry, we cannot resolve the issue by using this guide. For more help resolving this issue contact [Microsoft Support](https://support.microsoft.com). Please have all of the data collected from this troubleshooting available when you contact support.

### Log Parser Studio query for errors

To determine if these errors are causing a performance issue, run a Log Parser query for these errors. To do this, follow these steps:

1. Launch Log Parser Studio by double-clicking LPS.exe.
2. Select the Log folder icon to select files to process.

    :::image type="icon" source="media/troubleshoot-activesync-with-exchange-server/log-folder-icon.png":::

3. Select the Add Files or Add Folder button, then locate and select the file(s) copied earlier.

    :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/log-file-manager.png" alt-text="Screenshot of the Log file manager window with the file copied earlier selected in the Log Parser Studio query for errors section.":::

4. Verify the file/folder is selected and select **OK**.
5. Go to the **File** menu and select **New** > **Query**.
6. Enter the following query in the window:

    ```sql
    SELECT * FROM '[LOGFILEPATH]' WHERE cs-uri-query LIKE '%KeepAliveFailure%'
    ```

    > [!NOTE]
    > Replace KeepAliveFailure with the error found in the previous step.

7. Select the exclamation point icon to execute the query.

    :::image type="icon" source="media/troubleshoot-activesync-with-exchange-server/exclamation-point-icon.png":::

8. Analyze the results for this query and try to determine the cause of the error. In the following example, the `KeepAliveFailure` only occurs when requests are have the PrxTo to a CAS server in another site. Here we would want to investigate network connectivity issues between the two sites.

    :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/log-parser-studio-query-for-errors.png" alt-text="Screenshot of Log Parser Studio query for errors.":::

**Were you able to resolve the issue by address ActiveSync errors found in the IIS logs?**

- If yes, congratulations, your ActiveSync issue is resolved.
- If no, see [Capture Performance Data; Analyze Performance Data](#capture-performance-data-analyze-performance-data).

### Check for file level anti-virus

In many cases file-level anti-virus impacts ActiveSync traffic by delaying the processing of the request or response. Stopping these services does not disable the kernel mode filter driver used by these services. To disable file level anti-virus, follow the steps from [How to temporarily deactivate the kernel mode filter driver in Windows](https://support.microsoft.com/help/816071). Verify the kernel mode filter driver is no longer active after the Client Access Server has been restarted. To do this, follow these steps:

1. Open a command prompt.
2. Run the following command:

    ```console
    fltmc
    ```

3. Compare the results to the example filter drivers from [this article](https://support.microsoft.com/kb/816071) or search the web for the Filter Name.

   :::image type="content" source="media/troubleshoot-activesync-with-exchange-server/fltmc-output.png" alt-text="Screenshot of the output of the fltmc command.":::

**Did disabling the anti-virus kernel mode filter driver resolve the issue?**

- If yes, congratulations, your ActiveSync issue is resolved.
- If no, see [Exchange ActiveSync Application Pool](#exchange-activesync-application-pool).
