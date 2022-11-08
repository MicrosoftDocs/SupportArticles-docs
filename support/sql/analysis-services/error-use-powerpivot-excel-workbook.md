---
title: Error when you use PowerPivot for Excel workbook
description: This article provides a resolution for the problem that occurs when you try to use a PowerPivot for Excel workbook as a data source in SQL Server Analysis Services.
ms.date: 11/10/2020
ms.custom: sap:Analysis Services
ms.prod: sql
---
# Error message when you use a PowerPivot for Excel workbook as a data source in SQL Server Analysis Services

This article helps you resolve the problem that occurs when you try to use a PowerPivot for Excel workbook as a data source in SQL Server Analysis Services.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2607106

## Symptoms

Consider the following scenario:

- You configure Microsoft PowerPivot for Excel on a middle-tier server.
- You configure the server to use Kerberos authentication and then connect to the server.
- You try to use a PowerPivot for Excel workbook as a data source in Microsoft SQL Server Analysis Services.

In this scenario, you may receive an error message that resembles the following:

> HTTP Error 401.

## Cause

This issue occurs because the custom bindings for the Redirector service are configured to use Microsoft NTLM authentication. Additionally, the custom bindings are configured not to negotiate.

## Resolution

To resolve this issue, enable Kerberos authentication for the Redirector service. To do this, follow these steps:

1. Back up the *Web.config* file for the Redirector service.

    > [!NOTE]
    > By default, the *Web.config* file is located in the folder: `%SystemDrive%\program files\common files\web service extensions\14\ISAPI\powerpivot`.

2. Open the *Web.config* file for the Redirector service in Notepad.
3. Locate the `<binding name="RedirectorBinding">` tag, and then change the `authenticationScheme` value as follows:

    - Original

        ```console
        <binding name="RedirectorBinding">
        <webMessageEncoding webContentTypeMapperType="Microsoft.AnalysisServices.SharePoint.Integration.Redirector.RawContentTypeMapper, Microsoft.AnalysisServices.SharePoint.Integration" />
        <httpTransport manualAddressing="true" authenticationScheme="Ntlm" transferMode="Streamed" maxReceivedMessageSize="9223372036854775807"/>
        </binding>
        ```

    - Updated

        ```console
        <binding name="RedirectorBinding">
        <webMessageEncoding webContentTypeMapperType="Microsoft.AnalysisServices.SharePoint.Integration.Redirector.RawContentTypeMapper, Microsoft.AnalysisServices.SharePoint.Integration" />
        <httpTransport manualAddressing="true" authenticationScheme="Negotiate" transferMode="Streamed" maxReceivedMessageSize="9223372036854775807"/>
        </binding>
        ```

4. Locate the `<binding name="RedirectorSecureBinding"`> tag, and then change the **authenticationScheme** value as follows:

    - Original

        ```console
        <binding name="RedirectorSecureBinding">
        <webMessageEncoding webContentTypeMapperType="Microsoft.AnalysisServices.SharePoint.Integration.Redirector.RawContentTypeMapper, Microsoft.AnalysisServices.SharePoint.Integration" />
        <httpsTransport manualAddressing="true" authenticationScheme="Ntlm" transferMode="Streamed" maxReceivedMessageSize="9223372036854775807"/>
        </binding>
        ```

    - Updated

        ```console
        <binding name="RedirectorSecureBinding">
        <webMessageEncoding webContentTypeMapperType="Microsoft.AnalysisServices.SharePoint.Integration.Redirector.RawContentTypeMapper, Microsoft.AnalysisServices.SharePoint.Integration" />
        <httpsTransport manualAddressing="true" authenticationScheme="Negotiate" transferMode="Streamed" maxReceivedMessageSize="9223372036854775807"/>
        </binding>
        ```

5. On the **File** menu, click **Save**.
6. Exit Notepad.
