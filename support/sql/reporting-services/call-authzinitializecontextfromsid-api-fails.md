---
title: A call to AuthzInitializeContextFromSid fails
description: This article provides resolutions for the problem that you may experience with the AuthzInitializeContextFromSid API function call during the delivery of an e-mail subscription.
ms.date: 09/21/2020
ms.custom: sap:Reporting Services
ms.reviewer: matthofa, prabagar
---
# A call to the AuthzInitializeContextFromSid API function fails during the delivery of an e-mail subscription in SQL Server Reporting Services

This article helps you resolve the problem that you may experience with the `AuthzInitializeContextFromSid` API function call during the delivery of an e-mail subscription.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 842423

## Summary

This article discusses the cause and some possible resolutions for a problem that may occur in Microsoft SQL Server Reporting Services and Power BI Report Server, in SQL Server Reporting Services when you try to create and to process an e-mail subscription by using a domain user account. The problem occurs when an `AuthzInitializeContextFromSid` API function call in the Authz.dll file does not succeed.

> [!NOTE]
> This problem does not occur in Windows Server 2008.

The resolutions that are discussed in this article are as follows:

How to configure the Reporting Services Windows service to run under a domain user account. If this does not resolve the problem, you must also use one of the following methods:

- Grant the read permission for the domain user account on all the user accounts and all the group of the domain.
- Grant the read permission for the domain user account specifically on a user account or on a group that the user is a member of.

## Introduction

This article discusses a problem that is associated with the `AuthzInitializeContextFromSid` API function call that occurs during the delivery of an e-mail subscription. This article also discusses some possible resolutions for the problem.

## Detail information

While delivering an e-mail for an e-mail subscription, the Reporting Services program may call the `AuthzInitializeContextFromSid` API function that is defined in the Authz.dll file. The Reporting Services program may call the `AuthzInitializeContextFromSid` API function if one of the following conditions is true:

- A report is embedded in the e-mail.
- A report is attached to the e-mail.

If you create and process the e-mail subscription by using a domain user account that is different from the service logon account of the Reporting Services Windows service, the `AuthzInitializeContextFromSid` API function call may fail.

If the function call fails, you may have to configure the settings on the domain of the computer that is running Reporting Services to resolve the problem.

The Reporting Services program calls the `AuthzInitializeContextFromSid` API function to verify whether the user account that was used to create the subscription still has the correct permissions to view the report. This verification is not required when the e-mail contains only a link, a URL, to the report because Reporting Services performs user permissions verification when the user tries to access the report by using the URL.

The `AuthzInitializeContextFromSid` API function call reads the tokenGroupsGlobalAndUniversal (TGGAU) attribute of the security identification number (SID) that is specified in the `AuthzInitializeContextFromSid` API function call to determine Windows group membership information for the current user. Reporting Services calls the `AuthzInitializeContextFromSid` API function by using the security context of the service logon account of the Reporting Services Windows service. Therefore, the user account that you use to run the Reporting Services Windows service must have sufficient permissions to read the `TGGAU` attribute on the user account that is used to create and to process the e-mail subscriptions.

If the computer is not configured correctly to access and to run the `AuthzInitializeContextFromSid` API function call in the Authz.dll file, you may receive an error message. Additionally, an error message may be written to the Reporting Services log file. To determine what error occurred, follow these steps:

