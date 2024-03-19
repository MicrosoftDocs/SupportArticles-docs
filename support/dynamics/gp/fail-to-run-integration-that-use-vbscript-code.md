---
title: Error when you run an integration that uses VBScript code after you upgrade to Integration Manager for Microsoft Dynamics GP 10.0
description: This article gives an example VBScript code that is in the RetrieveGloblas format and describes what you have to change in the new GPConnection object code in Integration Manager for Microsoft Dynamics GP 10.0.
ms.topic: troubleshooting
ms.reviewer: theley, grwill, dlanglie
ms.date: 03/13/2024
---
# Error message when you run an integration that uses VBScript code after you upgrade to Integration Manager for Microsoft Dynamics GP 10.0: "DOC 1 ERROR: Object required"

This article lists the code that must be changed from the `RetrieveGlobals` format to use the new ADO connection objects that were added in Integration Manager for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 971837

## Symptoms

You upgrade to Integration Manager 10.0. When you run an integration that contains VBScript code, you receive the follow error message:

> DOC 1 ERROR: Object required:
>
> DOC 1 ERROR: Error Executing Script '\<Integration_Event>' Line xx:"

> [!NOTE]
> In this error message, "\<Integration_Event>" is the Integration Manager event that contains the VBScript code.

## Cause

This issue occurs if `RetrieveGlobals` VBScript code exists in one of the scripts in the integration.

## Resolution

To resolve this issue, update the VBScript code to use the new `GPConnection` object, and then update the lines that set up the `ADODB.Connection` object. The `RetrieveGlobals` userinfo object is no longer used in Integration Manager 10.0.

1. Locate the following line:

    ```vbs
    uom = SourceFields("ItemPriceUpdate.UofM")
    ```

    Change this line to resemble the following:

    ```vbs
    uom = SourceFields("Item Pricing Specific.UofM")
    ```

    > [!NOTE]
    > When you make this change, the script is updated so that it is compatible with the Integration Manager 10.0 Inventory Item sample integration. This step is not typically required to update code to use the `GPConnection` object.

2. Comment out the following line. This line is no longer required:

    ```vbs
    'Set userinfo = CreateObject("RetrieveGlobals9.retrieveuserinfo")
    ```

3. Comment out the line that uses the userinfo object Connection method to return an ADO connection object. Then, add a new line to create a new ADO connection object that will be passed to the `GPConnection` object open method:

    ```vbs
    'Set cn = userinfo.Connection
    Set cn = CreateObject("ADODB.Connection")
    ```

4. When you use the `GPConnection` object, you must specify the company database before you pass the ADO connection object to the Open method. To do this, comment out the line that uses the userinfo object intercompany_id method to set the `DefaultDatabase` property of the connection object. Then, add a new line that uses the built-in `GPConnection` object to specify the database as follows:

    ```vbs
    'cn.DefaultDatabase = userinfo.intercompany_id
    cn.ConnectionString = "database=" & GPConnection.GPConnInterCompanyID
    ```

5. Pass the ADO `Connection` object that you set up in step 4 to the `Open` method in the `GPConnection` object so that it is ready for use. Add the following line:

    ```vbs
    GPConnection.Open(cn)
    ```

6. Comment out the line at the bottom to release the userinfo object. This object was not created:

    ```vbs
    'Set userinfo = Nothing
    ```

    Make sure that you do not change the rest of the code. You have to change only the lines of code that create and set up the `ADODB.Connection` object. The following code is the updated code. You can paste this code into the Inventory Item sample integration After Document script event.

    ```vbs
    'Integration Manager 10.0 VBScript code
    'A similiar version can also be found in the Integration Manager Script Library
    Dim cn, cmd, rst, userinfo, Item, uom
    
    Item = SourceFields("Inventory Item Main.ItemNumber")
    uom = SourceFields("Item Pricing Specific.UofM")'Old Integration Manager 9.0 code
    'Create the retrieveglobals object
    'Set userinfo = CreateObject("RetrieveGlobals9.retrieveuserinfo")'Create the ADO connection object using RetrieveGlobals
    'Set cn = userinfo.Connection
    'cn.DefaultDatabase = userinfo.intercompany_id
    
    'New Integration Manager 10.0 code
    Set cn = CreateObject("ADODB.Connection")
    cn.ConnectionString = "database=" & GPConnection.GPConnInterCompanyID
    GPConnection.Open(cn)'Create the ADO command object
    Set cmd = CreateObject("ADODB.Command")
    cmd.ActiveConnection = cn
    
    cmd.CommandText = "Update IV00101 Set PRCHSUOM = '" & uom & "' where (ITEMNMBR='" & Item & "')"
    Set rst = cmd.Execute
    
    'release objects
    Set rst = Nothing
    Set cmd = Nothing
    Set cn = Nothing
    'Set userinfo = Nothing
    ```

## More information

The following is an example of an Integration Manager 9.0 VBScript code that uses RetrieveGlobals9.dll to create an ADO connection to execute an SQL statement to update the Default Purchasing UofM in an Inventory Item integration. The following code is added to the After Document event:

```vbs
Dim cn, cmd, rst, userinfo, Item, uom

Item = SourceFields("Inventory Item Main.ItemNumber")
uom = SourceFields("ItemPriceUpdate.UofM")'Create the retrieveglobals object
Set userinfo = CreateObject("RetrieveGlobals9.retrieveuserinfo")'Create the ADO connection object using RetrieveGlobals
Set cn = userinfo.Connection
cn.DefaultDatabase = userinfo.intercompany_id

'Create the ADO command object
Set cmd = CreateObject("ADODB.Command")
cmd.ActiveConnection = cn

cmd.CommandText = "Update IV00101 Set PRCHSUOM = '" & uom & "' where (ITEMNMBR='" & Item & "')"
Set rst = cmd.Execute

'release objects
Set rst = Nothing
Set cmd = Nothing
Set cn = Nothing
Set userinfo = Nothing
```
