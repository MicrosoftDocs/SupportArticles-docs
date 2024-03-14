---
title: Login failed for user
description: This article gives steps on how to resolve this error on Windows XP and Windows Vista computers.
ms.reviewer: theley, dlanglie
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# "Login failed for user" Error message when you try to run a Microsoft Dynamics eConnect Destination Adapter integration in Integration Manager for Microsoft Dynamics GP

This article provides a solution to an error that occurs when you try to run a Microsoft Dynamics eConnect Destination Adapter integration in Integration Manager for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 961566

## Symptoms

When you try to run a Microsoft Dynamics eConnect Adapter destination in Integration Manager for Microsoft Dynamics GP, you receive one of the following error messages:

> DOC 1 ERROR: Version=10.0.0.0  
Unique MessageId =  
Error Number = -2147467259  
Error Description = Login failed for user ''. The user is not associated with a trusted SQL Server connection.  
Error Source = Microsoft OLE DB Provider for SQL Server

> The destination could not be initialized due to the following problem:  
The server process could not be started because the configured identity is incorrect. Check the username and password. (Exception from HRESULT: 0x8000401A)

## Cause

This problem will occur if you don't have a domain user name and a domain password set up in the COM+ application in eConnect for Microsoft Dynamics GP.

## Resolution

**For Windows XP**  
To resolve this problem, follow these steps:

1. Start Component Services. To do it, select **Start**, select **Settings**, select **Control Panel**, and then select **Component Services**.
2. Expand **Component Services**, expand **Computers**, expand **My Computer**, and then expand **Com+ Applications**.
3. Right-click **eConnect 10 for Microsoft Dynamics GP**, and then select **Properties**.
4. Select the **Identity** tab, and then select **This User**.
5. Enter the domain administrator user ID and the domain password.
6. Select **Apply**.
7. Select **OK** to close the window.
8. Stop the eConnect 10 for Microsoft Dynamics GP COM+ component.
9. Start the eConnect 10 for Microsoft Dynamics GP COM+ component.
10. Run the integration.

**For Windows Vista**  
To resolve this problem, follow these steps:

1. Start Component Services.
2. Select **Start**, and then select **Run**.
3. Type **dcomcnfg**, and then select **OK**.
4. Expand **Component Services**, expand **Computers**, expand **My Computer**, and then expand **Com+ Applications**.
5. Right-click **eConnect 10 for Microsoft Dynamics GP**, and then select **Properties**.
6. Select the **Identity** tab, and then select **This User**.
7. Enter the domain administrator user ID and the domain password.
8. Select **Apply**.
9. Select **OK** to close the window.
10. Stop the eConnect 10 for Microsoft Dynamics GP COM+ component.
11. Start the eConnect 10 for Microsoft Dynamics GP COM+ component.
12. Run the integration.