1. Open the ReportServerService_ **Timestamp**.log file. Search for the word **authz**.

    > [!NOTE]
    > By default, the ReportServerService_ **Timestamp**.log file is located in the `<Installation drive>:\Program Files\Microsoft SQL Server\<InstanceOfSQLServer>\Reporting Services\Logfiles folder`.
  
    In the ReportServerService_ **Timestamp**.log file, you may notice error messages that are similar to the following:
  
    - Error message 1
  
        > ReportingServicesService!library!718!06/16/2004-00:00:03:: e ERROR: Throwing  Microsoft.ReportingServices.Diagnostics.Utilities.ServerConfigurationErrorException: The Report Server has encountered a configuration error; more details in the log files, AuthzInitializeContextFromSid: Win32 error: 5; possible reason - service account doesn't have rights to check domain user SIDs.; Info: Microsoft.ReportingServices.Diagnostics.Utilities.ServerConfigurationErrorException: The Report Server has encountered a configuration error; more details in the log files.
  
    - Error message 2
  
        > ReportingServicesService!library!7e4!05/24/2004-10:00:22:: e ERROR: Throwing  Microsoft.ReportingServices.Diagnostics.Utilities.ServerConfigurationErrorException: The Report Server has encountered a configuration error; more details in the log files, AuthzInitializeContextFromSid: Win32 error: 1722; Info: Microsoft.ReportingServices.Diagnostics.Utilities.ServerConfigurationErrorException: The Report Server has encountered a configuration error; more details in the log files.

2. Modify the e-mail subscription that caused the error message. Do not embed or attach a report in the e-mail. Use a link to the report. After you process the modified subscription, if you do not receive an error message, you can confirm that the error occurred because the `AuthzInitializeContextFromSid` API function call failed.

To resolve this problem, use one of the following methods.

You can use Method 1 if the following conditions are true:

- The Reporting Services Windows service is running under the Network Service account.
- You do not want to change the account that the Reporting Services Windows service is running under. You can use Method 2 for a general resolution. If Method 2 does not resolve the problem, use Method 3.

## Method 1

1. Add the Windows account to the Pre-Windows 2000 Compatibility Access group by using the Active Directory Users and Computers snap-in.
2. Add the Windows account to the Windows Authorization Access group by using the Active Directory Users and Computers snap-in.
3. Restart the computer that is running Reporting Services.

> [!NOTE]
> - The Windows account in step 1 and in step 2 is the account that you use to run Reporting Services.
> - After you add the account to these groups, it is guaranteed that Reporting Services can access the TGGAU attribute.
> - This method does not require you to modify permissions on any user or group.

## Method 2

Configure the Reporting Services Windows service to run under a domain user account.

> [!NOTE]
> An error message may be written to the Reporting Services trace log when you try to change the user account that is used to run the Reporting Services Windows service.

## Method 3

Configure the settings on the domain of the computer that is running Reporting Services. To do this, use one of the following methods.

### Grant the read permission on all the user accounts and on all the groups in the domain

You may be able to resolve the problem by granting read permissions for the user account that you use to run the Reporting Services Windows service to read the `TGGAU` attribute on all the user accounts and all the groups in the domain. To do this, use the information in one of the following sections, depending on the operating system you are using.

#### For a Microsoft Windows 2000 domain

If the domain is in a pre-Windows 2000 compatibility access mode, the EVERYONE group has read permission on the `TGGAU` attribute for all the user account and all the groups. Therefore, the user account that you use to run the Reporting Services Windows service has access to the `TGGAU` attribute on the user account that Reporting Services uses to create the e-mail subscription.

If the domain is not in a pre-Windows 2000 compatibility access mode, also known as Native mode, you must grant read permission for the user account that is used to run the Reporting Services Windows service so that it can read the `TGGAU` attribute on the user account that Reporting Services uses to create the subscription. You can create a domain local group that simulates the pre-Windows 2000 compatibility group, add the user account that you use to run the Reporting Services Windows service to this group, and then grant read permissions for the group on all the user accounts. To do this, follow these steps:

> [!NOTE]
> You must have administrator permissions on the domain to follow these steps.

1. Click **Start**, point to **Programs**, point to **Administrative Tools**, and then click **Active Directory Users and Computers**.
2. In the **Active Directory Users and Computers** window, in the left pane, expand the **DomainName**.
3. Right-click **Users**, point to **New**, and then click **Group**.
4. In the **New Object - Group** dialog box, type MyAuthZGrp in the **Group name** box.
5. Under **Group scope**, select the **Domain local** option, and then click **OK**. The **MyAuthZGrp** group may appear in the right pane.
6. In the left pane of the **Active Directory Users and Computers** window, right-click the **Users** folder, and then click **Properties**.
7. In the **Users Properties** dialog box, click the **Security** tab.
8. Click **Add**.
9. In the **Select Users, Computers or Groups** dialog box, select the group that you created in step 5.
10. Click **Add**, and then click **OK**.
11. Grant **Read** permission to the user account that you selected in step 9.

