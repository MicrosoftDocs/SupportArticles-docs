---
title: Outlook connection issues with Exchange mailboxes because of the RPC encryption requirement
description: Fixes some mailbox connection issues for Outlook 2013, Outlook 2010, or Outlook 2007 that has an Exchange 2010, Exchange 2013, or Exchange 2016 mailbox configured.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Clients and Mobile\Can't Connect to Mailbox with Outlook
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: gregmans, wduff, v-six
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
search.appverid: MET150
ms.date: 01/24/2024
---
# Outlook connection issues with Exchange mailboxes caused by the RPC encryption requirement

_Original KB number:_ &nbsp;3032395

The article only applies to the Microsoft Outlook connection issues that are caused by the RPC encryption requirement.

:::image type="content" source="./media/outlook-connection-issue-caused-by-rpc-encryption-requirement/exchange-encryption.png" alt-text="Screenshot about R P C encryption option.":::


## Symptoms

When you start Microsoft Office Outlook by using a profile that includes a mailbox on a server that's running Microsoft Exchange Server 2010, Exchange Server 2013, or Exchange Server 2016, you may receive the following error messages:

> Cannot start Microsoft Office Outlook. Unable to open the Outlook window. The set of folders could not be opened.

> Unable to open your default e-mail folders. The Microsoft Exchange Server computer is not available. Either there are network problems or the Microsoft Exchange Server computer is down for maintenance.

> The connection to the Microsoft Exchange Server is unavailable. Outlook must be online or connected to complete this action.

> Unable to open your default e-mail folders. The information store could not be opened.

> Outlook could not log on. Check to make sure you are connected to the network and are using the proper server and mailbox name. The connection to the Microsoft Exchange Server is unavailable. Outlook must be online or connected to complete this action.

However, if you're using a cached mode profile, Outlook doesn't display an error. You may experience the following symptoms:

- Outlook starts in the **Disconnected** state (the lower-right corner of the Outlook windows displays "Disconnected," the screenshot for the state is shown below).

    :::image type="content" source="./media/outlook-connection-issue-caused-by-rpc-encryption-requirement/disconnected-state.png" alt-text="Screenshot for the error in the lower-right corner of the Outlook window.":::

- Outlook starts and you can send and receive email messages. However, you only see two connections within the "Microsoft Exchange Connection Status" and you may see the Type Directory displayed as Disconnected/Connecting.

    :::image type="content" source="./media/outlook-connection-issue-caused-by-rpc-encryption-requirement/two-connection-states.png" alt-text="Screenshot of this symptom.":::

When you try to create a new Outlook profile for a mailbox on a server that's running Exchange 2010 or Exchange Server 2013, you may receive the following error messages:

> The action could not be completed. The connection to the Microsoft Exchange Server is unavailable. Outlook must be online or connected to complete this action.

> The name could not be resolved. The connection to the Microsoft Exchange Server is unavailable. Outlook must be online or connected to complete this action.

> Outlook could not log on. Check to make sure you are connected to the network and are using the proper server and mailbox name. The connection to the Microsoft Exchange Server is unavailable. Outlook must be online or connected to complete this action.

> The name could not be resolved. The action could not be completed.

> Your Server or Mailbox names could not be resolved.

## Resolution

> [!NOTE]
> If you are using one of the automated methods (Group Policy or a .prf file), make sure that you fully test the method before you deploy it on a large scale.

### Method 1: Update or create your Outlook profile with RPC encryption

#### Manually update an existing profile

To manually update an existing Outlook profile so that it uses RPC encryption, follow these steps:

