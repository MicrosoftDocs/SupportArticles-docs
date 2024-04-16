---
title: How to install with the minimum required permissions
description: Describes the minimum permissions that are required for a user to install Microsoft Dynamics CRM.
ms.reviewer: chanson
ms.topic: how-to
ms.date: 03/31/2021
ms.subservice: d365-sales-server
---
# How to install Microsoft Dynamics CRM with the minimum required permissions

This article describes the minimum permissions that are required for a user to install Microsoft Dynamics CRM.

_Applies to:_ &nbsp; Microsoft Dynamics 365, Microsoft Dynamics CRM  
_Original KB number:_ &nbsp; 946677

> [!NOTE]
>
> - This article assumes that all the Microsoft Dynamics CRM server roles are being installed on the same computer.
> - For more information about server roles, see the implementation guide.
> - During the installation, the Environment Diagnostic wizard checks whether the user who is installing Microsoft Dynamics CRM has the minimum required permissions. If the minimum required permissions are not met, you receive an error message.

## Installation options

You have two options when you install Microsoft Dynamics CRM with the minimum required permissions. You can let the Microsoft Dynamics CRM server Setup program create the security groups during the installation. Or, you can use pre-created Active Directory security groups.

You can also select to turn on the Auto Group Management functionality or to turn off the Auto Group Management functionality. By default, the Auto Group Management functionality is turned on. Microsoft Dynamics CRM automatically adds the appropriate user accounts and the appropriate computer accounts to the required Microsoft Dynamics CRM security groups. If you turn off Auto Group Management, Microsoft Dynamics CRM does not automatically add these accounts. In this case, a domain administrator or a user who has sufficient permissions must add the appropriate user accounts and the appropriate computer accounts to the required groups. These additions must be made after the installation and after any user is added to Microsoft Dynamics CRM.

### Installation option 1 - The Setup program creates the Active Directory security groups when you install Microsoft Dynamics CRM

1. Add the user account of the user who is installing Microsoft Dynamics CRM as a member of the local administrator group. To do this, follow these steps on the Microsoft Dynamics CRM server and on the computer that is running Microsoft SQL Server:

   1. Sign in to the server as a user who has local administrator permissions.
   2. Select **Start**, point to **Administrative Tools**, and then select **Computer Management**.
   3. Expand **System Tools**.
   4. Expand **Local Users and Groups**.
   5. Select **Groups**.
   6. Right-click **Administrators**, and then select **Properties**.
   7. To add the account of the user who is installing Microsoft Dynamics CRM, select **Add**.

2. If SQL Server Reporting Services (SSRS) is installed on a server other than the server on which you added permissions in step 1, you must add the Content Manager role at the root level for the installing user account. And, you must add the System Administrator role at the site-wide level for the installing user account. To do this, follow these steps on the Reporting Services server:

   1. Start Windows Internet Explorer, and then locate the following site:

      `https://srsserver/reports`

   2. On the **Properties** tab, select **New Role Assignment**.
   3. In the **Group or user name** box, type the user name of the user who is installing Microsoft Dynamics CRM, select the **Content Manager** check box, and then select **OK**.

        > [!NOTE]
        > Use the following format when you type the user name:  
        > **domainname**\\**username**  

   4. Select **Site Settings**.
   5. Under **Security**, select **Configure site-wide security**, and then select **New Role Assignment**.
   6. In the **Group or user name** text box, type the user name of the user who is installing Microsoft Dynamics CRM, select the **System Administrator** check box, and then select **OK**.

        > [!NOTE]
        > Use the following format when you type the user name:  
        > **domainname**\\**username**  

