---
title: Cannot access the exception service
description: Provides a solution to an error that occurs when you start the Exception Management console in Web Services for Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "Cannot access the exception service" Error message when you start the Exception Management console in Web Services for Microsoft Dynamics GP

This article provides a solution to an error that occurs when you start the Exception Management console in Web Services for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 924548

## Symptoms

When you start the Exception Management console in Web Services for Microsoft Dynamics GP, you receive the following error message:
> Cannot access the exception service. Verify the configuration file exists and contains the correct path to the exception service.

## Cause

This problem occurs if either of the following conditions is true:

- The URL of the Web Services for Microsoft Dynamics GP in the Microsoft.Dynamics.GP.Administration.Exceptions.dll.config file isn't entered correctly.

    > [!NOTE]
    > See [resolution 1](#resolution-1).
- The **Enable anonymous access** check box is selected for the DynamicsGPWebServices virtual directory.

    > [!NOTE]
    > See [resolution 2](#resolution-2).
- There's an invalid character in the WSExceptionLog table.

    > [!NOTE]
    > See [resolution 3](#resolution-3).

## Resolution 1

To enter the correct URL of the Web Services for Microsoft Dynamics GP, follow these steps:

1. Open the Microsoft.Dynamics.GP.Administration.Exceptions.dll.config file by using a text editor. This file is located in the following directory:  
    `C:\Program Files\Common Files\Microsoft Shared\Microsoft Dynamics\ManagementConsole`

2. In the file, locate the URL of the Web Services for Microsoft Dynamics GP.
3. Determine whether the URL is correct. To do it, test the URL in Microsoft Internet Explorer.
4. If the URL is incorrect, change the URL of the Web Services for Microsoft Dynamics GP in the file.

    The following code sample contains the correct format for the URL.

    ```xml
    <appSettings> <add key="DynamicsGPServiceURL" value="http://<computer_name>:80/DynamicsGPWebServices/DynamicsGPService.asmx" /> </appSettings>
    ```

> [!NOTE]
> The *<computer_name>* placeholder represents the name of the computer on which the Web Services for Microsoft Dynamics GP are installed. If the following conditions are true, you have to use the assigned IP address for the Web Services for Microsoft Dynamics GP Web site for this computer:
>
> - An IP address is assigned to the Web site.
> - Other Web sites are running on the same port number. However, these Web sites use different IP addresses.

## Resolution 2

To remove anonymous authentication from the DynamicsGPWebServices virtual directory, follow these steps:

1. In Control Panel, select **Administrative Tools**, and then select **Internet Information Services (IIS) Manager**.
2. Expand the computer name, and then expand the **Web Sites** folder.
3. Expand the Web site in which the Web Services for Microsoft Dynamics GP are installed.
4. Right-click the **DynamicsGPWebServices** virtual directory, and then select **Properties**.
5. Select the **Directory Security** tab, and then click to clear the **Enable anonymous access** check box.
6. Make sure that the **Integrated Windows Authentication** check box is selected.

## Resolution 3

To check for and remove invalid characters from the WSExceptionLog table, follow these steps:

1. Select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005** or to **Microsoft SQL Server 2008**, and then select **SQL Server Management Studio**.
2. In the Connect to Server window, follow these steps:
    1. In the **Server name** box, type the name of the server that is running SQL Server.
    2. In the **Authentication** box, select **SQL Authentication**.
    3. In the **Login** box, type **sa**.
    4. In the **Password** box, type the password for the sa user, and then select **Connect**.
3. Select the **New Query** button.
4. Type and then run the following script:

    ```sql
    select * from DYNAMICS..WSExceptionLog where ExceptionMessage like '%invalid character%'  
    ```

5. If any records are returned in step 4, type and then run the following script to remove them:

    ```sql
    delete DYNAMICS..WSExceptionLog where ExceptionMessage like '%invalid character%'  
    ```