1. In **Control Panel**, open the **Mail** item.
1. Select **Show Profiles**.
1. Select your profile, and then click **Properties**.
1. Select **E-mail Accounts**.
1. Select M**icrosoft Exchange (send from this account by default)** account > **Change**.
1. In the dialog box that contains your mailbox server and user name, select **More Settings**.
1. In the Microsoft Exchange dialog box, select the **Security** tab.
1. Select **Encrypt data between Microsoft Office Outlook and Microsoft Exchange** > **OK** (A screenshot for this step can be seen here).

    :::image type="content" source="./media/outlook-connection-issue-caused-by-rpc-encryption-requirement/select-encrypt-data-between-outlook-exchange.png" alt-text="Screenshot with Encrypt data between Microsoft Office Outlook and Microsoft Exchange selected.":::

1. Select **Next** > **Finish**.
1. Select **Close** > **Close** > **OK**.

#### Deploy a Group Policy setting to update existing Outlook profiles with RPC encryption

From a client perspective, deploying the Outlook-Exchange encryption setting is probably the simplest solution for organizations that have many Outlook clients. This solution involves a single change on a server (domain controller), and your clients are automatically updated after the policy is downloaded to the client.

##### Outlook 2010

By default, the RPC encryption setting is enabled in Outlook 2010. So you should only deploy this setting by using Group Policy for either of the following reasons:

- Your original Outlook 2010 deployment disabled RPC encryption between Outlook and Exchange.
- You want to prevent users from changing the RPC encryption setting in their Outlook profile.

The default Group Policy template for Outlook 2010 contains the Group Policy setting that controls Outlook-Exchange RPC encryption. To update existing Outlook 2010 profiles by using Group Policy, follow these steps:

