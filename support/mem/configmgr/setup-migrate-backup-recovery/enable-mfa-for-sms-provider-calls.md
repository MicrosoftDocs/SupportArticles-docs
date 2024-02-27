---
title: Enable MFA for SMS Provider calls
description: Describes a new feature that you can enable multi-factor authentication for SMS Provider calls to protect administrative actions.
ms.date: 12/05/2023
ms.reviewer: kaushika, preetir, prabagar, yuexia, buzb
---
# Enable multi-factor authentication for SMS Provider calls

Starting in Configuration Manager current branch version 1702, you can enable multi-factor authentication (MFA) for Systems Management Server (SMS) Provider calls to prevent unauthorized administrative accesses.

_Original product version:_ &nbsp; Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 4042963

## How to enable MFA for SMS Provider calls

> [!IMPORTANT]
> You must be a member of the Full Administrator role that has access to the All scope to set and change MFA setting for SMS Provider calls.

> [!NOTE]
> You can enable MFA from any server that hosts the SMS Provider because it is a global setting.

To enable MFA, follow these steps:

1. Open WBEMTEST.

1. Connect to the Configuration Manager primary site namespace `root\sms\site_<site code>`. Then, select **Execute Method**.

    :::image type="content" source="media/enable-mfa-for-sms-provider-calls/execute-method.png" alt-text="Screenshot of the Execute Method option in Windows Management Instrumentation Tester window." border="false":::

1. In the **Object Path** field, enter **sms_site**, and then select **OK**.

1. In **Method** list, select `SetAuthenticationLevel`, and then select **Edit In Parameters**.

    :::image type="content" source="media/enable-mfa-for-sms-provider-calls/edit-in-parameters.png" alt-text="Screenshot of the Execute Method dialog box where you can see the method list and Edit in parameters button." border="false":::

1. Edit the `AuthenticationLevel` and `ExceptionList` properties, and then select **Save Object**.

    > [!NOTE]
    > Both `AuthenticationLevel` and `ExceptionList` are global properties that are used on all primary sites.

    :::image type="content" source="media/enable-mfa-for-sms-provider-calls/edit-properties.png" alt-text="Screenshot of the AuthenticationLevel and ExceptionList properties." border="false":::

   - Edit the `AuthenticationLevel` property.

     Refer to the following table to set the value of `AuthenticationLevel`.

     |Value|Description|
     |---|---|
     |0|This is the default value. For this value, a second layer of authentication isn't required. Everyone can make SMS Provider calls based on their role-based access.|
     |10|For this level, users who are logged on by using a PIN or smart card can make SMS Provider calls if they have the appropriate permissions to access the respective provider.|
     |20|For this level, users who are logged on by using a PIN can make provider calls if they have the appropriate permissions to access the respective provider.|

   - Edit the `ExceptionList` property.

     You can bypass MFA for users in the `ExceptionList`, such as service accounts. Add the `UserSID` or `SecurityGroupSID` to the `ExceptionList`. To determine the SIDs, see [Well-Known SID Structures](/openspecs/windows_protocols/ms-dtyp/81d92bba-d22b-4a8c-908a-554ab29148ab).

     > [!NOTE]
     > Users in the `ExceptionList` can't call the `SetAuthenticationLevel` method.

1. select **Execute!**, and then select **Dismiss**.

You can run the following SQL query to check whether MFA is enabled. If MFA is enabled, the query output shows the value of the `Value3` property is `10`.

```sql
select * from vSMS_SC_GlobalProperty where PropertyName='{3B1F3900-A186-11d0-BDA9-00A0C909FDD7} Authentication'
```

### Use PowerShell cmdlets to set the AuthenticationLevel and ExceptionList properties

You can also use PowerShell cmdlets to set the `AuthenticationLevel` and `ExceptionList` properties.

> [!NOTE]
> To get the security identifier (SID) of Active Directory users and groups, run the [Get-AdUser](/powershell/module/activedirectory/get-aduser) and [Get-ADGroup](/powershell/module/activedirectory/get-adgroup) cmdlets.

#### Example 1: Set the authentication level and add two SIDs to the exception list

```powershell
[array]$ExceptionList=@("S-1-5-<domain SID>-<RID of the user or group account>","S-1-5-<domain SID>-<RID of the user or group account>")
[uint32]$AuthenticationLevel=<Authentication level value>
Invoke-CimMethod -Namespace 'root\sms\site_<site code>' -ClassName 'SMS_Site' -MethodName 'SetAuthenticationLevel' -Arguments @{AuthenticationLevel=$AuthenticationLevel;ExceptionList=$ExceptionList}
```

#### Example 2: Set the authentication level to default and remove any entries from the exception list

```powershell
[uint32]$AuthenticationLevel=0
Invoke-CimMethod -Namespace 'root\sms\site_<site code>' -ClassName 'SMS_Site' -MethodName 'SetAuthenticationLevel' -Arguments @{AuthenticationLevel=$AuthenticationLevel}
```
