{-------------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
the specific language governing rights and limitations under the License.

Code template generated with SynGen.
The original code is: Lua.pas, released 2004-10-27.
Description: Lua Syntax Parser/Highlighter
The initial author of this file is Jean-Franois Goulet.
Copyright (c) 2004, all rights reserved.

Contributors to the SynEdit and mwEdit projects are listed in the
Contributors.txt file.

Alternatively, the contents of this file may be used under the terms of the
GNU General Public License Version 2 or later (the "GPL"), in which case
the provisions of the GPL are applicable instead of those above.
If you wish to allow use of your version of this file only under the terms
of the GPL and not to allow others to use your version of this file
under the MPL, indicate your decision by deleting the provisions above and
replace them with the notice and other provisions required by the GPL.
If you do not delete the provisions above, a recipient may use your version
of this file under either the MPL or the GPL.

$Id: LuaSyntax.pas,v 1.1 2006/11/21 00:42:58 jfgoulet Exp $

You may retrieve the latest version of this file at the SynEdit home page,
located at http://SynEdit.SourceForge.net

-------------------------------------------------------------------------------}

unit LuaSyntax;


{$IFDEF FPC}
  {$MODE OBJFPC}
{$ENDIF}

{$DEFINE SYNEDIT_INCLUDE}

{$IFdef MSWindows}
  {$DEFINE SYN_WIN32}
{$ENDIF}

{$IFDEF VER130}
  {$DEFINE SYN_COMPILER_5}
  {$DEFINE SYN_DELPHI}
  {$DEFINE SYN_DELPHI_5}
{$ENDIF}

{$IFDEF VER125}
  {$DEFINE SYN_COMPILER_4}
  {$DEFINE SYN_CPPB}
  {$DEFINE SYN_CPPB_4}
{$ENDIF}

{$IFDEF VER120}
  {$DEFINE SYN_COMPILER_4}
  {$DEFINE SYN_DELPHI}
  {$DEFINE SYN_DELPHI_4}
{$ENDIF}

{$IFDEF VER110}
  {$DEFINE SYN_COMPILER_3}
  {$DEFINE SYN_CPPB}
  {$DEFINE SYN_CPPB_3}
{$ENDIF}

{$IFDEF VER100}
  {$DEFINE SYN_COMPILER_3}
  {$DEFINE SYN_DELPHI}
  {$DEFINE SYN_DELPHI_3}
{$ENDIF}

{$IFDEF VER93}
  {$DEFINE SYN_COMPILER_2}  { C++B v1 compiler is really v2 }
  {$DEFINE SYN_CPPB}
  {$DEFINE SYN_CPPB_1}
{$ENDIF}

{$IFDEF VER90}
  {$DEFINE SYN_COMPILER_2}
  {$DEFINE SYN_DELPHI}
  {$DEFINE SYN_DELPHI_2}
{$ENDIF}

{$IFDEF SYN_COMPILER_2}
  {$DEFINE SYN_COMPILER_1_UP}
  {$DEFINE SYN_COMPILER_2_UP}
{$ENDIF}

{$IFDEF SYN_COMPILER_3}
  {$DEFINE SYN_COMPILER_1_UP}
  {$DEFINE SYN_COMPILER_2_UP}
  {$DEFINE SYN_COMPILER_3_UP}
{$ENDIF}

{$IFDEF SYN_COMPILER_4}
  {$DEFINE SYN_COMPILER_1_UP}
  {$DEFINE SYN_COMPILER_2_UP}
  {$DEFINE SYN_COMPILER_3_UP}
  {$DEFINE SYN_COMPILER_4_UP}
{$ENDIF}

{$IFDEF SYN_COMPILER_5}
  {$DEFINE SYN_COMPILER_1_UP}
  {$DEFINE SYN_COMPILER_2_UP}
  {$DEFINE SYN_COMPILER_3_UP}
  {$DEFINE SYN_COMPILER_4_UP}
  {$DEFINE SYN_COMPILER_5_UP}
{$ENDIF}

{$IFDEF SYN_DELPHI_2}
  {$DEFINE SYN_DELPHI_2_UP}
{$ENDIF}

{$IFDEF SYN_DELPHI_3}
  {$DEFINE SYN_DELPHI_2_UP}
  {$DEFINE SYN_DELPHI_3_UP}
{$ENDIF}

{$IFDEF SYN_DELPHI_4}
  {$DEFINE SYN_DELPHI_2_UP}
  {$DEFINE SYN_DELPHI_3_UP}
  {$DEFINE SYN_DELPHI_4_UP}
{$ENDIF}

{$IFDEF SYN_DELPHI_5}
  {$DEFINE SYN_DELPHI_2_UP}
  {$DEFINE SYN_DELPHI_3_UP}
  {$DEFINE SYN_DELPHI_4_UP}
  {$DEFINE SYN_DELPHI_5_UP}
{$ENDIF}

{$IFDEF SYN_CPPB_3}
  {$DEFINE SYN_CPPB_3_UP}
{$ENDIF}

{$IFDEF SYN_COMPILER_3_UP}
  {$DEFINE SYN_NO_COM_CLEANUP}
{$ENDIF}

{$IFDEF SYN_CPPB_3_UP}
  // C++Builder requires this if you use Delphi components in run-time packages.
  {$ObjExportAll On}
{$ENDIF}

