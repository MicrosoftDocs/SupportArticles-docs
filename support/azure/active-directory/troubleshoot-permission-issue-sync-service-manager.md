---
title: Permission-issue error 8344 in Synchronization Service Manager
description: Learn how to diagnose and fix permission-issue error 8344 (insufficient access rights to perform the operation) in Synchronization Service Manager.
ms.date: 06/14/2023
ms.reviewer: calazlo, nualex, v-leedennis
ms.service: entra-id
ms.subservice: users
---
# Permission-issue error 8344, "Insufficient access rights to perform the operation."

This article discusses how to understand and troubleshoot the "permission-issue [8344]" error, "Insufficient access rights to perform the operation." This Microsoft Entra error occurs on an on-premises Active Directory connector during an export operation in Synchronization Service Manager.

[!INCLUDE [Feedback](../../includes/feedback.md)]

## Symptoms

On the [**Operations** tab](/azure/active-directory/hybrid/connect/how-to-connect-sync-service-manager-ui-operations) of the [Synchronization Service Manager](/azure/active-directory/hybrid/connect/how-to-connect-sync-service-manager-ui) app, the **Connection Operations** table contains a row that represents an on-premises AD connector in which the **Profile Name** column value is **Export**. However, the corresponding **Status** column value is **completed-export-errors**. When you select this table row, a secondary table displays one or more **permission-issue** export errors.

:::image type="content" source="./media/troubleshoot-permission-issue-sync-service-manager/sync-service-manager-symptoms.png" alt-text="Screenshot of the permission-issue errors in the Synchronization Service Manager app." lightbox="./media/troubleshoot-permission-issue-sync-service-manager/sync-service-manager-symptoms.png":::

If you select one of the **permission-issue** export errors, the **Connector Space Object Properties** dialog box appears. On the **Export Error** tab, the following information is shown.

| Error Information field              | Value                                                |
|--------------------------------------|------------------------------------------------------|
| **Error**                            | permission-issue                                     |
| **Connected data source error code** | 8344                                                 |
| **Connected data source error**      | Insufficient access rights to perform the operation. |

:::image type="content" source="./media/troubleshoot-permission-issue-sync-service-manager/sync-service-manager-export-error.png" alt-text="Screenshot of the Export Error tab in the Connector Space Object Properties dialog box of the Synchronization Service Manager app." lightbox="./media/troubleshoot-permission-issue-sync-service-manager/sync-service-manager-export-error.png":::

## Cause

The on-premises Active Directory connector account (`MSOL_<hex-digits>`) doesn't have permissions in Active Directory to write back the object's properties that are being synchronized with Microsoft Entra ID.

<a name='solution-1-grant-permissions-by-using-the-aadconnect-troubleshooting-console'></a>

## Solution 1: Grant permissions by using the Microsoft Entra Connect Troubleshooting console

> [!NOTE]  
> This solution is the recommended and preferred method.

In the on-premises Active Directory connector account (`MSOL_<hex-digits>`), locate the attributes that this account doesn't have permissions for. Then, use the Microsoft Entra Connect wizard to grant the permissions in the Microsoft Entra Connect Troubleshooting console, as described in the following sections.

### Part 1: Determine which on-premises Active Directory connector account is in use

To find the on-premises AD connector account, use one of the following tools.

<details>
<summary>The Microsoft Entra Connect wizard</summary>

1. On the Windows desktop, double-click the **Microsoft Entra Connect** icon to open the Microsoft Entra Connect wizard.

1. In the **Microsoft Entra Connect** dialog box, select the **Configure** button.

1. In the **Additional tasks** screen, select the **View or export current configuration** task, and then select the **Next** button.

1. In the **Review your solution** screen, locate the **Synchronized Directories** heading, and then copy the `MSOL_<hex-digits>` string from within the **ACCOUNT** field value.

1. Select the **Exit** button.

</details>

<details>
<summary>The Synchronization Service Manager app</summary>

1. Select **Start**, and then search for and select **Synchronization Service Manager**.

1. In the **Synchronization Service Manager** app, select the **Connectors** tab.

