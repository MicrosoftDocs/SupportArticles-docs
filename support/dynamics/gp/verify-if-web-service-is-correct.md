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

## Microsoft Dynamics GP 18.x to Microsoft Dynamics GP 2010

If using Web Services for Microsoft Dynamics GP 18.x to Microsoft Dynamics GP 2010, follow the steps below:

1. Navigate to the Web Services installation directory in Windows Explorer. The default location for the installation is `C:\Program Files\Microsoft Dynamics\GPWebServices`.

2. Open the SecurityAdminService folder within the installation directory from step #1.

    a. Right-click on the DynamicsSecurityAdmin.config and open it.
    b. Find the line that reads `<add baseAddress="http://SERVERNAME:48621/"/>`.
    c. Copy the URL from that line to a browser window to browse it.
    d. Verify that the service description appears as expected.

3. Open the ServiceConfigs folder within the installation directory from step #1.

    a. Right-click on the DynamicsGP.config and open it.
    b. Find the line that reads `<add baseAddress="http://SERVERNAME:48620/Dynamics/GPService"/>`.
    c. Copy the URL from that line to a browser window to browse it. By default, this URL is `http://SERVERNAME:48620/Dynamics/GPService`.
    d. Verify that the service description appears as expected.
    e. Right-click on the DynamicsGPLegacy.config and open it.
    f. Find the line that reads `<add baseAddress="http://SERVERNAME:48620/DynamicsGPWebServices"/>`.
    g. Copy the URL from that line to a browser window to browse it. By default, this URL is `http://SERVERNAME:48620/DynamicsGPWebServices`.
    h. Verify that the service description appears as expected.
    i. Right-click on the DynamicsSecurity.config and open it.
    j. Find the line that reads `<add baseAddress="http://SERVERNAME:48620/DynamicsSecurityService"/>`.
    k. Copy the URL from that line to a browser window to browse it. By default, this URL is `http://SERVERNAME:48620/DynamicsSecurityService`.
    l. Verify that the service description appears as expected.

4. Select **Start**, point to **Administrative Tools**, and then select **Dynamics Security Console**.
5. Expand the policy nodes to see the policies.
6. Verify that the policy information appears as expected.

7. Expand **Entity ID Assignments**.
8. Right-click on **Customer**, and select **Add**.
9. Entity Type: Customer.
10. Company: Select your Company.
11. It should populate the grid below with ID and Description.
***NOTE: If the company doesn't have customers, you can test with one of the other options.***

