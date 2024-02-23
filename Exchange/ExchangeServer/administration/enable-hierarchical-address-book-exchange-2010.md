---
title: Enable the Hierarchical Address Book feature in Exchange Server 2010
description: Describes how to enable the Hierarchical Address Book (HAB) feature in Exchange Server 2010.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: junkoy, v-six
appliesto: 
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Enable the Hierarchical Address Book feature in Microsoft Exchange Server 2010

_Original KB number:_ &nbsp;973994

This step-by-step article describes how to enable the Hierarchical Address Book (HAB) feature in Microsoft Exchange Server 2010. HAB is a feature in Exchange Server 2010 and an Office Outlook address book. HAB lets end users browse for recipients in the organizational hierarchy that they belong to.

HAB is enabled by creating a root organization that will be the top of the hierarchy. After you create a root organization on Exchange Server, Outlook 2010 automatically detects when the feature is enabled and adds the **Organization** tab in the **Outlook Address Book**  dialog box. End users can use HAB and the name list, such as the global address list, by switching tabs. The screenshot for this step is listed below.

:::image type="content" source="media/enable-hierarchical-address-book-exchange-2010/name-list.png" alt-text="Screenshot of the window for Select Names.":::

You must have the Active Directory Service Interfaces (ADSI) Edit snap-in to complete some of these steps.

> [!WARNING]
> If you use the ADSI Edit snap-in, the Lightweight Directory Access Protocol (LDAP) utility, or any other LDAP version 3 client, and you incorrectly change the attributes of Active Directory objects, you can cause serious problems. These problems may require you to reinstall Microsoft Windows Server, Microsoft Exchange Server, or both Windows and Exchange. Microsoft cannot guarantee that problems that occur if you incorrectly modify Active Directory object attributes can be resolved. Change these attributes at your own risk.

## Step one: Extend the Active Directory schema

To use HAB, you must extend the Active Directory schema in the Active Directory forest where you installed Exchange Server 2010. For more information about how to extend the Active Directory schema for the HAB, click the following article number to view the article in the Microsoft Knowledge Base:

[973788](https://support.microsoft.com/help/973788) How to extend the Active Directory schema for the Hierarchical Address Book (HAB) on an Exchange Server 2010 server

## Step two: Prepare organization hierarchy data in Exchange 2010

An organization is represented by a distribution group in your Exchange organization. To create a distribution group, use the Exchange Management Console (EMC) or the Exchange Management Shell (the Shell) in Exchange Server 2010.

For more information about how to create a distribution group in Exchange Server 2010, see [Create and manage distribution groups in Exchange Online](/exchange/recipients-in-exchange-online/manage-distribution-groups/manage-distribution-groups).

For example, the following screenshot shows the organization hierarchy for an example organization named **Contoso, Ltd**.

:::image type="content" source="media/enable-hierarchical-address-book-exchange-2010/contoso-ltd-organization.png" alt-text="Screenshot that shows the organization hierarchy for an example organization named Contoso, Ltd.":::

The following list explains this hierarchy:

- **Contoso-dom** is the name of the domain in which Exchange Server 2010 was installed.
- **Contoso, Ltd** is the name of the top tier of the organization in the hierarchy (root organization).
- **Contoso, Ltd** has three second-tier organizations (child organizations). These are named **Corporate Office**, **Product Support Organization**, and **Sales & Marketing Organization**.
- One of the second-tier organizations, **Corporate Office**, has three child organizations. These are named **Human Resources**, **Account Group**, and **Administration Group**.

> [!NOTE]
> The HAB feature in Exchange Server 2010 cannot display the distribution groups that are created in earlier versions of Exchange. You must update the version value of the `msExchaVersion` attribute of the distribution groups that are created in earlier versions of Exchange.  
> To do this, follow the steps:
>
> 1. Install Exchange Server 2010 Service Pack 1 (SP1) on the server.
> 1. Run the command in the Exchange Management Shell (the Shell): `Set-DisctibutionGroup -identity <distribution group name>  -forceupgrade`.

For more information about the `Set-DistributionGroup` command, see [General information about the Set-DistributionGroup command](/powershell/module/exchange/set-distributiongroup).

## Step three: Create an organization

1. *Optional* Before you create an organization, you can create a new organizational unit for the HAB. Or, you can use an existing organizational unit (OU) in your Exchange Forest (such as the default OU users). Run the following command in the Shell to create an organizational unit that's named **HAB Groups.**

    ```powershell
    dsadd ou "OU=HAB Groups,DC=Contoso-dom,DC=Contoso,DC=com"
    ```

1. Create a distribution group named **Contoso, Ltd.** with the Security Accounts Manager (SAM) account name and alias **ContosoRoot** in the organizational unit **Contoso-dom.Contoso.com/HAB Groups**. To do this, run the following command in the Shell:

    ```powershell
    New-DistributionGroup -Name "Contoso,Ltd" -Alias "ContosoRoot" -OrganizationalUnit "Contoso-dom.Contoso.com/HAB Groups" -SAMAccountName "ContosoRoot" -Type "Distribution" 
    ```

    > [!NOTE]
    > To run this command, you must be assigned one of the following management roles, either directly or by using a universal security group:
    >
    > - Organization Management
    > - Recipient Management
    >  
    > You can use both mail-enabled universal distribution groups and mail-enabled universal security groups as organizations. You can't use a dynamic distribution group as an organization.
    >  
    > You may want to configure the message delivery restrictions to some distribution groups. For example, the top tier of the example organization, **Contoso, Ltd**, contains all the employees in the organization. To accept messages from only specific employees in the **Human Resources** organization who are responsible for company-wide communications, configure the message delivery restrictions.
1. Repeat step 1 for each organization that you want to create.

    For this example, create the following organizations:

    - **Corporate Office**  
    - **Product Support Organization**  
    - **Sales & Marketing Organization**  
    - **Human Resources**  
    - **Account Group**  
    - **Administration Group**

    For more information about how to configure message delivery restrictions on Exchange Server 2010, see [Configure message delivery restrictions for a mailbox](/exchange/recipients-in-exchange-online/manage-user-mailboxes/configure-message-delivery-restrictions).

## Step four: Change the msOrg-IsOrganizational attribute to make the distribution group an organization

To make the distribution group an organization, you have to change the `msOrg-IsOrganizational` attribute so that it's set to **True**. To change the `msOrg-IsOrganizational` attribute, use the ADSI Edit snap-in or the LDAP utility.

1. If you don't have ADSI Edit installed on your computer, install the Windows Support Tools. For detailed instructions for ADSI Edit, go to the following Microsoft website:

    [ADSI Edit (adsiedit.msc)](/previous-versions/windows/it-pro/windows-server-2003/cc773354(v=ws.10))

1. Open **ADSI Edit**, expand **Default naming context**, expand the organizational unit, and then expand the **OU=HAB Groups** container where you created a distribution group named **Contoso, Ltd**. The screenshot for this step is listed below.

1. Open **ADSI Edit**, expand **Default naming context**, expand the organizational unit, and then expand the **OU=HAB Groups** container where you created a distribution group named **Contoso, Ltd**. The screenshot for this step is listed below.

   :::image type="content" source="media/enable-hierarchical-address-book-exchange-2010/adsi-edit.png" alt-text="Screenshot of A D S I Edit window expanding the OU\=HAB Groups.":::

1. Right-click **CN=Contoso,Ltd**, and then click **Properties**.
1. In the **CN=Contoso,Ltd Properties** dialog box, click the **Attribute Editor** tab.
1. In the **Attributes** section, locate **msOrg-IsOrganizational**, and then click **Edit**. The screenshot for this step is listed below.

   :::image type="content" source="media/enable-hierarchical-address-book-exchange-2010/attribute-editor.png" alt-text="Screenshot of selecting msOrg-IsOrganizational and edit.":::

1. In the Boolean Attribute Editor, click **True**, and then click **OK**.
1. In the **CN=Contoso,Ltd Properties** dialog box, click **OK**.
1. Repeat steps 2 through 7 for each organization that you want to create.

    For this example, change the msOrg-IsOrganizational attribute for the following organizations:
  
    - **Corporate Office**  
    - **Product Support Organization**  
    - **Sales & Marketing Organization**  
    - **Human Resources**  
    - **Account Group**  
    - **Administration Group**  

## Step five: Add child organizations to build the organization hierarchy

To build the organization hierarchy, you must add the child organizations to the respective organization.

For this example, add the following three second-tier organizations to the root organization **Contoso, Ltd**.:

- **Corporate Office**  
- **Product Support Organization**  
- **Sales & Marketing Organization**

Next, add the following three third-tier organizations to **Corporate Office**.

- **Human Resources**  
- **Account Group**  
- **Administration Group**

To add child organizations, follow the steps:

1. In EMC, run the following command to add the distribution group named **Corporate Office** (SMTP address: `CorporateOffice@Contoso.com`) to the distribution group named **Contoso, Ltd** (Alias: ContosoRoot).

    ```powershell
    Add-DistributionGroupMember -Identity "ContosoRoot" -Member "CorporateOffice@Contoso.com"
    ```

    For more information about how to add a member to a distribution group in Exchange Server 2010, see [Add a Member to a Distribution Group](/previous-versions/exchange-server/exchange-140/aa995970(v=exchg.140)).

    > [!NOTE]
    > To run this command, you must be assigned one of the following management roles, either directly or by using a universal security group:
    >
    > - Organization Management
    > - Recipient Management

1. Repeat step 1 to add other organizations to the root organization. (For this example, add **Product Support Organization** and **Sales & Marketing Organization** to **Contoso, Ltd**.)
1. Run the following command to add the distribution group named **Human Resources** (SMTP address: `HumanResources@Contoso.com`) to the distribution group named **Corporate Office** (Alias: CorporateOffice):

    ```powershell
    Add-DistributionGroupMember -Identity "CorporateOffice" -Member HumanResources@Contoso.com
    ```

1. Repeat step 3 to add other organizations to the organization **Corporate Office**.

    For this example, add **Account Group** and **Administration Group** to **Corporate Office**.

    > [!NOTE]
    > To use the Exchange Management Console (EMC) to add a distribution group member, follow the steps:
    >
    > 1. Start the Exchange Management Console.
    > 1. In the console tree, expand **Recipient Configuration**, and then click **Distribution Group**.
    > 1. In the results pane, select the distribution group **Contoso,Ltd** where you want to add the second-tier organization named **Corporate Office**, and then click **Properties**.
    > 1. In the **Contoso,Ltd Properties** dialog box, on the **Members** tab, click **Add** to open the **Select Recipient** dialog box.
    > 1. In the **Select Recipient** dialog box, click the **Corporate Office** distribution group, and then click **OK**. The screenshot for this step is listed below.
    >
    > :::image type="content" source="media/enable-hierarchical-address-book-exchange-2010/corporate-office.png" alt-text="Screenshot of selecting Corporate Office in the Contoso,Ltd Properties dialog box.":::

## Step six: Add organization members

Members who belong to the organization are members of the distribution group.

For this example, **David Hamilton** is a user who is a Vice President of an organization named **Corporate Office**. The screenshot for this step is listed below.

:::image type="content" source="media/enable-hierarchical-address-book-exchange-2010/user-example-david-Hamilton.png" alt-text="Screenshot shows that David Hamilton is a Vice President of an organization named Corporate Office.":::

To add David Hamilton (SMTP address: `dhamilton@contoso.com`) to **Corporate Office** (Alias: CorporateOffice) as a member of the organization, run the following command:

```powershell
Add-DistributionGroupMember -Identity "Corporate Office" -Member "DHamilton@Contoso.com"
```

For more information about how to add a member to a distribution group in Exchange Server 2010, see [Add a Member to a Distribution Group](/previous-versions/exchange-server/exchange-140/aa995970(v=exchg.140)).

> [!NOTE]
> To run this command, you must be assigned one of the following management roles, either directly or by using a universal security group:
>
> - Organization Management
> - Recipient Management
>
> A user can belong to multiple organizations while they are a member of multiple distribution groups.

## Step seven: Sort organizations and members

In the HAB, the organizations in the tree view and members in the user view can be sorted as follows.

1. The Seniority Index ( `msDS-HABSeniorityIndex` ) is sorted in descending order of seniority.
1. If the Seniority Index isn't populated or isn't equal, the sorting order falls back to Phonetic Display Name ( `msDS-PhoneticDisplayName` ) in ascending order (A-Z).
1. If the Phonetic Display Name isn't populated or isn't equal, the sorting order falls back to Display Name in ascending order.

## Step eight: Change the Seniority Index of organizations

To change the `msDS-HABSeniorityIndex` attribute of organizations, use the ADSI Edit snap-in or the LDAP utility.

For this example, the organization named **Corporate Office** has three child organizations. These are named **Accounting Group**, **Administration Group**, and **Human Resources Organization**. Without the `msDS-HABSeniorityIndex` attribute, those organizations are sorted alphabetically by the display name and appear in the tree pane as follow screenshots display:

:::image type="content" source="media/enable-hierarchical-address-book-exchange-2010/corporate-office-child-organizations-sorted-alphabetically.png" alt-text="Screenshot for the alphabetically sorted child organizations of Corporate Office.":::

To change the display order of those organizations, follow the steps:

1. Open **ADSI Edit**, expand **Default naming context**, expand an organizational unit, and then expand the OU=HAB Groups container in which you created a distribution group that is named **Human Resources Organization**.
1. Right-click **CN=Human Resources Organization**, and then click **Properties**.
1. In the **CN=Human Resources Organization Properties** dialog box, click the **Attribute Editor** tab. In the **Attributes** section, locate **msDS-HABSeniorityIndex**, and then click **Edit**. The screenshot for this step is listed below.

   :::image type="content" source="media/enable-hierarchical-address-book-exchange-2010/set-value-msds-abseniorityindex-human-resources-organization.png" alt-text="Screenshot about setting value for the msDS-HABSeniorityIndex of Human Resources Organization.":::

1. In the Integer Attribute Editor, type the value that you defined for the organization (such as *100*), and then click **OK**.
1. In **CN=Human Resources Organization Properties**, click **OK**.
1. Repeat steps 2 through 5 for Accounting Group with the Seniority Index 50 and for Administration Group with the Seniority Index 10 for example.

After you set the `msDS-HABSeniorityIndex`, **Human Resources Organization** is the top of the three organizations. The other organizations are sorted by descending number of the `msDS-HABSeniorityIndex`, as follow screenshot shows:

:::image type="content" source="media/enable-hierarchical-address-book-exchange-2010/other-organizations-sorted.png" alt-text="Screenshot about how other organizations are sorted.":::

## Step nine: Change the Seniority Index of members

To change the msDS-HABSeniorityIndex attribute of members, use the ADSI Edit snap-in or the LDAP utility.

For this example, **David Hamilton**, **Rajesh M. Patel**, and **Amy Alberts** belong to an organization that is named **Corporate Office**. Those users are created in the organizational unit **Contoso-dom.Contoso.com/Users**. David Hamilton is the Vice President of the organization. The company wants to display David Hamilton at the top of the member list so that employees easily understand who manages that organization.

To change the display order of these members, follow the steps:

1. Open **ADSI Edit**, expand **Default naming context**, and then expand an organizational unit OU=User, in which the user object **David Hamilton** is created.
1. Right-click **CN=David Hamilton**, and then click **Properties**.
1. In the **CN=David Hamilton Properties** dialog box, click the **Attribute Editor** tab. In the **Attributes** section, locate **msDS-HABSeniorityIndex**, and then click **Edit**. The screenshot for this step is listed below.

   :::image type="content" source="media/enable-hierarchical-address-book-exchange-2010/set-value-msds-habseniorityindex-david-hamilton.png" alt-text="Screenshot of setting value to msDS-HABSeniorityIndex of David Hamilton.":::

1. In the Integer Attribute Editor, type the integer value that you defined for the user (such as *100*), and then click **OK**.
1. In the CN=David Hamilton Properties dialog box, click **OK**.
1. Repeat steps 2 through 5 for the other member. For this example, repeat steps 2 through 5 for Rajesh M. Patel with the Seniority Index 50 and for Amy Alberts with the Seniority Index 10.

After you set the `msDS-HABSeniorityIndex` attribute, David Hamilton is the top of the list as the following screenshot shows, and other members are sorted by descending number of the Seniority In.

:::image type="content" source="media/enable-hierarchical-address-book-exchange-2010/how-david-hamilton-shows.png" alt-text="Screenshot of how David Hamilton shows.":::

## Step ten: Enable the Hierarchical Address Book feature

To enable the HAB in Exchange Server 2010, you must change the `msExchHABRootDepartmentLink` attribute of your Exchange Organization container. To change the `msExchHABRootDepartmentLink` attribute, use the ADSI Edit snap-in or the LDAP utility.

For this example, **Contoso, Ltd** is the name of the root organization that's created in the organizational unit **Contoso-dom.Contoso.com/HAB Groups**. **First Organization** is the name of the Exchange Organization.

1. Open **ADSI Edit**, expand **Default naming context**, expand an organizational unit, and then expand the **OU=HAB Groups** container in which you created a distribution group that is named **Contoso, Ltd**. The screenshot for this step is listed below.

   :::image type="content" source="media/enable-hierarchical-address-book-exchange-2010/create-contoso-ltd.png" alt-text="Screenshot of creating a distribution group named Contoso, Ltd.":::

1. Right-click **CN=Contoso,Ltd**, and then click **Properties**.
1. In the **CN=Contoso,Ltd Properties** dialog box, click the **Attribute Editor** tab. In the **Attributes** section, locate **distinguishedName**, and then click **View**. The screenshot for this step is listed below.

   :::image type="content" source="media/enable-hierarchical-address-book-exchange-2010/view-distinguishedName.png" alt-text="Screenshot of viewing distinguishedName.":::

1. In the **String Attribute Editor**, copy the following text from the **Value** box, and then click **OK**:

    *CN=Contoso\,Ltd, OU=HAB Groups,DC=Contoso-dom,DC=Contoso,DC=com*

1. In the **CN=Contoso,Ltd Properties** dialog box, click **OK**.
1. In **ADSI Edit**, expand **Configuration**, expand **CN=Configuration**, expand **CN=Services**, expand **CN=Microsoft Exchange**, and then select **CN=First Organization**. The screenshot for this step is listed below.

   :::image type="content" source="media/enable-hierarchical-address-book-exchange-2010/select-cn-first-organization.png" alt-text="Screenshot of selecting CN=First Organization.":::

1. Right-click **CN=First Organization**, and then click **Properties**.
1. In the **CN=First Organization Properties** dialog box, click the **Attribute Editor** tab. In the **Attributes** section, locate **msExchHABRootDepartmentLink**, and then click **Edit**. The screenshot for this step is listed below.

:::image type="content" source="media/enable-hierarchical-address-book-exchange-2010/set-value-msexchhabrootdepartmentLink.png" alt-text="Screenshot of how to set a value to msExchHABRootDepartmentLink.":::

1. In the **String Attribute Editor**, in the **Value** field, type the distinguishedName of the root organization that you copied in step 4, **CN=Contoso\,Ltd,OU=HAB Groups,DC=Contoso-dom,DC=Contoso,DC=com**, and then click **OK**.
1. In the **CN=First Organization Properties** dialog box, click **OK**.

After you set the `msExchHABRootDepartmentLink` attribute, Outlook 2010 automatically detects that the HAB feature is enabled on Exchange 2010 and shows the organization tab in the address book window.