#### For a Microsoft Windows Server 2003 domain

If the domain is at a Windows 2000 functional level, the EVERYONE group has read permissions to the TGGAU attribute of all user accounts and groups. Therefore, the Reporting Service service account has the correct permissions to the user account that created the e-mail subscription.

If the domain is at a Windows Server 2003 functional level, the Windows Authorization Access Group (WAA group) has read permissions to the TGGAU attribute of all user accounts and groups. Therefore, if you add the Reporting Services service account to the WAA group, the Reporting Services service account has read permissions to the TGGAU attribute of the user accounts that can create e-mail subscriptions.

To add the Reporting Services service account to the WAA group, follow these steps:

1. On the domain controller, click **Start**, point to **Programs**, point to **Administrative Tools**, and then click **Active Directory Users and Computers**.
2. In the Active Directory Users and Computers window, expand **DomainName**, and then click **Users** or another appropriate organization unit (OU).
3. Double-click the Reporting Services service account.
4. In the **Properties** dialog box, click the **Member Of** tab.
5. On the **Member Of** tab, click **Add**.
6. In the **Select Groups** dialog box, type Windows Authorization Access Group under **Enter the object names to select**, and then click **OK**.
7. Restart the Reporting Services service.

### Grant read permissions to a specific user account or group that can create a Reporting Services subscription

You may not want to grant read permissions to the TGGAU attribute of all user accounts and groups. Instead, you may want to grant read permissions to the TGGAU attribute of a specific user account or group.

> [!NOTE]
> - The user account that Reporting Services uses to run the subscription is the Windows user account that logs on to Report Manager when the subscription is created.
> - These steps are not required if the Reporting Services service account is in the WAA group.
> - You have to follow these steps for every user account or group that can create an e-mail subscription in Reporting Services.

To grant read permissions to the `TGGAU` attribute of a specific user account or group, follow these steps:

1. On a domain controller, click **Start**, point to **Programs**, point to **Administrative Tools**, and then click **Active Directory Users and Computers**.
2. On the **View** menu, make sure that the **Advanced features** item is selected.
3. Double-click the user account or the group that can create a Reporting Services subscription.
4. In the **Properties** dialog box, click the **Security** tab.
5. On the **Security** tab, click **Add**.
6. In the **Select Users, Computers or Groups** dialog box, type the Reporting Services service account under **Enter the object names to select**, and then click **OK**.
7. In the **Properties** dialog box, click the user account that you added in step 6 under **Group or user names**.
8. Under **Permissions forUser**, click to select the **Allow** check box next to the **Read** permission, and then click **OK**.

> [!NOTE]
> The changes may not take effect immediately.

## How to configure the domain settings on the computer

The configuration of the domain depends on the operation mode of the Microsoft Windows domain. Additionally, you must turn on the advanced features on the Windows domain. To find the domain operation mode on the domain controller, and to turn on the advanced features, follow these steps:

1. Click **Start**, point to **Programs**, point to **Administrative Tools**, and then click **Active Directory Users and Computers**.
2. In the **Active Directory Users and Computers** window, in the left pane, right-click the **DomainName**, and then click **Properties**.
3. In the ****DomainName**Properties** dialog box, see the **Domain operation mode** text box on the **General** tab.

The **Domain operation mode** text box shows what domain operation mode the domain is currently using.
4. In the left pane of the **Active Directory Users and Computers** window, click the **DomainName**.
5. On the **View** menu, click **Advanced Features**. For more information about the APIs that require access to authorization on user accounts, see [Some applications and APIs require access to authorization information on account objects](https://support.microsoft.com/help/331951).
