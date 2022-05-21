---
title: VarI8FromCy produces incorrect value
description: There is a long-existing but rarely encountered bug in the OLE Automation function for converting currency (CY) type to 8-byte (64-bit) integers.
ms.date: 03/16/2020
ms.custom: sap:Component development
ms.reviewer: cosminr
ms.technology: windows-dev-apps-component-dev
---
# VarI8FromCy produces incorrect value when CY value is large

This article describes that the issue in the OLE Automation function for converting currency (CY) type to 8-byte (64-bit) integers.

_Original product version:_ &nbsp;  Windows  
_Original KB number:_ &nbsp; 2282810

## Symptoms

An application using the `VariantChangeType`, `VariantChangeTypeEx`, or `VarI8FromCy` to convert a large (> 429497.0) or negative currency value into a 64-bit integer (for example, I8, `long` or `int64`) might get a resulting integer value that is off by one.

## Cause

There is a known flaw in the logic that will cause all values to be rounded away from 0 when the currency value has anything but 0 in its Hi portion.

## Resolution

Use your own replacement for these functions to implement the correct logic.

> [!NOTE]
> If you interoperate with other components that have not implemented this same workaround, then you (or your end user) may get differing or confusing results.

Here is an example of some functions that may suit your purposes to do this. In this case, you would call `MyVariantChangeType(Ex)` instead of `VariantChangeType(Ex)` in your code. And replace any direct calls to `VarI8FromCy` with calls to `MyVarI8FromCy` instead:

```cpp
STDAPI MyVarI8FromCy( CY cyIn, __int64 * pi64Out )
{
   LONG64 lVal = cyIn.int64 / 10000;
   LONG64 lDif = cyIn.int64 % 10000;

   if ( lDif + (lVal & 1) > 5000 ) // IEEE rounding
   {
      if ( cyIn.Hi >= 0 )
         lVal++;
      else
         lVal--;
   }
   *pi64Out = lVal;
   return NOERROR;
}

STDAPI MyVariantChangeType( VARIANTARG * pvargDest, VARIANTARG * pvargSrc,
                           unsigned short wFlags, VARTYPE vt )
{
   return MyVariantChangeTypeEx( pvargDest, pvargSrc, LOCALE_USER_DEFAULT, wFlags, vt );
}

STDAPI MyVariantChangeTypeEx( VARIANTARG * pvargDest, const VARIANTARG * pvargSrc, LCID lcid,
                              unsigned short wFlags, VARTYPE vt )
{
   HRESULT hResult = E_FAIL;

   if ( ( vt == VT_I8 )
      && ( V_VT(pvargSrc) == VT_CY )
      )
      hResult = MyVarI8FromCy( pvargSrc->cyVal, &pvargDest->llVal );
   else
      hResult = VariantChangeTypeEx( pvargDest, pvargSrc, lcid, wFlags, vt );
   return hResult;
}
```

## More information

Although this bug is known, there is evidence that applications have taken dependencies on this errant behavior, and therefore to change it now would cause these applications to break.

Some may be confused by the (lVal & 1) term in the code above. This is part of the IEEE standard for rounding, which provides that fractions that are exactly **.5** get rounded up when the integer portion is odd, but rounded down if the integer portion is even.
