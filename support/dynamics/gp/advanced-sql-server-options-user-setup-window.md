---
title: Advanced SQL Server options in the User Setup window
description: This article describes the frequently asked questions about the advanced SQL Server options that are used to integrate the Active Directory domain password policies with Microsoft Dynamics GP.
ms.reviewer: theley, kyouells
ms.date: 03/13/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# Frequently asked questions about the advanced SQL Server options in the User Setup window in Microsoft Dynamics GP

This article describes the frequently asked questions about the advanced SQL Server options that are used to integrate the Active Directory domain password policies with Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 922456

## Introduction

This article contains frequently asked questions about the advanced Microsoft SQL Server options in the User Setup window in Microsoft Dynamics GP.

## More information

- **Q1: What is the purpose of the advanced SQL Server options in the User Setup window?**

  A1: These options are used to integrate the Active Directory directory service domain password policies with Microsoft Dynamics GP. The domain password policies apply to Microsoft Dynamics GP users.

- **Q2: What are the prerequisites for these options?**

  A2: The following software and the following operating system must be running:

  - Microsoft Dynamics GP 9.0 or later versions
  - SQL Server 2005 or later versions
  - Windows Server 2003 or Windows Server 2008
  - Windows Server 2003 or Windows Server 2008 domain
  - SQL Server Native Client or SQL Server Native Client 10.0 at each client workstation

- **Q3: Where can I obtain SQL Native Client?**

  A3: To install the SQL Native Client on the client workstation, use one of the following methods:

  - Method 1: On the SQL Server 2005 CD, open the Servers\Setup folder, and then double-click the Sqlncli.msi file.

  - Method 2: On the SQL Server 2008 CD, open the x86\Setup\x86 folder, and then double-click the Sqlncli.msi file.

- **Q4: What domain password policies are in effect when the advanced SQL Server options are enabled?**

  A4: When the **Enforce Password Policy** check box is selected in the User Setup window, the following domain password policies are enabled if the policies are enabled in Active Directory:

  - Enforce Password History
  - Minimum Password Length
  - Password Must Meet Complexity Requirements
  - Account Lockout Duration
  - Account Lockout ThresholdWhen the **Enforce Password Expiration** check box is selected in the User Setup window, the following domain password policies are enabled if the policies are enabled in Active Directory:
  - Minimum Password Age
  - Maximum Password AgeWhen the **Change Password at Next Login** check box is selected, this option forces users to change their passwords the next time that the users log on to Microsoft Dynamics GP. No domain policy is related to this option.

- **Q5: How do the Account Lockup Threshold and the Account Lockup Duration domain policies relate to Microsoft Dynamics GP?**

  A5: The Account Lockup Threshold policy specifies the number of times that a user can type an incorrect password before the user is locked out of the system. The Account Lockup Duration policy specifies how long a user is locked out of the system after the user types an incorrect password.

  - Microsoft Dynamics GP 10.0 and Service Pack 1 - 4 for Microsoft Dynamics GP 10.0 send the user's password to SQL Server four times during each logon attempt. Therefore, to lock out the user after three logon attempts, set the requirement of the Account Lockout Threshold policy to 12. After Service Pack 2 for Microsoft Dynamics GP 10.0 or a later service pack is applied, Microsoft Dynamics GP sends the user's password to SQL Server one time during each logon attempt. Microsoft Dynamics GP 2010 also sends the user's password to SQL Server one time during the logon attempt.

  - We recommend that you set the Account Lockout Threshold to 50.

- **Q6: Does the Minimum Password Age domain policy affect a user who wants to change his or her password?**

  A6: Yes. After a password is set for a user, the user cannot change the password until the requirement of the Minimum Password Age policy is met. For example, if the requirement of the Minimum Password Age policy is one, the user cannot change the password until one day has passed.

- **Q7: Do the advanced SQL Server options work in Microsoft Business Solutions - Great Plains 8.0?**

  A7: No. These options appear dimmed and are unavailable in Microsoft Business Solutions - Great Plains 8.0.

- **Q8: If I enable the advanced SQL Server options, why do users receive the following error message when they try to change their passwords in the User Preferences window?**

  > The password change failed for an unknown reason. Enter a different password or contact your system administrator.

  A8: This problem occurs when the Minimum Password Age domain policy is set to a number that is greater than 0.

  When the Minimum Password Age domain policy is set to a number that is greater than 0, a password change is not accepted until the indicated number of days has passed. For example, if the Minimum Password Age domain policy is set to 1, you must wait at least one day to change the password. To let users change their passwords in the User Preferences window at any time, set the Minimum Password Age domain policy to 0.

- **Q9: Why do I receive the following error message when I click Save after I create a new user?**

  > The password is too short, enter a different password.

  A9: This problem occurs because the password does not meet the requirement of the Maximum Password Length domain policy if you clicked to select the **Enforce Password Policy** check box in the User Setup window.

- **Q10: Why do I receive the following error message when I click Save after I create a new user?**

  > This password does not meet the minimum criteria defined by the system administrator. Enter a different password.

  A10: This problem occurs because the requirement of the Password Must Meet Complexity Requirements domain policy is not met if you clicked to select the **Enforce Password Policy** check box in the User Setup window.

- **Q11: Why do I receive the following error message when I log on to Microsoft Dynamics GP?**

  > Your password has expired. Do you want to change your password now?

  A11: This problem occurs because the password meets the requirement of the Maximum Password Age domain policy. As soon as the requirement is met, you are prompted to change the password.

- **Q12: Why do I receive the following message when I log on to Microsoft Dynamics GP?**

  > You must change your password before access Microsoft Dynamics GP. Do you want to change your password now?

  A12: This message appears because you clicked to select the **Change Password at Next Login** check box in the User Setup window.

- **Q13: Why do I receive the following error message when I log on to Microsoft Dynamics GP?**

  This password cannot be used at this time. Enter a different password.

  A13: This problem occurs because the requirement of the Enforce Password History domain policy is not met if you clicked to select the **Enforce Password Policy** check box in the User Setup window.

- **Q14: Why do I receive the following error message when I log on to Microsoft Dynamics GP?**

  > This user account has been locked out. Contact your system administrator for assistance.

  A14: This problem occurs because the number of times that you tried to log on to Microsoft Dynamics GP exceeds the requirement of the Account Lockup Threshold domain policy.

- **Q15: How do I unlock a user if the user is locked out of the system?**

  A15: To unlock the user, use one of the following methods.

  - Method 1

  To unlock the user, wait until the account lockout duration time has passed.

  - Method 2

    To unlock the user, use SQL Server Management Studio. To do this, follow these steps:

    1. Start SQL Server Management Studio.
    2. Expand **Security**, and then click **Logins**.
    3. Right-click the user whom you want to unlock, and then click **Properties**.
    4. On the **General** tab, click to clear the **Enforce Password Policy** check box.
    5. Click **Status**, and then click to clear the **Login is locked out** check box.
    6. Click **OK**.
    7. Start Microsoft Dynamics GP, and then log on as the sa user.
    8. On the **Tools** menu, point to **Setup**, point to **System**, and then click **User**.
    9. Click the lookup button next to **User ID**, and then select the user who is locked out.
    10. Under **Advanced SQL Options**, click to select the **Enforce Password Policy** check box.
