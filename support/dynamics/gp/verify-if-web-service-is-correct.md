---
title: Verify if Web Services are correct
description: Describes how to verify that Microsoft Dynamics GP Web Services run correctly after you install Microsoft Dynamics GP Web Services.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/13/2024
---
# How to verify if Microsoft Dynamics GP Web Services are functioning correctly

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 950844

To verify that Microsoft Dynamics GP Web Services run correctly, follow these steps:

1. Navigate to the Web Services installation directory in Windows Explorer. The default location for the installation is _C:\Program Files\Microsoft Dynamics\GPWebServices_.

2. Open the SecurityAdminService folder within the installation directory from step 1.

    1. Right-click the DynamicsSecurityAdmin.config and open it.
    2. Find the line that reads `<add baseAddress="http://SERVERNAME:48621/"/>`.
    3. Copy the URL from that line to a browser window to browse it.
    4. Verify that the service description appears as expected.

3. Open the ServiceConfigs folder within the installation directory from step 1.

    1. Right-click the DynamicsGP.config and open it.
    2. Find the line that reads `<add baseAddress="http://SERVERNAME:48620/Dynamics/GPService"/>`.
    3. Copy the URL from that line to a browser window to browse it. By default, this URL is `http://SERVERNAME:48620/Dynamics/GPService`.
    4. Verify that the service description appears as expected.
    5. Right-click the DynamicsGPLegacy.config and open it.
    6. Find the line that reads `<add baseAddress="http://SERVERNAME:48620/DynamicsGPWebServices"/>`.
    7. Copy the URL from that line to a browser window to browse it. By default, this URL is `http://SERVERNAME:48620/DynamicsGPWebServices`.
    8. Verify that the service description appears as expected.
    9. Right-click the DynamicsSecurity.config and open it.
    10. Find the line that reads `<add baseAddress="http://SERVERNAME:48620/DynamicsSecurityService"/>`.
    11. Copy the URL from that line to a browser window to browse it. By default, this URL is `http://SERVERNAME:48620/DynamicsSecurityService`.
    12. Verify that the service description appears as expected.

4. Select **Start**, point to **Administrative Tools**, and then select **Dynamics Security Console**.
5. Expand the policy nodes to see the policies.
6. Verify that the policy information appears as expected.
7. Expand **Entity ID Assignments**.
8. Right-click **Customer**, and select **Add**.

   > [!NOTE]
   > If the company doesn't have customers, you can test with one of the other options.
9. Entity Type: Customer.
10. Company: Select your company.
11. It should populate the grid below with ID and description.
