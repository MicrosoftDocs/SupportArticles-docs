---
title: Visual Studio crashes when GetAddress() is invoked
description: Connect customer tries to use DEBUG_ADDRESS structure in a Managed EE implementation that crashes VS due to a member of DEBUG_ADDRESS_UNION size being specified incorrectly in the PIA (Microsoft.Visual Studio.Debugger.InteropA.dll).
ms.date: 04/27/2020
ms.prod-support-area-path: Debuggers and analyzers
ms.reviewer: raviuppa, ruisun, lukim
---
# Visual Studio crashes when Microsoft.VisualStudio.Debugger.Interop.IDebugAddress.GetAddress() is invoked

This article helps you resolve the problem where Visual Studio 2010 crashes when `Microsoft.VisualStudio.Debugger.Interop.IDebugAddress.GetAddress()` is invoked.

_Original product version:_ &nbsp; Visual Studio Professional 2010, Visual Studio Ultimate 2010  
_Original KB number:_ &nbsp; 2529043

## Symptoms

You try to use the `DEBUG_ADDRESS` structure or call a function that relies on the structure such as `IDebugAddress.GetAddress` in a Managed EE implementation that crashes Visual Studio due to a member of `DEBUG_ADDRESS_UNION` size being specified incorrectly in the Primary Interop Assembly (*Microsoft.Visual Studio.Debugger.InteropA.dll*)

## Cause

A member of `DEBUG_ADDRESS_UNION` size being specified incorrectly in the Primary Interop Assembly (*Microsoft.Visual Studio.Debugger.InteropA.dll*), and this results in a crash.

The Primary Interop Assembly binary shouldn't be modified and a new Primary Interop Assembly binary can't be released as it would break interop with other users who aren't using the updated binary. (Any difference in the Primary Interop Assembly would result in Component Object Model (COM) treating them as different Objects).

## Workaround

To work around the problem, include an updated definition of the `DEBUG_ADDRESS_UNION` struct in their managed code. All dependent interfaces and structs should be included to complete the transitive closure. You can continue to work with the existing Primary Interop Assembly and use `using` statements to use only the updated code where required.

