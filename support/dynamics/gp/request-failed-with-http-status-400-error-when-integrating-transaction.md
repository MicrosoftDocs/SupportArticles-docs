---
title: The request failed with HTTP status 400 error when integrating transactions
description: Fixes an issue that occurs when you integrate lots of transactions that contain many distributions.
ms.reviewer: theley, ttorgers, cwaswick, kyouells
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# "The request failed with HTTP status 400" error when you integrate transactions using Microsoft Dynamics GP Web Services

This article provides a resolution for the issue that you can't integrate transactions by using Microsoft Dynamics GP Web Services.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2960931

## Symptoms

When you use Microsoft Dynamics GP Web Services to integrate a large number of transactions that contain many distributions, you receive the following error message: The request failed with HTTP status 400: Bad Request.

## Cause

This issue occurs because a time-out or limitation is being encountered on the integrations that contain a large number of distribution records.

## Resolution

To resolve this issue, you can adjust the maximum message size quota (`maxReceivedMessageSize`) in the configurator file. To do this, you can modify the WSBindings.config file as follows:

1. Navigate to the WSBindings.config file in the GPWebServices\ServiceConfigs folder, and open it with Notepad.

    > [!NOTE]
    > The default path is:  
    C:\Program Files\Microsoft Dynamics\GPWebServices\ServiceConfigs

2. Add the `maxReceivedMessageSize` property to the `basicHttpBinding` node on the binding name line as shown in the following text:

    ```console
    <basicHttpBinding>
    <!-- change maxReceivedMessageSize to 2147483647 from 128896-->
    <binding name="BasicHttpBindingTarget" maxReceivedMessageSize="2147483647">
    <readerQuotas maxDepth="2147483647" maxStringContentLength="2147483647" maxArrayLength="2147483647" maxBytesPerRead="2147483647" maxNameTableCharCount="2147483647"/>
    <security mode="TransportCredentialOnly">
    <transport clientCredentialType="Ntlm"/>
    </security>
    </binding>
    </basicHttpBinding>
   ```

3. After you make the change and then save the modified configurator file, restart the web service, and then test another integration that has a large number of distributions.
