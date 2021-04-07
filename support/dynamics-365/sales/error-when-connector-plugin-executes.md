---
title: Error when Connector plugin executes
description: After applying CRM 2011 updates, an error occurs when the Microsoft Dynamics Connector plugin executes.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# After applying CRM 2011 updates, an error displays when the Microsoft Dynamics Connector plugin executes

This article provides a solution to an error that occurs after you apply Microsoft Dynamics CRM 2011 updates.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2544388

## Symptoms

After applying Microsoft Dynamics CRM 2011 updates, the following error occurs when the Microsoft Dynamics Connector plugin executes:

> *Unexpected exception from plug-in (Execute): Microsoft.Dynamics.Integration.Adapters.Crm2011.Plugin.ContactCreateUpdateEventHandler: System.IO.FileNotFoundException: Could not load file or assembly 'Microsoft.Crm.Sdk, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35' or one of its dependencies. The system cannot find the file specified.*  

## Resolution

Reinstall Dynamics Connector Feature Pack 5 (FP5) or later by following the steps below:

1. Obtain the latest Dynamics Connector update.

    > [!NOTE]
    > When prompted, sign in by using PartnerSource credentials.

2. Run the downloaded .msi file to reinstall the Connector.

3. Import the updated solution into Microsoft Dynamics CRM 2011 by following the steps below:

    1. Sign in to an organization in Microsoft Dynamics CRM as a CRM administrator.

    1. From the navigation pane, select **Settings** > **Customization** > Solutions. Select **Import**.

    1. Browse to the Connector installation directory (`\Program Files (x86)\Microsoft Dynamics\Microsoft Dynamics Adapter`).

    1. Select the ConnectorForMicrosoftDynamicsGp.zip solution file. Select **Open**.

    1. Select **Next**. When the Solution Information is displayed, a message might be displayed that warns a version mismatch. Select **Next**.

    1. Select a customization option:

        - Select Maintain customizations if you're installing Microsoft Dynamics CRM for the first time.
        - Select Overwrite customizations if you're upgrading an existing ERP solution or if you're upgrading to Microsoft Dynamics CRM 2011.

        > [!NOTE]
        > It will overwrite any un-managed customizations that were made in your system.

    1. Select Activate any processes and enable any SDK message processing steps included in the solution.

        > [!NOTE]
        > If you don't select this check box, the steps to install the plug-in won't be activated and the process can't be completed.

    1. Select **Next**.

    1. When the solution customizations have been successfully imported, select **Close** to exit.

## More information

For more information about upgrading and reinstalling the Dynamics Connector, which can be found at [Connector for Microsoft Dynamics installation guides](https://www.microsoft.com/download/details.aspx?id=10381).