3. For the user account of the user who is installing Microsoft Dynamics CRM, add the following permissions to the organizational unit (OU) in the Active Directory directory service.

    Permissions:

    - Read
    - Create All Child Objects

    Advanced permissions:

    - Read Permissions
    - Modify Permissions
    - Read Members
    - Write Members
  
    To add the permissions, follow these steps:

      1. Sign in to the domain controller server as a user who has domain administrator permissions.
      2. Select **Start**, select **Administrative Tools**, and then select **Active Directory Users and Computers**.
      3. On the **View** menu, select **Advanced Features**.
      4. In the navigation pane, find the OU that you want to use for the Microsoft Dynamics CRM installation. To do this, expand the tree to the node that contains the security group.
      5. Right-click the security group, select **Properties**, and then select the **Security** tab.
      6. In the **Group or user names** list, select the user account of the user who is installing Microsoft Dynamics CRM if the account is listed. If the account is not listed, select **Add** to add the user account.
      7. In the **Allow** column, select the check box for the **Create All Child Objects** permission.

            > [!NOTE]
            > By default, the **Allow** check box is selected for the **Read** permission.

      8. Select **Advanced**.
      9. In the **Permission entries** list, select **Add**, select the user account of the user who is installing Microsoft Dynamics CRM, and then select **OK**.
      10. In the **Apply onto** list, select **Group objects**.
      11. In the **Allow** column, select the following check boxes:
          - Read Permissions
          - Modify Permissions
      12. Select the **Properties** tab.
      13. In the **Apply onto** list, select **Group objects**.
      14. In the **Allow** column, select the following check boxes:
          - Read Members
          - Write Members
      15. Select **OK** three times.
4. Install Microsoft Dynamics CRM.

### Installation option 2 - Use the pre-created Active Directory security groups when you install Microsoft Dynamics CRM

1. Create the following security groups in Active Directory:

   - PrivUserGroup
   - PrivReportingGroup
   - ReportingGroup
   - SQLAccessGroup
   - UserGroup

   To create the security groups in Active Directory, follow these steps:

   1. Sign in to the domain controller server as a user who has domain administrator permissions.
   2. Select **Start**, select **Administrative Tools**, and then select **Active Directory Users and Computers**.
   3. Expand the **Active Directory Users and Computers** tree to the root of the domain or to the specific organizational unit (OU) that you want to use to install Microsoft Dynamics CRM.
   4. Right-click the domain root or the OU that you want to use, select **New**, and then select **Group**.
   5. In the **Group Name** field, type the name of the group. For example, type *PrivUserGroup*.
   6. If the domain functional level is Windows Server 2003 or Microsoft Windows 2000 native, select **Domain local** in the **Group scope** list. If the domain functional level is Windows 2000 mixed, select **Global** in the **Group scope** list.
   7. Select **OK**.
   8. Repeat steps 1d through 1g earlier in this section to create each security group.

2. Add the user account of the user who is installing Microsoft Dynamics CRM as a member of the Local Administrator group. You must complete this step on the computer that is running the Microsoft Dynamics CRM server and on the computer that is running SQL Server.

   1. Sign in to the server as a user who has local administrator permissions.
   2. Select **Start**, select **Administrative Tools**, and then select **Computer Management**.
   3. Expand **System Tools**, expand **Local Users and Groups**, and then expand **Groups**.
   4. Right-click **Administrators**, and then select **Properties**.
   5. To add the user account of the user who is installing Microsoft Dynamics CRM, select **Add**, and then select **OK**.

3. If SQL Server Reporting Services (SSRS) is installed on a server other than the server on which you added permissions in step 1, add the Content Manager role at the root level for the installing user account. Then, add the System Administrator Role at site-wide level for the installing user account. To do this, follow these steps on the server that is running Reporting Services:

   1. Start Internet Explorer, and then locate the following site:

      `https://srsserver/reports`

   2. Select the **Properties** tab, and then select **New Role Assignment**.
   3. In the **Group or user name** box, type the name of the user who is installing Microsoft Dynamics CRM, select the **Content Manager** check box, and then select **OK**.

        > [!NOTE]
        > Use the following format when you type the user name:  
        > **domainname**\\**username**

   4. Select **Site Settings**.
   5. Under **Security**, select **Configure site-wide security**, and then select **New Role Assignment**.
   6. In the **Group or user name** box, type the name of the user who is installing Microsoft Dynamics CRM, select the **System Administrator** check box, and then select **OK**.

        > [!NOTE]
        > Use the following format when you type the user name:  
        > **domainname**\\**username**