1. Create a file in Visual Studio called *Microsoft.VisualStudio.Debugger.InteropEE.cs*, and add the code listed in the [Sample code](#sample-code) section.
2. Include the source file in the Managed EE implementation project.
3. Specify `using` statements for each interface / structure they use that is part of the `DEBUG_ADDRESS_UNION` transitive closure. For example, to use the updated `DEBUG_ADDRESS` structure, the `using` statement would be:

    ```csharp
    using DEBUG_ADDRESS = Microsoft.VisualStudio.Debugger.InteropEE.DEBUG_ADDRESS
    ```

## Sample code

```csharp
/*******************************************************************************
* Microsoft.VisualStudio.Debugger.InteropEE.cs
* Copyright (c) Microsoft Corporation. All rights reserved.
* This code is licensed under the Visual Studio SDK license terms.
* THIS CODE IS PROVIDED *AS IS* WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS
* OR IMPLIED, INCLUDING ANY IMPLIED WARRANTIES OF FITNESS FOR A PARTICULAR
* PURPOSE, MERCHANTABILITY, OR NON-INFRINGEMENT.  
* This file contains an updated DEBUG_ADDRESS_UNION structure to fix a problem
* with the original binary where the size of unionmember was incorrect when
* used in a Custom Expression Evaluator.
* Primary Interop Assemblies should not be changed or updated, thus the user
* of the original Microsoft.VisualStudio.Debugger.InteropA.dll assembly should
* include this file in their source to use the updated structure.
* All EE Structures and Interfaces that depend on DEBUG_ADDRESS_UNION are also included.
* Users of Microsoft.VisualStudio.Debugger.InteropA can use the fixed structure
* after including this file in their source by the "using" keyword. E.g.
* using DEBUG_ADDRESS = Microsoft.VisualStudio.Debugger.InteropEE.DEBUG_ADDRESS
* using statements will also need to be implemented for each interface that
* depends upon it to complete the transitive closure.
******************************************************************************/

using System;
using System.Runtime.InteropServices;
using System.Runtime.InteropServices.ComTypes;
using Microsoft.VisualStudio.Debugger.Interop;

#pragma warning disable 108

namespace Microsoft.VisualStudio.Debugger.InteropEE
{
    #region interfaces
    // Depends on DEBUG_ADDRESS
    [ComImport, Guid("C2E34EBB-8B9D-11D2-9014-00C04FA38338"), InterfaceType((short)1)]
    public interface IDebugAddress
    {
        [PreserveSig]
        int GetAddress([Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.DEBUG_ADDRESS"), MarshalAs(UnmanagedType.LPArray)] DEBUG_ADDRESS[] pAddress);
    }

    // Depends on DEBUG_ADDRESS
    [ComImport, Guid("877A0DA6-A43E-4046-9BE3-F916AFF4FA7B"), InterfaceType((short)1)]
    public interface IDebugAddress2 : IDebugAddress
    {
        [PreserveSig]
        int GetAddress([Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.DEBUG_ADDRESS"), MarshalAs(UnmanagedType.LPArray)] DEBUG_ADDRESS[] pAddress);
        [PreserveSig]
        int GetProcessId(out uint pProcID);
    }

    // Depends on IDebugField
    [ComImport, InterfaceType((short)1), Guid("20F22571-AA1C-4724-AD0A-BDE2D19D6163")]
    public interface IDebugExtendedField : IDebugField
    {
        [PreserveSig]
        int GetInfo([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_INFO_FIELDS")] enum_FIELD_INFO_FIELDS dwFields, [Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_INFO"), MarshalAs(UnmanagedType.LPArray)] FIELD_INFO[] pFieldInfo);
        [PreserveSig]
        int GetKind([Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_KIND"), MarshalAs(UnmanagedType.LPArray)] enum_FIELD_KIND[] pdwKind);
        [PreserveSig]
        int GetType([MarshalAs(UnmanagedType.Interface)] out IDebugField ppType);
        [PreserveSig]
        int GetContainer([MarshalAs(UnmanagedType.Interface)] out IDebugContainerField ppContainerField);
        [PreserveSig]
        int GetAddress([MarshalAs(UnmanagedType.Interface)] out IDebugAddress ppAddress);
        [PreserveSig]
        int GetSize(out uint pdwSize);
        [PreserveSig]
        int GetExtendedInfo([In] ref Guid guidExtendedInfo, [Out, MarshalAs(UnmanagedType.LPArray, SizeParamIndex = 2)] IntPtr[] prgBuffer, [In, Out] ref uint pdwLen);
        [PreserveSig]
        int Equal([In, MarshalAs(UnmanagedType.Interface)] IDebugField pField);
        [PreserveSig]
        int GetTypeInfo([Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.TYPE_INFO"), MarshalAs(UnmanagedType.LPArray)] TYPE_INFO[] pTypeInfo);
        [PreserveSig]
        int GetExtendedKind([Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_KIND_EX"), MarshalAs(UnmanagedType.LPArray)] enum_FIELD_KIND_EX[] pdwKind);
        [PreserveSig]
        int IsClosedType();
    }

    // Depends on IDebugAddress
    [ComImport, ComConversionLoss, InterfaceType((short)1), Guid("C2E34EB1-8B9D-11D2-9014-00C04FA38338")]
    public interface IDebugField
    {
        [PreserveSig]
        int GetInfo([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_INFO_FIELDS")] enum_FIELD_INFO_FIELDS dwFields, [Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_INFO"), MarshalAs(UnmanagedType.LPArray)] FIELD_INFO[] pFieldInfo);
        [PreserveSig]
        int GetKind([Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_KIND"), MarshalAs(UnmanagedType.LPArray)] enum_FIELD_KIND[] pdwKind);
        [PreserveSig]
        int GetType([MarshalAs(UnmanagedType.Interface)] out IDebugField ppType);
        [PreserveSig]
        int GetContainer([MarshalAs(UnmanagedType.Interface)] out IDebugContainerField ppContainerField);
        [PreserveSig]
        int GetAddress([MarshalAs(UnmanagedType.Interface)] out IDebugAddress ppAddress);
        [PreserveSig]
        int GetSize(out uint pdwSize);
        [PreserveSig]
        int GetExtendedInfo([In] ref Guid guidExtendedInfo, [Out, MarshalAs(UnmanagedType.LPArray, SizeParamIndex = 2)] IntPtr[] prgBuffer, [In, Out] ref uint pdwLen);
        [PreserveSig]
        int Equal([In, MarshalAs(UnmanagedType.Interface)] IDebugField pField);
        [PreserveSig]
        int GetTypeInfo([Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.TYPE_INFO"), MarshalAs(UnmanagedType.LPArray)] TYPE_INFO[] pTypeInfo);
    }

    // Depends on IDebugAddress
    [ComImport, Guid("C2E34EB2-8B9D-11D2-9014-00C04FA38338"), InterfaceType((short)1)]
    public interface IDebugContainerField : IDebugField
    {
        [PreserveSig]
        int GetInfo([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_INFO_FIELDS")] enum_FIELD_INFO_FIELDS dwFields, [Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_INFO"), MarshalAs(UnmanagedType.LPArray)] FIELD_INFO[] pFieldInfo);
        [PreserveSig]
        int GetKind([Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_KIND"), MarshalAs(UnmanagedType.LPArray)] enum_FIELD_KIND[] pdwKind);
        [PreserveSig]
        int GetType([MarshalAs(UnmanagedType.Interface)] out IDebugField ppType);
        [PreserveSig]
        int GetContainer([MarshalAs(UnmanagedType.Interface)] out IDebugContainerField ppContainerField);
        [PreserveSig]
        int GetAddress([MarshalAs(UnmanagedType.Interface)] out IDebugAddress ppAddress);
        [PreserveSig]
        int GetSize(out uint pdwSize);
        [PreserveSig]
        int GetExtendedInfo([In] ref Guid guidExtendedInfo, [Out, MarshalAs(UnmanagedType.LPArray, SizeParamIndex = 2)] IntPtr[] prgBuffer, [In, Out] ref uint pdwLen);
        [PreserveSig]
        int Equal([In, MarshalAs(UnmanagedType.Interface)] IDebugField pField);
        [PreserveSig]
        int GetTypeInfo([Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.TYPE_INFO"), MarshalAs(UnmanagedType.LPArray)] TYPE_INFO[] pTypeInfo);
        [PreserveSig]
        int EnumFields([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_KIND")] enum_FIELD_KIND dwKindFilter, [In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_MODIFIERS")] enum_FIELD_MODIFIERS dwModifiersFilter, [In, MarshalAs(UnmanagedType.LPWStr)] string pszNameFilter, [In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.NAME_MATCH")] NAME_MATCH nameMatch, [MarshalAs(UnmanagedType.Interface)] out IEnumDebugFields ppEnum);
    }

    // Depends on IDebugAddress, IDebugContainerField
    [ComImport, InterfaceType((short)1), Guid("C2E34EB7-8B9D-11D2-9014-00C04FA38338")]
    public interface IDebugArrayField : IDebugContainerField
    {
        [PreserveSig]
        int GetInfo([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_INFO_FIELDS")] enum_FIELD_INFO_FIELDS dwFields, [Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_INFO"), MarshalAs(UnmanagedType.LPArray)] FIELD_INFO[] pFieldInfo);
        [PreserveSig]
        int GetKind([Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_KIND"), MarshalAs(UnmanagedType.LPArray)] enum_FIELD_KIND[] pdwKind);
        [PreserveSig]
        int GetType([MarshalAs(UnmanagedType.Interface)] out IDebugField ppType);
        [PreserveSig]
        int GetContainer([MarshalAs(UnmanagedType.Interface)] out IDebugContainerField ppContainerField);
        [PreserveSig]
        int GetAddress([MarshalAs(UnmanagedType.Interface)] out IDebugAddress ppAddress);
        [PreserveSig]
        int GetSize(out uint pdwSize);
        [PreserveSig]
        int GetExtendedInfo([In] ref Guid guidExtendedInfo, [Out, MarshalAs(UnmanagedType.LPArray, SizeParamIndex = 2)] IntPtr[] prgBuffer, [In, Out] ref uint pdwLen);
        [PreserveSig]
        int Equal([In, MarshalAs(UnmanagedType.Interface)] IDebugField pField);
        [PreserveSig]
        int GetTypeInfo([Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.TYPE_INFO"), MarshalAs(UnmanagedType.LPArray)] TYPE_INFO[] pTypeInfo);
        [PreserveSig]
        int EnumFields([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_KIND")] enum_FIELD_KIND dwKindFilter, [In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_MODIFIERS")] enum_FIELD_MODIFIERS dwModifiersFilter, [In, MarshalAs(UnmanagedType.LPWStr)] string pszNameFilter, [In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.NAME_MATCH")] NAME_MATCH nameMatch, [MarshalAs(UnmanagedType.Interface)] out IEnumDebugFields ppEnum);
        [PreserveSig]
        int GetNumberOfElements(out uint pdwNumElements);
        [PreserveSig]
        int GetElementType([MarshalAs(UnmanagedType.Interface)] out IDebugField ppType);
        [PreserveSig]
        int GetRank(out uint pdwRank);
    }

    // Depends on IDebugField
    [ComImport, Guid("C077C833-476C-11D2-B73C-0000F87572EF"), InterfaceType((short)1)]
    public interface IDebugBinder
    {
        [PreserveSig]
        int Bind([In, MarshalAs(UnmanagedType.Interface)] IDebugObject pContainer, [In, MarshalAs(UnmanagedType.Interface)] IDebugField pField, [MarshalAs(UnmanagedType.Interface)] out IDebugObject ppObject);
        [PreserveSig]
        int ResolveDynamicType([In, MarshalAs(UnmanagedType.Interface)] IDebugDynamicField pDynamic, [MarshalAs(UnmanagedType.Interface)] out IDebugField ppResolved);
        [PreserveSig]
        int ResolveRuntimeType([In, MarshalAs(UnmanagedType.Interface)] IDebugObject pObject, [MarshalAs(UnmanagedType.Interface)] out IDebugField ppResolved);
        [PreserveSig]
        int GetMemoryContext([In, MarshalAs(UnmanagedType.Interface)] IDebugField pField, [In] uint dwConstant, [MarshalAs(UnmanagedType.Interface)] out IDebugMemoryContext2 ppMemCxt);
        [PreserveSig]
        int GetFunctionObject([MarshalAs(UnmanagedType.Interface)] out IDebugFunctionObject ppFunction);
    }

    // Depends on IDebugField
    [ComImport, Guid("DCF3C6EE-7C7D-4E1F-AEEB-646902AF0723"), InterfaceType((short)1)]
    public interface IDebugBinder2
    {
        [PreserveSig]
        int GetMemoryObject([In, MarshalAs(UnmanagedType.Interface)] IDebugField pField, [In] uint dwConstant, [MarshalAs(UnmanagedType.Interface)] out IDebugObject ppObject);
        [PreserveSig]
        int GetExceptionObjectAndType([MarshalAs(UnmanagedType.Interface)] out IDebugObject ppException, [MarshalAs(UnmanagedType.Interface)] out IDebugField ppField);
    }

    // Depends on IDebugField
    [ComImport, InterfaceType((short)1), Guid("BBCD7263-B415-40F6-942A-4A9A8599B708")]
    public interface IDebugBinder3 : IDebugBinder
    {
        [PreserveSig]
        int Bind([In, MarshalAs(UnmanagedType.Interface)] IDebugObject pContainer, [In, MarshalAs(UnmanagedType.Interface)] IDebugField pField, [MarshalAs(UnmanagedType.Interface)] out IDebugObject ppObject);
        [PreserveSig]
        int ResolveDynamicType([In, MarshalAs(UnmanagedType.Interface)] IDebugDynamicField pDynamic, [MarshalAs(UnmanagedType.Interface)] out IDebugField ppResolved);
        [PreserveSig]
        int ResolveRuntimeType([In, MarshalAs(UnmanagedType.Interface)] IDebugObject pObject, [MarshalAs(UnmanagedType.Interface)] out IDebugField ppResolved);
        [PreserveSig]
        int GetMemoryContext([In, MarshalAs(UnmanagedType.Interface)] IDebugField pField, [In] uint dwConstant, [MarshalAs(UnmanagedType.Interface)] out IDebugMemoryContext2 ppMemCxt);
        [PreserveSig]
        int GetFunctionObject([MarshalAs(UnmanagedType.Interface)] out IDebugFunctionObject ppFunction);
        [PreserveSig]
        int GetMemoryObject([In, MarshalAs(UnmanagedType.Interface)] IDebugField pField, [In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.UINT64")] ulong uConstant, [MarshalAs(UnmanagedType.Interface)] out IDebugObject ppObject);
        [PreserveSig]
        int GetExceptionObjectAndType([MarshalAs(UnmanagedType.Interface)] out IDebugObject ppException, [MarshalAs(UnmanagedType.Interface)] out IDebugField ppField);
        [PreserveSig]
        int FindAlias([In, MarshalAs(UnmanagedType.LPWStr)] string pcstrName, [MarshalAs(UnmanagedType.Interface)] out IDebugAlias ppAlias);
        [PreserveSig]
        int GetAllAliases([In] uint uRequest, [In, Out, MarshalAs(UnmanagedType.LPArray, ArraySubType = UnmanagedType.Interface, SizeParamIndex = 0)] IDebugAlias[] ppAliases, out uint puFetched);
        [PreserveSig]
        int GetTypeArgumentCount(out uint uCount);
        [PreserveSig]
        int GetTypeArguments([In] uint Skip, [In] uint count, [In, Out, MarshalAs(UnmanagedType.LPArray, ArraySubType = UnmanagedType.Interface, SizeParamIndex = 1)] IDebugField[] ppFields, out uint pFetched);
        [PreserveSig]
        int GetEEService([In] Guid vendor, [In] Guid language, [In] Guid iid, [MarshalAs(UnmanagedType.IUnknown)] out object ppService);
        [PreserveSig]
        int GetMemoryContext64([In, MarshalAs(UnmanagedType.Interface)] IDebugField pField, [In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.UINT64")] ulong uConstant, [MarshalAs(UnmanagedType.Interface)] out IDebugMemoryContext2 ppMemCxt);
    }

    // Depends on IDebugAddress, IDebugContainerField
    [ComImport, Guid("C2E34EB5-8B9D-11D2-9014-00C04FA38338"), InterfaceType((short)1)]
    public interface IDebugClassField : IDebugContainerField
    {
        [PreserveSig]
        int GetInfo([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_INFO_FIELDS")] enum_FIELD_INFO_FIELDS dwFields, [Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_INFO"), MarshalAs(UnmanagedType.LPArray)] FIELD_INFO[] pFieldInfo);
        [PreserveSig]
        int GetKind([Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_KIND"), MarshalAs(UnmanagedType.LPArray)] enum_FIELD_KIND[] pdwKind);
        [PreserveSig]
        int GetType([MarshalAs(UnmanagedType.Interface)] out IDebugField ppType);
        [PreserveSig]
        int GetContainer([MarshalAs(UnmanagedType.Interface)] out IDebugContainerField ppContainerField);
        [PreserveSig]
        int GetAddress([MarshalAs(UnmanagedType.Interface)] out IDebugAddress ppAddress);
        [PreserveSig]
        int GetSize(out uint pdwSize);
        [PreserveSig]
        int GetExtendedInfo([In] ref Guid guidExtendedInfo, [Out, MarshalAs(UnmanagedType.LPArray, SizeParamIndex = 2)] IntPtr[] prgBuffer, [In, Out] ref uint pdwLen);
        [PreserveSig]
        int Equal([In, MarshalAs(UnmanagedType.Interface)] IDebugField pField);
        [PreserveSig]
        int GetTypeInfo([Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.TYPE_INFO"), MarshalAs(UnmanagedType.LPArray)] TYPE_INFO[] pTypeInfo);
        [PreserveSig]
        int EnumFields([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_KIND")] enum_FIELD_KIND dwKindFilter, [In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_MODIFIERS")] enum_FIELD_MODIFIERS dwModifiersFilter, [In, MarshalAs(UnmanagedType.LPWStr)] string pszNameFilter, [In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.NAME_MATCH")] NAME_MATCH nameMatch, [MarshalAs(UnmanagedType.Interface)] out IEnumDebugFields ppEnum);
        [PreserveSig]
        int EnumBaseClasses([MarshalAs(UnmanagedType.Interface)] out IEnumDebugFields ppEnum);
        [PreserveSig]
        int DoesInterfaceExist([In, MarshalAs(UnmanagedType.LPWStr)] string pszInterfaceName);
        [PreserveSig]
        int EnumNestedClasses([MarshalAs(UnmanagedType.Interface)] out IEnumDebugFields ppEnum);
        [PreserveSig]
        int GetEnclosingClass([MarshalAs(UnmanagedType.Interface)] out IDebugClassField ppClassField);
        [PreserveSig]
        int EnumInterfacesImplemented([MarshalAs(UnmanagedType.Interface)] out IEnumDebugFields ppEnum);
        [PreserveSig]
        int EnumConstructors([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.CONSTRUCTOR_ENUM")] CONSTRUCTOR_ENUM cMatch, [MarshalAs(UnmanagedType.Interface)] out IEnumDebugFields ppEnum);
        [PreserveSig]
        int GetDefaultIndexer([MarshalAs(UnmanagedType.BStr)] out string pbstrIndexer);
        [PreserveSig]
        int EnumNestedEnums([MarshalAs(UnmanagedType.Interface)] out IEnumDebugFields ppEnum);
    }

    // Depends on IDebugAddress
    [ComImport, InterfaceType((short)1), Guid("83919262-ACD6-11D2-9028-00C04FA302A1")]
    public interface IDebugEngineSymbolProviderServices
    {
        [PreserveSig]
        int EnumCodeContexts([In, MarshalAs(UnmanagedType.LPArray, ArraySubType = UnmanagedType.Interface, SizeParamIndex = 1)] IDebugAddress[] rgpAddresses, [In] uint celtAddresses, [MarshalAs(UnmanagedType.Interface)] out IEnumDebugCodeContexts2 ppEnum);
    }

    // Depends on IDebugAddress
    [ComImport, Guid("D318E959-22AB-4EEA-9A06-962B11AFDC29"), InterfaceType((short)1)]
    public interface IDebugEngineSymbolProviderServices2 : IDebugEngineSymbolProviderServices
    {
        [PreserveSig]
        int EnumCodeContexts([In, MarshalAs(UnmanagedType.LPArray, ArraySubType = UnmanagedType.Interface, SizeParamIndex = 1)] IDebugAddress[] rgpAddresses, [In] uint celtAddresses, [MarshalAs(UnmanagedType.Interface)] out IEnumDebugCodeContexts2 ppEnum);
        [PreserveSig]
        int ResolveAssembly([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] uint ulAppDomainID, [In] Guid guidModule, [In] uint tokAssemblyReference, [Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.RESOLVED_MODULES"), MarshalAs(UnmanagedType.LPArray)] RESOLVED_MODULES[] pResolvedModules);
        [PreserveSig]
        int GetEngineProvidedDocumentPrefix([MarshalAs(UnmanagedType.BStr)] out string bstrDocPrefix);
    }

    // Depends on IDebugField
    [ComImport, InterfaceType((short)1), Guid("796AE40B-6CDA-4F05-A663-D282A93AC7D4")]
    public interface IDebugTypeFieldBuilder
    {
        [PreserveSig]
        int CreatePrimitive([In] uint dwElementType, [MarshalAs(UnmanagedType.Interface)] out IDebugField pTypeField);
        [PreserveSig]
        int CreatePointerToType([In, MarshalAs(UnmanagedType.Interface)] IDebugField pTypeField, [MarshalAs(UnmanagedType.Interface)] out IDebugField pPtrToTypeField);
    }

    // Depends on IDebugField
    [ComImport, Guid("EED3392E-C13A-42A9-932F-145C12B4FB5C"), InterfaceType((short)1)]
    public interface IDebugTypeFieldBuilder2 : IDebugTypeFieldBuilder
    {
        [PreserveSig]
        int CreatePrimitive([In] uint dwElementType, [MarshalAs(UnmanagedType.Interface)] out IDebugField pTypeField);
        [PreserveSig]
        int CreatePointerToType([In, MarshalAs(UnmanagedType.Interface)] IDebugField pTypeField, [MarshalAs(UnmanagedType.Interface)] out IDebugField pPtrToTypeField);
        [PreserveSig]
        int CreateArrayOfType([In, MarshalAs(UnmanagedType.Interface)] IDebugField pTypeField, [In] uint rank, [MarshalAs(UnmanagedType.Interface)] out IDebugField pArrayOfTypeField);
    }

    // Depends on IDebugAddress, IDebugField, IDebugContainerField
    [ComImport, Guid("C2E34EAF-8B9D-11D2-9014-00C04FA38338"), InterfaceType((short)1)]
    public interface IDebugComPlusSymbolProvider : IDebugSymbolProvider
    {
        [PreserveSig]
        int Initialize([In, MarshalAs(UnmanagedType.Interface)] IDebugEngineSymbolProviderServices pServices);
        [PreserveSig]
        int Uninitialize();
        [PreserveSig]
        int GetContainerField([In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddress, [MarshalAs(UnmanagedType.Interface)] out IDebugContainerField ppContainerField);
        [PreserveSig]
        int GetField([In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddress, [In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddressCur, [MarshalAs(UnmanagedType.Interface)] out IDebugField ppField);
        [PreserveSig]
        int GetAddressesFromPosition([In, MarshalAs(UnmanagedType.Interface)] IDebugDocumentPosition2 pDocPos, [In] int fStatmentOnly, [MarshalAs(UnmanagedType.Interface)] out IEnumDebugAddresses ppEnumBegAddresses, [MarshalAs(UnmanagedType.Interface)] out IEnumDebugAddresses ppEnumEndAddresses);
        [PreserveSig]
        int GetAddressesFromContext([In, MarshalAs(UnmanagedType.Interface)] IDebugDocumentContext2 pDocContext, [In] int fStatmentOnly, [MarshalAs(UnmanagedType.Interface)] out IEnumDebugAddresses ppEnumBegAddresses, [MarshalAs(UnmanagedType.Interface)] out IEnumDebugAddresses ppEnumEndAddresses);
        [PreserveSig]
        int GetContextFromAddress([In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddress, [MarshalAs(UnmanagedType.Interface)] out IDebugDocumentContext2 ppDocContext);
        [PreserveSig]
        int GetLanguage([In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddress, out Guid pguidLanguage, out Guid pguidLanguageVendor);
        [PreserveSig]
        int GetGlobalContainer([MarshalAs(UnmanagedType.Interface)] out IDebugContainerField pField);
        [PreserveSig]
        int GetMethodFieldsByName([In, MarshalAs(UnmanagedType.LPWStr)] string pszFullName, [In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.NAME_MATCH")] NAME_MATCH nameMatch, [MarshalAs(UnmanagedType.Interface)] out IEnumDebugFields ppEnum);
        [PreserveSig]
        int GetClassTypeByName([In, MarshalAs(UnmanagedType.LPWStr)] string pszClassName, [In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.NAME_MATCH")] NAME_MATCH nameMatch, [MarshalAs(UnmanagedType.Interface)] out IDebugClassField ppField);
        [PreserveSig]
        int GetNamespacesUsedAtAddress([In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddress, [MarshalAs(UnmanagedType.Interface)] out IEnumDebugFields ppEnum);
        [PreserveSig]
        int GetTypeByName([In, MarshalAs(UnmanagedType.LPWStr)] string pszClassName, [In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.NAME_MATCH")] NAME_MATCH nameMatch, [MarshalAs(UnmanagedType.Interface)] out IDebugField ppField);
        [PreserveSig]
        int GetNextAddress([In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddress, [In] int fStatmentOnly, [MarshalAs(UnmanagedType.Interface)] out IDebugAddress ppAddress);
        [PreserveSig]
        int LoadSymbols([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] uint ulAppDomainID, [In] Guid guidModule, [In] ulong baseAddress, [In, MarshalAs(UnmanagedType.IUnknown)] object pUnkMetadataImport, [In, MarshalAs(UnmanagedType.BStr)] string bstrModuleName, [In, MarshalAs(UnmanagedType.BStr)] string bstrSymSearchPath);
        [PreserveSig]
        int UnloadSymbols([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] uint ulAppDomainID, [In] Guid guidModule);
        [PreserveSig]
        int GetEntryPoint([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] uint ulAppDomainID, [In] Guid guidModule, [MarshalAs(UnmanagedType.Interface)] out IDebugAddress ppAddress);
        [PreserveSig]
        int GetTypeFromAddress([In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddress, [MarshalAs(UnmanagedType.Interface)] out IDebugField ppField);
        [PreserveSig]
        int UpdateSymbols([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] uint ulAppDomainID, [In] Guid guidModule, [In, MarshalAs(UnmanagedType.Interface)] Microsoft.VisualStudio.OLE.Interop.IStream pUpdateStream);
        [PreserveSig]
        int CreateTypeFromPrimitive([In] uint dwPrimType, [In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddress, [In, MarshalAs(UnmanagedType.Interface)] ref IDebugField ppType);
        [PreserveSig]
        int GetFunctionLineOffset([In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddress, [In] uint dwLine, [MarshalAs(UnmanagedType.Interface)] out IDebugAddress ppNewAddress);
        [PreserveSig]
        int GetAddressesInModuleFromPosition([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] uint ulAppDomainID, [In] Guid guidModule, [In, MarshalAs(UnmanagedType.Interface)] IDebugDocumentPosition2 pDocPos, [In] int fStatmentOnly, [MarshalAs(UnmanagedType.Interface)] out IEnumDebugAddresses ppEnumBegAddresses, [MarshalAs(UnmanagedType.Interface)] out IEnumDebugAddresses ppEnumEndAddresses);
        [PreserveSig]
        int GetArrayTypeFromAddress([In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddress, [In, MarshalAs(UnmanagedType.LPArray, SizeParamIndex = 2)] byte[] pSig, [In] uint dwSigLength, [MarshalAs(UnmanagedType.Interface)] out IDebugField ppField);
        [PreserveSig]
        int GetSymAttribute([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] uint ulAppDomainID, [In] Guid guidModule, [In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop._mdToken")] int tokParent, [In, MarshalAs(UnmanagedType.LPWStr)] string pstrName, [In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] uint cBuffer, [ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] out uint pcBuffer, [Out, MarshalAs(UnmanagedType.LPArray, SizeParamIndex = 4)] byte[] buffer);
        [PreserveSig]
        int ReplaceSymbols([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] uint ulAppDomainID, [In] Guid guidModule, [In, MarshalAs(UnmanagedType.Interface)] Microsoft.VisualStudio.OLE.Interop.IStream pStream);
        [PreserveSig]
        int AreSymbolsLoaded([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] uint ulAppDomainID, [In] Guid guidModule);
        [PreserveSig]
        int LoadSymbolsFromStream([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] uint ulAppDomainID, [In] Guid guidModule, [In] ulong baseAddress, [In, MarshalAs(UnmanagedType.IUnknown)] object pUnkMetadataImport, [In, MarshalAs(UnmanagedType.Interface)] Microsoft.VisualStudio.OLE.Interop.IStream pStream);
        [PreserveSig]
        int GetSymUnmanagedReader([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] uint ulAppDomainID, [In] Guid guidModule, [MarshalAs(UnmanagedType.IUnknown)] out object ppSymUnmanagedReader);
        [PreserveSig]
        int GetAttributedClassesinModule([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] uint ulAppDomainID, [In] Guid guidModule, [In, MarshalAs(UnmanagedType.LPWStr)] string pstrAttribute, [MarshalAs(UnmanagedType.Interface)] out IEnumDebugFields ppEnum);
        [PreserveSig]
        int GetAttributedClassesForLanguage([In] Guid guidLanguage, [In, MarshalAs(UnmanagedType.LPWStr)] string pstrAttribute, [MarshalAs(UnmanagedType.Interface)] out IEnumDebugFields ppEnum);
        [PreserveSig]
        int IsHiddenCode([In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddress);
        [PreserveSig]
        int IsFunctionDeleted([In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddress);
        [PreserveSig]
        int GetNameFromToken([In, MarshalAs(UnmanagedType.IUnknown)] object pMetadataImport, [In] uint dwToken, [MarshalAs(UnmanagedType.BStr)] out string pbstrName);
        [PreserveSig]
        int IsFunctionStale([In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddress);
        [PreserveSig]
        int GetLocalVariablelayout([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] uint ulAppDomainID, [In] Guid guidModule, [In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] uint cMethods, [In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop._mdToken"), MarshalAs(UnmanagedType.LPArray, SizeParamIndex = 2)] int[] rgMethodTokens, [MarshalAs(UnmanagedType.Interface)] out Microsoft.VisualStudio.OLE.Interop.IStream pStreamLayout);
        [PreserveSig]
        int GetAssemblyName([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] uint ulAppDomainID, [In] Guid guidModule, [MarshalAs(UnmanagedType.BStr)] out string pbstrName);
    }

    // Depends on IDebugAddress, IDebugField
    [ComImport, Guid("29D97D99-2C50-4855-BC74-B3E372DDD602"), InterfaceType((short)1)]
    public interface IDebugComPlusSymbolProvider2 : IDebugComPlusSymbolProvider
    {
        [PreserveSig]
        int Initialize([In, MarshalAs(UnmanagedType.Interface)] IDebugEngineSymbolProviderServices pServices);
        [PreserveSig]
        int Uninitialize();
        [PreserveSig]
        int GetContainerField([In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddress, [MarshalAs(UnmanagedType.Interface)] out IDebugContainerField ppContainerField);
        [PreserveSig]
        int GetField([In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddress, [In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddressCur, [MarshalAs(UnmanagedType.Interface)] out IDebugField ppField);
        [PreserveSig]
        int GetAddressesFromPosition([In, MarshalAs(UnmanagedType.Interface)] IDebugDocumentPosition2 pDocPos, [In] int fStatmentOnly, [MarshalAs(UnmanagedType.Interface)] out IEnumDebugAddresses ppEnumBegAddresses, [MarshalAs(UnmanagedType.Interface)] out IEnumDebugAddresses ppEnumEndAddresses);
        [PreserveSig]
        int GetAddressesFromContext([In, MarshalAs(UnmanagedType.Interface)] IDebugDocumentContext2 pDocContext, [In] int fStatmentOnly, [MarshalAs(UnmanagedType.Interface)] out IEnumDebugAddresses ppEnumBegAddresses, [MarshalAs(UnmanagedType.Interface)] out IEnumDebugAddresses ppEnumEndAddresses);
        [PreserveSig]
        int GetContextFromAddress([In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddress, [MarshalAs(UnmanagedType.Interface)] out IDebugDocumentContext2 ppDocContext);
        [PreserveSig]
        int GetLanguage([In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddress, out Guid pguidLanguage, out Guid pguidLanguageVendor);
        [PreserveSig]
        int GetGlobalContainer([MarshalAs(UnmanagedType.Interface)] out IDebugContainerField pField);
        [PreserveSig]
        int GetMethodFieldsByName([In, MarshalAs(UnmanagedType.LPWStr)] string pszFullName, [In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.NAME_MATCH")] NAME_MATCH nameMatch, [MarshalAs(UnmanagedType.Interface)] out IEnumDebugFields ppEnum);
        [PreserveSig]
        int GetClassTypeByName([In, MarshalAs(UnmanagedType.LPWStr)] string pszClassName, [In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.NAME_MATCH")] NAME_MATCH nameMatch, [MarshalAs(UnmanagedType.Interface)] out IDebugClassField ppField);
        [PreserveSig]
        int GetNamespacesUsedAtAddress([In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddress, [MarshalAs(UnmanagedType.Interface)] out IEnumDebugFields ppEnum);
        [PreserveSig]
        int GetTypeByName([In, MarshalAs(UnmanagedType.LPWStr)] string pszClassName, [In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.NAME_MATCH")] NAME_MATCH nameMatch, [MarshalAs(UnmanagedType.Interface)] out IDebugField ppField);
        [PreserveSig]
        int GetNextAddress([In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddress, [In] int fStatmentOnly, [MarshalAs(UnmanagedType.Interface)] out IDebugAddress ppAddress);
        [PreserveSig]
        int LoadSymbols([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] uint ulAppDomainID, [In] Guid guidModule, [In] ulong baseAddress, [In, MarshalAs(UnmanagedType.IUnknown)] object pUnkMetadataImport, [In, MarshalAs(UnmanagedType.BStr)] string bstrModuleName, [In, MarshalAs(UnmanagedType.BStr)] string bstrSymSearchPath);
        [PreserveSig]
        int UnloadSymbols([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] uint ulAppDomainID, [In] Guid guidModule);
        [PreserveSig]
        int GetEntryPoint([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] uint ulAppDomainID, [In] Guid guidModule, [MarshalAs(UnmanagedType.Interface)] out IDebugAddress ppAddress);
        [PreserveSig]
        int GetTypeFromAddress([In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddress, [MarshalAs(UnmanagedType.Interface)] out IDebugField ppField);
        [PreserveSig]
        int UpdateSymbols([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] uint ulAppDomainID, [In] Guid guidModule, [In, MarshalAs(UnmanagedType.Interface)] Microsoft.VisualStudio.OLE.Interop.IStream pUpdateStream);
        [PreserveSig]
        int CreateTypeFromPrimitive([In] uint dwPrimType, [In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddress, [In, MarshalAs(UnmanagedType.Interface)] ref IDebugField ppType);
        [PreserveSig]
        int GetFunctionLineOffset([In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddress, [In] uint dwLine, [MarshalAs(UnmanagedType.Interface)] out IDebugAddress ppNewAddress);
        [PreserveSig]
        int GetAddressesInModuleFromPosition([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] uint ulAppDomainID, [In] Guid guidModule, [In, MarshalAs(UnmanagedType.Interface)] IDebugDocumentPosition2 pDocPos, [In] int fStatmentOnly, [MarshalAs(UnmanagedType.Interface)] out IEnumDebugAddresses ppEnumBegAddresses, [MarshalAs(UnmanagedType.Interface)] out IEnumDebugAddresses ppEnumEndAddresses);
        [PreserveSig]
        int GetArrayTypeFromAddress([In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddress, [In, MarshalAs(UnmanagedType.LPArray, SizeParamIndex = 2)] byte[] pSig, [In] uint dwSigLength, [MarshalAs(UnmanagedType.Interface)] out IDebugField ppField);
        [PreserveSig]
        int GetSymAttribute([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] uint ulAppDomainID, [In] Guid guidModule, [In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop._mdToken")] int tokParent, [In, MarshalAs(UnmanagedType.LPWStr)] string pstrName, [In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] uint cBuffer, [ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] out uint pcBuffer, [Out, MarshalAs(UnmanagedType.LPArray, SizeParamIndex = 4)] byte[] buffer);
        [PreserveSig]
        int ReplaceSymbols([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] uint ulAppDomainID, [In] Guid guidModule, [In, MarshalAs(UnmanagedType.Interface)] Microsoft.VisualStudio.OLE.Interop.IStream pStream);
        [PreserveSig]
        int AreSymbolsLoaded([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] uint ulAppDomainID, [In] Guid guidModule);
        [PreserveSig]
        int LoadSymbolsFromStream([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] uint ulAppDomainID, [In] Guid guidModule, [In] ulong baseAddress, [In, MarshalAs(UnmanagedType.IUnknown)] object pUnkMetadataImport, [In, MarshalAs(UnmanagedType.Interface)] Microsoft.VisualStudio.OLE.Interop.IStream pStream);
        [PreserveSig]
        int GetSymUnmanagedReader([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] uint ulAppDomainID, [In] Guid guidModule, [MarshalAs(UnmanagedType.IUnknown)] out object ppSymUnmanagedReader);
        [PreserveSig]
        int GetAttributedClassesinModule([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] uint ulAppDomainID, [In] Guid guidModule, [In, MarshalAs(UnmanagedType.LPWStr)] string pstrAttribute, [MarshalAs(UnmanagedType.Interface)] out IEnumDebugFields ppEnum);
        [PreserveSig]
        int GetAttributedClassesForLanguage([In] Guid guidLanguage, [In, MarshalAs(UnmanagedType.LPWStr)] string pstrAttribute, [MarshalAs(UnmanagedType.Interface)] out IEnumDebugFields ppEnum);
        [PreserveSig]
        int IsHiddenCode([In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddress);
        [PreserveSig]
        int IsFunctionDeleted([In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddress);
        [PreserveSig]
        int GetNameFromToken([In, MarshalAs(UnmanagedType.IUnknown)] object pMetadataImport, [In] uint dwToken, [MarshalAs(UnmanagedType.BStr)] out string pbstrName);
        [PreserveSig]
        int IsFunctionStale([In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddress);
        [PreserveSig]
        int GetLocalVariablelayout([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] uint ulAppDomainID, [In] Guid guidModule, [In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] uint cMethods, [In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop._mdToken"), MarshalAs(UnmanagedType.LPArray, SizeParamIndex = 2)] int[] rgMethodTokens, [MarshalAs(UnmanagedType.Interface)] out Microsoft.VisualStudio.OLE.Interop.IStream pStreamLayout);
        [PreserveSig]
        int GetAssemblyName([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] uint ulAppDomainID, [In] Guid guidModule, [MarshalAs(UnmanagedType.BStr)] out string pbstrName);
        [PreserveSig]
        int LoadSymbolsFromCallback([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] uint ulAppDomainID, [In] Guid guidModule, [In, MarshalAs(UnmanagedType.IUnknown)] object pUnkMetadataImport, [In, MarshalAs(UnmanagedType.IUnknown)] object pUnkCorDebugModule, [In, MarshalAs(UnmanagedType.BStr)] string bstrModuleName, [In, MarshalAs(UnmanagedType.BStr)] string bstrSymSearchPath, [In, MarshalAs(UnmanagedType.IUnknown)] object pCallback);
        [PreserveSig]
        int IsAddressSequencePoint([In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddress);
        [PreserveSig]
        int FunctionHasLineInfo([In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddress);
        [PreserveSig]
        int GetTypesByName([In, MarshalAs(UnmanagedType.LPWStr)] string pszClassName, [In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.NAME_MATCH")] NAME_MATCH nameMatch, [MarshalAs(UnmanagedType.Interface)] out IEnumDebugFields ppEnum);
        [PreserveSig]
        int LoadSymbolsWithCorModule([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] uint ulAppDomainID, [In] Guid guidModule, [In] ulong baseAddress, [In, MarshalAs(UnmanagedType.IUnknown)] object pUnkMetadataImport, [In, MarshalAs(UnmanagedType.IUnknown)] object pUnkCorDebugModule, [In, MarshalAs(UnmanagedType.BStr)] string bstrModuleName, [In, MarshalAs(UnmanagedType.BStr)] string bstrSymSearchPath);
        [PreserveSig]
        int LoadSymbolsFromStreamWithCorModule([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] uint ulAppDomainID, [In] Guid guidModule, [In] ulong baseAddress, [In, MarshalAs(UnmanagedType.IUnknown)] object pUnkMetadataImport, [In, MarshalAs(UnmanagedType.IUnknown)] object pUnkCorDebugModule, [In, MarshalAs(UnmanagedType.Interface)] Microsoft.VisualStudio.OLE.Interop.IStream pStream);
        [PreserveSig]
        int GetTypeFromToken([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] uint appDomain, [In] Guid guidModule, [In] uint tdToken, [MarshalAs(UnmanagedType.Interface)] out IDebugField ppField);
    }

    // Depends on IDebugAddress, IDebugField, IDebugContainerField
    [ComImport, Guid("C2E34EB4-8B9D-11D2-9014-00C04FA38338"), InterfaceType((short)1)]
    public interface IDebugMethodField : IDebugContainerField
    {
        [PreserveSig]
        int GetInfo([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_INFO_FIELDS")] enum_FIELD_INFO_FIELDS dwFields, [Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_INFO"), MarshalAs(UnmanagedType.LPArray)] FIELD_INFO[] pFieldInfo);
        [PreserveSig]
        int GetKind([Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_KIND"), MarshalAs(UnmanagedType.LPArray)] enum_FIELD_KIND[] pdwKind);
        [PreserveSig]
        int GetType([MarshalAs(UnmanagedType.Interface)] out IDebugField ppType);
        [PreserveSig]
        int GetContainer([MarshalAs(UnmanagedType.Interface)] out IDebugContainerField ppContainerField);
        [PreserveSig]
        int GetAddress([MarshalAs(UnmanagedType.Interface)] out IDebugAddress ppAddress);
        [PreserveSig]
        int GetSize(out uint pdwSize);
        [PreserveSig]
        int GetExtendedInfo([In] ref Guid guidExtendedInfo, [Out, MarshalAs(UnmanagedType.LPArray, SizeParamIndex = 2)] IntPtr[] prgBuffer, [In, Out] ref uint pdwLen);
        [PreserveSig]
        int Equal([In, MarshalAs(UnmanagedType.Interface)] IDebugField pField);
        [PreserveSig]
        int GetTypeInfo([Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.TYPE_INFO"), MarshalAs(UnmanagedType.LPArray)] TYPE_INFO[] pTypeInfo);
        [PreserveSig]
        int EnumFields([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_KIND")] enum_FIELD_KIND dwKindFilter, [In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_MODIFIERS")] enum_FIELD_MODIFIERS dwModifiersFilter, [In, MarshalAs(UnmanagedType.LPWStr)] string pszNameFilter, [In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.NAME_MATCH")] NAME_MATCH nameMatch, [MarshalAs(UnmanagedType.Interface)] out IEnumDebugFields ppEnum);
        [PreserveSig]
        int EnumParameters([MarshalAs(UnmanagedType.Interface)] out IEnumDebugFields ppParams);
        [PreserveSig]
        int GetThis([MarshalAs(UnmanagedType.Interface)] out IDebugClassField ppClass);
        [PreserveSig]
        int EnumAllLocals([In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddress, [MarshalAs(UnmanagedType.Interface)] out IEnumDebugFields ppLocals);
        [PreserveSig]
        int EnumLocals([In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddress, [MarshalAs(UnmanagedType.Interface)] out IEnumDebugFields ppLocals);
        [PreserveSig]
        int IsCustomAttributeDefined([In, MarshalAs(UnmanagedType.LPWStr)] string pszCustomAttributeName);
        [PreserveSig]
        int EnumStaticLocals([MarshalAs(UnmanagedType.Interface)] out IEnumDebugFields ppLocals);
        [PreserveSig]
        int GetGlobalContainer([MarshalAs(UnmanagedType.Interface)] out IDebugClassField ppClass);
        [PreserveSig]
        int EnumArguments([MarshalAs(UnmanagedType.Interface)] out IEnumDebugFields ppParams);
    }

    // Depends on IDebugAddress, IDebugField
    [ComImport, Guid("C2E34EB6-8B9D-11D2-9014-00C04FA38338"), InterfaceType((short)1)]
    public interface IDebugPropertyField : IDebugContainerField
    {
        [PreserveSig]
        int GetInfo([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_INFO_FIELDS")] enum_FIELD_INFO_FIELDS dwFields, [Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_INFO"), MarshalAs(UnmanagedType.LPArray)] FIELD_INFO[] pFieldInfo);
        [PreserveSig]
        int GetKind([Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_KIND"), MarshalAs(UnmanagedType.LPArray)] enum_FIELD_KIND[] pdwKind);
        [PreserveSig]
        int GetType([MarshalAs(UnmanagedType.Interface)] out IDebugField ppType);
        [PreserveSig]
        int GetContainer([MarshalAs(UnmanagedType.Interface)] out IDebugContainerField ppContainerField);
        [PreserveSig]
        int GetAddress([MarshalAs(UnmanagedType.Interface)] out IDebugAddress ppAddress);
        [PreserveSig]
        int GetSize(out uint pdwSize);
        [PreserveSig]
        int GetExtendedInfo([In] ref Guid guidExtendedInfo, [Out, MarshalAs(UnmanagedType.LPArray, SizeParamIndex = 2)] IntPtr[] prgBuffer, [In, Out] ref uint pdwLen);
        [PreserveSig]
        int Equal([In, MarshalAs(UnmanagedType.Interface)] IDebugField pField);
        [PreserveSig]
        int GetTypeInfo([Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.TYPE_INFO"), MarshalAs(UnmanagedType.LPArray)] TYPE_INFO[] pTypeInfo);
        [PreserveSig]
        int EnumFields([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_KIND")] enum_FIELD_KIND dwKindFilter, [In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_MODIFIERS")] enum_FIELD_MODIFIERS dwModifiersFilter, [In, MarshalAs(UnmanagedType.LPWStr)] string pszNameFilter, [In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.NAME_MATCH")] NAME_MATCH nameMatch, [MarshalAs(UnmanagedType.Interface)] out IEnumDebugFields ppEnum);
        [PreserveSig]
        int GetPropertyGetter([MarshalAs(UnmanagedType.Interface)] out IDebugMethodField ppField);
        [PreserveSig]
        int GetPropertySetter([MarshalAs(UnmanagedType.Interface)] out IDebugMethodField ppField);
    }

    [ComImport, InterfaceType((short)1), Guid("C2E34EAE-8B9D-11D2-9014-00C04FA38338")]
    public interface IDebugSymbolProvider
    {
        [PreserveSig]
        int Initialize([In, MarshalAs(UnmanagedType.Interface)] IDebugEngineSymbolProviderServices pServices);
        [PreserveSig]
        int Uninitialize();
        [PreserveSig]
        int GetContainerField([In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddress, [MarshalAs(UnmanagedType.Interface)] out IDebugContainerField ppContainerField);
        [PreserveSig]
        int GetField([In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddress, [In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddressCur, [MarshalAs(UnmanagedType.Interface)] out IDebugField ppField);
        [PreserveSig]
        int GetAddressesFromPosition([In, MarshalAs(UnmanagedType.Interface)] IDebugDocumentPosition2 pDocPos, [In] int fStatmentOnly, [MarshalAs(UnmanagedType.Interface)] out IEnumDebugAddresses ppEnumBegAddresses, [MarshalAs(UnmanagedType.Interface)] out IEnumDebugAddresses ppEnumEndAddresses);
        [PreserveSig]
        int GetAddressesFromContext([In, MarshalAs(UnmanagedType.Interface)] IDebugDocumentContext2 pDocContext, [In] int fStatmentOnly, [MarshalAs(UnmanagedType.Interface)] out IEnumDebugAddresses ppEnumBegAddresses, [MarshalAs(UnmanagedType.Interface)] out IEnumDebugAddresses ppEnumEndAddresses);
        [PreserveSig]
        int GetContextFromAddress([In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddress, [MarshalAs(UnmanagedType.Interface)] out IDebugDocumentContext2 ppDocContext);
        [PreserveSig]
        int GetLanguage([In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddress, out Guid pguidLanguage, out Guid pguidLanguageVendor);
        [PreserveSig]
        int GetGlobalContainer([MarshalAs(UnmanagedType.Interface)] out IDebugContainerField pField);
        [PreserveSig]
        int GetMethodFieldsByName([In, MarshalAs(UnmanagedType.LPWStr)] string pszFullName, [In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.NAME_MATCH")] NAME_MATCH nameMatch, [MarshalAs(UnmanagedType.Interface)] out IEnumDebugFields ppEnum);
        [PreserveSig]
        int GetClassTypeByName([In, MarshalAs(UnmanagedType.LPWStr)] string pszClassName, [In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.NAME_MATCH")] NAME_MATCH nameMatch, [MarshalAs(UnmanagedType.Interface)] out IDebugClassField ppField);
        [PreserveSig]
        int GetNamespacesUsedAtAddress([In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddress, [MarshalAs(UnmanagedType.Interface)] out IEnumDebugFields ppEnum);
        [PreserveSig]
        int GetTypeByName([In, MarshalAs(UnmanagedType.LPWStr)] string pszClassName, [In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.NAME_MATCH")] NAME_MATCH nameMatch, [MarshalAs(UnmanagedType.Interface)] out IDebugField ppField);
        [PreserveSig]
        int GetNextAddress([In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddress, [In] int fStatmentOnly, [MarshalAs(UnmanagedType.Interface)] out IDebugAddress ppAddress);
    }

    // Depends on IDebugAddress, IDebugField, IDebugContainerField
    [ComImport, Guid("7A739554-3FC6-43EE-981D-F49171151393"), InterfaceType((short)1)]
    public interface IDebugPrimitiveTypeField : IDebugField
    {
        [PreserveSig]
        int GetInfo([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_INFO_FIELDS")] enum_FIELD_INFO_FIELDS dwFields, [Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_INFO"), MarshalAs(UnmanagedType.LPArray)] FIELD_INFO[] pFieldInfo);
        [PreserveSig]
        int GetKind([Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_KIND"), MarshalAs(UnmanagedType.LPArray)] enum_FIELD_KIND[] pdwKind);
        [PreserveSig]
        int GetType([MarshalAs(UnmanagedType.Interface)] out IDebugField ppType);
        [PreserveSig]
        int GetContainer([MarshalAs(UnmanagedType.Interface)] out IDebugContainerField ppContainerField);
        [PreserveSig]
        int GetAddress([MarshalAs(UnmanagedType.Interface)] out IDebugAddress ppAddress);
        [PreserveSig]
        int GetSize(out uint pdwSize);
        [PreserveSig]
        int GetExtendedInfo([In] ref Guid guidExtendedInfo, [Out, MarshalAs(UnmanagedType.LPArray, SizeParamIndex = 2)] IntPtr[] prgBuffer, [In, Out] ref uint pdwLen);
        [PreserveSig]
        int Equal([In, MarshalAs(UnmanagedType.Interface)] IDebugField pField);
        [PreserveSig]
        int GetTypeInfo([Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.TYPE_INFO"), MarshalAs(UnmanagedType.LPArray)] TYPE_INFO[] pTypeInfo);
        [PreserveSig]
        int GetPrimitiveType(out uint pdwType);
    }

    // Depends on IDebugAddress, IDebugField, IDebugContainerField
    [ComImport, Guid("C2E34EB9-8B9D-11D2-9014-00C04FA38338"), InterfaceType((short)1)]
    public interface IDebugEnumField : IDebugContainerField
    {
        [PreserveSig]
        int GetInfo([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_INFO_FIELDS")] enum_FIELD_INFO_FIELDS dwFields, [Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_INFO"), MarshalAs(UnmanagedType.LPArray)] FIELD_INFO[] pFieldInfo);
        [PreserveSig]
        int GetKind([Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_KIND"), MarshalAs(UnmanagedType.LPArray)] enum_FIELD_KIND[] pdwKind);
        [PreserveSig]
        int GetType([MarshalAs(UnmanagedType.Interface)] out IDebugField ppType);
        [PreserveSig]
        int GetContainer([MarshalAs(UnmanagedType.Interface)] out IDebugContainerField ppContainerField);
        [PreserveSig]
        int GetAddress([MarshalAs(UnmanagedType.Interface)] out IDebugAddress ppAddress);
        [PreserveSig]
        int GetSize(out uint pdwSize);
        [PreserveSig]
        int GetExtendedInfo([In] ref Guid guidExtendedInfo, [Out, MarshalAs(UnmanagedType.LPArray, SizeParamIndex = 2)] IntPtr[] prgBuffer, [In, Out] ref uint pdwLen);
        [PreserveSig]
        int Equal([In, MarshalAs(UnmanagedType.Interface)] IDebugField pField);
        [PreserveSig]
        int GetTypeInfo([Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.TYPE_INFO"), MarshalAs(UnmanagedType.LPArray)] TYPE_INFO[] pTypeInfo);
        [PreserveSig]
        int EnumFields([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_KIND")] enum_FIELD_KIND dwKindFilter, [In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_MODIFIERS")] enum_FIELD_MODIFIERS dwModifiersFilter, [In, MarshalAs(UnmanagedType.LPWStr)] string pszNameFilter, [In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.NAME_MATCH")] NAME_MATCH nameMatch, [MarshalAs(UnmanagedType.Interface)] out IEnumDebugFields ppEnum);
        [PreserveSig]
        int GetUnderlyingSymbol([MarshalAs(UnmanagedType.Interface)] out IDebugField ppField);
        [PreserveSig]
        int GetStringFromValue([In] ulong value, [MarshalAs(UnmanagedType.BStr)] out string pbstrValue);
        [PreserveSig]
        int GetValueFromString([In, MarshalAs(UnmanagedType.LPWStr)] string pszValue, out ulong pValue);
        [PreserveSig]
        int GetValueFromStringCaseInsensitive([In, MarshalAs(UnmanagedType.LPWStr)] string pszValue, out ulong pValue);
    }

    // Depends on IDebugAddress, IDebugField, IDebugContainerField
    [ComImport, Guid("B5A2A5EA-D5AB-11D2-9033-00C04FA302A1"), InterfaceType((short)1)]
    public interface IDebugDynamicField : IDebugField
    {
        [PreserveSig]
        int GetInfo([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_INFO_FIELDS")] enum_FIELD_INFO_FIELDS dwFields, [Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_INFO"), MarshalAs(UnmanagedType.LPArray)] FIELD_INFO[] pFieldInfo);
        [PreserveSig]
        int GetKind([Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_KIND"), MarshalAs(UnmanagedType.LPArray)] enum_FIELD_KIND[] pdwKind);
        [PreserveSig]
        int GetType([MarshalAs(UnmanagedType.Interface)] out IDebugField ppType);
        [PreserveSig]
        int GetContainer([MarshalAs(UnmanagedType.Interface)] out IDebugContainerField ppContainerField);
        [PreserveSig]
        int GetAddress([MarshalAs(UnmanagedType.Interface)] out IDebugAddress ppAddress);
        [PreserveSig]
        int GetSize(out uint pdwSize);
        [PreserveSig]
        int GetExtendedInfo([In] ref Guid guidExtendedInfo, [Out, MarshalAs(UnmanagedType.LPArray, SizeParamIndex = 2)] IntPtr[] prgBuffer, [In, Out] ref uint pdwLen);
        [PreserveSig]
        int Equal([In, MarshalAs(UnmanagedType.Interface)] IDebugField pField);
        [PreserveSig]
        int GetTypeInfo([Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.TYPE_INFO"), MarshalAs(UnmanagedType.LPArray)] TYPE_INFO[] pTypeInfo);
    }

    // Depends on IDebugAddress, IDebugField
    [ComImport, Guid("B5B20820-E233-11D2-9037-00C04FA302A1"), InterfaceType((short)1)]
    public interface IDebugDynamicFieldCOMPlus : IDebugDynamicField
    {
        [PreserveSig]
        int GetInfo([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_INFO_FIELDS")] enum_FIELD_INFO_FIELDS dwFields, [Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_INFO"), MarshalAs(UnmanagedType.LPArray)] FIELD_INFO[] pFieldInfo);
        [PreserveSig]
        int GetKind([Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_KIND"), MarshalAs(UnmanagedType.LPArray)] enum_FIELD_KIND[] pdwKind);
        [PreserveSig]
        int GetType([MarshalAs(UnmanagedType.Interface)] out IDebugField ppType);
        [PreserveSig]
        int GetContainer([MarshalAs(UnmanagedType.Interface)] out IDebugContainerField ppContainerField);
        [PreserveSig]
        int GetAddress([MarshalAs(UnmanagedType.Interface)] out IDebugAddress ppAddress);
        [PreserveSig]
        int GetSize(out uint pdwSize);
        [PreserveSig]
        int GetExtendedInfo([In] ref Guid guidExtendedInfo, [Out, MarshalAs(UnmanagedType.LPArray, SizeParamIndex = 2)] IntPtr[] prgBuffer, [In, Out] ref uint pdwLen);
        [PreserveSig]
        int Equal([In, MarshalAs(UnmanagedType.Interface)] IDebugField pField);
        [PreserveSig]
        int GetTypeInfo([Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.TYPE_INFO"), MarshalAs(UnmanagedType.LPArray)] TYPE_INFO[] pTypeInfo);
        [PreserveSig]
        int GetTypeFromPrimitive([In] uint dwCorElementType, [MarshalAs(UnmanagedType.Interface)] out IDebugField ppType);
        [PreserveSig]
        int GetTypeFromTypeDef([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] uint ulAppDomainID, [In] Guid guidModule, [In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop._mdToken")] int tokClass, [MarshalAs(UnmanagedType.Interface)] out IDebugField ppType);
    }

    // Depends on IDebugAddress
    [ComImport, Guid("C077C822-476C-11D2-B73C-0000F87572EF"), InterfaceType((short)1)]
    public interface IDebugExpressionEvaluator
    {
        [PreserveSig]
        int Parse([In, MarshalAs(UnmanagedType.LPWStr)] string upstrExpression, [In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.PARSEFLAGS")] enum_PARSEFLAGS dwFlags, [In] uint nRadix, [MarshalAs(UnmanagedType.BStr)] out string pbstrError, out uint pichError, [MarshalAs(UnmanagedType.Interface)] out IDebugParsedExpression ppParsedExpression);
        [PreserveSig]
        int GetMethodProperty([In, MarshalAs(UnmanagedType.Interface)] IDebugSymbolProvider pSymbolProvider, [In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddress, [In, MarshalAs(UnmanagedType.Interface)] IDebugBinder pBinder, [In] int fIncludeHiddenLocals, [MarshalAs(UnmanagedType.Interface)] out IDebugProperty2 ppProperty);
        [PreserveSig]
        int GetMethodLocationProperty([In, MarshalAs(UnmanagedType.LPWStr)] string upstrFullyQualifiedMethodPlusOffset, [In, MarshalAs(UnmanagedType.Interface)] IDebugSymbolProvider pSymbolProvider, [In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddress, [In, MarshalAs(UnmanagedType.Interface)] IDebugBinder pBinder, [MarshalAs(UnmanagedType.Interface)] out IDebugProperty2 ppProperty);
        [PreserveSig]
        int SetLocale([In] ushort wLangID);
        [PreserveSig]
        int SetRegistryRoot([In, MarshalAs(UnmanagedType.LPWStr)] string ustrRegistryRoot);
    }

    // Depends on IDebugAddress
    [ComImport, InterfaceType((short)1), Guid("2DE1D5E0-CA57-456F-815C-5902825A2795")]
    public interface IDebugExpressionEvaluator2 : IDebugExpressionEvaluator
    {
        [PreserveSig]
        int Parse([In, MarshalAs(UnmanagedType.LPWStr)] string upstrExpression, [In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.PARSEFLAGS")] enum_PARSEFLAGS dwFlags, [In] uint nRadix, [MarshalAs(UnmanagedType.BStr)] out string pbstrError, out uint pichError, [MarshalAs(UnmanagedType.Interface)] out IDebugParsedExpression ppParsedExpression);
        [PreserveSig]
        int GetMethodProperty([In, MarshalAs(UnmanagedType.Interface)] IDebugSymbolProvider pSymbolProvider, [In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddress, [In, MarshalAs(UnmanagedType.Interface)] IDebugBinder pBinder, [In] int fIncludeHiddenLocals, [MarshalAs(UnmanagedType.Interface)] out IDebugProperty2 ppProperty);
        [PreserveSig]
        int GetMethodLocationProperty([In, MarshalAs(UnmanagedType.LPWStr)] string upstrFullyQualifiedMethodPlusOffset, [In, MarshalAs(UnmanagedType.Interface)] IDebugSymbolProvider pSymbolProvider, [In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddress, [In, MarshalAs(UnmanagedType.Interface)] IDebugBinder pBinder, [MarshalAs(UnmanagedType.Interface)] out IDebugProperty2 ppProperty);
        [PreserveSig]
        int SetLocale([In] ushort wLangID);
        [PreserveSig]
        int SetRegistryRoot([In, MarshalAs(UnmanagedType.LPWStr)] string ustrRegistryRoot);
        [PreserveSig]
        int SetCorPath([In, MarshalAs(UnmanagedType.LPWStr)] string pcstrCorPath);
        [PreserveSig]
        int Terminate();
        [PreserveSig]
        int SetCallback([In, MarshalAs(UnmanagedType.Interface)] IDebugSettingsCallback2 pCallback);
        [PreserveSig]
        int PreloadModules([In, MarshalAs(UnmanagedType.Interface)] IDebugSymbolProvider pSym);
        [PreserveSig]
        int GetService([In] Guid uid, [Out] out IntPtr ppService);
        [PreserveSig]
        int SetIDebugIDECallback([In, MarshalAs(UnmanagedType.Interface)] IDebugIDECallback pCallback);
    }

    // Depends on IDebugAddress
    [ComImport, InterfaceType((short)1), Guid("4C7EC6F5-BB6C-43A2-853C-80FF48B7A8A6")]
    public interface IDebugExpressionEvaluator3 : IDebugExpressionEvaluator2
    {
        [PreserveSig]
        int Parse([In, MarshalAs(UnmanagedType.LPWStr)] string upstrExpression, [In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.PARSEFLAGS")] enum_PARSEFLAGS dwFlags, [In] uint nRadix, [MarshalAs(UnmanagedType.BStr)] out string pbstrError, out uint pichError, [MarshalAs(UnmanagedType.Interface)] out IDebugParsedExpression ppParsedExpression);
        [PreserveSig]
        int GetMethodProperty([In, MarshalAs(UnmanagedType.Interface)] IDebugSymbolProvider pSymbolProvider, [In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddress, [In, MarshalAs(UnmanagedType.Interface)] IDebugBinder pBinder, [In] int fIncludeHiddenLocals, [MarshalAs(UnmanagedType.Interface)] out IDebugProperty2 ppProperty);
        [PreserveSig]
        int GetMethodLocationProperty([In, MarshalAs(UnmanagedType.LPWStr)] string upstrFullyQualifiedMethodPlusOffset, [In, MarshalAs(UnmanagedType.Interface)] IDebugSymbolProvider pSymbolProvider, [In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddress, [In, MarshalAs(UnmanagedType.Interface)] IDebugBinder pBinder, [MarshalAs(UnmanagedType.Interface)] out IDebugProperty2 ppProperty);
        [PreserveSig]
        int SetLocale([In] ushort wLangID);
        [PreserveSig]
        int SetRegistryRoot([In, MarshalAs(UnmanagedType.LPWStr)] string ustrRegistryRoot);
        [PreserveSig]
        int SetCorPath([In, MarshalAs(UnmanagedType.LPWStr)] string pcstrCorPath);
        [PreserveSig]
        int Terminate();
        [PreserveSig]
        int SetCallback([In, MarshalAs(UnmanagedType.Interface)] IDebugSettingsCallback2 pCallback);
        [PreserveSig]
        int PreloadModules([In, MarshalAs(UnmanagedType.Interface)] IDebugSymbolProvider pSym);
        [PreserveSig]
        int GetService([In] Guid uid, [MarshalAs(UnmanagedType.IUnknown)] out IntPtr ppService);
        [PreserveSig]
        int SetIDebugIDECallback([In, MarshalAs(UnmanagedType.Interface)] IDebugIDECallback pCallback);
        [PreserveSig]
        int Parse2([In, MarshalAs(UnmanagedType.LPWStr)] string upstrExpression, [In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.PARSEFLAGS")] enum_PARSEFLAGS dwFlags, [In] uint nRadix, [In, MarshalAs(UnmanagedType.Interface)] IDebugSymbolProvider pSymbolProvider, [In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddress, [MarshalAs(UnmanagedType.BStr)] out string pbstrError, out uint pichError, [MarshalAs(UnmanagedType.Interface)] out IDebugParsedExpression ppParsedExpression);
    }

    // Depends on IDebugAddress
    [ComImport, Guid("7895C94C-5A3F-11D2-B742-0000F87572EF"), InterfaceType((short)1)]
    public interface IDebugParsedExpression
    {
        [PreserveSig]
        int EvaluateSync([In] uint dwEvalFlags,
        [In] uint dwTimeout,
        [In, MarshalAs(UnmanagedType.Interface)] IDebugSymbolProvider pSymbolProvider,
        [In, MarshalAs(UnmanagedType.Interface)] IDebugAddress pAddress,
        [In, MarshalAs(UnmanagedType.Interface)] IDebugBinder pBinder,
        [In, MarshalAs(UnmanagedType.BStr)] string bstrResultType,
        [MarshalAs(UnmanagedType.Interface)] out IDebugProperty2 ppResult);
    }

    // Depends on IDebugAddress, IDebugField
    [ComImport, Guid("82545B58-F203-4835-ACD6-6D0997AA6F25"), InterfaceType((short)1)]
    public interface IEEVisualizerService
    {
        [PreserveSig]
        int GetCustomViewerCount(out uint pcelt);
        [PreserveSig]
        int GetCustomViewerList([In] uint celtSkip, [In] uint celtRequested, [Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.DEBUG_CUSTOM_VIEWER"), MarshalAs(UnmanagedType.LPArray, SizeParamIndex = 1)] DEBUG_CUSTOM_VIEWER[] rgViewers, out uint pceltFetched);
        [PreserveSig]
        int GetPropertyProxy([In] uint dwID, [MarshalAs(UnmanagedType.Interface)] out IPropertyProxyEESide proxy);
        [PreserveSig]
        int GetValueDisplayStringCount([In] uint DisplayKind, [In, MarshalAs(UnmanagedType.Interface)] IDebugField propertyOrField, out uint pcelt);
        [PreserveSig]
        int GetValueDisplayStrings([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.DisplayKind")] enum_DisplayKind DisplayKind, [In, MarshalAs(UnmanagedType.Interface)] IDebugField propertyOrField, [In] uint celtSkip, [In] uint celtRequested, [Out, MarshalAs(UnmanagedType.LPArray, ArraySubType = UnmanagedType.BStr, SizeParamIndex = 3)] string[] rgStrings, [Out, MarshalAs(UnmanagedType.LPArray, SizeParamIndex = 3)] int[] rgIsExpression, out uint pceltFetched);
        [PreserveSig]
        int GetBrowsableState([In, MarshalAs(UnmanagedType.Interface)] IDebugField propertyOrField, [Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.BrowsableKind"), MarshalAs(UnmanagedType.LPArray)] enum_BrowsableKind[] BrowsableKind);
        [PreserveSig]
        int PossiblyHasInlineProxy(out int mayHaveProxy);
        [PreserveSig]
        int CreateInlineProxy([MarshalAs(UnmanagedType.Interface)] out IDebugObject proxy, out int IsExceptionNotProxy, [MarshalAs(UnmanagedType.BStr)] out string errorString);
    }

    // Depends on IDebugField
    [ComImport, InterfaceType((short)1), Guid("C2E34EBC-8B9D-11D2-9014-00C04FA38338")]
    public interface IEnumDebugFields
    {
        [PreserveSig]
        int Next([In] uint celt, [Out, MarshalAs(UnmanagedType.LPArray, ArraySubType = UnmanagedType.Interface, SizeParamIndex = 0)] IDebugField[] rgelt, [In, Out] ref uint pceltFetched);
        [PreserveSig]
        int Skip([In] uint celt);
        [PreserveSig]
        int Reset();
        [PreserveSig]
        int Clone([MarshalAs(UnmanagedType.Interface)] out IEnumDebugFields ppEnum);
        [PreserveSig]
        int GetCount(out uint pcelt);
    }

    // Depends on IDebugContainerField, IDebugField
    [ComImport, InterfaceType((short)1), Guid("C2E34EB8-8B9D-11D2-9014-00C04FA38338")]
    public interface IDebugPointerField : IDebugContainerField
    {
        [PreserveSig]
        int GetInfo([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_INFO_FIELDS")] enum_FIELD_INFO_FIELDS dwFields, [Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_INFO"), MarshalAs(UnmanagedType.LPArray)] FIELD_INFO[] pFieldInfo);
        [PreserveSig]
        int GetKind([Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_KIND"), MarshalAs(UnmanagedType.LPArray)] enum_FIELD_KIND[] pdwKind);
        [PreserveSig]
        int GetType([MarshalAs(UnmanagedType.Interface)] out IDebugField ppType);
        [PreserveSig]
        int GetContainer([MarshalAs(UnmanagedType.Interface)] out IDebugContainerField ppContainerField);
        [PreserveSig]
        int GetAddress([MarshalAs(UnmanagedType.Interface)] out IDebugAddress ppAddress);
        [PreserveSig]
        int GetSize(out uint pdwSize);
        [PreserveSig]
        int GetExtendedInfo([In] ref Guid guidExtendedInfo, [Out, MarshalAs(UnmanagedType.LPArray, SizeParamIndex = 2)] IntPtr[] prgBuffer, [In, Out] ref uint pdwLen);
        [PreserveSig]
        int Equal([In, MarshalAs(UnmanagedType.Interface)] IDebugField pField);
        [PreserveSig]
        int GetTypeInfo([Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.TYPE_INFO"), MarshalAs(UnmanagedType.LPArray)] TYPE_INFO[] pTypeInfo);
        [PreserveSig]
        int EnumFields([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_KIND")] enum_FIELD_KIND dwKindFilter, [In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_MODIFIERS")] enum_FIELD_MODIFIERS dwModifiersFilter, [In, MarshalAs(UnmanagedType.LPWStr)] string pszNameFilter, [In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.NAME_MATCH")] NAME_MATCH nameMatch, [MarshalAs(UnmanagedType.Interface)] out IEnumDebugFields ppEnum);
        [PreserveSig]
        int GetDereferencedField([MarshalAs(UnmanagedType.Interface)] out IDebugField ppField);
    }

    // Depends on IDebugField
    [ComImport, InterfaceType((short)1), Guid("A3A37C5E-8D71-487D-A9E1-B9A1B3BA9CBB")]
    public interface IDebugCustomAttribute
    {
        [PreserveSig]
        int GetParentField([MarshalAs(UnmanagedType.Interface)] out IDebugField ppField);
        [PreserveSig]
        int GetAttributeTypeField([MarshalAs(UnmanagedType.Interface)] out IDebugClassField ppCAType);
        [PreserveSig]
        int GetName([MarshalAs(UnmanagedType.BStr)] out string bstrName);
        [PreserveSig]
        int GetAttributeBytes([In, Out, MarshalAs(UnmanagedType.LPArray, SizeParamIndex = 1)] byte[] ppBlob, [In, Out] ref uint pdwLen);
    }

    // Depends on IDebugField, IDebugContainerField
    [ComImport, Guid("C5717D6C-8DBF-4852-B7D8-C003EE09541F"), InterfaceType((short)1)]
    public interface IDebugGenericFieldDefinition
    {
        [PreserveSig]
        int TypeParamCount([In, Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] ref uint pcParams);
        [PreserveSig]
        int GetFormalTypeParams([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] uint cParams, [Out, MarshalAs(UnmanagedType.LPArray, ArraySubType = UnmanagedType.Interface, SizeParamIndex = 0)] IDebugGenericParamField[] ppParams, [In, Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] ref uint pcParams);
        [PreserveSig]
        int ConstructInstantiation([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] uint cArgs, [In, MarshalAs(UnmanagedType.LPArray, ArraySubType = UnmanagedType.Interface, SizeParamIndex = 0)] IDebugField[] ppArgs, [MarshalAs(UnmanagedType.Interface)] out IDebugField ppConstructedField);
    }

    // Depends on IDebugField
    [ComImport, InterfaceType((short)1), Guid("C93C9DD0-0A65-4966-BCEB-633EEEE2E096")]
    public interface IDebugGenericFieldInstance
    {
        [PreserveSig]
        int TypeArgumentCount([In, Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] ref uint pcArgs);
        [PreserveSig]
        int GetTypeArguments([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] uint cArgs, [Out, MarshalAs(UnmanagedType.LPArray, ArraySubType = UnmanagedType.Interface, SizeParamIndex = 0)] IDebugField[] ppArgs, [In, Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] ref uint pcArgs);
    }

    // Depends on IDebugField
    [ComImport, Guid("941105E9-760A-49EC-995F-7668CB60216C"), InterfaceType((short)1)]
    public interface IDebugGenericParamField : IDebugField
    {
        [PreserveSig]
        int GetInfo([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_INFO_FIELDS")] enum_FIELD_INFO_FIELDS dwFields, [Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_INFO"), MarshalAs(UnmanagedType.LPArray)] FIELD_INFO[] pFieldInfo);
        [PreserveSig]
        int GetKind([Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.FIELD_KIND"), MarshalAs(UnmanagedType.LPArray)] enum_FIELD_KIND[] pdwKind);
        [PreserveSig]
        int GetType([MarshalAs(UnmanagedType.Interface)] out IDebugField ppType);
        [PreserveSig]
        int GetContainer([MarshalAs(UnmanagedType.Interface)] out IDebugContainerField ppContainerField);
        [PreserveSig]
        int GetAddress([MarshalAs(UnmanagedType.Interface)] out IDebugAddress ppAddress);
        [PreserveSig]
        int GetSize(out uint pdwSize);
        [PreserveSig]
        int GetExtendedInfo([In] ref Guid guidExtendedInfo, [Out, MarshalAs(UnmanagedType.LPArray, SizeParamIndex = 2)] IntPtr[] prgBuffer, [In, Out] ref uint pdwLen);
        [PreserveSig]
        int Equal([In, MarshalAs(UnmanagedType.Interface)] IDebugField pField);
        [PreserveSig]
        int GetTypeInfo([Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.TYPE_INFO"), MarshalAs(UnmanagedType.LPArray)] TYPE_INFO[] pTypeInfo);
        [PreserveSig]
        IntPtr GetNameOfFormalParam([MarshalAs(UnmanagedType.BStr)] out string pbstrName);
        [PreserveSig]
        int ConstraintCount([In, Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] ref uint pcConst);
        [PreserveSig]
        int GetConstraints([In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] uint cConstraints, [Out, MarshalAs(UnmanagedType.LPArray, ArraySubType = UnmanagedType.Interface, SizeParamIndex = 0)] IDebugField[] ppConstraints, [In, Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] ref uint pcConstraints);
        [PreserveSig]
        int GetOwner([MarshalAs(UnmanagedType.Interface)] out IDebugField ppOwner);
        [PreserveSig]
        int GetIndex(out uint pIndex);
        [PreserveSig]
        int GetFlags(out uint pdwFlags);
    }

    // depends on IDebugFunctionObject
    [ComImport, Guid("F71D9EA0-4269-48dc-9E8D-F86DEFA042B3"), InterfaceType((short)1)]
    public interface IDebugFunctionObject : IDebugObject
    {
        [PreserveSig]
        int GetSize([Out, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] out uint pnSize);
        [PreserveSig]
        int GetValue([Out, MarshalAs(UnmanagedType.LPArray, SizeParamIndex = 1)] byte[] pValue, [In, ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")] uint nSize);
        [PreserveSig]
        int SetValue([In, MarshalAs(UnmanagedType.LPArray, SizeParamIndex = 1)] byte[] pValue,[In] uint nSize); 
        [PreserveSig]
        int SetReferenceValue([In, MarshalAs(UnmanagedType.Interface)] IDebugObject pObject);
        [PreserveSig]
        int GetMemoryContext([MarshalAs(UnmanagedType.Interface)] ref IDebugMemoryContext2 ppContext);
        [PreserveSig]
        int GetManagedDebugObject([MarshalAs(UnmanagedType.Interface)] out IDebugManagedObject ppObject);
        [PreserveSig]
        int IsNullReference([Out] out int pfIsNull);
        [PreserveSig]
        int IsEqual([In, MarshalAs(UnmanagedType.Interface)] IDebugObject pObject, [Out] out int pfIsEqual);
        [PreserveSig]
        int IsReadOnly([Out] out int pfIsReadOnly);
        [PreserveSig]
        int IsProxy([Out] out int pfIsProxy);
        [PreserveSig]
        int CreatePrimitiveObject([In] enum_OBJECT_TYPE ot, [MarshalAs(UnmanagedType.Interface)] out IDebugObject ppObject);
        [PreserveSig]
        int CreateObject([In, MarshalAs(UnmanagedType.Interface)] IDebugFunctionObject pConstructor,
        [In] uint dwArgs,
        [In, Out, MarshalAs(UnmanagedType.LPArray, ArraySubType = UnmanagedType.Interface, SizeParamIndex = 1)] IDebugObject[] pArgs,
        [MarshalAs(UnmanagedType.Interface)] out IDebugObject ppObject);
        [PreserveSig]
        int CreateObjectNoConstructor([In, MarshalAs(UnmanagedType.Interface)] IDebugField pClassField,
        [MarshalAs(UnmanagedType.Interface)] out IDebugObject ppObject);
        [PreserveSig]
        int CreateArrayObject([In] enum_OBJECT_TYPE ot,
        [In, MarshalAs(UnmanagedType.Interface)] IDebugField pClassField,
        [In] uint dwRank,
        [In, MarshalAs(UnmanagedType.LPArray, SizeParamIndex = 2)] uint[] dwDims,
        [In, MarshalAs(UnmanagedType.LPArray, SizeParamIndex = 2)] uint[] dwLowBounds,
        [MarshalAs(UnmanagedType.Interface)] out IDebugObject ppObject);
        [PreserveSig]
        int CreateStringObject([In, MarshalAs(UnmanagedType.LPWStr)] string pcstrString,
        [MarshalAs(UnmanagedType.Interface)] out IDebugObject ppOjbect);
        [PreserveSig]
        int Evaluate([In, Out, MarshalAs(UnmanagedType.LPArray, ArraySubType = UnmanagedType.Interface, SizeParamIndex = 1)] IDebugObject[] ppParams,
        [In] IntPtr dwParams,
        [In] uint dwTimeout,
        [MarshalAs(UnmanagedType.Interface)] out IDebugObject ppResult);
    }

    [ComImport, Guid("8E861CC7-D21C-43e7-AB7B-947921689B88"), InterfaceType((short)1)]
    public interface IDebugFunctionObject2
    {
        int Evaluate([In, Out, MarshalAs(UnmanagedType.LPArray, ArraySubType = UnmanagedType.Interface, SizeParamIndex = 1)] IDebugObject[] ppParams,
        [In] IntPtr dwParams,
        [In] uint dwEvalFlags,
        [In] uint dwTimeout,
        [MarshalAs(UnmanagedType.Interface)] out IDebugObject ppResult
        );
        int CreateObject([In, MarshalAs(UnmanagedType.Interface)] IDebugFunctionObject pConstructor,
        [In] uint dwArgs,
        [In, Out, MarshalAs(UnmanagedType.LPArray, ArraySubType = UnmanagedType.Interface, SizeParamIndex = 1)] IDebugObject[] pArgs,
        [In] uint dwEvalFlags,
        [In] uint dwTimeout,
        [MarshalAs(UnmanagedType.Interface)] out IDebugObject ppObject
        );
        int CreateStringObjectWithLength([In, MarshalAs(UnmanagedType.LPWStr)] string pcstrString,
        [In] uint uiLength,
        [MarshalAs(UnmanagedType.Interface)] out IDebugObject ppObject
        );
    }

    [ComImport, Guid("3FF130FC-B14F-4bae-AE44-46B1CD3928CC"), InterfaceType((short)1)]
    public interface IDebugObject2
    {
        // Methods inherited from IDebugObject
        [PreserveSig]
        int GetManagedDebugObject([MarshalAs(UnmanagedType.Interface)] out IDebugManagedObject ppObject);
        [PreserveSig]
        int GetMemoryContext([MarshalAs(UnmanagedType.Interface)] out IDebugMemoryContext2 pContext);
        [PreserveSig]
        int GetSize(out uint pnSize);
        [PreserveSig]
        int GetValue([Out, MarshalAs(UnmanagedType.LPArray, SizeParamIndex=1)] byte[] pValue, uint nSize);
        [PreserveSig]
        int IsEqual([In, MarshalAs(UnmanagedType.IUnknown)] IDebugObject pObject, out int pfIsEqual);
        [PreserveSig]
        int IsNullReference(out int pfIsNull);
        [PreserveSig]
        int IsProxy(out int pfIsProxy);
        [PreserveSig]
        int IsReadOnly(out int pfIsReadOnly);
        [PreserveSig]
        int SetReferenceValue([In, MarshalAs(UnmanagedType.Interface)] IDebugObject pObject);
        [PreserveSig]
        int SetValue([In, MarshalAs(UnmanagedType.LPArray, SizeParamIndex=1)] byte[] pValue, uint nSize);

        //New methods specific to IDebugObject2
        [PreserveSig]
        int GetBackingFieldForProperty([MarshalAs(UnmanagedType.Interface)] out IDebugObject2 ppObject);
        [PreserveSig]
        int GetICorDebugValue([MarshalAs(UnmanagedType.IUnknown)] out object ppUnk);
        [PreserveSig]
        int CreateAlias([MarshalAs(UnmanagedType.Interface)] out IDebugAlias ppAlias);
        [PreserveSig]
        int GetAlias([MarshalAs(UnmanagedType.Interface)] out IDebugAlias ppAlias);
        [PreserveSig]
        int GetField([MarshalAs(UnmanagedType.Interface)] out IDebugField ppField);
        [PreserveSig]
        int IsUserData([MarshalAs(UnmanagedType.Interface)] out int pfUser);
        [PreserveSig]
        int IsEncOutdated([MarshalAs(UnmanagedType.Interface)] out int pfEncOutdated);
    }
    #endregion

    #region structs
    // Depends on IDebugField
    [StructLayout(LayoutKind.Sequential, Pack = 8)]
    public struct BUILT_TYPE
    {
        [ComAliasName("Microsoft.VisualStudio.Debugger.Interop.ULONG32")]
        public uint ulAppDomainID;
        public Guid guidModule;
        [MarshalAs(UnmanagedType.Interface)]
        public IDebugField pUnderlyingField;
    }

    // Depends on DEBUG_ADDRESS_UNION
    [StructLayout(LayoutKind.Sequential, Pack = 8)]
    public struct DEBUG_ADDRESS
    {
        public uint ulAppDomainID;
        public Guid guidModule;
        public int tokClass;
        public DEBUG_ADDRESS_UNION addr;

        public void Init()
        {
            ulAppDomainID = 0;
            guidModule = Guid.Empty;
            tokClass = 0;
            addr.dwKind = Microsoft.VisualStudio.Debugger.Interop.enum_ADDRESS_KIND.ADDRESS_KIND_METADATA_METHOD;
            addr.unionmember.addrMethod.tokMethod = 0;
            addr.unionmember.addrMethod.dwOffset = 0;
            addr.unionmember.addrMethod.dwVersion = 1;
        }
    }

    // Depends on DEBUG_ADDRESS_UNION_MEMBERS
    [StructLayout(LayoutKind.Sequential, Pack = 8)]
    public struct DEBUG_ADDRESS_UNION
    {
        public Microsoft.VisualStudio.Debugger.Interop.enum_ADDRESS_KIND dwKind;
        public DEBUG_ADDRESS_UNION_MEMBERS unionmember;
    }

    [StructLayout(LayoutKind.Explicit, Size = 0x18, Pack = 8)]
    public struct DEBUG_ADDRESS_UNION_MEMBERS
    {
        [FieldOffset(0)]
        public METADATA_ADDRESS_ARRAYELEM addrArrayElem;
        [FieldOffset(0)]
        public METADATA_ADDRESS_FIELD addrField;
        [FieldOffset(0)]
        public METADATA_ADDRESS_METHOD addrMethod;
        [FieldOffset(0)]
        public NATIVE_ADDRESS addrNative;
        [FieldOffset(0)]
        public METADATA_ADDRESS_PARAM addrParam;
        [FieldOffset(0)]
        public UNMANAGED_ADDRESS_THIS_RELATIVE addrThisRel;
        [FieldOffset(0)]
        public UNMANAGED_ADDRESS_PHYSICAL addrUPhysical;
        [FieldOffset(0)]
        public uint unused;
    }
    #endregion
}
```
