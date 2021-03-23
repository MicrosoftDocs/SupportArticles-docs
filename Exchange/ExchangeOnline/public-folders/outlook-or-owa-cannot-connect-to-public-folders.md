---
title: Outlook or OWA cannot connect to Public Folders
description: Troubleshoot an issue in which Exchange Online users can't connect to Public Folders by using Outlook or OWA.
ms.date: 08/19/2020
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Online
- CSSTroubleshoot
ms.reviewer: 
appliesto:
- Exchange Online
search.appverid: MET150
---
# Exchange Online users can't connect to public folders by using Outlook or OWA

_Original KB number:_ &nbsp; 4549862

**Who is it for?**

A tenant administrator whose users experience this issue.

**How does it work?**

We'll begin by asking you about the issue that users are facing. Then we'll take you through the specific guide for your situation.

**Estimated time of completion:**

60-90 minutes

## How many users experience this issue

- [All users](#does-the-issue-affect-outlook-or-owa)
- [Some users](#use-exchange-online-powershell)

### Use Exchange Online PowerShell

Connect to Exchange Online PowerShell, locate the `PublicFolderMailbox` parameter that's configured on working users, and then configure that parameter for the affected users. To do this, set the parameter to the same value as the `DefaultPublicFolderMailbox` parameter value.

For example, see the following screenshot.

:::image type="content" source="media/outlook-or-owa-cannot-connect-to-public-folders/defaultpfmailbox.jpg" alt-text="Commands to view and change DefaultPFMailbox" border="false":::

> [!NOTE]
> Wait at least one hour for change to take effect.

**Does this resolve your issue?**

- If yes, congratulations! Your problem is resolved. We're glad that this guide was helpful for you.
- If no, see [Does the issue affect Outlook or OWA](#does-the-issue-affect-outlook-or-owa).

### Is the public folder (PF) node visible in Outlook

To check whether the PF node is visible in Outlook, see the following example.

:::image type="content" source="media/outlook-or-owa-cannot-connect-to-public-folders/check-pf-node.png" alt-text="Public Folder node in Outlook":::

- [The PF node is visible](#do-users-get-credential-prompts-or-errors-when-they-try-to-expand-pf)
- [The PF node is not visible](#run-an-autodiscover-test-for-affected-users)

### Do users get credential prompts or errors when they try to expand PF

- [Yes](#check-if-the-publicfoldersenabled-parameter-is-local-or-remote)
- [No](#do-users-have-permissions-on-the-pf-tree-or-the-public-folder)

### Collect Outlook tracing log

Collect the Outlook tracing log and Fiddler trace when you reproduce the issue, and then open a support ticket for further help. For more information about how to collect logs, see [How to enable global and advanced logging for Microsoft Outlook](https://support.microsoft.com/help).

### Check if the PublicFoldersEnabled parameter is Local or Remote

To check whether the `PublicFoldersEnabled` parameter value is **Local** or **Remote**, see the command example in the following screenshot.

:::image type="content" source="media/outlook-or-owa-cannot-connect-to-public-folders/publicfoldersenabled-value.jpg" alt-text="local or remote" border="false":::

- [PublicFoldersEnabled is Local](#do-users-have-permissions-on-the-pf-tree-or-the-public-folder)
- [PublicFoldersEnabled is Remote](#is-that-a-cloud-only-pf-mailbox)

### Collect logs at on-premises Exchange Server

Collect logs at the on-premises server that is running Exchange Server, and then open a support ticket for further help. For more information about how to collect logs, go to [ExchangeLogCollector](https://github.com/dpaulson45/ExchangeLogCollector).

### Do users have permissions on the PF tree or the public folder

- [Yes](#collect-outlook-tracing-log)
- [No](#assign-correct-permissions-to-users-on-the-pf-tree)

### Assign correct permissions to users on the PF tree

**Does this resolve your issue?**

- If yes, congratulations! Your problem is resolved. We're glad that this guide was helpful for you.
- [No](#is-the-public-folder-pf-node-visible-in-outlook)

### Run an Autodiscover test for affected users

Run the **Autodiscover** test for affected users, and then check whether you see the **\<PublicFolderInformation>**  block in the Autodiscover response. To do this, see the following example.

:::image type="content" source="media/outlook-or-owa-cannot-connect-to-public-folders/public-folder-info.png" alt-text="Expected output showing public folder information":::

- [You see the \<PublicFolderInformation> block](#does-test-email-autodiscover-work-successfully-for-the-pf-mailbox)
- [You do not see the \<PublicFolderInformation> block](#is-the-pf-mailbox-assigned-to-the-user)

### Does Test Email Autodiscover work successfully for the PF mailbox

To check whether the **Test Email Autodiscover** feature works successfully for the PF mailbox, see the following example.

:::image type="content" source="media/outlook-or-owa-cannot-connect-to-public-folders/test-email-autodiscover.png" alt-text="Test Email AutoConfiguration":::

- [Test Email Autodiscover works successfully](#clear-autodiscover-xml-files)
- [Test Email Autodiscover does not work successfully](#collect-outlook-tracing-log)

### Clear Autodiscover XML files

Delete Autodiscover XML files, restart the Outlook client, and then try again. To do this, see [Unexpected Autodiscover behavior when you have registry settings under the \Autodiscover key](/outlook/troubleshoot/domain-management/unexpected-autodiscover-behavior).

**Does this resolve your issue?**

- If yes, congratulations! Your problem is resolved. We're glad that this guide was helpful for you.
- If no, see [Collect Outlook tracing log](#collect-outlook-tracing-log).

### Is the PF mailbox assigned to the user

1. Connect to Exchange Online PowerShell.
2. Run the following command to determine whether an effective PF mailbox is populated on the user mailbox:  

    ```powershell
    Get-Mailbox <mailbox name> | ft *eff*
    ```

See the following example.

:::image type="content" source="media/outlook-or-owa-cannot-connect-to-public-folders/get-mailbox.jpg" alt-text="default pf mailbox":::

- [The PF mailbox is assigned to the user](#check-whether-the-mailbox-is-excluded-from-the-pf-connection)
- [The PF mailbox is not assigned to the user](#check-whether-publicfoldersenabled-is-local-or-remote)

### Check whether the mailbox is excluded from the PF connection

To check whether the mailbox is excluded from the PF connection, see the command example in the following screenshot.

:::image type="content" source="media/outlook-or-owa-cannot-connect-to-public-folders/check-excluded-mailbox.jpg" alt-text="show control cmdlet" border="false":::

- [The mailbox is excluded from the PF connection](#check-the-link)
- [The mailbox is not excluded from the PF connection](#make-sure-that-the-pf-mailbox-is-ready-to-serve-hierarchy)

### Check the link

To do this, see [Announcing Support for Controlled Connections to Public Folders in Outlook](https://techcommunity.microsoft.com/t5/exchange-team-blog/announcing-support-for-controlled-connections-to-public-folders/ba-p/608591).

**Does this resolve your issue?**

- If yes, congratulations! Your problem is resolved. We're glad that this guide was helpful for you.
- If no, see [Collect Outlook tracing log](#collect-outlook-tracing-log).

### Check whether PublicFoldersEnabled is Local or Remote

To check whether the `PublicFoldersEnabled` parameter is **Local**  or **Remote**, run the following command:

```powershell
Get-OrganizationConfig | fl *Public*
```

See the following example.

:::image type="content" source="media/outlook-or-owa-cannot-connect-to-public-folders/publicfoldersenabled-value.jpg" alt-text="local or remote" border="false":::

- [Local](#is-rootpublicfoldermailbox-populated-by-a-valid-guid)
- [Remote](#are-on-premises-pf-mailboxes-or-proxies-synced-to-the-cloud)

### Is RootPublicFolderMailbox populated by a valid GUID

To check whether the `RootPublicFolderMailbox` parameter is populated by using a valid GUID, see the command example in the following screenshot.

:::image type="content" source="media/outlook-or-owa-cannot-connect-to-public-folders/check-rootpublicfoldermailbox.png" alt-text="root pf mailbox" border="false":::

- [RootPublicFolderMailbox is populated by valid GUID](#make-sure-that-the-pf-mailbox-is-ready-to-serve-hierarchy)
- [RootPublicFolderMailbox is not populated by valid GUID](#make-sure-that-the-public-folders-are-deployed-correctly)

### Make sure that the PF mailbox is ready to serve hierarchy

To make sure that the PF mailbox is ready to serve hierarchy, run the following command:

```powershell
Get-Mailbox -PublicFolder | fl *hier*
```

You may see the following output:

```console
IsExcludedFromServingHierarchy : False
IsHierarchyReady               : True
IsHierarchySyncEnabled         : True
```

See the following example.

:::image type="content" source="media/outlook-or-owa-cannot-connect-to-public-folders/pf-mailbox-hierarchy-example.jpg" alt-text="PF Mailbox hierarchy example":::

- [The PF mailbox is ready to serve hierarchy](#make-sure-that-the-pf-hierarchy-is-in-sync-for-pf-mailboxes)
- [The PF mailbox is not ready to serve hierarchy](#set-defaultpublicfoldermailbox-manually-or-enable-some-pf-mailboxes-to-server-hierarchy)

### Make sure that the public folders are deployed correctly

To make sure that the public folders are deployed correctly, see [Create a public folder mailbox](/exchange/collaboration-exo/public-folders/create-public-folder-mailbox).

**Does this resolve your issue?**

- If yes, congratulations! Your problem is resolved. We're glad that this guide was helpful for you.
- If no, see [Collect Outlook tracing log](#collect-outlook-tracing-log).

### Make sure that the PF hierarchy is in sync for PF mailboxes

To make sure that the PF hierarchy is in sync for PF mailboxes, see the command example in following screenshot.

:::image type="content" source="media/outlook-or-owa-cannot-connect-to-public-folders/force-hierarchy-sync-cmdlet-example.jpg" alt-text="force hierarchy sync cmdlet and result example" border="false":::

**Does this resolve your issue?**

- If yes, congratulations! Your problem is resolved. We're glad that this guide was helpful for you.
- If no, see [Collect Outlook tracing log](#collect-outlook-tracing-log).

### Set DefaultPublicFolderMailbox manually or enable some PF mailboxes to server hierarchy

Either set the `DefaultPublicFolderMailbox` parameter manually or enable some PF mailboxes to server hierarchy.

**Does this resolve your issue?**

- If yes, congratulations! Your problem is resolved. We're glad that this guide was helpful for you.
- If no, see [Collect Outlook tracing log](#collect-outlook-tracing-log).

### Does the issue affect Outlook or OWA

- [Outlook](#is-the-public-folder-pf-node-visible-in-outlook)
- [OWA](#is-publicfoldersenabled-set-to-remote)

### Is PublicFoldersEnabled set to Remote

To check whether `PublicFoldersEnabled` is set to **Remote**, see the command example in the following screenshot.

:::image type="content" source="media/outlook-or-owa-cannot-connect-to-public-folders/get-the-publicfoldersenabled-value.jpg" alt-text="Command to check PublicFoldersEnabled setting" border="false":::

- If Local, collect F12 logs or a Fiddler trace, and open a support issue for further help.
- If [Remote](#owa-cant-access-public-folders-in-the-remote-configuration)

### OWA can't access public folders in the Remote configuration

OWA can't access public folders in the **Remote** configuration. Try the result when public folders are enabled in the **Local** configuration.

### Are on-premises PF mailboxes or proxies synced to the cloud

The on-premises PF mailboxes should be synced as a mail-enabled user on the cloud.

:::image type="content" source="media/outlook-or-owa-cannot-connect-to-public-folders/validate-onpremise-pf-mbx.jpg" alt-text="Validate that onpremise PF MBX synced as MEU (2)":::

The proxy mailbox is synced correctly to the cloud as a mail-enabled user.

:::image type="content" source="media/outlook-or-owa-cannot-connect-to-public-folders/validate-proxy-mbx.jpg" alt-text="Validate proxy mailbox":::

- [Yes](#does-the-remote-pf-mailbox-on-exchange-online-include-the-on-premises-proxy-pf-mailbox)
- [No](#make-sure-that-the-proxy-pf-mailbox-is-synced)

### Make sure that the proxy PF mailbox is synced

Make sure that the proxy PF mailbox is synced correctly, and wait for the cache to be updated. For more information, see [Troubleshoot an object that is not synchronizing with Azure Active Directory](/azure/active-directory/hybrid/tshoot-connect-object-not-syncing).

**Does this resolve your issue?**

- If yes, congratulations! Your problem is resolved. We're glad that this guide was helpful for you.
- If no, we’re sorry that your issue can't be resolved by this guide. Open a support ticket for further help.

### Does the remote PF mailbox on Exchange Online include the on-premises proxy PF mailbox

To determine this, see the command example in the following screenshot.

:::image type="content" source="media/outlook-or-owa-cannot-connect-to-public-folders/command-example.jpg" alt-text="command example 1" border="false":::

**Does this resolve your issue?**  

- [Yes](#make-sure-that-the-effective-pf-mailbox-shows-the-values-from-the-remote-pf-mailbox)
- [No](#configure-the-remote-pf-mailbox)

### Make sure that the effective PF mailbox shows the values from the remote PF mailbox

To determine this, see the command example in the following screenshot.

:::image type="content" source="media/outlook-or-owa-cannot-connect-to-public-folders/command-example-2.jpg" alt-text="command example 2" border="false":::

**Does this resolve your issue?**

- If yes, congratulations! Your problem is resolved. We're glad that this guide was helpful for you.
- If no, we’re sorry that your issue can't be resolved by this guide. Open a support ticket for further help.

### Configure the remote PF mailbox

To configure the remote PF mailbox, refer to the following articles. Then, wait for an hour, and check your access again.

- For Exchange 2010, see [Configure legacy on-premises public folders for a hybrid deployment](/exchange/collaboration-exo/public-folders/set-up-legacy-hybrid-public-folders).
- For Exchange 2013 and later versions, see [Configure Exchange Server public folders for a hybrid deployment](/exchange/collaboration-exo/public-folders/set-up-modern-hybrid-public-folders).

**Does this resolve your issue?**

- If yes, congratulations! Your problem is resolved. We're glad that this guide was helpful for you.
- If no, we’re sorry that your issue can't be resolved by this guide. Open a support ticket for further help.

### Is that a cloud-only PF mailbox

To determine this, see the command example in the following screenshot.

:::image type="content" source="media/outlook-or-owa-cannot-connect-to-public-folders/command-example-3.jpg" alt-text="command example 3":::

- [Yes](#smtp-soft-matching)
- [No](#is-a-valid-x500-address-stamped-on-the-on-premises-user)

### SMTP (soft) matching

To soft match on-premises user accounts to Office 365 user accounts, see [How to use SMTP matching to match on-premises user accounts to Office 365 user accounts for directory synchronization](https://support.microsoft.com/help/2641663).

**Does this resolve your issue?**

- If yes, congratulations! Your problem is resolved. We're glad that this guide was helpful for you.
- If no, we’re sorry that your issue can't be resolved by this guide. Open a support ticket for further help.

### Is a valid X500 address stamped on the on-premises user

To determine this, see the command examples in the following screenshots.

In on-premises

:::image type="content" source="media/outlook-or-owa-cannot-connect-to-public-folders/command-example-4.jpg" alt-text="command example 4":::

In Exchange Online

:::image type="content" source="media/outlook-or-owa-cannot-connect-to-public-folders/command-example-5.jpg" alt-text="command example 5" border="false":::

- [Yes](#what-is-the-version-of-exchange-server-thats-hosting-the-pfs)
- [No](#add-a-valid-x500-address-on-the-user)

### What is the version of Exchange Server that's hosting the PFs

For more information about Exchange Server build numbers and release dates, see [Exchange Server build numbers and release dates](/exchange/new-features/build-numbers-and-release-dates?view=exchserver-2019).

- [Exchange 2010](#is-outlook-anywhere-enabled-on-the-server-that-hosts-the-pf-database)
- [Exchange 2019, 2016, or 2013](#collect-logs-at-on-premises-exchange-server)

### Add a valid X500 address on the user

If the X500 value is missing on the on-premises object, initiate delta sync on the computer on which Azure AD Connect is installed. For more information, see [PowerShell Basics: How to Force AzureAD Connect to Sync](https://techcommunity.microsoft.com/t5/itops-talk-blog/powershell-basics-how-to-force-azuread-connect-to-sync/ba-p/887043).

Alternatively, add X500 address manually by running this command on-premises:

```powershell
Set-RemoteMailbox -Identity "mailbox name" -EmailAddresses @{add="X500:replace with legacyexchangeDN value from the cloud object"}
```

For more information about `Set-RemoteMailbox`, see this [article](/powershell/module/exchange/set-remotemailbox?view=exchange-ps).

**Does this resolve your issue?**

- If yes, congratulations! Your problem is resolved. We're glad that this guide was helpful for you.
- If no, see [Collect logs at on-premises Exchange Server](#collect-logs-at-on-premises-exchange-server).

### Is Outlook Anywhere enabled on the server that hosts the PF database

To determine this, see the command example in the following screenshot.

:::image type="content" source="media/outlook-or-owa-cannot-connect-to-public-folders/command-example-6.jpg" alt-text="command example 6" border="false":::

- [Yes](#identify-the-proxy-mailbox-and-check-the-rpc-running-state)
- [No](#enable-outlook-anywhere)

### Identify the proxy mailbox and check the RPC running state

Find the effective or default PF mailbox that is stamped on the affected user to determine the proxy mailbox. To do this, see the command example in the following screenshot.

:::image type="content" source="media/outlook-or-owa-cannot-connect-to-public-folders/command-example-7.jpg" alt-text="command example 7" border="false":::

Then, check whether the Microsoft Exchange RPC Client Access service is running on the Client Access server (CAS) on which the PF database hosts the proxy mailbox.

:::image type="content" source="media/outlook-or-owa-cannot-connect-to-public-folders/check-rpc-cas.jpg" alt-text="check whether RPC Client Access service is running on CAS" border="false":::

- [RPC is running](#check-the-rpcclientaccessserver-value)
- [RPC is not running](#start-the-rpc-client-access-service)

### Enable Outlook Anywhere

Enable Outlook Anywhere on all Exchange 2010 servers that host the PF database. For more information about Outlook Anywhere, see [Outlook Anywhere](/exchange/outlook-anywhere-exchange-2013-help).

**Does this resolve your issue?**

- If yes, congratulations! Your problem is resolved. We're glad that this guide was helpful for you.
- If no, see [Collect logs at on-premises Exchange Server](#collect-logs-at-on-premises-exchange-server).

### Start the RPC Client Access service

Start the Microsoft Exchange RPC Client Access service.

**Does this resolve your issue?**

- If yes, congratulations! Your problem is resolved. We're glad that this guide was helpful for you.
- If no, see [Collect logs at on-premises Exchange Server](#collect-logs-at-on-premises-exchange-server).

### Check the RpcClientAccessServer value

Check whether the `RpcClientAccessServer` value for the new database that hosts the proxy PF mailbox is set to the server FQDN. To do this, see the command example in the following screenshot.

:::image type="content" source="media/outlook-or-owa-cannot-connect-to-public-folders/check-rpcclientaccessserver-value.jpg" alt-text="check the RpcClientAccessServer value":::

The proxy mailbox database \<NewMDBforPFs> is a mailbox database that hosts the proxy mailbox (PFMailbox1) only.

**RpcClientAccessServer**: This is the public folder server that also hosts the CAS role. This should be the name of the actual CAS server internal FQDN and not the CAS array name.

**IsExcludeFromProvisioning**: This should be set to **True**. This setting prevents new mailboxes from automatically being added to this empty proxy database.

- [The RPC value is set to the server FQDN](#collect-logs-at-on-premises-exchange-server)
- [The RPC value is not set to the server FQDN](#set-the-rpcclientaccessserver-value)

### Set the RpcClientAccessServer value

To set the `RpcClientAccessServer` value, run the following command in on-premises:

```powershell
Set-MailboxDatabase <NewMDBforPFs> -RpcClientAccessServer <ServerFQDN>
```

**Do you make the change successfully?**

- If yes, see [Check the RpcClientAccessServer value](#check-the-rpcclientaccessserver-value).
- If no, we’re sorry that your issue can't be resolved by this guide. Open a support ticket for further help.