{$IFDEF FPC}
  {$DEFINE SYN_COMPILER_1_UP}
  {$DEFINE SYN_COMPILER_2_UP}
  {$DEFINE SYN_COMPILER_3_UP}
  {$DEFINE SYN_COMPILER_4_UP}
  {$DEFINE SYN_DELPHI_2_UP}
  {$DEFINE SYN_DELPHI_3_UP}
  {$DEFINE SYN_DELPHI_4_UP}
  {$DEFINE SYN_DELPHI_5_UP}
  {$DEFINE SYN_LAZARUS}
{$ENDIF}

{------------------------------------------------------------------------------}
{ Common compiler defines                                                      }
{------------------------------------------------------------------------------}

// defaults are short evaluation of boolean values and long strings

// lazarus change   no $B-
{$H+}

{------------------------------------------------------------------------------}
{ Please change this to suit your needs                                        }
{------------------------------------------------------------------------------}

// support for multibyte character sets
{$IFDEF SYN_COMPILER_3_UP}
{$IFNDEF SYN_LAZARUS}
{$DEFINE SYN_MBCSSUPPORT}
{$ENDIF}
{$ENDIF}

// additional tests for debugging

{.$DEFINE SYN_DEVELOPMENT_CHECKS}

{$IFDEF SYN_DEVELOPMENT_CHECKS}

{$R+,Q+,S+,T+}

{$ENDIF}

interface

uses
{$IFDEF SYN_CLX}
  QGraphics,
  QSynEditTypes,
  QSynEditHighlighter,
{$ELSE}
  Graphics,
  SynEditTypes,
  SynEditHighlighter,
{$ENDIF}
  SysUtils,
  Classes,
  StringHashList,
  SynEditHighlighterFoldBase,
  LCLType,
  Registry;

type
  TtkTokenKind = (
    tkComment,
    tkIdentifier,
    tkKey,
    tkLuaMString,
    tkNull,
    tkNumber,
    tkOctal,
    tkHex,
    tkFloat,
    tkSpace,
    tkString,
    tkInternalFunction,
    tkUnknown);

  TRangeState = (rsUnKnown, rsLuaComment, rsLuaMComment, rsLuaMString, rsString1, rsString2);

  TProcTableProc = procedure of object;

  PIdentFuncTableFunc = ^TIdentFuncTableFunc;
  TIdentFuncTableFunc = function: TtkTokenKind of object;

const
  MaxKey = 110;

