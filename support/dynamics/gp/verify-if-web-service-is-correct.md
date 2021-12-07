---
title: Verify if Web Services is correct
description: Describes how to verify that the Microsoft Dynamics GP Web services run correctly after you install the Microsoft Dynamics GP Web services.
ms.reviewer:
ms.topic: how-to
ms.date: 03/31/2021
---
# How to verify if Microsoft Dynamics GP Web Services is functioning correctly

This article describes how to verify that the Microsoft Dynamics GP Web Services is functionally correctly.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 950844

## Introduction

To verify that the Microsoft Dynamics GP Web services run correctly, follow these steps:

## Microsoft Dynamics GP 2013 or Microsoft Dynamics GP 2010

If using Web Services for Microsoft Dynamics GP 2013 or Microsoft Dynamics GP 2010, follow the steps below:

1. Navigate to the Web Services installation directory in Windows Explorer. The default location for the installation is `C:\Program Files\Microsoft Dynamics\GPWebServices`.
2. Open the SecurityAdminService folder within the installation directory from step #1.

    1. Right-click on the DynamicsSecurityAdmin.config and open it.
    1. Find the line that reads `<add baseAddress="https://SERVERNAME:48621/"/>`.
    1. Copy the URL from that line to a browser window to browse it.
    1. Verify that the service description appears as expected.

3. Open the ServiceConfigs folder within the installation directory from step #1.

    1. Right-click on the DynamicsGP.config and open it.
    1. Find the line that reads `<add baseAddress="https://SERVERNAME:48620/Dynamics/GPService"/>`.
    1. Copy the URL from that line to a browser window to browse it. By default, this URL is `https://SERVERNAME:48620/Dynamics/GPService`.
    1. Verify that the service description appears as expected.
    1. Right-click on the DynamicsGPLegacy.config and open it.
    1. Find the line that reads `<add baseAddress="https://SERVERNAME:48620/DynamicsGPWebServices"/>`.
    1. Copy the URL from that line to a browser window to browse it. By default, this URL is `https://SERVERNAME:48620/DynamicsGPWebServices`.
    1. Verify that the service description appears as expected.
    1. Right-click on the DynamicsSecurity.config and open it.
    1. Find the line that reads `<add baseAddress="https://SERVERNAME:48620/DynamicsSecurityService"/>`.
    1. Copy the URL from that line to a browser window to browse it. By default, this URL is `https://SERVERNAME:48620/DynamicsSecurityService`.
    1. Verify that the service description appears as expected.

4. Select **Start**, point to **Administrative Tools**, and then select **Dynamics Security Console**.
5. Expand the policy nodes to see the policies.
6. Verify that the policy information appears as expected.
7. Expand **Entity ID Assignments**.
8. Right-click on **Customer**, and select **Add**.
9. Entity Type: Customer.
10. Company: Select your Company.
11. It should populate the grid below with ID and Description.

## Microsoft Dynamics GP 10.0 or Microsoft Dynamics GP 9.0

If using Web Services for Microsoft Dynamics GP 10.0 or Microsoft Dynamics GP 9.0, follow the steps below:

1. Start Administrative Tools, and then access the Web sites list. To do it, follow the steps for your version of the program:

    - Windows Server 2003

        1. Select **Start**, point to **Administrative Tools**, and then select **Internet Information Services (IIS) Manager**.
        1. Select the plus sign next to the computer name to expand the selection.
        1. Select the plus sign next to Web Sites to expand the selection.

    - Windows Server 2008

        1. Select **Start**, point to **Administrative Tools**, and then select **Internet Information Services (IIS) Manager**.
        1. Select the plus sign next to the computer name to expand the selection.
        1. Select the plus sign next to Sites to expand the selection, and then select the **Content View** button at the bottom of the Internet Information Services (IIS) Manager window.

2. In the Internet Information Services (IIS) Manager window, expand the Microsoft Dynamics GP Web Services Web site.

3. Select the DynamicsGPWebServices virtual directory, right-click DynamicsGPWebService.asmx, and then select **Browse**.

4. Verify that the service description appears as expected.

5. In the Internet Information Services (IIS) Manager window, expand the Microsoft Dynamics GP Web Services Web site.

6. Select the DynamicsSecurityService virtual directory, right-click DynamicsSecurityService.asmx, and then select **Browse**.

7. Verify that the service description appears as expected.

8. In the Internet Information Services (IIS) Manager window, select the Dynamics Security Admin Service Web site.

9. Right-click DynamicsAdminService.asmx, and then select **Browse**.

10. Verify that the service description appears as expected.

11. Select **Start**, point to **Administrative Tools**, and then select **Dynamics Security Console**.

12. Expand the policy nodes to see the policies.

13. Verify that the policy information appears as expected.

14. Expand Entity ID Assignments.

15. Right-click on **Customer**, and select **Add**.

16. Entity Type: Customer

17. Company: Select your Company.

18. It should populate the grid below with ID and Description.
