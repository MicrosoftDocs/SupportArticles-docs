---
title: Unable to generate a temporary class
description: Fixes an issue where you receive the Unable to generate a temporary class (result=1) error when you execute the Invoke Web Services object.
ms.date: 06/26/2024
---
# Unable to generate a temporary class (result=1) error when executing the Invoke Web Services object

This article helps you work around an issue where you receive the **Unable to generate a temporary class (result=1)** error when you execute the Invoke Web Services object.

_Applies to:_ &nbsp; All versions of Orchestrator  
_Original KB number:_ &nbsp; 2486643

## Symptoms

When you execute the Invoke Web Services object in Microsoft System Center Orchestrator or Opalis Integration Server, you receive one or more of the following errors in the **Error Summary Text** published data:

> Unable to generate a temporary class (result=1).  
> error CS0029: Cannot implicitly convert type 'Opalis.WebServices.DynamicProxy.CustomType' to 'Opalis.WebServices.DynamicProxy.CustomType[]'  
> error CS0030: Cannot implicitly convert type 'Opalis.WebServices.DynamicProxy.CustomType[]' to 'Opalis.WebServices.DynamicProxy.CustomType'

## Cause

A known issue with WSDL.exe can cause a proxy class to be generated incorrectly if an array of complex type includes an element that's also an array of complex type and for which only one element exists.

> [!NOTE]
> WSDL.exe is included in the Microsoft .NET Framework.

## Workaround

There are three workarounds available:

- You can generate the proxy class manually by using WSDL.exe and then change the proxy class in which the data type was inappropriately created as a two-dimensional array (for example, `CustomType[][]`) so that it's a single-dimensional array (for example, `CustomType[]`).

- You can change the data type in the desired Web Services Description Language (WSDL) so that a second, optional element is included in the definition. You can do this by adding an element such as the following example:

    `<xs:element minOccurs="0" name="dummyElement" nillable="true" type="xs:string"/>`

- You can change the complex type in the desired WSDL so that the boundary attributes are part of the complex type instead of being part of the element. (That is, you can move the `minOccurs` and `maxOccurs` attributes to the complex type and then remove them from the element.)