1. In the **Connectors** list, right-click the **Name** value of the on-premises Active Directory connector, and then select **Properties**.

1. In the **Properties** dialog box, locate the **Connector Designer** pane, and then select **Connect to Active Directory Forest**.

1. In the **Connect to Active Directory Forest** pane, copy the value of the **User name** field. This value contains the name of the on-premises Active Directory connector account.

</details>

<details>
<summary>The ADSyncTools module in PowerShell</summary>

If the [ADSyncTools module](https://www.powershellgallery.com/packages/ADSyncTools) isn't already installed in your PowerShell environment, install that module. After the module is installed, run the `Get-ADSyncToolsADconnectorAccount` cmdlet:

```azurepowershell
Install-Module ADSyncTools  # Not required if the ADSyncTools module is already installed
Get-ADSyncToolsADconnectorAccount
```

The output is a table that displays the `Name`, `Forest`, `Domain`, and `Username` columns for each Active Directory connector account. The text string that you want to copy is in the `Username` column.

</details>

### Part 2: Determine which attributes the on-premises Active Directory connector account doesn't have permissions for

1. Select **Start**, and then search for and select **Synchronization Service Manager**.
1. In the **Synchronization Service Manager** app, select the **Operations** tab.
1. In the **Connector Operations** table, select the row that has the following characteristics.

   | Column name      | Value                                                  |
   |------------------|--------------------------------------------------------|
   | **Name**         | The name of the on-premises Active Directory connector |
   | **Profile Name** | **Export**                                             |
   | **Status**       | **completed-export-errors**                            |

1. In the bottom-right table, select an object in the first column (labeled **Export Errors**) for which **permission-issue** is listed as one of the errors in the second column.
1. In the **Connector Space Object Properties** dialog box, select the **Pending Export** tab.
1. Locate the **Attribute information** table, and then select the **Changes** column to sort by that column.

   :::image type="content" source="./media/troubleshoot-permission-issue-sync-service-manager/pending-export-attribute-information.png" alt-text="Screenshot of the Attribute information table, Pending Export tab, Connector Space Object Properties dialog box, Synchronization Service Manager app." lightbox="./media/troubleshoot-permission-issue-sync-service-manager/pending-export-attribute-information.png":::

1. Identify the Microsoft Entra Connect feature that you're using by following one of these methods:

   - Review the list of [Exchange hybrid writeback](/azure/active-directory/hybrid/connect/reference-connect-sync-attributes-synchronized#exchange-hybrid-writeback) attributes to synchronize, and then return to the **Attribute information** table UI to find the Exchange hybrid writeback attribute that ADSync was trying to add or modify. For example, the added or modified attribute might be the [msDS-ExternalDirectoryObjectID](/openspecs/windows_protocols/ms-ada2/0abc1d06-ac09-476f-a60b-5deb05b394f7) attribute.

   - Check the Microsoft Entra Connect features by running the `Get-ADSyncGlobalSettings` cmdlet from a PowerShell session, as shown in the following code:

     ```azurepowershell
     (Get-ADSyncGlobalSettings).Parameters | select Name, Value | sort Name
     ```

### Part 3: Grant the missing permissions

> [!IMPORTANT]  
> The account that's used to run the Microsoft Entra Connect tool must be allowed to grant permissions on all domains to Active Directory. Usually, only the Enterprise Administrator has Domain Administrator rights on all domains in the Active Directory forest.

1. On the Windows Desktop, double-click the **Microsoft Entra Connect** icon.
1. In the **Microsoft Entra Connect** dialog box, select the **Configure** button.
1. In the **Additional tasks** pane, select the **Troubleshoot** task, and then select the **Next** button.
1. On the **Welcome to Microsoft Entra Connect Troubleshooting** page, select the **Launch** button to start the troubleshooting menu in a console.
1. In the `AADConnect Troubleshooting` menu in the console, enter *4* to configure the Active Directory Domain Services (AD DS) connector account permissions.

   ```console
   ----------------------------------------AADConnect Troubleshooting-----------------------------------------
   
           Enter '1' - Troubleshoot Object Synchronization
           Enter '2' - Troubleshoot Password Hash Synchronization
           Enter '3' - Collect General Diagnostics
           Enter '4' - Configure AD DS Connector Account Permissions
           Enter '5' - Test Azure Active Directory Connectivity
           Enter '6' - Test Active Directory Connectivity
           Enter 'Q' - Quit
   
           Please make a selection: 4_
   ```

1. In the `Configure Permissions` menu, enter the option that you're interested in. In this example, enter *4* to set the Exchange Hybrid permissions.

   ```console
   --------------------------------------------Configure Permissions------------------------------------------
   
           Enter '1' - Get AD Connector account
           Enter '2' - Get objects with inheritance disabled
           Enter '3' - Set basic read permissions
           Enter '4' - Set Exchange Hybrid permissions
           Enter '5' - Set Exchange mail public folder permissions
           Enter '6' - Set MS-DS-Consistency-Guid permissions
           Enter '7' - Set password hash sync permissions
           Enter '8' - Set password writeback permissions
           Enter '9' - Set restricted permissions
           Enter '10' - Set unified group writeback permissions
           Enter '11' - Show AD object permissions
           Enter '12' - Set default AD Connector account permissions
           Enter '13' - Compare object read permissions when running in context of AD Connector account vs Admin account
           Enter 'B' - Go back to main troubleshooting menu
           Enter 'Q' - Quit
   
           Please make a selection: 4_
   ```

1. In the `Account to Configure` screen, when you're prompted by the message, "Would you like to configure an existing connector account or a custom account?," enter *E* for an existing connector account (the default response):

   ```console
   Account to Configure
   Would you like to configure an existing connector account or a custom account?
   [E] Existing Connector Account  [C] Custom Account  [?] Help (default is "E")  E_
   ```

1. In the `Configured connectors and their related accounts` screen, after you see a list of rows that contain `ADConnectorName`, `ADConnectorForest`, `ADConnectorAccountName`, and `ADConnectorAccountDomain` data, enter the name of the connector for the account that you want to configure:

   ```console
   Configured connectors and their related accounts:

   ADConnectorName  ADConnectorForest ADConnectorAccountName ADConnectorAccountDomain
   ---------------- ----------------- ---------------------- ------------------------
   corp.contoso.com corp.contoso.com  MSOL__<hex-digits>     domain.contoso.com
   test.local       test.local        MSOL__<hex-digits>     test.local




   Name of the connector who's account to configure: corp.contoso.com_
   ```
   **Note:** In this screen, the word "who's" appears as shown although it should be "whose."
   
1. Either select <kbd>Enter</kbd> to apply the permissions at the root of the domain for all child objects, or specify the target object to set the permissions on. For example, you can specify the target organizational unit (OU) in which the users reside:

   ```console
   To set permissions for a single target object, enter the DistinguishedName of the target AD
   object. Giving no input will set root permissions for all Domains in the Forest: _
   ```

1. In the `Update AdminSdHolders` screen, when you're prompted whether to "Update [AdminSDHolder](/windows-server/identity/ad-ds/plan/security-best-practices/appendix-c--protected-accounts-and-groups-in-active-directory#adminsdholder) container when updating with these permissions?," enter *Y* for `Yes` only if you're synchronizing [Protected Accounts in Active Directory](/windows-server/identity/ad-ds/plan/security-best-practices/appendix-c--protected-accounts-and-groups-in-active-directory) to Microsoft Entra ID. Otherwise, enter *N* for `No` (the default response).

   ```console
   Update AdminSdHolders
   Update AdminSDHolder container when updating with these permissions?
   [Y] Yes  [N] No  [?] Help (default is "N"): _
   ```

   > [!NOTE]  
   > We recommend that you don't synchronize your on-premises AD administrator accounts to Microsoft Entra ID. For more information, see the [Administrator password setting](/azure/active-directory/authentication/howto-sspr-deployment#administrator-password-setting) section of [Plan a Microsoft Entra self-service password reset deployment](/azure/active-directory/authentication/howto-sspr-deployment).

1. In the `Confirm` screen, enter *Y* for `Yes` to confirm your choice (the default response):

   ```console
   Confirm
   Are you sure you want to perform this action?
   Performing the operation "Grant Exchange Hybrid permissions" on target "corp.contoso.com"
   [Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): y_
   ```

## Solution 2: Grant permissions by using the ADSyncConfig module in PowerShell

> [!NOTE]  
> This solution is also a recommended method.

For information about this solution, see the ["Using the ADSyncConfig PowerShell module"](/azure/active-directory/hybrid/connect/how-to-connect-configure-ad-ds-connector-account#using-the-adsyncconfig-powershell-module) section of [Microsoft Entra Connect: Configure AD DS connector account permissions](/azure/active-directory/hybrid/connect/how-to-connect-configure-ad-ds-connector-account).

## Solution 3: Grant permissions by using the Active Directory Users and Computers snap-in

> [!WARNING]  
> If you grant permissions manually in Active Directory by using this method, this action might cause insufficient permissions that can have unexpected results.

1. On an account that has the appropriate Domain Administrator permissions, select **Start**, and then search for and select the **Active Directory Users and Computers** snap-in (*dsa.msc*).

1. In the **View** menu, if a check mark isn't displayed next to **Advanced features**, select that menu item so that you can view the advanced features.

1. In the console tree, locate the object that represents the root of the domain. Right-click that object, and then select **Properties**.

1. In the **Properties** dialog box, select the **Security** tab, and then select the **Advanced** button.

1. In the **Advanced Security Settings** dialog box, select the **Permissions** tab, and then select the **Add** button.

1. In the **Permission Entry** dialog box, enter the settings as described in the following table.

   | Setting | Action |
   |--|--|
   | **Principal** name | Select the **Select a principal** link. Enter the name of the account to apply the permissions to (the account that Microsoft Entra Connect uses), and then select **OK**. |
   | **Type** list | Select **Allow**. |
   | **Applies to** list | Select **Descendant User objects** to show the list of permissions that are allowed for the selected principal. |
   | **Properties** options | Select the check box for each permission property option that you want. Scroll through the list of properties to find the attributes that you need. Property option names can include **Read all properties**, **Write all properties**, **Read msDS-OperationsForAzTaskBL**, **Read msDS-parentdistname**, and so on. |

   :::image type="content" source="./media/troubleshoot-permission-issue-sync-service-manager/permission-entry-dialog-box.png" alt-text="Screenshot of the Permission Entry dialog box in the Active Directory Users and Computers snap-in." lightbox="./media/troubleshoot-permission-issue-sync-service-manager/permission-entry-dialog-box.png" border="false":::

1. To exit the dialog boxes and apply the changes, select the **OK** button three times.

## Solution 4: Grant permissions by using the dsacls tool

> [!WARNING]  
> If you grant permissions manually in Active Directory by using this method, this action might cause insufficient permissions that can have unexpected results.

To grant permissions to read and write all properties for all objects at the root of the domain to all of its descendant objects, run the following [dsacls](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/cc771151(v=ws.11)) command:

```cmd
dsacls.exe "DC=Contoso,DC=com" /G "CONTOSO\ADConnectAccount:RPWP;;" /I:S
```

In this command, `DC=Contoso,DC=com` is the distinguished name of your domain, and `CONTOSO\ADConnectAccount` is the domain account that Microsoft Entra Connect uses.

## Known issues

The following table lists known issues that cause **permission-issue** errors but can't currently be fixed by the listed solutions.

| Condition | Effect |
|--|--|
| The **AdminCount** attribute for a user is greater than zero, even though the user is no longer a member of a Protected Group. | You see unexpected synchronization results or **permission-issue** errors because the new permissions aren't applied. |
| There are [SDProp](/windows-server/identity/ad-ds/plan/security-best-practices/appendix-c--protected-accounts-and-groups-in-active-directory#sdprop) issues in Active Directory. | The **permission-issue** error persists after you apply a solution because Active Directory can't propagate the new permissions for all child objects in the domain. |

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
