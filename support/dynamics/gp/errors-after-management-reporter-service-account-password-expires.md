---
title: Error if Management Reporter service account password expires
description: Describes an error message you may receive when you sign in to a company in Management Reporter. Provides a resolution.
ms.reviewer: theley, jopankow, kevogt
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Financial - Management Reporter
---
# Error messages occur after the Management Reporter service account password expires

This article provides a resolution for the error messages that may occur when you sign in to a company after the Management Reporter service account password expires.

_Applies to:_ &nbsp; Microsoft Dynamics GP, Microsoft Dynamics AX 2009, Microsoft Dynamics SL 2011  
_Original KB number:_ &nbsp; 2666579

## Symptoms

You receive the following error message when you sign in to a company in Microsoft Management Reporter:

> The MRProcessService service was unable to log on as <domain\username> with the currently configured password due to the following error:
Logon failure: unknown user name or bad password.

You may also receive the error:

> Error 1069: The service did not start due to a logon failure

## Cause

The Active Directory domain account that is used for the Management Reporter Process Service or the Management Reporter application pool has an expired password.

## Resolution

Update the password stored for the Management Reporter service account for the Windows Service and IIS. To perform this, follow these steps:

1. All users must exit the Management Reporter Report Designer and Report Viewer applications.

2. Change the password for the account. To do this, sign in to a computer joined to your domain as the Active Directory account selected to run the Management Reporter services and change the password. Or, you can request that a network administrator change the account's password for you.

3. The old password is saved with the configuration of the services and must manually be changed. Follow the steps in the appropriate section here, based on your operating system version, to update the passwords:

### Windows Server 2003

1. Select **Start**, select **Administrative Tools**, and then select **Services**.
2. Locate the Management Reporter Process Service.
3. Right-select the service named Management Reporter Process Service and then select Stop. Repeat this step until the Status no longer displays Started. If the service is already stopped, the **Stop** option will not be available and you may continue to the next step.
4. Right-select the service named Management Reporter Process Service and then select **Properties**.
5. Select the **Log On** tab.
6. Select **This account**.
7. Select **Browse**.
8. Enter the domain\username of the account that you want to select, or select **Advanced** to search.
9. Select **Check Names** to verify the account can be found.
10. Select **OK**.
11. Delete the password entered in the **Password** and **Confirm Password** fields.
12. Enter the correct password for the domain account in the **Password** and **Confirm Password** fields.

    > [!NOTE]
    > Make sure that you type the password correctly as the password is not validated against the account's current network password.
13. Select **Apply**.
14. Select **OK**.
15. Open the Internet Information Services (IIS) Manager. To do this, select Start, select **Control Panel**, select **Administrative Tools**, and then select **Internet Information Services (IIS) Manager**.
16. Expand the computer name and select the Application Pools folder.
17. Right-select the Management Reporter application pool and select **Stop**. If the State listed already says Stopped, you may skip this step.
18. Right-select the Management Reporter application pool, and then select **Properties**.
19. Select the **Identity** tab.
20. Select **Configurable**.
21. Select **Browse**.
22. Enter the domain\username of the account that you want to select, or select **Advanced** to search.
23. Select **Check Names** to verify the account can be found.
24. Select **OK**.
25. Enter the password in the **Password** field.
26. Select **Apply**.
27. Reenter the password for the account in the **Please reenter the password to confirm** window.
28. Select **OK**.
29. Select **OK** again to return to IIS Manager window.

    > [!NOTE]
    > Make sure that you type the password correctly as the password is not validated against the account's current network password.

30. Right-select the Management Reporter application pool, and then select **Start**.
31. Select **Start**, select **Control Panel**, select **Administrative Tools**, and then select **Event Viewer**.
32. Select **Application** to select the Application log.
33. Review the log to verify no error messages occurred when you started the Management Reporter application pool.
34. Select **System** to select the System log.
35. Review the log to verify no error messages occurred when you started the Management Reporter application pool.
36. Select Start, select **Control Panel**, select **Administrative Tools**, and then select **Services**.
37. Locate the Management Reporter Process Service.
38. Right-select the service named Management Reporter Process Service and then select **Start**.
39. Select **Start**, select **Control Panel**, select **Administrative Tools**, and then select **Event Viewer**.
40. Select **Application** to select the Application log.
41. Review the log to verify no error messages occurred when you started the Management Reporter Process Service.
42. Select **System** to select the System log.
43. Review the log to verify no error messages occurred when you started the Management Reporter Process Service.

### Windows Server 2008

1. Select **Start**, select **Control Panel**, select **Administrative Tools**, and then select **Services**.
2. Locate the Management Reporter Process Service.
3. Right-select the service named Management Reporter Process Service and then select Stop. Repeat this step until the Status no longer displays Started. If the service is already stopped, the **Stop** option will not be available and you may continue to the next step.
4. Right-select the service named Management Reporter Process Service and then select Properties.
5. Select the **Log On** tab.
6. Select **This account**.
7. Select **Browse**.
8. Enter the domain\username of the account that you want to select, or select **Advanced** to search.
9. Select **Check Names** to verify the account can be found.
10. Select **OK**.
11. Delete the password entered in the **Password** and **Confirm Password** fields.
12. Enter the correct password for the domain account in the **Password** and **Confirm Password** fields.

    > [!NOTE]
    > Make sure that you type the password correctly as the password is not validated against the account's current network password.

13. Select **Apply**.
14. Select **OK**.
15. Open the Internet Information Services (IIS) Manager. To do this, select **Start**, select **Control Panel**, select **Administrative Tools**, and then select **Internet Information Services (IIS) Manager**.
16. Expand the computer name and select the Application Pools folder.
17. Right-select the Management Reporter application pool and then select **Stop**. If the Status listed already says Stopped, you may skip this step.
18. Right-select the Management Reporter application pool, and select **Advanced Settings**. The Advanced Settings window opens.
19. Select **Identity** to select the Identity field.
20. Select the ellipses (... ) next to the account name. The Application Pool Identity window opens.
21. Select **Custom Account**.
22. Select **Set**. The Set Credentials window opens.
23. Enter the domain\username to be used for the Management Reporter application pool.
24. Enter the password for the account in the **Password** and **Confirm Password** fields.
25. Select **OK** on the Set Credentials screen.

    > [!NOTE]
    > The password entered for the account is validated against the account's current network password.

26. Select **OK** on the Application Pool Identity window.
27. Select **OK** on the Advanced Settings window.
28. Right-select the Management Reporter application pool, and then select **Start**.
29. Select **Start**, select **Control Panel**, select **Administrative Tools**, and then select **Event Viewer**.
30. Select **Application** to select the Application log.
31. Review the log to verify no error messages occurred when you start the Management Reporter application pool.
32. Select **System** to select the System log.
33. Review the log to verify no error messages occurred when you start the Management Reporter application pool.
34. Select **Start**, select **Administrative Tools**, and then select **Services**.
35. Locate the Management Reporter Process Service.
36. Right-select the service named Management Reporter Process Service and then select **Start**.
37. Select **Start**, select **Control Panel**, select **Administrative Tools**, and then select **Event Viewer**.
38. Select **Application** to select the Application log.
39. Review the log to verify no error messages occurred when you start the Management Reporter Process Service.
40. Select **System** to select the System log.
41. Review the log to verify no error messages occurred when you start the Management Reporter Process Service.