1. Download the [latest version of the Outlk14.adm Group Policy template](https://www.microsoft.com/download/details.aspx?id=18968).
1. Add the .adm file to your domain controller.

    > [!NOTE]
    > The steps to add the .adm file to a domain controller vary according to the version of Windows that you are running. In addition, because you may be applying the policy to an organizational unit and not to the domain, the steps may also vary for this aspect of applying a policy. Therefore, check your Windows documentation for detailed information.

    Go to step 3 after you add the .adm template to the Local Group Policy Editor.

1. Under **User Configuration**, expand **Administrative Templates (ADM)** to locate the policy node for your template. By using the Outlk14.adm template, this node will be named Microsoft Outlook 2010.
1. Under **Account Settings**, select the **Exchange** node (A screenshot for this step can be seen here).

    :::image type="content" source="./media/outlook-connection-issue-caused-by-rpc-encryption-requirement/select-exchange-node-2010.png" alt-text="Screenshot with the Exchange node under Outlook 2010 selected.":::

1. Double-click the **Enable RPC encryption** policy setting.
1. On the **Setting** tab, select **Enabled**.
1. Select **OK**.

At this point, the policy setting will be applied on your Outlook client workstations when the Group Policy update is replicated. To test this change, run the following command:

```console
 gpupdate /force
```

After you run this command, start Registry Editor on the workstation to make sure that the following registry data exists on the client:

```console
Key: HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\14.0\Outlook\RPC
DWORD: EnableRPCEncryption
Value: 1
```

If you see this registry data in the registry, the Group Policy setting is applied to this client. Start Outlook to verify that the change resolves the problem.  

##### Outlook 2013

By default, the RPC encryption setting is enabled in Outlook 2013. So you should only deploy this setting by using Group Policy for either of the following reasons:

- Your original Outlook 2013 deployment disabled RPC encryption between Outlook and Exchange.
- You want to prevent users from changing the RPC encryption setting in their Outlook profile.

The default Group Policy template for Outlook 2013 contains the Group Policy setting that controls Outlook-Exchange RPC encryption. To update existing Outlook 2013 profiles by using Group Policy, follow these steps:

1. Download the [Office 2013 ADM templates](https://www.microsoft.com/download/details.aspx?id=35554).
2. Add the .admx and .adml files to your domain controller. This adds the Outlook ADM template to make it available in the Local Group Policy Editor.

    > [!NOTE]
    > The steps to add the .admx and adml files to a domain controller vary according to the version of Windows that you are running. In addition, because you may be applying the policy to an organizational unit and not to the domain, the steps may also vary for this aspect of policy application. Therefore, check your [Windows documentation](/previous-versions/office/office-2010/cc179081(v=office.14)) for detailed information. (This article is labeled for Office 2010. However, it also applies to Office 2013.)

3. Start the Local Group Policy Editor.
4. Under **User Configuration**, expand **Administrative Templates (ADM)** to locate the policy node for your template. When you use the Outlk15.admx template, this node will be named **Microsoft Outlook 2013**.
5. Under **Account Settings**, select the **Exchange** node (A screenshot for this step can be seen here).

    :::image type="content" source="./media/outlook-connection-issue-caused-by-rpc-encryption-requirement/select-exchange-node-2013.png" alt-text="Screenshot with the Exchange node under Outlook 2013 selected.":::

6. Double-click the **Enable RPC encryption** policy setting.
7. On the **Setting** tab, select **Enabled**.
8. Select **OK**.

At this point, the policy setting will be applied on your Outlook client workstations when the Group Policy update is replicated. To test this change, run the following command on a workstation:

```console
 gpupdate /force
```

After you run this command, start Registry Editor on the workstation to make sure that the following registry data exists on the client:

```console
Key: HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\15.0\Outlook\RPC
 DWORD: EnableRPCEncryption
 Value: 1
```

If you see this registry data in the registry, the Group Policy setting is applied to this client. Start Outlook to verify that the change resolves the problem.

### Method 2: Disable the encryption requirement on all CAS servers

> [!IMPORTANT]
> Microsoft strongly recommends you leave the encryption requirement enabled on your server, and to use one of the other methods listed in this article. Method 2 is only provided in this article for situations where you cannot immediately deploy the necessary RPC encryption settings on your Outlook clients. If you use Method 2 to allow Outlook clients to connect without RPC encryption, please re-enable the RPC encryption requirement on your CAS servers as quickly as possible to maintain the highest level of client-to-server communication.

To disable the required encryption between Outlook and Exchange, follow these steps:

1. Run the following command in the Exchange Management Shell:

    ```powershell
     Set-RpcClientAccess -Server <Exchange server name> -EncryptionRequired:$False
    ```

    > [!NOTE]
    > The *Exchange_server_name* placeholder represents the name of an Exchange Server that has the Client Access Server role.

    You must run this cmdlet for all Client Access servers that are running Exchange Server 2010 or later version.

1. Rerun this command for each Exchange server that has the **Client Access Server** role. The command also needs to be run on each **Mailbox Server** role that contains a **Public Folder Store**. Public Folder connections from the MAPI client go directly to the **RPC Client Access Service** on the Mailbox server.
1. After your Outlook clients are updated with the setting to enable encrypted RPC communication with Exchange (see steps provided below), you can re-enable the RPC encryption requirement on your Exchange servers that have the **Client Access Server** role.

    To re-enable the RPC encryption requirement on your Exchange servers that have the **Client Access Server** role, run the following command in the Exchange Management Shell:

    ```powershell
     Set-RpcClientAccess -Server <Exchange server name> -EncryptionRequired:$True
    ```

    > [!NOTE]
    > The *Exchange_server_name* placeholder represents the name of an Exchange server that has the Client Access Server role.

    You must run this cmdlet for all Client Access servers that are running Exchange Server 2010 or later version.

## Cause

One possible cause is that you're using Outlook and you disable the **Encrypt data between Microsoft Office Outlook and Microsoft Exchange** profile setting. The default configuration for Exchange Server 2013 requires RPC Encryption from the Outlook client. This prevents the client from being able to connect.

> [!NOTE]
> The default Exchange Server 2010 Release to Manufacturing (RTM) configuration requires RPC encryption. This behavior is a change from Exchange Server 2010 Service Pack 1 where the RPC encryption requirement is disabled by default. However, any Client Access Server (CAS) deployed prior to Service Pack 1, or upgraded to Service Pack 1, will retain the existing RPC encryption requirement setting which could still prevent the client from being able to connect.
