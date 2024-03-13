---
title: Errors in Payables Batch Edit List about Multicurrency using Microsoft Dynamics GP
description: Describes error messages The Currency ID is missing, or The Rate Type ID is missing, or The Exchange Table ID is missing in Payables Batch Edit list.
ms.reviewer:
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Error messages in Payables Batch Edit List about Multicurrency using Microsoft Dynamics GP

This article describes error messages that occur when a computer check batch or Void check batch isn't post after Multicurrency Management has been installed and set up.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2741077

## Symptoms

You receive the following error messages on the Payables Batch Edit List after a computer check batch or Void check batch isn't post after Multicurrency Management has been installed and set up:

> The Currency ID is missing.
>
> The Rate Type ID is missing.
>
> The Exchange Table ID is missing.

## Cause

These errors occur because Check Links isn't run on the Multicurrency setup table after enabling Multicurrency in GP. Since you're voiding a historical document that was originally entered before Multicurrency was enabled, Check Links needs to be run so that the fields mentioned in the errors are updated with the data from the Multicurrency setup. If you don't run Check Links, you'll receive the above errors because those fields are blank in the Multicurrency table (MC020103). These errors also occur when you try to void a historical payment that was created before Mutlicurrency was installed.

## Resolution

To resolve this problem, follow these steps.

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

1. Run Check Links on the Multicurrency Setup tables:
1. Point to **Microsoft Dynamics GP** menu, then **Maintenance** and then **Check Links**.
1. Select the **System** option from the Series drop-down menu.
1. Highlight the **Multicurrency System Setup** option and click **Insert**.
1. Highlight the **Multicurrency Access** option and click **Insert**.
1. Change the Series drop down menu to **Financial**.
1. Highlight the **Multicurrency Setup** option and click **Insert**.
1. Then click the **OK** button to run Check Links on the selected Multicurrency options.
1. A Report Destination window will pop up and you can print the Error Log.

You should now be able to void historical payments without error.