4. If you want Microsoft Dynamics CRM to manage the Microsoft Dynamics CRM security groups that are created during the installation, add the following permissions to the security groups that you created in step 1 earlier in this section:

   Permissions:

   - Read
   - Write
   - Add/Remove self as member

   Advanced permissions:

   - List Contents
   - Read All Properties
   - Write All Properties
   - Read Permissions
   - Modify Permissions
   - All Validated Writes
   - Add/Remove self as member
  
   To add the permissions, follow these steps for each security group that you created in step 1 earlier in this section:

   1. Sign in to the domain controller server as a user who has domain administrator permissions.
   2. Select **Start**, select **Administrative Tools**, and then select **Active Directory Users and Computers**.
   3. On the **View** menu, select **Advanced Features**.
   4. In the navigation pane, expand the tree to the security group, right-click the security group, select **Properties**, and then select the **Security** tab.
   5. In the **Group or user names** list, select the user account of the user who is installing Microsoft Dynamics CRM if the account is listed. If the account is not listed, select **Add** to add the user account.

   6. In the **Allow** column, select the check box for the **Write** permission. This action causes the system to automatically select the check box for the **Add/Remove self as member** permission.

        > [!NOTE]
        > By default, the **Allow** check box is selected for the **Read** permission.
   7. Select **Advanced**.
   8. In the **Permission entries** list, select the user account of the user who is installing Microsoft Dynamics CRM, and then select **Edit**.
   9. Select the **Modify Permissions** check box in the **Allow** column.
   10. Select **OK** three times.

       > [!NOTE]
       >
       > - By default, the following permissions are set to **Allow**:
       >
       >   - List Contents
       >   - Read All Properties
       >   - Write All Properties
       >   - Read Permissions
       >   - All Validated Writes
       >   - Add/Remove self as member
       >
       > - If you will turn off Auto Group Management for the installation, you do not have to complete step 4.
       > - For more information about Auto Group Management, see the [Auto Group Management options](#auto-group-management-options) section.

5. When you first sign in to Microsoft Dynamics CRM, and every time that a user is added to Microsoft Dynamics CRM, you must complete the following actions:

   - To sign in, use a user account that has the necessary rights.
   - Manually add the users and the computers to the appropriate security groups.

6. To use the pre-created Active Directory security groups, create a configuration file to point to Microsoft Dynamics CRM. To do this, create an XML configuration file that uses the syntax that is in the following example. Modify the variables as appropriate. The list that follows the sample code describes how to modify the variables that are in this example.

   In the following sample code, the XML file is named Config_precreate.xml. The domain name is `microsoft.com`. These names represent the actual names that you use. The Active Directory hierarchy is as follows:

   - root domain
     - Company Name OU
       - Company Name OU
  
   Sample code

    ```console
    <CRMSetup> <Server> <Groups AutoGroupManagementOff="true"> <PrivUserGroup>CN=PrivUserGroup,OU=Company Name,OU=Company Name,DC=<domain>,DC=<domain_extension></PrivUserGroup> <SQLAccessGroup>CN=SQLAccessGroup,OU=Company Name,OU=Company Name, DC=<domain>,DC=<domain_extension></SQLAccessGroup> <UserGroup>CN=UserGroup,OU=Company Name,OU=Company Name,DC=<domain>,DC=<domain_extension></UserGroup> <ReportingGroup>CN=ReportingGroup,OU=Company Name,OU=Company Name, DC=<domain>,DC=<domain_extension></ReportingGroup> <PrivReportingGroup>CN=PrivReportingGroup,OU=Company Name,OU=Company Name, DC=<domain>,DC=<domain_extension></PrivReportingGroup> </Groups> </Server> </CRMSetup>
    ```

    Modify the parameters in the example by using the following replacement values:

      - *PrivUserGroup*: The name of the PrivUserGroup security group
      - *SQLAccessGroup*: The name of the SQLAccessGroup security group
      - *UserGroup*: The name of the UserGroup security group
      - *ReportingGroup*: The name of the ReportingGroup security group
      - *PrivReportingGroup*: The name of the ReportingGroup security group
      - *domain*: The domain name
      - *domain_extension*: The domain extension

      > [!NOTE]
      > For more information about all the configuration file parameters and samples, see the implementation guide.

7. Run the Microsoft Dynamics CRM server installation. To do this, select **Start**, select **Run**, type *C:\ServerSetup.exe /config C:\configprecreate.xml* in the **Open** box, and then select **OK**.

    > [!NOTE]
    >
    > - C:\ServerSetup.exe refers to the path of the ServerSetup.exe file on the installation medium.  
    > - C:\configprecreate.xml refers to the name and the path of the configuration file that was created.

## Auto Group Management options

The Auto Group Management option is used to determine how the appropriate users and the appropriate computers are added to the security groups. Microsoft Dynamics CRM can add the users and the computers. Or, a user who has appropriate permissions in the Microsoft Dynamics CRM security groups can manually add the users and the computers.

For the Auto Group Management option, use one of the following methods. Use Method 1 to set the AutoGroupManagementOff option to **false** and to have Auto Group Management turned on. Use Method 2 to set the AutoGroupManagementOff option to **true** and to have Auto Group Management turned off.

> [!NOTE]
> The Auto Group Management option can be used only if you are installing Microsoft Dynamics CRM by using pre-created Active Directory security groups.  
> When import organization wizard runs to import organization it considers AutoGroupManagementOff registry value to assign necessary SQL permissions on the imported database. If it's set to 1 import org wizard will not assign SQL permissions on the database, so SQL permissions may need to be assigned through SQL management studio after the import wizard succeeds. If it's set to 0 import org wizard will assign SQL permissions on the database. By default AutoGroupManagementOff reg value is set to 0.

### Method 1 - Set the AutoGroupManagementOff option to false

Because this setting is the default setting, you do not have to add anything to the configuration file. However, the following procedure is an example that describes how to set the AutoGroupManagementOff option to **false**.

Create an XML configuration file that uses the syntax in the following example. Modify the variables as appropriate. To modify the variables that are in this example, refer to step 6 in the [Installation option 2 - Use the pre-created Active Directory security groups when you install Microsoft Dynamics CRM](#installation-option-2---use-the-pre-created-active-directory-security-groups-when-you-install-microsoft-dynamics-crm) section as a guideline.

In this example, the XML file is named Config_precreate.xml. The domain name is `microsoft.com`. The Active Directory hierarchy is as follows:

- root domain
  - Company Name OU
    - Company Name OU Sample code

```console
<CRMSetup> <Server> <Groups> <Groups autogroupmanagementoff="false"> <PrivUserGroup>CN=PrivUserGroup,OU=Company Name,OU=Company Name,DC=microsoft,DC=com</PrivUserGroup> <SQLAccessGroup>CN=SQLAccessGroup,OU=Company Name,OU=Company Name, DC=microsoft,DC=com</SQLAccessGroup> <UserGroup>CN=UserGroup,OU=Company Name,OU=Company Name,DC=microsoft,DC=com</UserGroup> <ReportingGroup>CN=ReportingGroup,OU=Company Name,OU=Company Name, DC=microsoft,DC=com</ReportingGroup> <PrivReportingGroup>CN=PrivReportingGroup,OU=Company Name,OU=Company Name, DC=microsoft,DC=com</PrivReportingGroup> </Groups> </CRMSetup>
```

### Method 2 - Set the AutoGroupManagementOff option to true

1. Create an XML configuration file that uses the syntax that is in the following example. Modify the variables as appropriate. To modify the variables that are in this example, refer to step 6 in the [Installation option 2 - Use the pre-created Active Directory security groups when you install Microsoft Dynamics CRM](#installation-option-2---use-the-pre-created-active-directory-security-groups-when-you-install-microsoft-dynamics-crm) section as a guideline.

    In this example, the XML file is named Config_manageoff.xml. The domain name is `microsoft.com`. The Active Directory hierarchy is as follows:

    - root domain
      - Company Name OU
        - Company Name OU

    Sample code

    ```console
    <CRMSetup> <Server> <Groups AutoGroupManagementOff="true"> <PrivUserGroup>CN=PrivUserGroup,OU=Company Name,OU=Company Name, DC=microsoft,DC=com</PrivUserGroup> <SQLAccessGroup>CN=SQLAccessGroup,OU=Company Name,OU=Company Name, DC=microsoft,DC=com</SQLAccessGroup> <UserGroup>CN=UserGroup,OU=Company Name,OU=Company Name, DC=microsoft,DC=com</UserGroup> <ReportingGroup>CN=ReportingGroup,OU=Company Name,OU=Company Name, DC=microsoft,DC=com</ReportingGroup> <PrivReportingGroup>CN=PrivReportingGroup,OU=Company Name,OU=Company Name, DC=microsoft,DC=com</PrivReportingGroup> </Groups> </Server> </CRMSetup>
    ```

2. Add the appropriate user accounts and the appropriate computer accounts as members of the following groups.

    > [!NOTE]
    > You must follow this step only if the AutoGroupManagementOff option is set to **true**.

    PrivUserGroup

    - The account that the CRMAppPool application pool uses.
    - The account that the ASP.NET process model uses.
    - The user account that runs the Microsoft Dynamics CRM installation.
    - The computer account on which the Microsoft Dynamics CRM-Exchange E-mail Router will be installed.

    ReportingGroup

    - All Microsoft Dynamics CRM user accounts (this includes the user who is installing Microsoft Dynamics CRM).

    SQLAccessGroup

    - The account that the CRMAppPool application pool uses.
    - The account that the ASP.NET process model uses.

    UserGroup

    - All Microsoft Dynamics CRM user accounts (this includes the user who is installing Microsoft Dynamics CRM).

    PrivReportingGroup

    - The computer account on which the Microsoft Dynamics CRM Data Connector for Microsoft SQL Server Reporting Services will be installed.

    To add the accounts, follow these steps for each group in the list:

      1. Sign in to the domain controller server as a user who has domain administrator permissions.
      2. Select **Start**, select **Administrative Tools**, and then select **Active Directory Users and Computers**.
      3. In the navigation pane, expand the tree to the node that contains the security group, right-click the security group, select **Properties**, and then select the **Members** tab.
      4. To add a user account, select **Add**, and then select **OK**. To add a computer account, select **Object Types**, select the **Computers** check box, and then select **OK**.

3. To verify which account the CRMAppPool application pool uses, follow these steps on the computer that is running the Microsoft Dynamics CRM server:

   1. Select **Start**, select **Administrative Tools**, and then select **Internet Information Services (IIS) Manager**.
   2. Expand the computer name.
   3. Expand **Application Pools**.
   4. Right-click **CRMAppPool**, select **Properties**, and then select the **Identity** tab.

   The NetworkService account and the LocalSystem account are both represented by the **domainname\computername $** account. Therefore, if you must add the NetworkService account or the LocalSystem account to a security group, you must add the **domainname\computername $** account.

   If the **Configurable** option is selected, you must add the specified user account to the security group. The specified user account appears in a text box.

4. To verify the account that the ASP.NET process model uses, follow these steps on the Microsoft Dynamics CRM server:

   1. In Windows Explorer, open the following folder:

      `C:\WINNT\Microsoft.NET\Framework\v1.1.4322\CONFIG`

   2. Right-click **Machine.config**, select **Open With**, and then select **Notepad**.
   3. Search for the word *username* in the text. The file contains multiple instances of the word. Locate the fifth instance of *username* that is in the text. The value for the fifth instance of *username* is the account that the ASP.NET process model uses.

   The SYSTEM account and the computer account are both represented by the **domainname\computername $** account. Therefore, if you must add the SYSTEM account or the computer account to a security group, you must add the **domainname\computername $** account.

   If a user name is specified in the Machine.config file, you must add the specified user account to the security group.

## Service account

During the installation of Microsoft Dynamics CRM, you will see a Specify Security Account page. On this page, you can select to use a domain user account as the security account. To do this, follow these steps:

1. Add the domain user account to the Performance Log Users local group. To do this, follow these steps:

   1. On the computer that is running the Microsoft Dynamics CRM server, select **Start**, select **All Programs**, select **Administrative Tools**, and then select **Computer Management**.
   2. Expand **Local Users and Groups**, and then expand **Groups**.
   3. Right-click the **Performance Log Users** group, and then select **Add to Group**.
   4. Select **Add**, type the domain user account, and then select **OK** two times.

2. Create the HTTP Service Principal Names account under the domain user account. To do this, follow these steps:

   1. Install Windows Server Support Tools if it is not installed.

      > [!NOTE]
      > This step does not have to be done on the computer that is running the Microsoft Dynamics CRM server. This step can be done on another server in the domain. And, you must be logged on by using an account that has permissions to add service principal names (SPNs) to user accounts.

   2. At a command prompt, type the following commands, and then press ENTER after each command:

      SETSPN -a http/**crmservername.domain.comuseraccount**  
      SETSPN -a http/**crmservernameuseraccount**

> [!NOTE]
> The **crmservername** placeholder is the name of the server on which Microsoft Dynamics CRM will be installed. The **domain.com** placeholder represents the name of the domain. The **useraccount** placeholder represents the account that you are using as the Service Account during the Microsoft Dynamics CRM installation.

## References

For more information about how to use SPNs, see [How to use SPNs when you configure Web applications that are hosted on Internet Information Services](https://support.microsoft.com/help/929650).
