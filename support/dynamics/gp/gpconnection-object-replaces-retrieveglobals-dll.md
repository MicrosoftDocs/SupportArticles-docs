---
title: Information about the new connection object in Integration Manager for Microsoft Dynamics GP 10.0
description: Discusses the new connection object that's available in Integration Manager for Microsoft Dynamics GP 10.0. This connection object replaces the RetrieveGlobals DLL.
ms.reviewer: theley, kvogel
ms.date: 03/13/2024
---
# Information about the new connection object in Integration Manager for Microsoft Dynamics GP 10.0

This article discusses the new connection object that's available in Integration Manager for Microsoft Dynamics GP 10.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 939371

## Introduction

Integration Manager has provided an ADO Connection object for Microsoft Dynamics GP 10.0 that replaces the RetrieveGlobals DLL. The reference name of this object is GPConnection. This object exposes the methods and the properties that are listed in this article. The "The GPConnection object" section includes Integration Manager script examples of how to use the new connection object in Microsoft Script Editor.

## The GPConnection object

The Open method in the GPConnection object is **GPConnection.Open**. This method uses the ADO Connection object to establish an open ADO connection that uses the current Microsoft Dynamics GP user logon information. After this call is made, the object is set to an open ADO Connection. After this behavior occurs, the connection can be used the same as any other ADO Connection is used.

### Properties of the GPConnection.Open method

- **GPConnection.GPConnUserDate**: the current user date
- **GPConnection.GPConnInterCompanyID**: the intercompany ID that is the company database ID
- **GPConnection.GPConnUserID**: the current user ID
- **GPConnection.GPConnUserName**: the current user name
- **GPConnection.GPConnDataSource**: the current data source that is used by Microsoft Dynamics GP

## Notes

- The Open method in the GPConnection object uses the data source that is used by the current instance of Microsoft Dynamics GP. This data source doesn't use a default company (database), such as TWO or GPDAT. To make the data source use a default company, you must set the default company value in the connection string before you call the open method. The connection string cannot be updated after the open method is called.
  
    The following script is an example of how to set the default company value.

    ```console
    set MyCon = CreateObject("ADODB.Connection")
    MyCon.Connectionstring = "database=GPDAT"
    GPConnection.Open(MyCon)
    ```

- There's no Close method in the GPConnection object because the method isn't required. As soon as the connection is returned in the connection object that is created in the script, that connection object can be closed in the typical way.

- All properties return string values. An example of such a property is the **User Date** field.

    The following script is an example of how to take the following actions:
  - make a connection
  - run an update statement to the SQL database
  - retrieve the connection information

  ```console
    ' Create an ADO record set.
    set recset = CreateObject("ADODB.Recordset")' Create the ADO connection to be used.
    set MyCon = CreateObject("ADODB.Connection")' Initialize the connection string to specify a default database. In this case, the string
    ' is set to the current company. However, the string can be set to a constant. For example,
    ' the string can be to "database=GPDAT."
    MyCon.Connectionstring = "database=" + GPConnection.GPConnInterCompanyID
    ' Call the GPConnection open method that is passing in the ADO connection that you created. 
    ' When the connection returns, MyCon will be set to an open ADO connection. 
    GPConnection.Open(MyCon)' Create a string to contain an update call to the customer master table.
    updatecommand = "update RM00101 set [CUSTNAME]='IM Customer' where [CUSTNMBR]='AARONFIT0022'"
    ' Run the update command.
    recset = MyCon.Execute(updatecommand )' Close the ADO connection in the typical way.
    MyCon.Close
    ' Retrieve the properties that are exposed by the new GPConnection object.
    MsgBox GPConnection.GPConnUserDate
    MsgBox GPConnection.GPConnInterCompanyID
    MsgBox GPConnection.GPConnUserID
    MsgBox GPConnection.GPConnUserName
    MsgBox GPConnection.GPConnDataSource
    ```

## References

For more information about the RetrieveGlobals.dll and RetrieveGlobals9.dll files, click the following article number to view the article in the Microsoft Knowledge Base:

[913341](https://support.microsoft.com/help/913341) How to use the new RetrieveGlobals9.dll file in Integration Manager and in Microsoft Dynamics GP 9.0
