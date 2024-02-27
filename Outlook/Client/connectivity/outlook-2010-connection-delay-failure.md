---
title: Outlook 2010 connection delays or failures
description: Describes an issue in which you may experience Outlook 2010 connection delays or failures. The Outlook status bar may display the message.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: aruiz, gbratton
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Microsoft Outlook 2010
ms.date: 01/30/2024
---
# You may experience Outlook 2010 connection delays or failures when Outlook 2010 is configured to connect to two Microsoft 365 accounts

_Original KB number:_ &nbsp; 2675986

## Symptoms

When you configure Outlook 2010 with a profile to connect to two or more Microsoft 365 email accounts, you may experience connection delays or failures. When you start Outlook, you see that the Outlook status bar displays **Trying to connect...** or **Disconnected** when you click a folder. This behavior may occur for one or multiple Exchange Online email accounts.

Screenshots of both messages as shown in the Outlook status bar follow.

:::image type="content" source="./media/outlook-2010-connection-delay-failure/trying-to-connect.png" alt-text="Screenshot of Trying to connect message in the Outlook status bar." border="false":::

:::image type="content" source="./media/outlook-2010-connection-delay-failure/disconnected.png" alt-text="Screenshot of Disconnected message in the Outlook status bar." border="false":::

## Resolution

To resolve this issue, apply [KB 2598374](https://support.microsoft.com/help/2598374).

## Workaround

If you are unable to install the Outlook 2010 hotfix package dated June 26, 2012 (KB2598374), use the workaround below to prevent the symptom that is described in the [Symptoms](#symptoms) section. The workaround involves a two-step process. First, the administrator must grant your account explicit permissions to the secondary mailbox. Second, you must remove the credentials for the secondary mailbox from your local Windows workstation.

> [!NOTE]
> This workaround requires the Microsoft 365 administrator to use Windows PowerShell to change permissions to the Exchange Online mailboxes.

### How to obtain explicit permissions to the secondary mailbox

Your Exchange Online administrator must connect to the Microsoft 365 environment by using Windows PowerShell to grant your user account explicit permission to the secondary or shared mailbox.

> [!IMPORTANT]
> The administrator should use **Run as administrator** to start Windows PowerShell.

Although the symptom that is described in the [Symptoms](#symptoms) section is not caused by the AutoMapping feature, we recommend that AutoMapping is disabled when Outlook is used to connect to two or more Exchange Online accounts. To grant your user account explicit permissions to the secondary mailbox and at the same time to disable the AutoMapping feature, the administrator must follow these steps:

1. Connect to Exchange Online by using Windows PowerShell:
   1. Click **Start**, and then click **All Programs**.
   2. Click **Accessories**, click **Windows PowerShell**, and then click **Windows PowerShell**.
   3. Run the following command:

        ```powershell
        $LiveCred = Get-Credential
        ```

   4. In the Windows PowerShell Credential Request window that opens, type the credentials of an administrator account in your cloud-based organization. When you are finished, click **OK**.
   5. Run the following command:

      ```powershell
      $Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $LiveCred -Authentication Basic -AllowRedirection
      ```

   6. To make sure that Windows PowerShell can run scripts, run the following command:

        ```powershell
        Set-ExecutionPolicy RemoteSigned
        ```

   7. Run the following command:

        ```powershell
        Import-PSSession $Session
        ```

        > [!NOTE]
        > A progress indicator appears that shows the importing of commands that are used in the cloud-based service into the client-side session of your local computer. When this process is complete, you can run the commands in the following steps.

2. If the user doesn't have full access permissions to the secondary mailbox, go to step 3. If the user already has full access permissions to the secondary mailbox, follow these steps to remove full access permissions from the secondary mailbox:
    1. Run the following command:

        ```powershell  
        Remove-MailboxPermission -Identity <SecondaryMailbox> -User <PrimaryMailbox> -AccessRights FullAccess
        ```

        In this command, \<SecondaryMailbox> represents the mailbox from which the primary mailbox user's permissions are being removed. For example, to remove Corey Gray's full access permissions to Henry Ross's mailbox, use the following command:

        ```powershell
        Remove-MailboxPermission -Identity henryr@contoso.com -User coreyg@contoso.com -AccessRights FullAccess
        ```

    2. When you are prompted to confirm the action, type `Y`, and then press Enter.

3. To grant full access permissions to the user for the mailbox, but not to enable AutoMapping, follow these steps:

    1. Run the following command:

        ```powershell
        Add-MailboxPermission -Identity <SecondaryMailbox> -User <PrimaryMailbox> -AccessRights FullAccess -AutoMapping:$false
        ```

        In this command, \<SecondaryMailbox> represents the mailbox to which the primary mailbox user is being granted permissions. For example, to grant an administrator full access permissions to John Smith's mailbox, use the following command:

        ```powershell
        Add-MailboxPermission -Identity henryr@contoso.com -User coreyg@contoso.com -AccessRights FullAccess -AutoMapping:$false
        ```

    2. After you run this command, the following output is displayed:

        |Identity|User|Access Rights|IsInherited|Deny|
        |---|---|---|---|---|
        |Henry Ross|Contoso\henryr|Full access|False|False|

4. If the user also requires Send As permissions, run the following command:

    ```powershell
    Add-RecipientPermission <SecondaryMailbox> -AccessRights SendAs -Trustee <PrimaryMailbox>  
    ```

    In this command, \<SecondaryMailbox> represents the mailbox for which the primary mailbox user is being granted Send As permission. For example, to grant an administrator Send As permissions on John Smith's mailbox, use the following command:

    ```powershell
    Add-RecipientPermission "Henry Ross" -AccessRights SendAs -Trustee "Corey Gray"
    ```

5. Run the following command to disconnect the Windows PowerShell:

    ```powershell
    Remove-PSSession $Session
    ```

### How to remove credentials for the secondary mailbox from local Windows workstation

After the administrator grants your account explicit permissions to the secondary mailbox, you must remove any existing credentials that are stored on your local Windows workstation for the secondary mailbox. This forces Outlook to use your credentials to connect to both your own mailbox and to the shared mailbox.

Usually, when Outlook requires credentials to connect to a mailbox, a **Windows Security** dialog box appears. If you previously checked the **Remember my credentials** option, the credentials were saved on your workstation. To remove the credentials that were stored in Windows, follow these steps:

1. Click **Start**, click **Control Panel**, and then click **Credential Manager**.

    > [!NOTE]
    > If **View by** is set to **Category**, click **User Accounts** first, and then click **Credential Manager**.

2. Locate the set of credentials that are used to connect to *.outlook.com or to your Microsoft 365 domain.
3. Expand the set of credentials, and then select **Remove from Vault**.
4. Locate the set of credentials that are used to connect to the secondary mailbox.
5. Expand the set of credentials, and then select **Remove from Vault**.

    > [!NOTE]
    > If you are running Windows XP, run the **User Accounts** item in Control Panel. Click the **Advanced** tab, and then click the **Manage Passwords** button.

When you next open Outlook, a credentials prompt is displayed. By using the steps in the previous section, you granted the primary mailbox full access permissions to the secondary mailbox. Therefore, you only have to save the credentials for the primary mailbox. To save the credentials, click to select the **Remember my credentials** check box. Outlook then uses the stored primary mailbox credentials to connect to the secondary mailbox.

## More information

For more information about how to grant and remove full access permissions, see [How to remove automapping for a shared mailbox in Microsoft 365](/outlook/troubleshoot/domain-management/remove-automapping-for-shared-mailbox).

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the **Applies to**.