type
  //TSynLuaSyn = class(TSynCustomHighlighter)
  TSynLuaSyn = class(TSynCustomFoldHighlighter)
  private
    FTokenPos, FTokenEnd: Integer;
    FLineText: String;

    StartCodeFold: boolean;
    EndCodeFold: boolean;

    //FCurRange: integer;
    fProcTable: array[#0..#255] of TProcTableProc;
    fRangeExtended: ptrUInt;
    fStringLen: Integer;
    fToIdent: PChar;
    fTokenID: TtkTokenKind;
    fIdentFuncTable: array[0 .. MaxKey] of TIdentFuncTableFunc;
    fCommentAttri: TSynHighlighterAttributes;
    fIdentifierAttri: TSynHighlighterAttributes;
    fKeyAttri: TSynHighlighterAttributes;
    fLuaMStringAttri: TSynHighlighterAttributes;
    fNumberAttri: TSynHighlighterAttributes;
    fHexAttri: TSynHighlighterAttributes;
    fSpaceAttri: TSynHighlighterAttributes;
    fStringAttri: TSynHighlighterAttributes;
    fInternalFunctionAttri: TSynHighlighterAttributes;
    function KeyHash(ToHash: PChar): Integer;
    function KeyComp(const aKey: string): Boolean;
    function Func17: TtkTokenKind;
    function Func21: TtkTokenKind;
    function Func22: TtkTokenKind;
    function Func25: TtkTokenKind;
    function Func26: TtkTokenKind;
    function Func35: TtkTokenKind;
    function Func38: TtkTokenKind;
    function Func42: TtkTokenKind;
    function Func45: TtkTokenKind;
    function Func48: TtkTokenKind;
    function Func51: TtkTokenKind;
    function Func52: TtkTokenKind;
    function Func57: TtkTokenKind;
    function Func61: TtkTokenKind;
    function Func62: TtkTokenKind;
    function Func67: TtkTokenKind;
    function Func68: TtkTokenKind;
    function Func70: TtkTokenKind;
    function Func71: TtkTokenKind;
    function Func81: TtkTokenKind;
    function Func82: TtkTokenKind;
    function Func102: TtkTokenKind;
    function Func110: TtkTokenKind;
    procedure IdentProc;
    procedure UnknownProc;
    function AltFunc: TtkTokenKind;
    procedure InitIdent;
    function IdentKind(MayBe: PChar): TtkTokenKind;
    procedure MakeMethodTables;
    procedure NullProc;
    procedure SpaceProc;
    procedure CRProc;
    procedure LFProc;
    procedure LuaCommentOpenProc;
    procedure LuaCommentProc;
    procedure LuaMCommentOpenProc;
    procedure LuaMCommentProc;
    procedure LuaMStringOpenProc;
    procedure LuaMStringProc;
    procedure String1OpenProc;
    procedure String1Proc;
    procedure String2OpenProc;
    procedure String2Proc;
    procedure NumberProc;
    function LongDelimCheck(aRun: integer): integer;
  protected
    function GetIdentChars: TSynIdentChars; override;
    function GetSampleSource: string; override;
    function IsFilterStored: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    {$IFNDEF SYN_CPPB_1} class {$ENDIF}
    function GetLanguageName: string; override;
    function GetRange: Pointer; override;
    procedure ResetRange; override;
    procedure SetRange(Value: Pointer); override;
    function GetDefaultAttribute(Index: integer): TSynHighlighterAttributes; override;
    function GetEol: Boolean; override;
    function GetKeyWords: string;
    function GetTokenID: TtkTokenKind;
    procedure SetLine(const NewValue: String; LineNumber: Integer); override;
    function GetToken: String; override;
    {$IFDEF SYN_LAZARUS}
    procedure GetTokenEx(out TokenStart: PChar; out TokenLength: integer); override;
    {$ENDIF}

    function GetTokenAttribute: TSynHighlighterAttributes; override;
    function GetTokenKind: integer; override;
    function GetTokenPos: Integer; override;

    function LoadFromRegistry(RootKey: HKEY; Key: string): boolean; override;


    procedure Next; override;
  published
    property CommentAttri: TSynHighlighterAttributes read fCommentAttri write fCommentAttri;
    property IdentifierAttri: TSynHighlighterAttributes read fIdentifierAttri write fIdentifierAttri;
    property KeyAttri: TSynHighlighterAttributes read fKeyAttri write fKeyAttri;
    property InternalFunctionAttri: TSynHighlighterAttributes read fInternalFunctionAttri write fInternalFunctionAttri;
    property LuaMStringAttri: TSynHighlighterAttributes read fLuaMStringAttri write fLuaMStringAttri;
    property NumberAttri: TSynHighlighterAttributes read fNumberAttri write fNumberAttri;
    property HexAttri: TSynHighlighterAttributes read fHexAttri write fHexAttri;
    property SpaceAttri: TSynHighlighterAttributes read fSpaceAttri write fSpaceAttri;
    property StringAttri: TSynHighlighterAttributes read fStringAttri write fStringAttri;
  end;

var luasyntaxStringHashList: TStringHashList;

implementation

uses
{$IFDEF SYN_CLX}
  QSynEditStrConst, math;
{$ELSE}
  SynEditStrConst, math;
{$ENDIF}

{$IFDEF SYN_COMPILER_3_UP}
resourcestring
{$ELSE}
const
{$ENDIF}
  SYNS_FilterLua = 'Lua Files (*.lua, *.lpr)|*.lua;*.lpr';
  SYNS_LangLua = 'Lua';
  SYNS_AttrLuaMString = 'Multiline String';
  SYNS_AttrNumber = 'Numbers';

var
  Identifiers: array[#0..#255] of ByteBool;
  mHashTable : array[#0..#255] of Integer;




procedure MakeIdentTable;
var
  I: Char;
begin
  for I := #0 to #255 do
  begin
    case I of
      '_', '0'..'9', 'a'..'z', 'A'..'Z': Identifiers[I] := True;
    else
      Identifiers[I] := False;
    end;
    case I in ['_', 'A'..'Z', 'a'..'z'] of
      True:
        begin
          if (I > #64) and (I < #91) then
            mHashTable[I] := Ord(I) - 64
          else if (I > #96) then
            mHashTable[I] := Ord(I) - 95;
        end;
    else
      mHashTable[I] := 0;
    end;
  end;
end;

procedure TSynLuaSyn.InitIdent;
var
  I: Integer;
  pF: PIdentFuncTableFunc;
begin
  pF := PIdentFuncTableFunc(@fIdentFuncTable);
  for I := Low(fIdentFuncTable) to High(fIdentFuncTable) do
  begin
    pF^ := {$IFDEF FPC}@{$ENDIF}AltFunc;
    Inc(pF);
  end;
  fIdentFuncTable[17] := {$IFDEF FPC}@{$ENDIF}Func17;
  fIdentFuncTable[21] := {$IFDEF FPC}@{$ENDIF}Func21;
  fIdentFuncTable[22] := {$IFDEF FPC}@{$ENDIF}Func22;
  fIdentFuncTable[25] := {$IFDEF FPC}@{$ENDIF}Func25;
  fIdentFuncTable[26] := {$IFDEF FPC}@{$ENDIF}Func26;
  fIdentFuncTable[35] := {$IFDEF FPC}@{$ENDIF}Func35;
  fIdentFuncTable[38] := {$IFDEF FPC}@{$ENDIF}Func38;
  fIdentFuncTable[42] := {$IFDEF FPC}@{$ENDIF}Func42;
  fIdentFuncTable[45] := {$IFDEF FPC}@{$ENDIF}Func45;
  fIdentFuncTable[48] := {$IFDEF FPC}@{$ENDIF}Func48;
  fIdentFuncTable[51] := {$IFDEF FPC}@{$ENDIF}Func51;
  fIdentFuncTable[52] := {$IFDEF FPC}@{$ENDIF}Func52;
  fIdentFuncTable[57] := {$IFDEF FPC}@{$ENDIF}Func57;
  fIdentFuncTable[61] := {$IFDEF FPC}@{$ENDIF}Func61;
  fIdentFuncTable[62] := {$IFDEF FPC}@{$ENDIF}Func62;
  fIdentFuncTable[67] := {$IFDEF FPC}@{$ENDIF}Func67;
  fIdentFuncTable[68] := {$IFDEF FPC}@{$ENDIF}Func68;
  fIdentFuncTable[70] := {$IFDEF FPC}@{$ENDIF}Func70;
  fIdentFuncTable[71] := {$IFDEF FPC}@{$ENDIF}Func71;
  fIdentFuncTable[81] := {$IFDEF FPC}@{$ENDIF}Func81;
  fIdentFuncTable[82] := {$IFDEF FPC}@{$ENDIF}Func82;
  fIdentFuncTable[102] := {$IFDEF FPC}@{$ENDIF}Func102;
  fIdentFuncTable[110] := {$IFDEF FPC}@{$ENDIF}Func110;
end;

function TSynLuaSyn.KeyHash(ToHash: PChar): Integer;
begin
  Result := 0;
  while ToHash^ in ['_', 'a'..'z', 'A'..'Z'] do
  begin
    inc(Result, mHashTable[ToHash^]);
    inc(ToHash);
  end;
  fStringLen := ToHash - fToIdent;
end;

function TSynLuaSyn.KeyComp(const aKey: String): Boolean;
var
  I: Integer;
  Temp: PChar;
begin
  Temp := fToIdent;
  if Length(aKey) = fStringLen then
  begin
    Result := True;
    for i := 1 to fStringLen do
    begin
      if Temp^ <> aKey[i] then
      begin
        Result := False;
        break;
      end;
      inc(Temp);
    end;
  end else Result := False;
end;

function TSynLuaSyn.Func17: TtkTokenKind;
begin
  if KeyComp('if') then
  begin
    StartCodeFold:=true;
    Result := tkKey;
  end
  else Result := tkIdentifier;

end;

function TSynLuaSyn.Func21: TtkTokenKind;
begin
  if KeyComp('do') then
  begin
    StartCodeFold:=true;
    Result := tkKey;
  end
  else Result := tkIdentifier;

end;

function TSynLuaSyn.Func22: TtkTokenKind;
begin
  if KeyComp('and') then Result := tkKey else Result := tkIdentifier;
end;

function TSynLuaSyn.Func25: TtkTokenKind;
begin
  if KeyComp('in') then Result := tkKey else Result := tkIdentifier;
end;

function TSynLuaSyn.Func26: TtkTokenKind;
begin
  if KeyComp('end') then
  begin
    EndCodeFold:=true;
    Result := tkKey;
   end
  else Result := tkIdentifier;

end;

function TSynLuaSyn.Func35: TtkTokenKind;
begin
  if KeyComp('or') then Result := tkKey else Result := tkIdentifier;
end;

function TSynLuaSyn.Func38: TtkTokenKind;
begin
  if KeyComp('nil') then Result := tkKey else Result := tkIdentifier;
end;

function TSynLuaSyn.Func42: TtkTokenKind;
begin
  if KeyComp('for') then Result := tkKey else
    if KeyComp('break') then Result := tkKey else Result := tkIdentifier;
end;

function TSynLuaSyn.Func45: TtkTokenKind;
begin
  if KeyComp('else') then Result := tkKey else Result := tkIdentifier;
end;

function TSynLuaSyn.Func48: TtkTokenKind;
begin
  if KeyComp('local') then Result := tkKey else
    if KeyComp('false') then Result := tkKey else Result := tkIdentifier;
end;

function TSynLuaSyn.Func51: TtkTokenKind;
begin
  if KeyComp('then') then Result := tkKey else Result := tkIdentifier;
end;

function TSynLuaSyn.Func52: TtkTokenKind;
begin
  if KeyComp('not') then Result := tkKey else Result := tkIdentifier;
end;

function TSynLuaSyn.Func57: TtkTokenKind;
begin
  if KeyComp('loaddll') then Result := tkIdentifier else Result := tkIdentifier;
end;

function TSynLuaSyn.Func61: TtkTokenKind;
begin
  if KeyComp('asd') then Result := tkIdentifier else Result := tkIdentifier;
end;

function TSynLuaSyn.Func62: TtkTokenKind;
begin
  if KeyComp('while') then Result := tkKey else
    if KeyComp('print') then Result := tkIdentifier else
      if KeyComp('elseif') then Result := tkKey else Result := tkIdentifier;
end;

function TSynLuaSyn.Func67: TtkTokenKind;
begin
  if KeyComp('asd') then Result := tkIdentifier else Result := tkIdentifier;
end;

function TSynLuaSyn.Func68: TtkTokenKind;
begin
  if KeyComp('true') then Result := tkKey else Result := tkIdentifier;
end;

function TSynLuaSyn.Func70: TtkTokenKind;
begin
  if KeyComp('asd') then Result := tkIdentifier else
    if KeyComp('asd') then Result := tkIdentifier else
      if KeyComp('dofile') then Result := tkIdentifier else Result := tkIdentifier;
end;

function TSynLuaSyn.Func71: TtkTokenKind;
begin
  if KeyComp('repeat') then
  begin
    Result := tkKey;
    StartCodeFold:=true;
  end
  else Result := tkIdentifier;
end;

function TSynLuaSyn.Func81: TtkTokenKind;
begin
  if KeyComp('until') then
  begin
    Result := tkKey;
    EndCodeFold:=true;
  end
  else Result := tkIdentifier;
end;

function TSynLuaSyn.Func82: TtkTokenKind;
begin
  if KeyComp('asd') then Result := tkIdentifier else
    if KeyComp('asd') then Result := tkIdentifier else
      if KeyComp('beep') then Result := tkIdentifier else Result := tkIdentifier;
end;

function TSynLuaSyn.Func102: TtkTokenKind;
begin
  if KeyComp('return') then Result := tkKey else Result := tkIdentifier;
end;

function TSynLuaSyn.Func110: TtkTokenKind;
begin
  if KeyComp('function') then
  begin
    Result := tkKey;
    StartCodeFold:=true;

  end
  else Result := tkIdentifier;
end;

function TSynLuaSyn.AltFunc: TtkTokenKind;
begin
  Result := tkIdentifier;
end;

function TSynLuaSyn.IdentKind(MayBe: PChar): TtkTokenKind;
var
  HashKey: Integer;
begin
  fToIdent := MayBe;
  HashKey := KeyHash(MayBe);
  if HashKey <= MaxKey then
    Result := fIdentFuncTable[HashKey]{$IFDEF FPC}(){$ENDIF}
  else
    Result := tkIdentifier;

  if result=tkIdentifier then
  begin
    if luasyntaxStringHashList.Find(copy(maybe, 1,fstringLen))<>-1 then
      result:=tkInternalFunction;
  end;
end;

procedure TSynLuaSyn.MakeMethodTables;
var
  I: Char;
begin
  for I := #0 to #255 do
    case I of
      #0: fProcTable[I] := {$IFDEF FPC}@{$ENDIF}NullProc;
      #10: fProcTable[I] := {$IFDEF FPC}@{$ENDIF}LFProc;
      #13: fProcTable[I] := {$IFDEF FPC}@{$ENDIF}CRProc;
      '-': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}LuaCommentOpenProc;
      '[': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}LuaMStringOpenProc;
      '"': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}String1OpenProc;
      '''': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}String2OpenProc;
      #1..#9, #11, #12, #14..#32 : fProcTable[I] := {$IFDEF FPC}@{$ENDIF}SpaceProc;
      '0'..'9': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}NumberProc;
      'A'..'Z', 'a'..'z', '_': fProcTable[I] := {$IFDEF FPC}@{$ENDIF}IdentProc;
    else
      fProcTable[I] := {$IFDEF FPC}@{$ENDIF}UnknownProc;
    end;
end;

procedure TSynLuaSyn.SpaceProc;
begin
  fTokenID := tkSpace;
  repeat
    inc(FTokenEnd);
    if fTokenEnd>length(FLineText) then break;

  until (not (FLineText[FTokenEnd] in [#1..#32]));
end;

procedure TSynLuaSyn.NullProc;
begin
  fTokenID := tkNull;
end;

procedure TSynLuaSyn.CRProc;
begin
  fTokenID := tkSpace;
  inc(FTokenEnd);
  if FLineText[FTokenEnd] = #10 then
    inc(FTokenEnd);
end;

procedure TSynLuaSyn.LFProc;
begin
  fTokenID := tkSpace;
  inc(FTokenEnd);
end;

function TSynLuaSyn.LongDelimCheck(aRun: integer): integer;
var
  sep: integer;
begin
  sep:=1;
  while ((aRun+sep)<length(FLineText)) and (FLineText[aRun+sep]='=') and (sep<255) do Inc(sep);
  if ((aRun+sep)<=length(FLineText)) and (FLineText[aRun]=FLineText[aRun+Sep]) then exit(sep);
  result:=0;
end;

procedure TSynLuaSyn.LuaCommentOpenProc;
var sep: Integer;
begin
  Inc(FTokenEnd);
  //check for --[ or --

  if FTokenEnd>length(FLineText) then
  begin
    fTokenID := tkIdentifier;
    exit;
  end;

  if (length(FLineText)>FtokenEnd+1) and (FLineText[FTokenEnd] = '-') and
     (FLineText[FTokenEnd + 1] = '[') then
  begin
    sep:=LongDelimCheck(FTokenEnd+1);
    if sep>0 then
    begin
      Inc(FTokenEnd, sep + 2);
      fRangeExtended := PtrUInt(rsLuaMComment)+10*sep;
      StartCodeFoldBlock;

      LuaMCommentOpenProc;
      exit;
    end;
  end;

  if (FTokenEnd<length(flinetext)) and (FLineText[FTokenEnd] = '-') then   //--
  begin
    fRangeExtended := PtrUInt(0);
    LuaCommentProc;
    fTokenID := tkComment;
  end
  else
    fTokenID := tkIdentifier;
end;

procedure TSynLuaSyn.LuaCommentProc;
begin
  fTokenID := tkComment;

  FTokenEnd:=length(FLineText)+1;

  fRangeExtended:=0;
end;

procedure TSynLuaSyn.LuaMCommentOpenProc;
begin
  LuaMCommentProc;
  fTokenID := tkComment;
end;

procedure TSynLuaSyn.LuaMCommentProc;
var sep,tmp: Integer;
begin
  if FTokenEnd>length(flinetext) then exit;

  case FLineText[FTokenEnd] of
     #0: NullProc;
    #10: LFProc;
    #13: CRProc;
  else
    begin
      fTokenID := tkComment;
      repeat
        if (FLineText[FTokenEnd] = ']') then
        begin
          sep:=LongDelimCheck(FTokenEnd);
          if (sep>0) and (sep=(fRangeExtended div 10)) then
          begin
            tmp:=FTokenPos;
            FTokenPos:=FTokenEnd;
            Inc(FTokenEnd, sep + 1);
            fRangeExtended := PtrUInt(rsUnKnown);

            EndCodeFoldBlock;
            FTokenPos:=tmp;


            Break;
          end;
        end;
        Inc(FTokenEnd);
      until FTokenEnd>length(FLineText);
    end;
  end;
end;

procedure TSynLuaSyn.LuaMStringOpenProc;
var sep: Integer;
begin
  Inc(FTokenEnd);
  sep:=LongDelimCheck(FTokenEnd-1);
  if sep>0 then
  begin
    Inc(FTokenEnd, sep);
    fRangeExtended := ptrUInt(rsLuaMString)+10*sep;
    StartCodeFoldBlock;

    LuaMStringProc;
    fTokenID := tkLuaMString;
  end
  else
    fTokenID := tkIdentifier;
end;

procedure TSynLuaSyn.LuaMStringProc;
var sep,tmp: Integer;
begin
  if FTokenEnd>length(FLineText) then exit;

  case FLineText[FTokenEnd] of
     #0: NullProc;
    #10: LFProc;
    #13: CRProc;
  else
    begin
      fTokenID := tkLuaMString;
      repeat
        if (FLineText[FTokenEnd] = ']') then
        begin
          sep:=LongDelimCheck(FTokenEnd);
          if (sep>0) and (sep=(fRangeExtended div 10)) then
          begin
            tmp:=FTokenPos;
            FTokenPos:=FTokenEnd;
            Inc(FTokenEnd, sep + 1);
            fRangeExtended := PtrUInt(rsUnKnown);

            EndCodeFoldBlock;
            FTokenPos:=tmp;


            Break;
          end;
        end;
        Inc(FTokenEnd);
      until FTokenEnd>=length(FLineText)
    end;
  end;
end;

procedure TSynLuaSyn.NumberProc;
var
  idx1: Integer; // token[1]
  i: Integer;
begin
  idx1 := FTokenEnd;
  Inc(FTokenEnd);
  fTokenID := tkNumber;
  while (FTokenEnd<=length(FLineText)) and (FLineText[FTokenEnd] in
    ['0'..'9', 'A'..'F', 'a'..'f', '.', 'u', 'U', 'l', 'L', 'x', 'X', '-', '+']) do
  begin
    case FLineText[FTokenEnd] of
      '.':
        if (FTokenEnd<Length(FLineText)) and (FLineText[Succ(FTokenEnd)] = '.') then
          Break
        else
          if (fTokenID <> tkHex) then
            fTokenID := tkFloat
          else // invalid
          begin
            fTokenID := tkUnknown;
            Exit;
          end;
      '-', '+':
        begin
          if fTokenID <> tkFloat then // number <> float. an arithmetic operator
            Exit;
          if not (FLineText[Pred(FTokenEnd)] in ['e', 'E']) then
            Exit; // number = float, but no exponent. an arithmetic operator
          if (FTokenEnd<Length(FLineText)) and (not (FLineText[Succ(FTokenEnd)] in ['0'..'9', '+', '-'])) then // invalid
          begin
            Inc(FTokenEnd);
            fTokenID := tkUnknown;
            Exit;
          end
        end;
      '0'..'7':
        if (FTokenEnd = Succ(idx1)) and (FLineText[idx1] = '0') then // octal number
          fTokenID := tkNumber; // Jean-Franois Goulet - Changed for token Number because token Octal was plain text and cannot be modified...
      '8', '9':
        if (FLineText[idx1] = '0') and
           ((fTokenID <> tkHex) and (fTokenID <> tkFloat)) then // invalid octal char
             fTokenID := tkUnknown;
      'a'..'d', 'A'..'D':
        if fTokenID <> tkHex then // invalid char
          Break;
      'e', 'E':
        if (fTokenID <> tkHex) then
          if FLineText[Pred(FTokenEnd)] in ['0'..'9'] then // exponent
          begin
            for i := idx1 to Pred(FTokenEnd) do
              if FLineText[i] in ['e', 'E'] then // too many exponents
              begin
                fTokenID := tkUnknown;
                Exit;
              end;
            if (FTokenEnd<Length(FLineText)) and (not (FLineText[Succ(FTokenEnd)] in ['0'..'9', '+', '-'])) then
              Break
            else
              fTokenID := tkFloat
          end
          else // invalid char
            Break;
      'f', 'F':
        if fTokenID <> tkHex then
        begin
          for i := idx1 to Pred(FTokenEnd) do
            if FLineText[i] in ['f', 'F'] then // declaration syntax error
            begin
              fTokenID := tkUnknown;
              Exit;
            end;
          if fTokenID = tkFloat then
          begin
            if FLineText[Pred(FTokenEnd)] in ['l', 'L'] then // can't mix
              Break;
          end
          else
            fTokenID := tkFloat;
        end;
      'l', 'L':
        begin
          for i := idx1 to Pred(FTokenEnd) do
            if FLineText[i] in ['l', 'L'] then // declaration syntax error
            begin
              fTokenID := tkUnknown;
              Exit;
            end;
          if fTokenID = tkFloat then
            if FLineText[Pred(FTokenEnd)] in ['f', 'F'] then // can't mix
              Break;
        end;
      'u', 'U':
        if fTokenID = tkFloat then // not allowed
          Break
        else
          for i := idx1 to Pred(FTokenEnd) do
            if FLineText[i] in ['u', 'U'] then // declaration syntax error
            begin
              fTokenID := tkUnknown;
              Exit;
            end;
      'x', 'X':
        if (FTokenEnd<length(FLineText)) and (FTokenEnd = Succ(idx1)) and   // 0x... 'x' must be second char
           (FLineText[idx1] = '0') and  // 0x...
           (FLineText[Succ(FTokenEnd)] in ['0'..'9', 'a'..'f', 'A'..'F']) then // 0x... must be continued with a number
             fTokenID := tkHex
           else // invalid char
           begin
             if (FTokenEnd<length(FLineText)) and (not Identifiers[FLineText[Succ(FTokenEnd)]]) and
                (FLineText[Succ(idx1)] in ['x', 'X']) then
             begin
               Inc(FTokenEnd); // highlight 'x' too
               fTokenID := tkUnknown;
             end;
             Break;
           end;
    end; // case
    Inc(FTokenEnd);
  end; // while
  if (FTokenEnd<=length(FlineText)) and (FLineText[FTokenEnd] in ['A'..'Z', 'a'..'z', '_']) then
    fTokenID := tkUnknown;
end;

procedure TSynLuaSyn.String1OpenProc;
begin
  Inc(FTokenEnd);
  fRangeExtended := PtrUInt(rsString1);
  String1Proc;
  fTokenID := tkString;
end;

procedure TSynLuaSyn.String1Proc;
begin
  fTokenID := tkString;
  repeat

    if (FTokenEnd<=length(FLineText)) and (((FLineText[FTokenEnd] = '"') and (FLineText[FTokenEnd - 1] <> '\')) or ((FLineText[FTokenEnd - 1] = '\') and (FLineText[FTokenEnd - 2] = '\') and (FLineText[FTokenEnd] = '"'))) then
    begin
      Inc(FTokenEnd, 1);
      fRangeExtended := PtrUInt(rsUnKnown);
      Break;
    end;
    Inc(FTokenEnd);
  until ftokenend>length(flinetext);
end;

procedure TSynLuaSyn.String2OpenProc;
begin
  Inc(FTokenEnd);
  fRangeExtended := PtrUInt(rsString2);
  String2Proc;
  fTokenID := tkString;
end;

procedure TSynLuaSyn.String2Proc;
begin
  fTokenID := tkString;
  repeat

    if (ftokenEnd<length(FLineText)) and (FLineText[FTokenEnd] = '''') then
    begin
      Inc(FTokenEnd, 1);
      fRangeExtended := PtrUInt(rsUnKnown);
      Break;
    end;
    Inc(FTokenEnd);
  until FTokenEnd>length(FLineText);
end;

constructor TSynLuaSyn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fCommentAttri := TSynHighLighterAttributes.Create(SYNS_AttrComment);
  fCommentAttri.Style := [fsItalic];
  fCommentAttri.Foreground := clGray;
  AddAttribute(fCommentAttri);

  fIdentifierAttri := TSynHighLighterAttributes.Create(SYNS_AttrIdentifier);
  AddAttribute(fIdentifierAttri);

  fKeyAttri := TSynHighLighterAttributes.Create(SYNS_AttrReservedWord);
  fKeyAttri.Style := [fsBold];
  fKeyAttri.Foreground:=clBlue;
  AddAttribute(fKeyAttri);

  fInternalFunctionAttri := TSynHighLighterAttributes.Create(SYNS_AttrInternalFunction);
  fInternalFunctionAttri.Style := [fsBold];
  fInternalFunctionAttri.Foreground:=$c08000;
  fInternalFunctionAttri.Background:=$eeeeee;
  AddAttribute(fInternalFunctionAttri);

  fLuaMStringAttri := TSynHighLighterAttributes.Create(SYNS_AttrLuaMString);
  fLuaMStringAttri.Foreground := $0000ff;
  AddAttribute(fLuaMStringAttri);

  fNumberAttri := TSynHighLighterAttributes.Create(SYNS_AttrNumber);
  fNumberAttri.Foreground := $f00000;
  AddAttribute(fNumberAttri);

  fHexAttri := TSynHighLighterAttributes.Create(SYNS_AttrHexadecimal);
  fHexAttri.Foreground := $708f00;
  AddAttribute(fHexAttri);

  fSpaceAttri := TSynHighLighterAttributes.Create(SYNS_AttrSpace);
  AddAttribute(fSpaceAttri);

  fStringAttri := TSynHighLighterAttributes.Create(SYNS_AttrString);
  fStringAttri.Foreground := $0505e0;
  AddAttribute(fStringAttri);

  SetAttributesOnChange({$IFDEF FPC}@{$ENDIF}DefHighlightChange);
  InitIdent;
  MakeMethodTables;
  fDefaultFilter := SYNS_FilterLua;
  fRangeExtended := ptrUInt(rsUnknown);
end;

procedure TSynLuaSyn.SetLine(const NewValue: String; LineNumber: Integer);
begin
  inherited;
  FLineText := NewValue;
  // Next will start at "FTokenEnd", so set this to 1
  FTokenEnd := 1;
  Next;
end;

procedure TSynLuaSyn.IdentProc;
begin
  fTokenID := IdentKind(@FLineText[FTokenEnd]);
  inc(FTokenEnd, fStringLen);
  while (FTokenEnd<length(FLineText)) and Identifiers[FLineText[FTokenEnd]] do
    Inc(FTokenEnd);
end;

procedure TSynLuaSyn.UnknownProc;
begin
{$IFDEF SYN_MBCSSUPPORT}
  if FLine[Run] in LeadBytes then
    Inc(Run,2)
  else
{$ENDIF}
  if ord(FLineText[FTokenEnd])>$80 then
    inc(FTokenEnd,2)
  else
    inc(FTokenEnd);

  fTokenID := tkUnknown;
end;

procedure TSynLuaSyn.Next;
var
  l: Integer;

  s: string;
begin
  ftokenid:=tkNull;
  StartCodeFold:=false;
  EndCodeFold:=false;

  FTokenPos := FTokenEnd;
  // assume empty, will only happen for EOL
  FTokenEnd := FTokenPos;

  l := length(FLineText);
  If FTokenPos > l then
    // At line end
    exit
  else

  case TRangeState(fRangeExtended mod 10) of
    rsLuaMComment: LuaMCommentProc;
    rsLuaMString: LuaMStringProc;
  else
    begin
      fRangeExtended := PtrUInt(rsUnknown);
      fProcTable[FLineText[FTokenEnd]];
    end;
  end;

  if startcodefold then
    StartCodeFoldBlock;

  if EndCodeFold then
    EndCodeFoldBlock;

        {
  if (copy(FLineText, FTokenPos, FTokenEnd - FTokenPos) = 'if') then
    StartCodeFoldBlock;
  if (copy(FLineText, FTokenPos, FTokenEnd - FTokenPos) = 'do') then
    StartCodeFoldBlock;
  if (copy(FLineText, FTokenPos, FTokenEnd - FTokenPos) = 'function') then
    StartCodeFoldBlock;
  if (copy(FLineText, FTokenPos, FTokenEnd - FTokenPos) = 'end') then
    EndCodeFoldBlock;



  if (copy(FLineText, FTokenPos, FTokenEnd - FTokenPos) = 'repeat') then
    StartCodeFoldBlock;

  if (copy(FLineText, FTokenPos, FTokenEnd - FTokenPos) = 'until') then
    EndCodeFoldBlock;   }


end;

function TSynLuaSyn.GetDefaultAttribute(Index: integer): TSynHighLighterAttributes;
begin
  case Index of
    SYN_ATTR_COMMENT    : Result := fCommentAttri;
    SYN_ATTR_IDENTIFIER : Result := fIdentifierAttri;
    SYN_ATTR_KEYWORD    : Result := fKeyAttri;
    SYN_ATTR_STRING     : Result := fStringAttri;
    SYN_ATTR_WHITESPACE : Result := fSpaceAttri;
  else
    Result := nil;
  end;
end;

function TSynLuaSyn.GetEol: Boolean;
begin
  Result := FTokenPos > length(FLineText);
end;

function TSynLuaSyn.GetKeyWords: string;
begin
  Result :=
    'and,break,do,dofile,else,elseif,end,exit,false,for,function,if,in,loa' +
    'ddll,local,nil,not,or,print,repeat,return,Sleep,then,true,type,until,w' +
    'hile';
end;

function TSynLuaSyn.GetToken: String;
begin
  Result := copy(FLineText, FTokenPos, FTokenEnd - FTokenPos);
end;

{$IFDEF SYN_LAZARUS}
procedure TSynLuaSyn.GetTokenEx(out TokenStart: PChar;
  out TokenLength: integer);
begin
  TokenStart := @FLineText[FTokenPos];
  TokenLength := FTokenEnd - FTokenPos;
end;
{$ENDIF}

function TSynLuaSyn.GetTokenID: TtkTokenKind;
begin
  Result := fTokenId;
end;

function TSynLuaSyn.GetTokenAttribute: TSynHighLighterAttributes;
begin
  case GetTokenID of
    tkComment: Result := fCommentAttri;
    tkIdentifier: Result := fIdentifierAttri;
    tkKey: Result := fKeyAttri;
    tkLuaMString: Result := fLuaMStringAttri;
    tkNumber, tkFloat: Result := fNumberAttri;
    tkHex: result := fHexAttri;
    tkSpace: Result := fSpaceAttri;
    tkString: Result := fStringAttri;
    tkInternalFunction: result:= fInternalFunctionAttri;
    tkUnknown: Result := fIdentifierAttri;
  else
    Result := nil;
  end;
end;

function TSynLuaSyn.GetTokenKind: integer;
begin
  Result := Ord(fTokenId);
end;

function TSynLuaSyn.GetTokenPos: Integer;
begin
  Result := FTokenPos - 1;
end;

function TSynLuaSyn.GetIdentChars: TSynIdentChars;
begin
  Result := ['_', 'a'..'z', 'A'..'Z'];
end;

function TSynLuaSyn.GetSampleSource: string;
begin
  Result := 'Sample source for: '#13#10 +
            'Lua Syntax Parser/Highlighter';
end;

function TSynLuaSyn.IsFilterStored: Boolean;
begin
  Result := fDefaultFilter <> SYNS_FilterLua;
end;

{$IFNDEF SYN_CPPB_1} class {$ENDIF}
function TSynLuaSyn.GetLanguageName: string;
begin
  Result := SYNS_LangLua;
end;

procedure TSynLuaSyn.ResetRange;
begin
  //
  inherited ResetRange;
//  FCurRange := 0;
  fRangeExtended := PtrUInt(rsUnknown);
end;

procedure TSynLuaSyn.SetRange(Value: Pointer);
begin
  inherited SetRange(Value);
  fRangeExtended := PtrInt(CodeFoldRange.RangeType);

end;

function TSynLuaSyn.GetRange: Pointer;
begin
  //Result := Pointer(fRangeExtended);
  CodeFoldRange.RangeType := Pointer(PtrInt(fRangeExtended));

  result:=inherited GetRange;

  if fRangeExtended<>0 then
  asm
  nop
  end;


end;

function TSynLuaSyn.LoadFromRegistry(RootKey: HKEY; Key: string): boolean;
var
  reg: TRegistry;
  i: integer;
begin
  reg:=tregistry.create;
  reg.RootKey:=Rootkey;
  result:=false;
  if reg.OpenKey(Key,false) then
  begin
    result:=true;
    for i:=0 to AttrCount-1 do
      result:=result and Attribute[i].LoadFromRegistry(reg);
  end;

  reg.free;

  DefHighlightChange(self);
end;


initialization
  MakeIdentTable;
  luasyntaxStringHashList:=TStringHashList.Create(true);

{$IFNDEF SYN_CPPB_1}
  RegisterPlaceableHighlighter(TSynLuaSyn);
{$ENDIF}

finalization
  freeandnil(luasyntaxStringHashList);

end.

