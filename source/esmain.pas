unit esMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, SynEdit, SynHighlighterXML, Forms, Controls,
  Graphics, Dialogs, StdCtrls, ExtCtrls, Grids, ComCtrls, Types,
  Buttons, ActnList, Menus,
  fpeMetaData, fpeGlobal, fpeTags, fpeExifData, fpeIPTCData,
  mruManager,
  mpHexEditor;

type
  TBytes = array[0..MaxInt div SizeOf(Byte) - 1] of Byte;
  PBytes = ^TBytes;

  THexEditor = class(TMPHexEditor)
  public
    property DataStorage;
  end;


  { TMainForm }

  TMainForm = class(TForm)
    AcImgFit: TAction;
    AcGotoIFD0: TAction;
    AcGotoIFD1: TAction;
    AcGotoExifSubIFD: TAction;
    AcGotoTIFFHeader: TAction;
    AcGotoGPSSubIFD: TAction;
    AcGotoInteropSubIFD: TAction;
    AcFileOpen: TAction;
    AcFileQuit: TAction;
    AcFileReload: TAction;
    AcHelpAbout: TAction;
    AcCfgUseFPExif: TAction;
    AcGotoIPTC: TAction;
    AcGotoICCProfile: TAction;
    AcGotoXMP: TAction;
    ActionList: TActionList;
    cbHexAddressMode: TCheckBox;
    cbHexSingleBytes: TCheckBox;
    Image: TImage;
    ImageList: TImageList;
    AnalysisInfo: TLabel;
    MainMenu: TMainMenu;
    MainPageControl: TPageControl;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MnuIPTC: TMenuItem;
    MnuCfgUseDExif: TMenuItem;
    MnuCfg: TMenuItem;
    MnuTIFF: TMenuItem;
    MnuFileSeparator1: TMenuItem;
    MnuHelpAbout: TMenuItem;
    MnuHelp: TMenuItem;
    MnuFileOpen: TMenuItem;
    MnuFileQuit: TMenuItem;
    MnuFileSeparator2: TMenuItem;
    MenuItem13: TMenuItem;
    MnuFileReload: TMenuItem;
    MnuMostRecentlyUsed: TMenuItem;
    MnuIFD0: TMenuItem;
    MnuIFD1: TMenuItem;
    MnuEXIF: TMenuItem;
    MnuIFDSeparator2: TMenuItem;
    MnuGPS: TMenuItem;
    MnuInterOp: TMenuItem;
    MnuIFDSeparator1: TMenuItem;
    MnuFile: TMenuItem;
    AnalysisNotebook: TNotebook;
    OpenDialog: TOpenDialog;
    HexPageControl: TPageControl;
    fpExifPageControl: TPageControl;
    PgGrid: TPage;
    PgSynEdit: TPage;
    Panel2: TPanel;
    HexPanel: TPanel;
    PgHex: TTabSheet;
    APP1Popup: TPopupMenu;
    APP13Popup: TPopupMenu;
    App2Popup: TPopupMenu;
    RecentFilesPopup: TPopupMenu;
    ScrollBox: TScrollBox;
    HexSplitter: TSplitter;
    StatusBar: TStatusBar;
    AnalysisGrid: TStringGrid;
    PgImage: TTabSheet;
    fpExifPage: TTabSheet;
    fpExifGridPage: TTabSheet;
    IPTCGridPage: TTabSheet;
    IPTCGrid: TStringGrid;
    ExifGrid: TStringGrid;
    AnalysisSynEdit: TSynEdit;
    TbGotoSOF1: TToolButton;
    TbGotoSOF2: TToolButton;
    TbGotoSOF3: TToolButton;
    TbGotoSOF5: TToolButton;
    TbGotoDHT: TToolButton;
    TbGotoSOF6: TToolButton;
    TbGotoSOF7: TToolButton;
    TbGotoJPG: TToolButton;
    TbGotoSOF9: TToolButton;
    TbGotoSOF10: TToolButton;
    TbGotoSOF11: TToolButton;
    TbGotoSOF13: TToolButton;
    TbGotoSOF14: TToolButton;
    TbGotoSOF15: TToolButton;
    TbGotoDAC: TToolButton;
    TbGotoDQT: TToolButton;
    MainToolBar: TToolBar;
    TbGotoAPP13: TToolButton;
    ToolButton10: TToolButton;
    TbNextSegment: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    SynXMLSyn: TSynXMLSyn;
    PgAnalysis: TTabSheet;
    PgConverter: TTabSheet;
    HexToolBar: TToolBar;
    TbGotoSOI: TToolButton;
    TbGotoSOF0: TToolButton;
    TbGotoAPP0: TToolButton;
    TbGotoAPP1: TToolButton;
    TbGotoAPP2: TToolButton;
    TbGotoEOI: TToolButton;
    TbGotoCOM: TToolButton;
    TbGotoSOS: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ValueGrid: TStringGrid;
    procedure AcCfgUseFPExifExecute(Sender: TObject);
    procedure AcFileOpenExecute(Sender: TObject);
    procedure AcFileQuitExecute(Sender: TObject);
    procedure AcFileReloadExecute(Sender: TObject);
    procedure AcGotoICCProfileExecute(Sender: TObject);
    procedure AcGotoIPTCExecute(Sender: TObject);
    procedure AcGotoXMPExecute(Sender: TObject);
    procedure AcHelpAboutExecute(Sender: TObject);
    procedure AcImgFitExecute(Sender: TObject);
    procedure AnalysisGridClick(Sender: TObject);
    procedure AnalysisGridPrepareCanvas(Sender: TObject; ACol, ARow: Integer;
      AState: TGridDrawState);
    procedure cbHexAddressModeChange(Sender: TObject);
    procedure cbHexSingleBytesChange(Sender: TObject);
    procedure ExifGridCompareCells(Sender: TObject; ACol, ARow, BCol,
      BRow: Integer; var Result: integer);
    procedure FormCreate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure HexEditorClick(Sender: TObject);
    procedure MainPageControlChange(Sender: TObject);
    procedure MRUMenuManagerRecentFile(Sender:TObject; const AFileName:string);
    procedure TagsGridPrepareCanvas(sender: TObject; aCol, aRow: Integer;
      aState: TGridDrawState);
    procedure TbGotoAPP1ArrowClick(Sender: TObject);
    procedure TbGotoMarker(Sender: TObject);
    procedure TbGotoTIFFHeaderClick(Sender: TObject);
    procedure TbGotoIFD(Sender: TObject);
    procedure TbNextSegmentClick(Sender: TObject);
    procedure ValueGridClick(Sender: TObject);

  private
    FImgInfo: TImgInfo;
    FFileName: String;
    FCurrOffset: Int64;
    FBuffer: PBytes;
    FBufferSize: Int64;
    FMotorolaOrder: Boolean;
    FWidth: Integer;
    FHeight: Integer;
    IFDList: array[0..4] of Int64;
    FCurrIFDIndex: Integer;
    FMRUMenuManager : TMRUMenuManager;
    FHexEditor: THexEditor;
    FLoadFPExif: Boolean;
    procedure BuildAPP13Menu(AOffset: Int64);
    procedure ClearAnalysis;
    procedure DisableAllBtns;
    function DisplayAdobeImageResource(AOffset: Int64; AID: Word): Boolean;
    function DisplayColorProfile(AOffset: Int64): Boolean;
    procedure DisplayColorProfileTag(ATagIndex: Integer;
      AStartOffset: Int64; var AOffset: Int64; var ARow: Integer);
    function DisplayGenericMarker(AOffset: Int64): Boolean;
    function DisplayMarker(AOffset: Int64): Boolean;
    function DisplayMarkerAPP0(AOffset: Int64): Boolean;
    function DisplayMarkerAPP1(AOffset: Int64): Boolean;
    function DisplayMarkerAPP13(AOffset: Int64): Boolean;
    function DisplayMarkerCOM(AOffset: Int64): Boolean;
    function DisplayMarkerEOI(AOffset: Int64): Boolean;
    function DisplayIFD(AOffset, ATIFFHeaderOffset: Int64; AParentTagID: Word;
      AInfo: String): Boolean;
    function DisplayMarkerSOF0(AOffset: Int64): Boolean;
    function DisplayMarkerSOI(AOffset: Int64): Boolean;
    function DisplayMarkerSOS(AOffset: Int64): Boolean;
    function DisplayTIFFHeader(AOffset: Int64): Boolean;
    function DisplayXMP(AOffset: Int64; ALength: Integer): Boolean;
    function FindMarker(AMarker: Byte): Int64;
    function FindNextMarker(AMarker: byte; AFromPos: Int64): Int64;
    function FindNextMarker: Int64;
    function FindSegmentBtn(AMarker: Word): TToolButton;
    function FindTIFFHeader: Int64;
    function FindXMP(out XMPLength: Integer): Int64;
    function GetBEIntValue(AOffset: Int64; AByteCount: Byte; out AValue: Int64): Boolean;
    function GetExifIntValue(AOffset: Int64; AByteCount: Byte; out AValue: Int64): Boolean;
    function GetExifValue(AOffset: Int64; ADataType, ADataSize: Integer): String;
    function GetImageResourceBlockName(AID: Integer): String;
    function GetMarkerName(AMarker: Byte; Long: Boolean): String;
    function GetValueGridDataSize: Integer;
    function GotoAdobeImageResource(AResourceID: Word; var AOffset: Int64): Boolean;
    function GotoColorProfile(ASignature: String; var AOffset: Int64): Boolean;
    function GotoNextIFD(var AOffset: Int64): Boolean;
    procedure GotoOffset(AOffset: Int64);
    function GotoSubIFD(ATag: Word; var AOffset: Int64; ATiffHeaderOffset: Int64): Boolean;
    procedure LoadFile(const AFileName: String);
//    procedure Populate_dExifGrid(AKind: Integer);
    procedure Populate_fpExifGrids;
    procedure Populate_ValueGrid;
    procedure PopupGotoImageResourceBlock(Sender: TObject);
    function ScanIFDs: Boolean;
    procedure StatusMsg(const AMsg: String);
    procedure UpdateIFDs;
    procedure UpdateMarkers;
    procedure UpdateStatusbar;

    procedure ReadArgs;
    procedure ReadFromIni;
    procedure WriteToIni;

  public
    procedure BeforeRun;

  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

uses
  LCLType, StrUtils, Math, IniFiles, TypInfo,
  esAbout;

const
  ROW_INDEX         =  1;
  ROW_BITS          =  2;
  ROW_BYTE          =  3;
  ROW_SHORTINT      =  4;
  ROW_WORD          =  5;
  ROW_WORD_BE       =  6;
  ROW_SMALLINT      =  7;
  ROW_SMALLINT_BE   =  8;
  ROW_DWORD         =  9;
  ROW_DWORD_BE      = 10;
  ROW_LONGINT       = 11;
  ROW_LONGINT_BE    = 12;
  ROW_QWORD         = 13;
  ROW_QWORD_BE      = 14;
  ROW_INT64         = 15;
  ROW_INT64_BE      = 16;
  ROW_RATIONAL64    = 17;
  ROW_RATIONAL64_BE = 18;
  ROW_SINGLE        = 19;
  ROW_DOUBLE        = 20;
  ROW_ANSISTRING    = 21;
  ROW_PANSICHAR     = 22;
  ROW_WIDESTRING    = 23;
  ROW_PWIDECHAR     = 24;

  PANEL_OFFSET = 0;
  PANEL_ENDIAN = 1;
  PANEL_MSG = 2;

const
  MARKER_SOI   = $D8;
  MARKER_EOI   = $D9;
  MARKER_APP0  = $E0;
  MARKER_APP1  = $E1;       // EXIF
  MARKER_APP2  = $E2;
  MARKER_APP13 = $ED;       // IPTC
  MARKER_APP14 = $EE;
  MARKER_COM   = $FE;
  MARKER_DAC   = $CC;
  MARKER_DHT   = $C4;
  MARKER_DQT   = $DB;
  MARKER_JPG   = $C8;
  MARKER_SOF0  = $C0;
  MARKER_SOF1  = $C1;
  MARKER_SOF2  = $C2;
  MARKER_SOF3  = $C3;
  MARKER_SOF5  = $C5;
  MARKER_SOF6  = $C6;
  MARKER_SOF7  = $C7;
  MARKER_SOF9  = $C9;
  MARKER_SOF10 = $CA;
  MARKER_SOF11 = $CB;
  MARKER_SOF12 = $CC;
  MARKER_SOF13 = $CD;
  MARKER_SOF14 = $CE;
  MARKER_SOF15 = $CF;
  MARKER_SOS   = $DA;

  TAG_EXIF_OFFSET    = $8769;
  TAG_GPS_OFFSET     = $8825;
  TAG_INTEROP_OFFSET = $A005;
  TAG_SUBIFD_OFFSET  = $014A;

  INDEX_IFD0     = 0;
  INDEX_EXIF     = 1;
  INDEX_INTEROP  = 2;
  INDEX_GPS      = 3;
  INDEX_IFD1     = 4;

  EXIF_KEY = 'Exif'#0#0;
  XMP_BASE_KEY = 'http://ns.adobe.com/xap/1.0/';
  XMP_KEY = XMP_BASE_KEY + #0;
  IPTC_KEY = 'Photoshop 3.0'#0;
  ADOBE_IMAGE_RESOURCE_KEY = '8BIM';

  OFFSET_MASK = '%d ($%0:.8x)';

var
  MaxHistory: Integer = 16;


function GetFixedFontName: String;
var
  idx: Integer;
begin
  Result := Screen.SystemFont.Name;
  idx := Screen.Fonts.IndexOf('Courier New');
  if idx = -1 then
    idx := Screen.Fonts.IndexOf('Courier 10 Pitch');
  if idx <> -1 then
    Result := Screen.Fonts[idx]
  else
    for idx := 0 to Screen.Fonts.Count-1 do
      if pos('courier', Lowercase(Screen.Fonts[idx])) = 1 then
      begin
        Result := Screen.Fonts[idx];
        exit;
      end;
end;

function CalcIniName: String;
begin
  Result := ChangeFileExt(Application.ExeName, '.ini');
end;


{ TMainForm }

procedure TMainForm.AcCfgUseFPExifExecute(Sender: TObject);
begin
  FLoadFPExif := AcCfgUseFPExif.Checked;
end;

procedure TMainForm.AcFileOpenExecute(Sender: TObject);
begin
  if OpenDialog.Execute then
    LoadFile(OpenDialog.Filename);
end;

procedure TMainForm.AcFileQuitExecute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.AcFileReloadExecute(Sender: TObject);
begin
  if FFilename <> '' then
    LoadFile(FFileName);
end;

procedure TMainForm.AcGotoICCProfileExecute(Sender: TObject);
var
  offs: Int64;
begin
  offs := FindMarker(MARKER_APP2);
  if offs = -1 then
    exit;
  if GotoColorProfile('ICC_PROFILE', offs) then
  begin
    GotoOffset(offs);
    DisplayColorProfile(offs);
  end;
end;


procedure TMainForm.AcGotoIPTCExecute(Sender: TObject);
var
  offs: Int64;
begin
  offs := FindMarker(MARKER_APP13);
  if offs = -1 then
    exit;

  if GotoAdobeImageResource($0404, offs) then begin
    GotoOffset(offs);
    DisplayAdobeImageResource(offs, $0404);
  end;
end;

procedure TMainForm.AcGotoXMPExecute(Sender: TObject);
var
  offs: Int64;
  len: Integer;
begin
  offs := FindXMP(len);
  if offs = -1 then
    exit;
  GotoOffset(offs);
  DisplayXMP(offs, len);
end;

procedure TMainForm.AcHelpAboutExecute(Sender: TObject);
begin
  with TAboutForm.Create(nil) do
    try
      ShowModal;
    finally
      Free;
    end;
(*
  MessageDlg(
    'Icons displayed in this program are used from the icons8 library' +
    '(https://icons8.com/) under a "Creative Commons Attribution-NoDerivs 3.0 Unported" license',
    mtInformation, [mbOK], 0
  );
  *)
end;

procedure TMainForm.AcImgFitExecute(Sender: TObject);
begin
  if AcImgFit.Checked then
  begin
    Image.Parent := PgImage;
    Image.Center := true;
  end else
  begin
    Image.Parent := Scrollbox;
    Image.Center := false;
  end;
  Image.Stretch := AcImgFit.Checked;
  Image.Proportional := AcImgFit.Checked;
  Scrollbox.Visible := not AcImgFit.Checked;
end;


procedure TMainForm.AnalysisGridClick(Sender: TObject);
var
  idx, n: Integer;
  s: String;
begin
  idx := FHexEditor.SelStart;

  s := AnalysisGrid.Cells[0, AnalysisGrid.Row];
  n := pos(' ', s);
  if n > 0 then
    s := Copy(s, 1, n-1);
  if not TryStrToInt(s, n) then
    exit;

  if n > 0 then begin
    FHexEditor.SelStart := n;
    n := n + StrToInt(AnalysisGrid.Cells[1, AnalysisGrid.Row]) - 1;
    FHexEditor.SelEnd := n;
  end else
    FHexEditor.SelEnd := idx;

  FHexEditor.CenterCursorPosition;
end;


procedure TMainForm.AnalysisGridPrepareCanvas(sender: TObject; aCol,
  aRow: Integer; aState: TGridDrawState);
var
  s: String;
begin
  s := AnalysisGrid.Cells[ACol, ARow];
  if (s <> '') and ((s[1] = '#') or (s = 'Offset to next IFD')) and (ACol = 3) then
    AnalysisGrid.Canvas.Font.Style := [fsBold];
end;


procedure TMainForm.BeforeRun;
begin
  ReadFromIni;
  ReadArgs;
end;


procedure TMainForm.BuildApp13Menu(AOffset: Int64);
var
  s: String = '';
  numBytes: Integer;
  n: Int64;
  item: TMenuItem;
  startOffs: PtrInt;
begin
  APP13Popup.Items.Clear;

  inc(AOffset, 2);  // jump over segment ID
  inc(AOffset, 2);  // jump over segment size

  numBytes := 14;
  SetLength(s, numbytes);
  Move(FBuffer^[AOffset], s[1], numbytes);
  if s <> IPTC_KEY then
    exit;
  inc(AOffset, numbytes);

  while true do
  begin
    startOffs := AOffset;
    numbytes := 4;
    SetLength(s, numbytes);
    Move(FBuffer^[AOffset], s[1], numbytes);
    if s <> ADOBE_IMAGE_RESOURCE_KEY then   // '8BIM'
      exit;

    // ID of image resource block
    inc(AOffset, numbytes);
    numBytes := 2;
    if not GetBEIntValue(AOffset, numbytes, n) then
      exit;

    // Create menu item
    s := GetImageResourceBlockName(n);
    item := TMenuItem.Create(self);
    item.Caption := Format('$%.4x - %s', [n, s]);
    item.Tag := startOffs;
    item.OnClick := @PopupGotoImageResourceBlock;
    APP13Popup.Items.Add(item);

    // Length of name
    inc(AOffset, numbytes);
    n := FBuffer^[AOffset];
    inc(AOffset, 1);
    // Name
    if n = 0 then
      inc(AOffset)
    else
      inc(AOffset, n);

    // Size of data block
    numBytes := 4;
    if not GetBEIntValue(AOffset, numBytes, n) then
      exit;
    if n = 1 then n := 2;
    inc(AOffset, n + numBytes);
  end;
end;


procedure TMainForm.cbHexAddressModeChange(Sender: TObject);
begin
  FHexEditor.RulerNumberBase := IfThen(cbHexAddressMode.Checked, 16, 10);
  FHexEditor.OffsetFormat := IfThen(cbHexAddressMode.Checked, '-!10:$|', '-!0A: |');
end;


procedure TMainForm.cbHexSingleBytesChange(Sender: TObject);
begin
  FHexEditor.BytesPerColumn := IfThen(cbHexSingleBytes.Checked, 1, 2);
end;


procedure TMainForm.ClearAnalysis;
begin
  AnalysisInfo.Caption := ' ';
  AnalysisGrid.RowCount := 2;
  AnalysisGrid.Rows[1].Clear;
  AnalysisSynEdit.Lines.Clear;
end;

function TMainForm.DisplayAdobeImageResource(AOffset: Int64; AID: Word): Boolean;
var
  numbytes: Integer;
  s: String = '';
  j: Integer;
  size: Integer;
  val: Int64;
  itemCounter: Integer;
  dssize: Word;
  len: Integer;
  recNo: Integer;
  tagDef: TTagDef;
begin
  Result := false;

  AnalysisInfo.Caption := 'Adobe image resource';
  AnalysisGrid.RowCount := 5 + AnalysisGrid.FixedRows;
  j := AnalysisGrid.FixedRows;

  numbytes := 4;
  SetLength(s, numbytes);
  Move(FBuffer^[AOffset], s[1], numbytes);
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
  AnalysisGrid.Cells[2, j] := s;                                  // 8BIM
  AnalysisGrid.Cells[3, j] := 'Adobe Image Resource signature';
  inc(j);
  inc(AOffset, numbytes);

  numbytes := 2;
  if not GetBEIntValue(AOffset, numbytes, val) then
    exit;
  s := GetImageResourceBlockName(val);
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
  AnalysisGrid.Cells[2, j] := Format('%d ($%.4x) --> ' + s, [val, val]);
  AnalysisGrid.Cells[3, j] := 'Unique identifer of resource';
  inc(j);
  inc(AOffset, numbytes);

  numbytes := 1;
  val := FBuffer^[AOffset];
  len := val;
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
  AnalysisGrid.Cells[2, j] := IntToStr(val);
  AnalysisGrid.Cells[3, j] := 'Length of resource name';
  inc(j);
  inc(AOffset, numbytes);

  numbytes := val;
  SetLength(s, numbytes);
  Move(FBuffer^[AOffset+1], s[1], numbytes);
  if odd(numbytes) then
    inc(numbytes)
  else
    inc(numbytes, 1);
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
  AnalysisGrid.Cells[2, j] := s;
  AnalysisGrid.Cells[3, j] := 'Name of resource';
  inc(j);
  inc(AOffset, numbytes);

  numbytes := 4;
  if not GetBEIntValue(AOffset, numbytes, val) then
    exit;
  size := val;
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
  AnalysisGrid.Cells[2, j] := IntToStr(val);
  AnalysisGrid.Cells[3, j] := 'Size of data';
  inc(j);
  inc(AOffset, numbytes);

  itemCounter := -1;
  numbytes := 1;
  val := FBuffer^[AOffset];
  while val = $1C do begin
    AnalysisGrid.RowCount := AnalysisGrid.RowCount + 5;
    inc(itemCounter);

    AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
    AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
    AnalysisGrid.Cells[2, j] := Format('%d ($%.2x)', [val, val]);
    AnalysisGrid.Cells[3, j] := 'Marker of dataset #' + IntToStr(itemCounter);
    inc(j);
    inc(AOffset, numbytes);

    numbytes := 1;
    val := FBuffer^[AOffset];
    recNo := val;
    AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
    AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
    AnalysisGrid.Cells[2, j] := Format('%d ($%.2x)', [val, val]);
    AnalysisGrid.Cells[3, j] := 'Record number of dataset #' + IntToStr(itemCounter);
    inc(j);
    inc(AOffset, numbytes);

    numbytes := 1;
    val := FBuffer^[AOffset];
    s := 'Dataset number of dataset #' + IntToStr(itemCounter);
    if recNo = 2 then
    begin
      tagDef := FindIPTCTagDef(TAGPARENT_IPTC + $0200 + val);
      if tagDef <> nil then
        s := s + ': ' + tagDef.Desc
      else
        s := s + ': <not found>';
    end;

    AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
    AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
    AnalysisGrid.Cells[2, j] := IntToStr(val);
    AnalysisGrid.Cells[3, j] := s;
    inc(j);
    inc(AOffset, numbytes);

    numbytes := 2;
    if not GetBEIntValue(AOffset, numbytes, val) then
      exit;
    dssize := val;
    AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
    AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
    AnalysisGrid.Cells[2, j] := IntToStr(val);
    AnalysisGrid.Cells[3, j] := 'Data field byte count of dataset #' + IntToStr(itemCounter);
    inc(j);
    inc(AOffset, numbytes);

    numbytes := dsSize;
    AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
    AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
    AnalysisGrid.Cells[2, j] := '...';
    AnalysisGrid.Cells[3, j] := 'Data field of dataset #' + IntToStr(itemCounter);
    inc(j);
    inc(AOffset, numbytes);

    numbytes := 1;
    val := FBuffer^[AOffset];
  end;
end;

function S15Fixed16NumberToStr(n: DWord): String;
type
  TS15Fixed16 = record
    IntPart: SmallInt;
    FracPart: Word;
  end;
var
  d: Double;
begin
  with TS15Fixed16(n) do
    d := BEToN(IntPart) + BEToN(FracPart) / word($FFFF);
  Result := FormatFloat('0.00000', d);
end;

function TMainForm. DisplayColorProfile(AOffset: Int64): Boolean;
type
  TICCDateTime = record
    Year, Month, Day, Hour, Minute, Second: Word;
  end;
var
  startOffset: Int64;
  numBytes: Integer;
  i, j: Integer;
  val: Int64;
  s: String = '';
  dt: TICCDateTime;
  dw: DWord = 0;
  numTags: Integer;
begin
  Result := false;

  AnalysisInfo.Caption := 'ICC Color Profile';
  AnalysisGrid.RowCount := AnalysisGrid.FixedRows + 1000;
  j := AnalysisGrid.FixedRows;
  startOffset := AOffset;

  numBytes := 4;
  if not GetBEIntValue(AOffset, numbytes, val) then
    exit;
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numBytes);
  AnalysisGrid.Cells[2, j] := Format('%d ($%.4x)', [val, val]);
  AnalysisGrid.Cells[3, j] := 'Profile size';
  inc(j);
  inc(AOffset, numBytes);

  numBytes := 4;
  SetLength(s, numbytes);
  Move(FBuffer^[AOffset], s[1], numBytes);
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numBytes);
  AnalysisGrid.Cells[2, j] := s;
  AnalysisGrid.Cells[3, j] := 'Preferred Colour Management Module type';
  inc(j);
  inc(AOffset, numBytes);

  numBytes := 4;
  SetLength(s, numbytes);
  Move(FBuffer^[AOffset], s[1], numbytes);
  s := Format('%d.%d', [ord(s[1]), ord(s[2])]);
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numBytes);
  AnalysisGrid.Cells[2, j] := s;
  AnalysisGrid.Cells[3, j] := 'Profile version and sub-version number';
  inc(j);
  inc(AOffset, numBytes);

  numBytes := 4;
  SetLength(s, numBytes);
  Move(FBuffer^[AOffset], s[1], numbytes);
  case s of
    'scnr': s := s + ' (scanners, digital cameras)';
    'mntr': s := s + ' (CRTs, LCDs)';
    'prtr': s := s + ' (printers)'
  end;
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numBytes);
  AnalysisGrid.Cells[2, j] := s;
  AnalysisGrid.Cells[3, j] := 'Profile/device class';
  inc(j);
  inc(AOffset, numBytes);

  numBytes := 4;
  SetLength(s, numBytes);
  Move(FBuffer^[AOffset], s[1], numbytes);
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numBytes);
  AnalysisGrid.Cells[2, j] := s;
  AnalysisGrid.Cells[3, j] := 'Color space of data';
  inc(j);
  inc(AOffset, numBytes);

  numBytes := 4;
  SetLength(s, numBytes);
  Move(FBuffer^[AOffset], s[1], numbytes);
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numBytes);
  AnalysisGrid.Cells[2, j] := s;
  AnalysisGrid.Cells[3, j] := 'Profile connection space';
  inc(j);
  inc(AOffset, numBytes);

  numBytes := 12;
  Move(FBuffer^[AOffset], dt, SizeOf(dt));
  s := DateToStr(EncodeDate(BEToN(dt.Year), BEToN(dt.Month), BEToN(dt.Day))) + ' ' +
    TimeToStr(EncodeTime(BEToN(dt.Hour), BEToN(dt.Minute), BEToN(dt.Second), 0));
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numBytes);
  AnalysisGrid.Cells[2, j] := s;
  AnalysisGrid.Cells[3, j] := 'Date and time this profile was first created';
  inc(j);
  inc(AOffset, numBytes);

  numBytes := 4;
  SetLength(s, numBytes);
  Move(FBuffer^[AOffset], s[1], numbytes);
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numBytes);
  AnalysisGrid.Cells[2, j] := s;;
  AnalysisGrid.Cells[3, j] := 'Profile file signature';
  inc(j);
  inc(AOffset, numBytes);

  numBytes := 4;
  SetLength(s, numBytes);
  Move(FBuffer^[AOffset], s[1], numbytes);
  case s of
    'APPL': s := s + ' (Apple Computer, Inc.)';
    'MSFT': s := s + ' (Microsoft Corporation)';
    'SGI ': s := s + ' (Silicon Graphics, Inc.)';
    'SUNW': s := s + ' (Sun Microsystems, Inc.)';
    'TGNT': s := s + ' (Taligent, Inc.)';
  end;
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numBytes);
  AnalysisGrid.Cells[2, j] := s;;
  AnalysisGrid.Cells[3, j] := 'Primary platform target for the profile';
  inc(j);
  inc(AOffset, numBytes);

  numBytes := 4;
  if not GetBEIntValue(AOffset, numbytes, val) then
    exit;
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numBytes);
  AnalysisGrid.Cells[2, j] := Format('%d ($%.4x)', [val, val]);
  AnalysisGrid.Cells[3, j] := 'Profile flags';
  inc(j);
  inc(AOffset, numBytes);

  numBytes := 4;
  SetLength(s, numBytes);
  Move(FBuffer^[AOffset], s[1], numbytes);
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numBytes);
  AnalysisGrid.Cells[2, j] := s;
  AnalysisGrid.Cells[3, j] := 'Device manufacturer';
  inc(j);
  inc(AOffset, numBytes);

  numBytes := 4;
  if not GetBEIntValue(AOffset, numbytes, val) then
    exit;
  s := Format('%d ($%.4x)', [val, val]);
  if val = 0 then s := s + '; not used';
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numBytes);
  AnalysisGrid.Cells[2, j] := s;
  AnalysisGrid.Cells[3, j] := 'Device model';
  inc(j);
  inc(AOffset, numBytes);

  numBytes := 4;       // field size is 8, but GetBEIntValue does not handle this
  if not GetBEIntValue(AOffset, numbytes, val) then
    exit;
  s := Format('%d ($%.4x)', [val, val]);
  s := s + '; ' + IfThen(val and $01 = 0, 'reflective', 'transparency');
  s := s + '; ' + IfThen(val and $02 = 0, 'glossy', 'matte');
  s := s + '; ' + IfThen(val and $04 = 0, 'positive', 'negative') + ' media polarity';
  s := s + '; ' + IfThen(val and $08 = 0, 'colour', 'b/w') + ' media';
  s := s + '; ' + IfThen(val and $10 = 0, 'paper/paperboard', 'non-paper-based');
  s := s + '; ' + IfThen(val and $20 = 0, 'non-textured', 'textured');
  s := s + '; ' + IfThen(val and $40 = 0, 'isotropic', 'non-isotropic');
  s := s + '; ' + IfThen(val and $80 = 0, 'non self-luminous', 'self-luminous');
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numBytes);
  AnalysisGrid.Cells[2, j] := s;
  AnalysisGrid.Cells[3, j] := 'Device attributes';
  inc(j);
  inc(AOffset, numBytes+4);  // +4 for the missing bytes of the field size

  numBytes := 4;
  if not GetBEIntValue(AOffset, numbytes, val) then
    exit;
  s := Format('%d ($%.4x)', [val, val]);
  case val of
    0: s := s + ': Perpetual';
    1: s := s + ': Media-relative colorimetric';
    2: s := s + ': Saturation';
    3: s := s + ': ICC-absolute colorimetric';
  end;
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numBytes);
  AnalysisGrid.Cells[2, j] := s;
  AnalysisGrid.Cells[3, j] := 'Rendering intent';
  inc(j);
  inc(AOffset, numBytes);

  numBytes := 4;
  Move(FBuffer^[AOffset], dw, numbytes);
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numBytes);
  AnalysisGrid.Cells[2, j] := S15Fixed16NumberToStr(dw);
  AnalysisGrid.Cells[3, j] := 'X of nCIEXYZ values of the PCS illuminant, computed with the PCS observer';
  inc(j);
  inc(AOffset, numBytes);

  numBytes := 4;
  Move(FBuffer^[AOffset], dw, numbytes);
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numBytes);
  AnalysisGrid.Cells[2, j] := S15Fixed16NumberToStr(dw);
  AnalysisGrid.Cells[3, j] := 'Y of nCIEXYZ values of the PCS illuminant, computed with the PCS observer';
  inc(j);
  inc(AOffset, numBytes);

  numBytes := 4;
  Move(FBuffer^[AOffset], dw, numbytes);
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numBytes);
  AnalysisGrid.Cells[2, j] := S15Fixed16NumberToStr(dw);
  AnalysisGrid.Cells[3, j] := 'Z of nCIEXYZ values of the PCS illuminant, computed with the PCS observer';
  inc(j);
  inc(AOffset, numBytes);

  numBytes := 4;
  SetLength(s, numBytes);
  Move(FBuffer^[AOffset], s[1], numbytes);
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numBytes);
  AnalysisGrid.Cells[2, j] := s;
  AnalysisGrid.Cells[3, j] := 'Profile creator signature';
  inc(j);
  inc(AOffset, numBytes);

  numBytes := 44;
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numBytes);
  AnalysisGrid.Cells[2, j] := '(reserved)';
  AnalysisGrid.Cells[3, j] := 'reserved';
  inc(j);
  inc(AOffset, numBytes);

  numBytes := 4;
  if not GetBEIntValue(AOffset, numbytes, val) then
    exit;
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numBytes);
  AnalysisGrid.Cells[2, j] := IntToStr(val);
  AnalysisGrid.Cells[3, j] := 'Tag count';
  inc(j);
  inc(AOffset, numBytes);
  numTags := val;

  for i := 1 to numTags do
    DisplayColorProfileTag(i, startOffset, AOffset, j);
(*
    numBytes := 4;
    SetLength(s, numbytes);
    Move(FBuffer^[AOffset], s[1], numBytes);
    AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
    AnalysisGrid.Cells[1, j] := IntToStr(numBytes);
    AnalysisGrid.Cells[2, j] := s;
    AnalysisGrid.Cells[3, j] := Format('#%d: Tag "%s"', [i, s]);
    inc(j);
    inc(AOffset, numBytes);

    numBytes := 4;
    if not GetBEIntValue(AOffset, numBytes, val) then
      exit;
    AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
    AnalysisGrid.Cells[1, j] := IntToStr(numBytes);
    AnalysisGrid.Cells[2, j] := IntToStr(val);
    AnalysisGrid.Cells[3, j] := 'Offset to data';
    inc(j);
    inc(AOffset, numBytes);
    offs := startoffset + val;

    numBytes := 4;
    if not GetBEIntValue(AOffset, numBytes, val) then
      exit;
    AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
    AnalysisGrid.Cells[1, j] := IntToStr(numBytes);
    AnalysisGrid.Cells[2, j] := IntToStr(val);
    AnalysisGrid.Cells[3, j] := 'Element size for the number of bytes in the tag data element';
    inc(j);
    inc(AOffset, numBytes);

    // Copy tag data value to buffer b
    SetLength(b, val);
    Move(FBuffer^[offs], b[0], Length(b));

    // Get tag type
    SetLength(s, 4);
    Move(b[0], s[1], 4);
    AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [offs]);
    AnalysisGrid.Cells[1, j] := '4';
    AnalysisGrid.Cells[2, j] := s;
    AnalysisGrid.Cells[3, j] := 'Tag type';
    inc(j);
    inc(offs, 4);

    // Reserved
    Move(b[4], dw, 4);
    AnalysisGrid.Cells[0, j] := Format(Offset_Mask, [offs]);
    AnalysisGrid.Cells[1, j] := '4';
    AnalysisGrid.Cells[2, j] := IntToStr(BEToN(dw));
    AnalysisGrid.Cells[3, j] := '(reserved, must be 0)';
    inc(j);
    inc(offs, 4);

    case s of
      'desc':    // Description tag
        begin
          Move(b[8], dw, 4);
          dw := BEToN(dw);
          AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [offs]);
          AnalysisGrid.Cells[1, j] := '4';
          AnalysisGrid.Cells[2, j] := IntToStr(dw);
          AnalysisGrid.Cells[3, j] := 'Description length';
          inc(j);
          SetLength(s, dw);
          Move(b[12], s[1], dw);
          AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [offs]);
          AnalysisGrid.Cells[1, j] := IntToStr(dw);
          AnalysisGrid.Cells[2, j] := s;
          AnalysisGrid.Cells[3, j] := 'Description';
          inc(j);
        end;
      'text':      // Text tag
        begin
          SetLength(s, Length(b) - 8);
          Move(b[8], s[1], Length(s));
          AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [offs]);
          AnalysisGrid.Cells[1, j] := IntToStr(Length(s));
          AnalysisGrid.Cells[2, j] := s;
          AnalysisGrid.Cells[3, j] := 'Text';
          inc(j);
        end;
    end;
  end;
  *)

  AnalysisGrid.RowCount := j;
  Result := true;
end;


procedure TMainForm.DisplayColorProfileTag(ATagIndex: Integer;
  AStartOffset: Int64; var AOffset: Int64; var ARow: Integer);
var
  i, numBytes: Integer;
  sFull: String;
  val: Int64;
  offs: Int64;
  dw: DWord = 0;
  w: Word = 0;
  b: fpeGlobal.TBytes = nil;
  s: String = '';
begin
  numBytes := 4;
  SetLength(s, numbytes);
  Move(FBuffer^[AOffset], s[1], numBytes);
  AnalysisGrid.Cells[0, ARow] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, ARow] := IntToStr(numBytes);
  AnalysisGrid.Cells[2, ARow] := s;
  sFull := '';
  case s of
    'bkpt': sFull := 'Media black point';
    'bTRC': sFull := 'Blue tone reproduction curve';
    'bXYZ': sFull := 'Blue colorant';
    'cprt': sFull := 'Copyright';
    'gTRC': sFull := 'Green tone reproduction curve';
    'gXYZ': sFull := 'Green colorant';
    'rTRC': sFull := 'Red tone reproduction curve';
    'rXYZ': sFull := 'Red colorant';
    'wtpt': sFull := 'Media white point';
  end;
  s := '"' + s + '"';
  if sFull <> '' then s := s + ' (' + sFull + ')';
  AnalysisGrid.Cells[3, ARow] := Format('#%d: Tag signature %s', [ATagIndex, s]);
  inc(ARow);
  inc(AOffset, numBytes);

  numBytes := 4;
  if not GetBEIntValue(AOffset, numBytes, val) then
    exit;
  AnalysisGrid.Cells[0, ARow] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, ARow] := IntToStr(numBytes);
  AnalysisGrid.Cells[2, ARow] := IntToStr(val);
  AnalysisGrid.Cells[3, ARow] := 'Offset to data';
  inc(ARow);
  inc(AOffset, numBytes);
  offs := AStartOffset + val;

  numBytes := 4;
  if not GetBEIntValue(AOffset, numBytes, val) then
    exit;
  AnalysisGrid.Cells[0, ARow] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, ARow] := IntToStr(numBytes);
  AnalysisGrid.Cells[2, ARow] := IntToStr(val);
  AnalysisGrid.Cells[3, ARow] := 'Element size for the number of bytes in the tag data element';
  inc(ARow);
  inc(AOffset, numBytes);

  // Copy tag data value to buffer b
  SetLength(b, val);
  Move(FBuffer^[offs], b[0], Length(b));

  // Get tag type
  SetLength(s, 4);
  Move(b[0], s[1], 4);
  AnalysisGrid.Cells[0, ARow] := Format(OFFSET_MASK, [offs]);
  AnalysisGrid.Cells[1, ARow] := '4';
  AnalysisGrid.Cells[2, ARow] := s;
  AnalysisGrid.Cells[3, ARow] := 'Tag type';
  inc(ARow);
  inc(offs, 4);

  // Reserved
  Move(b[4], dw, 4);
  AnalysisGrid.Cells[0, ARow] := Format(OFFSET_MASK, [offs]);
  AnalysisGrid.Cells[1, ARow] := '4';
  AnalysisGrid.Cells[2, ARow] := IntToStr(BEToN(dw));
  AnalysisGrid.Cells[3, ARow] := '(reserved, must be 0)';
  inc(ARow);
  inc(offs, 4);

  case s of
    'curv':    // curve
      begin
        // Number of points on curve
        Move(b[8], dw, 4);
        dw := BEToN(dw);
        AnalysisGrid.Cells[0, ARow] := Format(OFFSET_MASK, [offs]);
        AnalysisGrid.Cells[1, ARow] := '4';
        AnalysisGrid.Cells[2, ARow] := IntToStr(dw);
        AnalysisGrid.Cells[3, ARow] := 'Points count';
        inc(ARow);
        Move(b[12], w, 2);
        s := IntToStr(BEToN(w));
        for i := 1 to dw-1 do
        begin
          Move(b[12+2*i], w, 2);
          s := s + '; ' + IntToStr(BEToN(w));
        end;
        AnalysisGrid.Cells[0, ARow] := Format(OFFSET_MASK, [offs]);
        AnalysisGrid.Cells[1, ARow] := IntToStr(QWord(dw)*2);  // QWord to silence the compiler
        AnalysisGrid.Cells[2, ARow] := s;
        AnalysisGrid.Cells[3, ARow] := 'Curve values';
      end;

    'desc':    // Description type
      begin
        Move(b[8], dw, 4);
        dw := BEToN(dw);
        AnalysisGrid.Cells[0, ARow] := Format(OFFSET_MASK, [offs]);
        AnalysisGrid.Cells[1, ARow] := '4';
        AnalysisGrid.Cells[2, ARow] := IntToStr(dw);
        AnalysisGrid.Cells[3, ARow] := 'Description length';
        inc(ARow);
        SetLength(s, dw);
        Move(b[12], s[1], dw);
        AnalysisGrid.Cells[0, ARow] := Format(OFFSET_MASK, [offs]);
        AnalysisGrid.Cells[1, ARow] := IntToStr(dw);
        AnalysisGrid.Cells[2, ARow] := s;
        AnalysisGrid.Cells[3, ARow] := 'Description (ASCII)';
      end;

    'text':      // Text type
      begin
        SetLength(s, Length(b) - 8);
        Move(b[8], s[1], Length(s));
        AnalysisGrid.Cells[0, ARow] := Format(OFFSET_MASK, [offs]);
        AnalysisGrid.Cells[1, ARow] := IntToStr(Length(s));
        AnalysisGrid.Cells[2, ARow] := s;
        AnalysisGrid.Cells[3, ARow] := 'Text';
      end;

    'XYZ ':   // XYZ type: three s15Fixed16Number numbers
      begin
        Move(b[8], dw, 4);
        s := S15Fixed16NumberToStr(dw);
        Move(b[12], dw, 4);
        s := s + '; ' + S15Fixed16NumberToStr(dw);
        Move(b[16], dw, 4);
        s := s + '; ' + S15Fixed16NumberToStr(dw);
        AnalysisGrid.Cells[0, ARow] := Format(OFFSET_MASK, [offs]);
        AnalysisGrid.Cells[1, ARow] := '12';
        AnalysisGrid.Cells[2, ARow] := s;
        AnalysisGrid.Cells[3, ARow] := 'CIEXYZ tristimulus values';
      end;
  end;
  inc(ARow);
end;

function TMainForm.DisplayGenericMarker(AOffset: Int64): Boolean;
var
  m: byte;
  j: Integer;
  numbytes: byte;
  val: Int64;
begin
  Result := false;

  m := FBuffer^[AOffset + 1];

  AnalysisInfo.Caption := Format('%s (%s)', [GetMarkerName(m, false), GetMarkerName(m, true)]);
  AnalysisGrid.RowCount := 2 + AnalysisGrid.FixedRows;
  j := AnalysisGrid.FixedRows;

  numbytes := 2;
  if not GetBEIntValue(AOffset, numbytes, val) then
    exit;
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
  AnalysisGrid.Cells[2, j] := Format('%d ($%.4x)', [val, val]);
  AnalysisGrid.Cells[3, j] := GetMarkerName(m, true);
  inc(j);
  inc(AOffset, numbytes);

  numbytes := 2;
  if not GetBEIntValue(AOffset, numbytes, val) then
    exit;
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
  AnalysisGrid.Cells[2, j] := IntToStr(val);
  AnalysisGrid.Cells[3, j] := 'Size';
  inc(j);
  inc(AOffset, numbytes);

  Result := true;
end;

function TMainForm.DisplayMarker(AOffset: Int64): Boolean;
var
  m: Byte;
begin
  Result := false;
  GotoOffset(AOffset);
  m := FBuffer^[AOffset + 1];
  case m of
    MARKER_SOI   : Result := DisplayMarkerSOI(AOffset);
    MARKER_APP0  : Result := DisplayMarkerAPP0(AOffset);
    MARKER_APP1  : Result := DisplayMarkerAPP1(AOffset);
    MARKER_APP2  : begin
                     if GotoColorProfile('ICC_PROFILE', AOffset) then
                     begin
                       GotoOffset(AOffset);
                       Result := DisplayColorProfile(AOffset);
                     end;
                   end;
    MARKER_APP13 : Result := DisplayMarkerAPP13(AOffset);
    MARKER_EOI   : Result := DisplayMarkerEOI(AOffset);
    MARKER_SOF0  : Result := DisplayMarkerSOF0(AOffset);
    MARKER_SOS   : Result := DisplayMarkerSOS(AOffset);
    MARKER_COM   : Result := DisplayMarkerCOM(AOffset);
    else           Result := DisplayGenericMarker(AOffset);
  end;
end;

function TMainForm.DisplayMarkerAPP0(AOffset: Int64): Boolean;
var
  s: String = '';
  val: Int64;
  j: Integer;
  numbytes: Byte;
begin
  Result := false;

  AnalysisInfo.Caption := 'APP0 (Application marker 0)';
  AnalysisNotebook.PageIndex := 0;
  AnalysisGrid.RowCount := 9 + AnalysisGrid.FixedRows;
  j := AnalysisGrid.FixedRows;

  numbytes := 2;
  if not GetBEIntValue(AOffset, numbytes, val) then
    exit;
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
  AnalysisGrid.Cells[2, j] := Format('%d ($%.4x)', [val, val]);
  AnalysisGrid.Cells[3, j] := 'APP0 marker';
  inc(j);
  inc(AOffset, numbytes);

  numbytes := 2;
  if not GetBEIntValue(AOffset, numbytes, val) then
    exit;
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
  AnalysisGrid.Cells[2, j] := IntToStr(val);
  AnalysisGrid.Cells[3, j] := 'Size';
  inc(j);
  inc(AOffset, numbytes);

  numbytes := 5;
  SetLength(s, 5);
  Move(FBuffer^[AOffset], s[1], 5);
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
  AnalysisGrid.Cells[2, j] := s;
  AnalysisGrid.Cells[3, j] := 'Identifier (must be JFIF)';
  inc(j);
  inc(AOffset, 5);

  numbytes := 2;
  if not GetBEIntValue(AOffset, numbytes, val) then
    exit;
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
  AnalysisGrid.Cells[2, j] := IntToStr(val);
  AnalysisGrid.Cells[3, j] := 'JFIF format revision';
  inc(j);
  inc(AOffset, numbytes);

  numbytes := 1;
  if not GetBEIntvalue(AOffset, numbytes, val) then exit;
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
  AnalysisGrid.Cells[2, j] := IntToStr(val);
  case val of
    0: s := 'aspect ratio';
    1: s := 'inches';
    2: s := 'cm';
    else s := 'unknown';
  end;
  AnalysisGrid.Cells[3, j] := 'Units: ' + s;
  inc(j);
  inc(AOffset, numbytes);

  numbytes := 2;
  if not GetBEIntValue(AOffset, numbytes, val) then exit;
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
  AnalysisGrid.Cells[2, j] := IntToStr(val);
  AnalysisGrid.Cells[3, j] := 'X density';
  inc(j);
  inc(AOffset, numbytes);

  numbytes := 2;
  if not GetBEIntValue(AOffset, numbytes, val) then exit;
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
  AnalysisGrid.Cells[2, j] := IntToStr(val);
  AnalysisGrid.Cells[3, j] := 'Y density';
  inc(j);
  inc(AOffset, numbytes);

  numbytes := 1;
  if not GetBEIntValue(AOffset, numbytes, val) then exit;
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
  AnalysisGrid.Cells[2, j] := IntToStr(val);
  AnalysisGrid.Cells[3, j] := 'Thumbnail width';
  inc(j);
  inc(AOffset, numbytes);

  numbytes := 1;
  if not GetBEIntValue(AOffset, numbytes, val) then exit;
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
  AnalysisGrid.Cells[2, j] := IntToStr(val);
  AnalysisGrid.Cells[3, j] := 'Thumbnail height';
  inc(j);
  inc(AOffset, numbytes);

  Result := True;
end;

function TMainForm.DisplayMarkerAPP1(AOffset: Int64): Boolean;
var
  s: String = '';
  val: Int64;
  j: Integer;
  numbytes: Byte;
begin
  Result := false;

  AnalysisInfo.Caption := 'APP1 (Application marker 1, EXIF/XMP)';
  AnalysisNotebook.PageIndex := 0;
  AnalysisGrid.RowCount := 3 + AnalysisGrid.FixedRows;
  j := AnalysisGrid.FixedRows;

  numbytes := 2;
  if not GetBEIntValue(AOffset, numbytes, val) then
    exit;
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
  AnalysisGrid.Cells[2, j] := Format('%d ($%.4x)', [val, val]);
  AnalysisGrid.Cells[3, j] := 'APP1 marker';
  inc(j);
  inc(AOffset, numbytes);

  numbytes := 2;
  if not GetBEIntValue(AOffset, numbytes, val) then
    exit;
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
  AnalysisGrid.Cells[2, j] := IntToStr(val);
  AnalysisGrid.Cells[3, j] := 'Size';
  inc(j);
  inc(AOffset, numbytes);

  numbytes := Length(EXIF_KEY);
  SetLength(s, numbytes);
  Move(FBuffer^[AOffset], s[1], numbytes);
  if (s = EXIF_KEY) then
  begin
    AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
    AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
    AnalysisGrid.Cells[2, j] := s;
    AnalysisGrid.Cells[3, j] := 'EXIF identifer';
    inc(j);
    inc(AOffset, numbytes);
  end else
  begin
    numbytes := Length(XMP_KEY);
    SetLength(s, numbytes);
    Move(FBuffer^[AOffset], s[1], numbytes);
    if s = XMP_KEY then
    begin
      AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
      AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
      AnalysisGrid.Cells[2, j] := s;
      AnalysisGrid.Cells[3, j] := 'XMP identifer';
      inc(j);
      inc(AOffset, numbytes);
    end;
  end;

  Result := true;
end;

// Source: https://www.adobe.com/devnet-apps/photoshop/fileformatashtml/
function TMainForm.DisplayMarkerAPP13(AOffset: Int64): Boolean;
var
  s: String = '';
  val: Int64;
  j: Integer;
  numbytes: Byte;
begin
  Result := false;

  AnalysisInfo.Caption := 'APP13 (Application marker 13, IPTC)';
  AnalysisNotebook.PageIndex := 0;
  AnalysisGrid.RowCount := 3 + AnalysisGrid.FixedRows;
  j := AnalysisGrid.FixedRows;

  numbytes := 2;
  if not GetBEIntValue(AOffset, numbytes, val) then
    exit;
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
  AnalysisGrid.Cells[2, j] := Format('%d ($%.4x)', [val, val]);
  AnalysisGrid.Cells[3, j] := 'APP31 marker';
  inc(j);
  inc(AOffset, numbytes);

  numbytes := 2;
  if not GetBEIntValue(AOffset, numbytes, val) then
    exit;
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
  AnalysisGrid.Cells[2, j] := IntToStr(val);
  AnalysisGrid.Cells[3, j] := 'Size';
  inc(j);
  inc(AOffset, numbytes);

  numbytes := 14;
  SetLength(s, numbytes);
  Move(FBuffer^[AOffset], s[1], numbytes);
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
  AnalysisGrid.Cells[2, j] := s;
  AnalysisGrid.Cells[3, j] := 'IPTC identifer';
  inc(j);
  inc(AOffset, numbytes);

  Result := true;
end;


function TMainForm.DisplayIFD(AOffset, ATIFFHeaderOffset: Int64;
  AParentTagID: Word; AInfo: String): Boolean;
var
  n: Int64;
  val: Int64;
  valsng: Single absolute val;
  i, j: Integer;
  numBytes: byte;
  s: String;
//  pTag: PTagEntry;
  pTag: TTagDef;
  tagID: TTagIDRec;
  dt: byte;
  ds: Integer;
begin
  Result := false;

  numBytes := 2;
  if not GetExifIntValue(AOffset, numBytes, n) then
    exit;

  AnalysisInfo.Caption := AInfo;
  AnalysisNotebook.PageIndex := 0;
  AnalysisGrid.RowCount := AnalysisGrid.FixedRows + n*4 + 2;

  j := AnalysisGrid.FixedRows;
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
  AnalysisGrid.Cells[2, j] := IntToStr(n);
  AnalysisGrid.Cells[3, j] := 'Number of directory entries';
  inc(AOffset, numbytes);
  inc(j);

  tagID.Parent := AParentTagID;

  for i:=0 to n-1 do begin
    numbytes := 2;
    if not GetExifIntValue(AOffset, numbytes, val) then
      exit;

    tagID.Tag := val;
    pTag := FindExifTagDef(DWord(tagID));
    {
    if FCurrIFDIndex = INDEX_GPS then
      pTag := FindGpsTag(val)
    else
      pTag := FindExifTag(val);
      }
    if pTag = nil then
      s := 'unknown'
    else
      s := pTag.Desc;
//      s := pTag^.Desc;
    AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
    AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
    AnalysisGrid.Cells[2, j] := Format('%d ($%.4x)', [val, val]);
    AnalysisGrid.Cells[3, j] := Format('#%d: Tag type (%s)', [i, s]);
    inc(AOffset, numbytes);
    inc(j);

    numbytes := 2;
    if not GetExifIntValue(AOffset, numbytes, val) then
      exit;
    case val of
       1: s := 'UInt8';
       2: s := 'Zero-term. byte-string';
       3: s := 'UInt16';
       4: s := 'UInt32';
       5: s := 'Fraction';
       6: s := 'Int8';
       7: s := 'binary';
       8: s := 'Int16';
       9: s := 'Int32';
      10: s := 'Signed fraction';
      11: s := 'Single';
      12: s := 'Double';
      else s := '';
    end;
    dt := val;
    AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
    AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
    AnalysisGrid.Cells[2, j] := Format('%d', [val]);
    AnalysisGrid.Cells[3, j] := Format('   Data type (%s)', [s]);;
    inc(AOffset, numbytes);
    inc(j);

    numbytes := 4;
    if not GetExifIntValue(AOffset, numbytes, val) then
      exit;
    ds := val;
    AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
    AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
    AnalysisGrid.Cells[2, j] := IntToStr(ds);
    AnalysisGrid.Cells[3, j] := '   Data size (L)';
    inc(AOffset, numbytes);
    inc(j);

    numbytes := 4;
    if not GetExifIntValue(AOffset, numbytes, val) then
      exit;
    AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
    AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
    if ds <= 4 then
      case dt of
         2: begin
              SetLength(s, ds);
              Move(val, s[1], ds);
            end;
         7: begin
              SetLength(s, ds);
              Move(val, s[1], ds);
            end;
        11: s := FloatToStr(valsng);
       else s := IntToStr(val);
      end
    else begin
      s := IntToStr(val);
      s := s + ' --> ' + GetExifValue(ATiffHeaderOffset + val, dt, ds);
    end;
    AnalysisGrid.Cells[2, j] := s;
    if ds <= 4 then
      AnalysisGrid.Cells[3, j] := '   Data value' else
      AnalysisGrid.Cells[3, j] := '   Offset to data --> Data';
    inc(AOffset, numbytes);
    inc(j);
  end;

  numbytes := 4;
  if not GetExifIntValue(AOffset, numbytes, val) then
    exit;
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
  if val = 0 then begin
    AnalysisGrid.Cells[2, j] := IntToStr(val);
    AnalysisGrid.Cells[3, j] := 'End marker';
  end else begin
    AnalysisGrid.Cells[2, j] := IntToStr(val) + ' --> ' + IntToStr(ATiffHeaderOffset + val);
    AnalysisGrid.Cells[3, j] := 'Offset to next IFD';
  end;
  inc(AOffset, numbytes);

  Result := true;
end;

function TMainForm.DisplayMarkerCOM(AOffset: Int64): Boolean;
var
  j: Integer;
  numbytes: Integer;
  val: Int64;
  s: String = '';
begin
  Result := false;

  AnalysisInfo.Caption := 'COM (Comment)';
  AnalysisNotebook.PageIndex := 0;
  AnalysisGrid.RowCount := 3 + AnalysisGrid.FixedRows;
  j := AnalysisGrid.FixedRows;

  numbytes := 2;
  if not GetBEIntValue(AOffset, numbytes, val) then
    exit;
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
  AnalysisGrid.Cells[2, j] := Format('%d ($%.4x)', [val, val]);
  AnalysisGrid.Cells[3, j] := 'COM marker';
  inc(j);
  inc(AOffset, numbytes);

  numbytes := 2;
  if not GetBEIntValue(AOffset, numbytes, val) then
    exit;
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
  AnalysisGrid.Cells[2, j] := IntToStr(val);
  AnalysisGrid.Cells[3, j] := 'Size';
  inc(j);
  inc(AOffset, numbytes);

  SetLength(s, val - 2);
  Move(FBuffer^[AOffset], s[1], Length(s));
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
  AnalysisGrid.Cells[2, j] := s;
  AnalysisGrid.Cells[3, j] := 'Comment text';
  inc(j);

  Result := true;
end;

function TMainForm.DisplayMarkerEOI(AOffset: Int64): Boolean;
var
  val: Int64;
  j: Integer;
  numbytes: Byte;
begin
  Result := false;

  AnalysisInfo.Caption := 'EOI (End of image)';

  AnalysisNotebook.PageIndex := 0;
  AnalysisGrid.RowCount := 1 + AnalysisGrid.FixedRows;
  j := AnalysisGrid.FixedRows;

  numbytes := 2;
  if not GetBEIntValue(AOffset, numbytes, val) then
    exit;
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
  AnalysisGrid.Cells[2, j] := Format('%d ($%.4x)', [val, val]);
  AnalysisGrid.Cells[3, j] := 'EOI marker';
  inc(j);
  inc(AOffset, numbytes);

  Result := true;
end;

function TMainForm.DisplayMarkerSOF0(AOffset: Int64): Boolean;
var
  val: Int64;
  j: Integer;
  numbytes: Byte;
begin
  Result := false;

  AnalysisInfo.Caption := 'SOF0 (Start of frame 0)';
  AnalysisNotebook.PageIndex := 0;
  AnalysisGrid.RowCount := 6 + AnalysisGrid.FixedRows;
  j := AnalysisGrid.FixedRows;

  numbytes := 2;
  if not GetBEIntValue(AOffset, numbytes, val) then
    exit;
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
  AnalysisGrid.Cells[2, j] := Format('%d ($%.4x)', [val, val]);
  AnalysisGrid.Cells[3, j] := 'SOF0 marker';
  inc(j);
  inc(AOffset, numbytes);

  numbytes := 2;
  if not GetBEIntValue(AOffset, numbytes, val) then
    exit;
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
  AnalysisGrid.Cells[2, j] := IntToStr(val);
  AnalysisGrid.Cells[3, j] := 'Size';
  inc(j);
  inc(AOffset, numbytes);

  numbytes := 1;
  if not GetBEIntValue(AOffset, numbytes, val) then
    exit;
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
  AnalysisGrid.Cells[2, j] := IntToStr(val);
  AnalysisGrid.Cells[3, j] := 'Data precision (bits/sample)';
  inc(j);
  inc(AOffset, numbytes);

  numbytes := 2;
  if not GetBEIntValue(AOffset, numbytes, val) then
    exit;
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
  AnalysisGrid.Cells[2, j] := IntToStr(val);
  AnalysisGrid.Cells[3, j] := 'Image height';
  inc(j);
  inc(AOffset, numbytes);

  numbytes := 2;
  if not GetBEIntValue(AOffset, numbytes, val) then
    exit;
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
  AnalysisGrid.Cells[2, j] := IntToStr(val);
  AnalysisGrid.Cells[3, j] := 'Image width';
  inc(j);
  inc(AOffset, numbytes);

  numbytes := 1;
  if not GetBEIntValue(AOffset, numbytes, val) then
    exit;
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
  AnalysisGrid.Cells[2, j] := IntToStr(val);
  AnalysisGrid.Cells[3, j] := 'Number of components';
  inc(j);
  inc(AOffset, numbytes);

  Result := true;
end;

function TMainForm.DisplayTIFFHeader(AOffset: Int64): Boolean;
var
  s: String;
  numbytes: Byte;
  j, val: Int64;
  tiffHdr: Int64;
begin
  Result := false;

  tiffHdr := AOffset;
  AnalysisInfo.Caption := 'TIFF header';
  AnalysisNotebook.PageIndex := 0;
  AnalysisGrid.RowCount := AnalysisGrid.FixedRows + 3;
  j := AnalysisGrid.FixedRows;

  s := char(FBuffer^[AOffset]) + char(FBuffer^[AOffset+1]);
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := '2';
  AnalysisGrid.Cells[2, j] := s;
  if s = 'II' then s := 'Intel (little endian)' else
  if s = 'MM' then s := 'Motorola (big endian)' else s := '';
  AnalysisGrid.Cells[3, j] := 'Byte order (' + s + ')';
  inc(j);
  inc(AOffset, 2);

  numbytes := 2;
  if not GetExifIntValue(AOffset, numbytes, val) then exit;
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
  AnalysisGrid.Cells[2, j] := Format('%d ($%.4x)', [val, val]);
  AnalysisGrid.Cells[3, j] := 'TIFF version number';
  inc(j);
  inc(AOffset, numbytes);

  numbytes := 4;
  if not GetExifIntValue(AOffset, numbytes, val) then exit;
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
  AnalysisGrid.Cells[2, j] := Format('%d --> %d', [val, tiffHdr + val]);
  AnalysisGrid.Cells[3, j] := 'Offset to first IFD (from begin of TIFF header)';
  inc(j);
  inc(AOffset, numbytes);
end;


function TMainForm.DisplayMarkerSOI(AOffset: Int64): Boolean;
var
  val: Int64;
  j: Integer;
  numbytes: Byte;
begin
  Result := false;

  AnalysisInfo.Caption := 'SOI (Start of image)';
  AnalysisNotebook.PageIndex := 0;
  AnalysisGrid.RowCount := 1 + AnalysisGrid.FixedRows;
  j := AnalysisGrid.FixedRows;

  numbytes := 2;
  if not GetBEIntValue(AOffset, numbytes, val) then
    exit;
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
  AnalysisGrid.Cells[2, j] := Format('%d ($%.4x)', [val, val]);
  AnalysisGrid.Cells[3, j] := 'SOI marker';
  inc(j);
  inc(AOffset, numbytes);

  Result := true;
end;


function TMainForm.DisplayMarkerSOS(AOffset: Int64): Boolean;
var
  val: Int64;
  j: Integer;
  numbytes: Byte;
begin
  Result := false;

  AnalysisInfo.Caption := 'SOS (Start of scan)';
  AnalysisNotebook.PageIndex := 0;
  AnalysisGrid.RowCount := 2 + AnalysisGrid.FixedRows;
  j := AnalysisGrid.FixedRows;

  numbytes := 2;
  if not GetBEIntValue(AOffset, numbytes, val) then
    exit;
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
  AnalysisGrid.Cells[2, j] := Format('%d ($%.4x)', [val, val]);
  AnalysisGrid.Cells[3, j] := 'SOS marker';
  inc(j);
  inc(AOffset, numbytes);

  numbytes := 2;
  if not GetBEIntValue(AOffset, numbytes, val) then
    exit;
  AnalysisGrid.Cells[0, j] := Format(OFFSET_MASK, [AOffset]);
  AnalysisGrid.Cells[1, j] := IntToStr(numbytes);
  AnalysisGrid.Cells[2, j] := IntToStr(val);
  AnalysisGrid.Cells[3, j] := 'Size';
  inc(j);
  inc(AOffset, numbytes);

  Result := true;
end;


function TMainForm.DisplayXMP(AOffset: Int64; ALength: Integer): Boolean;
var
  s: String = '';
begin
  Result := false;
  AnalysisInfo.Caption := 'XMP meta data';
  AnalysisNotebook.PageIndex := 1;

  if (AOffset + ALength >= FBufferSize) then
    exit;

  SetLength(s, ALength);
  Move(FBuffer^[AOffset], s[1], ALength);
  AnalysisSynEdit.Lines.Text := s;

  Result := true;
end;


procedure TMainForm.ExifGridCompareCells(Sender: TObject;
  ACol, ARow, BCol, BRow: Integer; var Result: integer);
var
  sA, sB: String;
begin
  sA := ExifGrid.Cells[ACol, ARow];
  sB := ExifGrid.Cells[BCol, BRow];
  Result := CompareText(sA, sB);
  if ExifGrid.SortOrder = soDescending then
    Result := -Result;
end;


function TMainForm.FindMarker(AMarker: byte): Int64;
var
  p, p0: PByte;
  pw: PWord;
  len: Integer;
begin
  Result := -1;
  if FBuffer = nil then
    exit;

  // The EOI marker is the last marker of the file, following the compressed data
  // which have unknown length. --> We find the marker by scanning
  // NOTE: Markers are not allowed in compressed data
  // (https://stackoverflow.com/questions/26715684/parsing-jpeg-sos-marker)
  if AMarker = MARKER_EOI then begin
    Result := 0;
    p := @FBuffer^[0];
    while Result < FBufferSize do begin
      if p^ = $FF then begin
        inc(p);
        if p^ = AMarker then
          exit;
        inc(Result);
      end;
      inc(p);
      inc(Result);
    end;
    Result := -1;
    exit;
  end;

  p := @FBuffer^[0];
  if p^ <> $FF then exit;
  p := @FBuffer^[1];
  if p^ <> $D8 then exit;

  if (AMarker = $D8) then begin
    Result := 0;
    exit;
  end;

  Result := 2;
  p := @FBuffer^[2];
  p0 := p;
  while (Result < FBufferSize) do begin
    while (p^ in [$FF, 0]) do
      inc(p);
    dec(p);

    if p^ <> $FF then begin
      Result := -1;
      exit;
    end;
    inc(p);
    if p^ = AMarker then begin
      Result := p - p0 + 1;
//      dec(Result, 2);
      exit;
    end;
    inc(p);
    pw := PWord(p);
    len := BEToN(pw^);
    inc(p, len);
    Result := Result + 2 + len;
  end;
  Result := -1;
end;

function TMainForm.FindNextMarker(AMarker: Byte; AFromPos: Int64): Int64;
var
  p: PByte;
begin
  Result := AFromPos;
  p := @FBuffer^[AFromPos];
  while Result < FBufferSize do begin
    if p^ = $FF then begin
      inc(p);
      if p^ = AMarker then
        exit;
      inc(Result);
    end;
    inc(p);
    inc(Result);
  end;
  Result := -1;
end;

function TMainForm.FindNextMarker: Int64;
var
  p: PByte;
  w: word;
  offs0: Int64;
begin
  Result := -1;
  if FBuffer^[FCurrOffset] <> $FF then begin
    ShowMessage('Navigate to the begin of a segment first.');
    exit;
  end;
  if FCurrOffset = 0 then
    Result := 2
  else begin
    offs0 := FCurrOffset;
    p := @FBuffer^[FCurrOffset + 2];
    w := BEToN(PWord(p)^);
    inc(p, w + 2);
    Result := FCurrOffset + w + 2;
    if FBuffer^[Result] <> $FF then
      FCurroffset := offs0;
  end;
end;

function TMainForm.FindTIFFHeader: Int64;
var
  p: PByte;
begin
  Result := FindMarker(MARKER_APP1);
  if Result = -1 then
    exit;
  while Result < FBufferSize do begin
    p := @FBuffer^[Result];
    inc(p, 4);
    if PChar(p) = 'Exif' then begin
      inc(Result, 2 + 2 + Length('Exif'#0#0));
      exit;
    end else begin
      Result := FindNextMarker(Marker_APP1, Result+1);
      if Result > 0 then
        exit;
    end;
  end;
end;

function TMainForm.FindXMP(out XMPLength: Integer): Int64;
var
  p: PByte;
begin
  XMPLength := -1;
  Result := FindMarker(MARKER_APP1);
  if Result = -1 then
    exit;
  while Result < FBufferSize do begin
    p := @FBuffer^[Result];
    inc(p, 4);
    if PChar(p) = XMP_BASE_KEY then
    begin
      dec(p, 2);
      XMPLength := BEToN(PWord(p)^) - 2 - Length(XMP_KEY);
      inc(Result, 2 + 2 + Length(XMP_KEY));
      exit;
    end else
    begin
      Result := FindNextMarker(MARKER_APP1, Result+1);
      if Result = -1 then
        exit;
    end;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  FCurrOffset := -1;
  FLoadFPExif := true;

  TbGotoSOI.Tag := MARKER_SOI;
  TbGotoAPP0.Tag := MARKER_APP0;
  TbGotoAPP1.Tag := MARKER_APP1;
  TbGotoAPP2.Tag := MARKER_APP2;
  TbGotoAPP13.Tag := MARKER_APP13;
  TbGotoSOF0.Tag := MARKER_SOF0;
  TbGotoSOF1.Tag := MARKER_SOF1;
  TbGotoSOF2.Tag := MARKER_SOF2;
  TbGotoSOF3.Tag := MARKER_SOF3;
  TbGotoDHT.Tag := MARKER_DHT;
  TbGotoSOF5.Tag := MARKER_SOF5;
  TbGotoSOF6.Tag := MARKER_SOF6;
  TbGotoSOF7.Tag := MARKER_SOF7;
  TbGotoJPG.Tag := MARKER_JPG;
  TbGotoSOF9.Tag := MARKER_SOF9;
  TbGotoSOF10.Tag := MARKER_SOF10;
  TbGotoSOF11.Tag := MARKER_SOF11;
  TbGotoSOF13.Tag := MARKER_SOF13;
  TbGotoSOF14.Tag := MARKER_SOF14;
  TbGotoSOF15.Tag := MARKER_SOF15;
  TbGotoDAC.Tag := MARKER_DAC;
  TbGotoCOM.Tag := MARKER_COM;
  TbGotoDQT.Tag := MARKER_DQT;
  TbGotoSOS.Tag := MARKER_SOS;
  TbGotoEOI.Tag := MARKER_EOI;

  AcGotoIFD0.Tag := AcGotoTIFFHeader.Tag + 1 + INDEX_IFD0;
  AcGotoEXIFSubIFD.Tag := AcGotoTIFFHeader.Tag + 1 + INDEX_EXIF;
  AcGotoINTEROPSubIFD.Tag := AcGotoTIFFHeader.Tag + 1+ INDEX_INTEROP;
  AcGotoGPSSubIFD.Tag := AcGotoTIFFHeader.Tag + 1 + INDEX_GPS;
  AcGotoIFD1.Tag := AcGotoTIFFHeader.Tag + 1 + INDEX_IFD1;

  FMRUMenuManager := TMRUMenuManager.Create(self);
  with FMRUMenuManager do begin
    Name := 'MRUMenuManager';
    IniFileName := CalcIniName;
    IniSection := 'RecentFiles';
    MaxRecent := MaxHistory;
    MenuCaptionMask := '&%x - %s';    // & --> create hotkey
    MenuItem := MnuMostRecentlyUsed;
    PopupMenu := RecentFilesPopup;
    OnRecentFile := @MRUMenuManagerRecentFile;
  end;

  FHexEditor := THexEditor.Create(self);
  with FHexEditor do
  begin
    Parent := PgHex;
    Width := 600;
    Align := alLeft;
    Font.Name := GetFixedFontName;   // The hard-coded Courier New does not exist in Linux
    Font.Size := 9;
    BytesPerColumn := IfThen(cbHexSingleBytes.Checked, 1, 2);
    RulerNumberBase := IfThen(cbHexAddressMode.Checked, 16, 10);
    OffsetFormat := IfThen(cbHexAddressMode.Checked, '-!10:$|', '-!0A: |');
    ReadOnlyView := true;
    OnClick := @HexEditorClick;
  end;

  with AnalysisGrid do begin
    ColWidths[0] := 120;
    ColWidths[1] := 50;
    ColWidths[2] := 150;
  end;

  with ValueGrid do begin
    ColCount := 3;
    RowCount := ROW_PWIDECHAR + 1;
    Cells[0, 0] := 'Data type';
    Cells[1, 0] := 'Value';
    Cells[2, 0] := 'Offset range (byte count)';
    Cells[0, ROW_INDEX] := 'Offset';
    Cells[0, ROW_BITS] := 'Bits';
    Cells[0, ROW_BYTE] := 'Byte';
    Cells[0, ROW_SHORTINT] := 'ShortInt';
    Cells[0, ROW_WORD] := 'Word';
    Cells[0, ROW_WORD_BE] := 'Word (BE)';
    Cells[0, ROW_SMALLINT] := 'SmallInt';
    Cells[0, ROW_SMALLINT_BE] := 'SmallInt (BE)';
    Cells[0, ROW_DWORD] := 'DWord';
    Cells[0, ROW_DWORD_BE] := 'DWord (BE)';
    Cells[0, ROW_LONGINT] := 'LongInt';
    Cells[0, ROW_LONGINT_BE] := 'LongInt (BE)';
    Cells[0, ROW_QWORD] := 'QWord';
    Cells[0, ROW_QWORD_BE] := 'QWord (BE)';
    Cells[0, ROW_INT64] := 'Int64';
    Cells[0, ROW_INT64_BE] := 'Int64 (BE)';
    Cells[0, ROW_RATIONAL64] := 'Rational';
    Cells[0, ROW_RATIONAL64_BE] := 'Rational (BE)';
    Cells[0, ROW_SINGLE] := 'Single';
    Cells[0, ROW_DOUBLE] := 'Double';
    Cells[0, ROW_ANSISTRING] := 'AnsiString';
    Cells[0, ROW_PANSICHAR] := 'PAnsiChar';
    Cells[0, ROW_WIDESTRING] := 'WideString';
    Cells[0, ROW_PWIDECHAR] := 'PWideChar';
    ColWidths[0] := Canvas.TextWidth(' SmallInt (BE) ');
  end;
  CbHexAddressModeChange(nil);

  for i:=0 to HexToolbar.ButtonCount-1 do
    HexToolbar.Buttons[i].Enabled := false;
  {
  Populate_dExifGrid(0);  // Exif tags
  Populate_dExifGrid(1);  // Exif thumbnail tags
  Populate_dExifGrid(2);  // IPTC tags
  }
end;

procedure TMainForm.FormDeactivate(Sender: TObject);
begin
  WriteToIni;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  WriteToIni;
end;

function TMainForm.GetBEIntValue(AOffset: Int64; AByteCount: Byte;
  out AValue: Int64): Boolean;
var
  b: Byte = 0;
  w: Word = 0;
  dw: DWord = 0;
  qw: Int64 = 0;
begin
  Result := false;
  if AOffset - AByteCount >= FBufferSize then
    exit;
  case AByteCount of
    1: begin
         b := FBuffer^[AOffset];
         AValue := b;
       end;
    2: begin
         Move(FBuffer^[AOffset], w, 2);
         AValue := BEToN(w);
       end;
    4: begin
         Move(FBuffer^[AOffset], dw, 4);
         AValue := BEToN(dw);
       end;
    else
      raise Exception.Create('This integer data type is not supporred.');
  end;
  Result := true;
end;

function TMainForm.GetExifIntValue(AOffset: Int64; AByteCount: Byte;
  out AValue: Int64): Boolean;
var
  b: Byte = 0;
  w: Word = 0;
  dw: DWord = 0;
begin
  Result := false;
  if AOffset - AByteCount >= FBufferSize then
    exit;
  case AByteCount of
    1: begin
         b := FBuffer^[AOffset];
         AValue := b;
       end;
    2: begin
         Move(FBuffer^[AOffset], w, 2);
         if FMotorolaOrder then w := BEToN(w) else w := LEtoN(w);
         AValue := w;
       end;
    4: begin
         Move(FBuffer^[AOffset], dw, 4);
         if FMotorolaOrder then dw := BEToN(dw) else dw := LEtoN(dw);
         AValue := dw;
       end;
    else
      raise Exception.Create('This integer datatype is not supported.');
  end;
  Result := true;
end;

function TMainForm.GetExifValue(AOffset: Int64; ADataType,ADataSize: Integer): String;
var
  n: Int64;
  sng: Single;
  dbl: Double;
  i: Integer;
begin
  if (AOffset + ADataSize > FBufferSize) or
     (AOffset + ADataSize < 0) then
  begin
    Result := '<???>';
    exit;
  end;

  case ADataType of
    1: Result := IntToStr(FBuffer^[AOffset]);  // unsigned byte
    2: begin   // ASCII string
         SetLength(Result, ADataSize);
         for i:=1 to ADataSize do
           Result[i] := char(FBuffer^[AOffset + i - 1]);  // ASCII string
         exit;
       end;
    3: begin  // unsigned short
         n := PWord(@FBuffer^[AOffset])^;
         if FMotorolaOrder then n := BEToN(n) else n := LEtoN(n);
         Result := IntToStr(n);
       end;
    4: begin  // unsigned long
         n := PDWord(@FBuffer^[AOffset])^;
         if FMotorolaOrder then n := BEToN(n) else n := LEtoN(n);
         Result := IntToStr(n);
       end;
    5: begin  // unsigned rational
         n := PDWord(@FBuffer^[AOffset])^;
         if FMotorolaOrder then n := BEToN(n) else n := LEtoN(n);
         Result := IntToStr(n);
         n := PDWord(@FBuffer^[AOffset + 4])^;
         if FMotorolaOrder then n := BEToN(n) else n := LEtoN(n);
         Result := Result + '/' + IntToStr(n);
       end;
    6: begin   // singed byte
         Result := IntToStr(ShortInt(@FBuffer^[AOffset]));
       end;
    7: begin   // undefined
         Result := '';
       end;
    8: begin   // signed short
         n := SmallInt(PWord(@FBuffer^[AOffset]));
         if FMotorolaOrder then n := BEToN(n) else LEtoN(n);
         Result := IntToStr(n);
       end;
    9: begin   // signed long
         n := LongInt(PDWord(@FBuffer^[AOffset])^);
         if FMotorolaOrder then n := BEToN(n) else LEtoN(n);
         Result := IntToStr(n);
       end;
   10: begin   // signed rational
         n := LongInt(PDWord(@FBuffer^[AOffset])^);
         if FMotorolaOrder then n := BEToN(n) else n := LEtoN(n);
         Result := IntToStr(n);
         n := LongInt(PDWord(@FBuffer^[AOffset + 4])^);
         if FMotorolaOrder then n := BEToN(n) else n := LEtoN(n);
         Result := Result + '/' + IntToStr(n);
       end;
   11: begin  // single
         sng := PSingle(@FBuffer^[AOffset])^;
         // Motorola?
         Result := Format('%g', [sng]);
       end;
   12: begin  // double
         dbl := PDouble(@FBuffer^[AOffset])^;
         // Motorola ??
         Result := Format('%g', [dbl]);
       end;
   else
       Result := '';
  end;
end;

{ Returns the names of the ADOBE image resource blocks. Used in APP13 segment.
  Ref.: https://www.adobe.com/devnet-apps/photoshop/fileformatashtml/#50577409_38034 }
function TMainForm.GetImageResourceBlockName(AID: Integer): String;
begin
  case AID of
    $03E8: Result := 'obsolete (Photoshop 2.0 only)';
    $03E9: Result := 'Macintosh print manager print info record';
    $03EA: Result := 'Macintosh page format information. No longer read by Photoshop. (Obsolete)';
    $03EB: Result := '(Obsolete--Photoshop 2.0 only ) Indexed color table';
    $03ED: Result := 'ResolutionInfo structure';
    $03EE: Result := 'Names of the alpha channels as a series of Pascal strings.';
    $03EF: Result := '(Obsolete) DisplayInfo structure';
    $03F0: Result := 'Caption as a Pascal string';
    $03F1: Result := 'Border information';
    $03F2: Result := 'Background color';
    $03F3: Result := 'Print flags';
    $03F4: Result := 'Grayscale and multichannel halftoning information';
    $03F5: Result := 'Color halftoning information';
    $03F6: Result := 'Duotone halftoning information';
    $03F7: Result := 'Grayscale and multichannel transfer function';
    $03F8: Result := 'Color transfer functions';
    $03F9: Result := 'Duotone transfer functions';
    $03FA: Result := 'Duotone image information';
    $03FB: Result := 'Two bytes for the effective black and white values for the dot range';
    $03FC: Result := '(Obsolete)';
    $03FD: Result := 'EPS options';
    $03FE: Result := 'Quick Mask information';
    $03FF: Result := '(Obsolete)';
    $0400: Result := 'Layer state information';
    $0401: Result := 'Working path (not saved)';
    $0402: Result := 'Layers group information';
    $0403: Result := '(Obsolete)';
    $0404: Result := 'IPTC-NAA record';
    $0405: Result := 'Image mode for raw format files';
    $0406: Result := 'JPEG quality. Private';
    $0408: Result := '(Photoshop 4.0) Grid and guides information';
    $0409: Result := '(Photoshop 4.0) Thumbnail resource for Photoshop 4.0 only';
    $040A: Result := '(Photoshop 4.0) Copyright flag';
    $040B: Result := '(Photoshop 4.0) URL. Handle of a text string with uniform resource locator';
    $040C: Result := '(Photoshop 5.0) Thumbnail resource (supersedes resource 1033)';
    $040D: Result := '(Photoshop 5.0) Global Angle';
    $040E: Result := '(Obsolete, Photoshop 5.0) Color samplers resource';
    $040F: Result := '(Photoshop 5.0) ICC Profile';
    $0410: Result := '(Photoshop 5.0) Watermark';
    $0411: Result := '(Photoshop 5.0) ICC Untagged Profile';
    $0412: Result := '(Photoshop 5.0) Effects visible';
    $0413: Result := '(Photoshop 5.0) Spot Halftone';
    $0414: Result := '(Photoshop 5.0) Document-specific IDs seed number';
    $0415: Result := '(Photoshop 5.0) Unicode Alpha Names';
    $0416: Result := '(Photoshop 6.0) Indexed Color Table Count';
    $0417: Result := '(Photoshop 6.0) Transparency Index';
    $0419: Result := '(Photoshop 6.0) Global Altitude';
    $041A: Result := '(Photoshop 6.0) Slices';
    $041B: Result := '(Photoshop 6.0) Workflow URL';
    $041C: Result := '(Photoshop 6.0) Jump To XPEP';
    $041D: Result := '(Photoshop 6.0) Alpha Identifiers';
    $041E: Result := '(Photoshop 6.0) URL List';
    $0421: Result := '(Photoshop 6.0) Version Info';
    $0422: Result := '(Photoshop 7.0) EXIF data 1';
    $0423: Result := '(Photoshop 7.0) EXIF data 3';
    $0424: Result := '(Photoshop 7.0) XMP metadata';
    $0425: Result := '(Photoshop 7.0) Caption digest';
    $0426: Result := '(Photoshop 7.0) Print scale';
    $0428: Result := '(Photoshop CS) Pixel Aspect Ratio';
    $0429: Result := '(Photoshop CS) Layer Comps';
    $042A: Result := '(Photoshop CS) Alternate Duotone Colors';
    $042B: Result := '(Photoshop CS)Alternate Spot Colors';
    $042D: Result := '(Photoshop CS2) Layer Selection ID(s)';
    $042E: Result := '(Photoshop CS2) HDR Toning information';
    $042F: Result := '(Photoshop CS2) Print info';
    $0430: Result := '(Photoshop CS2) Layer Group(s) Enabled ID';
    $0431: Result := '(Photoshop CS3) Color samplers resource';
    $0432: Result := '(Photoshop CS3) Measurement Scale';
    $0433: Result := '(Photoshop CS3) Timeline Information';
    $0434: Result := '(Photoshop CS3) Sheet Disclosure';
    $0435: Result := '(Photoshop CS3) DisplayInfo structure';
    $0436: Result := '(Photoshop CS3) Onion Skins';
    $0438: Result := '(Photoshop CS4) Count Information';
    $043A: Result := '(Photoshop CS5) Print Information';
    $043B: Result := '(Photoshop CS5) Print Style';
    $043C: Result := '(Photoshop CS5) Macintosh NSPrintInf';
    $043D: Result := '(Photoshop CS5) Windows DEVMODE';
    $043E: Result := '(Photoshop CS6) Auto Save File Path';
    $043F: Result := '(Photoshop CS6) Auto Save Format';
    $0440: Result := '(Photoshop CC) Path Selection State';
    $07D0..$0BB6: Result := 'Path Information (saved paths)';
    $0BB7: Result := 'Name of clipping path';
    $0BB8: Result := '(Photoshop CC) Origin Path Info';
    $0FA0..$1387: Result := 'Plug-In resource(s)';
    $1B58: Result := 'Image Ready variables';
    $1B59: Result := 'Image Ready data sets';
    $1B5A: Result := 'Image Ready default selected state';
    $1B5B: Result := 'Image Ready 7 rollover expanded state';
    $1B5C: Result := 'Image Ready rollover expanded state';
    $1B5D: Result := 'Image Ready save layer settings';
    $1B5E: Result := 'Image Ready version';
    $1B40: Result := '(Photoshop CS3) Lightroom workflow';
    $2710: Result := 'Print flags information';
    else   Result := '(unknown)';
  end;
end;


function TMainForm.GetMarkerName(AMarker: Byte; Long: Boolean): String;
begin
  case AMarker of
    MARKER_SOI   : Result := IfThen(Long, 'Start of image', 'SOI');
    MARKER_EOI   : Result := IfThen(Long, 'End of image', 'EOI');
    MARKER_APP0  : Result := IfThen(Long, 'Application marker 0 - JFIF', 'APP0 (JFIF)');
    MARKER_APP1  : Result := IfThen(Long, 'Application marker 1 - EXIF', 'APP1 (EXIF)');
    MARKER_APP2  : Result := IfThen(Long, 'Application marker 2', 'APP2');
    MARKER_APP13 : Result := IfThen(Long, 'Application marker 13 - IPTC', 'APP13 (IPTC)');
    MARKER_APP14 : Result := IfThen(Long, 'Application marker 14 - Copyright', 'APP14)');
    MARKER_COM   : Result := IfThen(Long, 'Comment marker', 'COM');
    MARKER_DAC   : Result := IfThen(Long, 'Definition of arithmetic coding', 'DAC');
    MARKER_DHT   : Result := IfThen(Long, 'Definition of Huffman tables', 'DHT');
    MARKER_DQT   : Result := IfThen(Long, 'Definition of quantization tables', 'DQT');
    MARKER_JPG   : Result := IfThen(Long, 'JPG extensions', 'JPG');
    MARKER_SOF0  : Result := IfThen(Long, 'Start of frame 0 - Baseline DCT', 'SOF0');
    MARKER_SOF1  : Result := IfThen(Long, 'Start of frame 1 - Extended sequential DCT', 'SOF1');
    MARKER_SOF2  : Result := IfThen(Long, 'Start of frame 2 - Progressive DCT', 'SOF2');
    MARKER_SOF3  : Result := IfThen(Long, 'Start of frame 3 - Lossless (sequential)', 'SOF3');
    MARKER_SOF5  : Result := IfThen(Long, 'Start of frame 5 - Differential sequential DCT', 'SOF5');
    MARKER_SOF6  : Result := IfThen(Long, 'Start of frame 6 - Differential progressive DCT', 'SOF6');
    MARKER_SOF7  : Result := IfThen(Long, 'Start of frame 7 - Differential lossless (sequential)', 'SOF7');
    MARKER_SOF9  : Result := IfThen(Long, 'Start of frame 0 - Extended sequential DCT', 'SOF9');
    MARKER_SOF10 : Result := IfThen(Long, 'Start of frame 10 - Proogressive DCT', 'SOF10');
    MARKER_SOF11 : Result := IfThen(Long, 'Start of frame 11 - Lossless (sequential)', 'SOF11');
    MARKER_SOF13 : Result := IfThen(Long, 'Start of frame 13 - Differential sequential DCT', 'SOF13');
    MARKER_SOF14 : Result := IfThen(Long, 'Start of frame 14 - Differential progressive DCT', 'SOF14');
    MARKER_SOF15 : Result := IfThen(Long, 'Start of frame 15 - Differential lossless (sequential)', 'SOF15');
    MARKER_SOS   : Result := IfThen(Long, 'Start of scan', 'SOS');
    else           Result := IfThen(Long, 'Unknown', Format('$%.2x', [AMarker]));
  end;
end;

function TMainForm.GetValueGridDataSize: Integer;

  function ExtractLength(s: String): Integer;
  var
    i: Integer;
    n1, n2: Integer;
    isFirst: Boolean;
  begin
    isFirst := true;
    n1 := 0;
    n2 := 0;
    for i:=1 to Length(s) do
      case s[i] of
        '0'..'9':
          if isFirst then
            n1 := n1*10 + ord(s[i]) - ord('0') else
            n2 := n2*10 + ord(s[i]) - ord('0');
        ' ': if isFirst then isFirst := false;
      end;
    Result := n2 - n1 + 1;
  end;

begin
  Result := -1;
  case ValueGrid.Row of
    ROW_BITS          : Result := SizeOf(Byte);
    ROW_BYTE          : Result := SizeOf(Byte);
    ROW_SHORTINT      : Result := SizeOf(ShortInt);
    ROW_WORD,
    ROW_WORD_BE       : Result := SizeOf(Word);
    ROW_SMALLINT,
    ROW_SMALLINT_BE   : Result := SizeOf(SmallInt);
    ROW_DWORD,
    ROW_DWORD_BE      : Result := SizeOf(DWord);
    ROW_LONGINT,
    ROW_LONGINT_BE    : Result := SizeOf(LongInt);
    ROW_QWORD,
    ROW_QWORD_BE      : Result := SizeOf(QWord);
    ROW_INT64,
    ROW_INT64_BE      : Result := SizeOf(Int64);
    ROW_RATIONAL64,
    ROW_RATIONAL64_BE : Result := SizeOf(DWord) * 2;
    ROW_SINGLE        : Result := SizeOf(Single);
    ROW_DOUBLE        : Result := SizeOf(Double);
    ROW_ANSISTRING,
    ROW_WIDESTRING,
    ROW_PANSICHAR,
    ROW_PWIDECHAR     : Result := ExtractLength(ValueGrid.Cells[2, ValueGrid.Row]);
  end;
end;

function TMainForm.GotoAdobeImageResource(AResourceID: Word;
  var AOffset: Int64): Boolean;
type
  TAPP13Header = packed record
    Marker: Word;
    Size: Word;
    Identifier: Array[1..14] of ansichar;
  end;
  PAPP13Header = ^TAPP13Header;

  TAdobeImageResourceHeader = packed record
    Key: array[1..4] of ansichar;
    ID: Word;
    NameLen: Byte;
  end;
  PAdobeImageResourceHeader = ^TAdobeImageResourceHeader;

var
  i: Int64;
  app13hdr: TAPP13Header;
  imgres: TAdobeImageResourceHeader;
  size: DWord;
begin
  Result := false;

  i := AOffset;

  app13hdr := PAPP13Header(@FBuffer^[i])^;
  app13hdr.Size := BEToN(app13hdr.Size);
  if not CompareMem(@app13hdr.Identifier[1], @IPTC_KEY[1], Length(IPTC_KEY)) then
    exit;

  inc(i, SizeOf(app13hdr));
  repeat
    imgres := PAdobeImageResourceHeader(@FBuffer^[i])^;
    imgres.ID := BEtoN(imgres.ID);
    if not CompareMem(@FBuffer^[i], @ADOBE_IMAGE_RESOURCE_KEY[1], 4) then
      exit;
    if imgres.ID = AResourceID then
      break;
    inc(i, SizeOf(imgres));
    if odd(imgres.NameLen) then
      inc(i, imgres.NameLen)
    else
      {%H-}inc(i, imgres.NameLen + 1);
    size := BEToN(PDWord(@FBuffer^[i])^);
    inc(i, size);
  until false;

  AOffset := i;
  Result := true;
end;

function TMainForm.GotoColorProfile(ASignature: String; var AOffset: Int64): Boolean;
var
  hdr: AnsiString = '';
  seq: AnsiString = '';
begin
  Result := false;
  inc(AOffset, 4);

  // Check header "ICC_PROFILE"
  SetLength(hdr, Length(ASignature));
  Move(FBuffer^[AOffset], hdr[1], Length(hdr));
  if hdr <> ASignature then
    exit;
  inc(AOffset, Length(hdr));

  // Check sequence number
  SetLength(seq, 3);
  Move(FBuffer^[AOffset], seq[1], Length(seq));
  if seq <> #00#01#01 then
    exit;
  inc(AOffset, Length(seq));

  // AOffset now points to the begin of the ICC Color profile as documented in
  // http://www.color.org/specification/ICC.2-2019.pdf

  Result := true;
end;


function TMainForm.GotoNextIFD(var AOffset: Int64): Boolean;
var
  n: Int64;
begin
  Result := false;

  if not GetExifIntValue(AOffset, 2, n) then
    exit;

  inc(AOffset, 2 + n*(2+2+4+4));
  if not GetExifIntValue(AOffset, 4, n) then
    exit;

  inc(AOffset, 4 + n);
  Result := true;
end;

procedure TMainForm.GotoOffset(AOffset: Int64);
begin
  if FBuffer = nil then
    exit;

  if AOffset > High(FBuffer^) then begin
    StatusMsg('Out of buffer limits.');
    exit;
  end;

  if AOffset < 0 then begin
    StatusMsg('Out of buffer limits.');
    exit;
  end;

  if AOffset >= FHexEditor.Datasize then begin
    StatusMsg('Out of buffer limits.');
    exit;
  end;

  FCurrOffset := AOffset;
  FHexEditor.SelStart := AOffset;
  FHexEditor.SelEnd := AOffset;
  FHexEditor.CenterCursorPosition;

  Populate_ValueGrid;
  UpdateStatusbar;
  TbNextSegment.Enabled := FBuffer^[AOffset] = $FF;
end;


function TMainForm.GotoSubIFD(ATag: Word;
  var AOffset: Int64; ATIFFHeaderOffset: Int64): boolean;
var
  n,L: Int64;
  val: Int64;
  i: Integer;
begin
  Result := false;

  if not GetExifIntValue(AOffset, 2, n) then
    exit;

  inc(AOffset, 2);

  for i:=0 to n-1 do begin
    if not GetExifIntValue(AOffset, 2, val) then
      exit;
    if val = ATag then begin        // See TAG_XXXX_OFFSET constants
      inc(AOffset, 2 + 2);
      if not GetExifIntValue(AOffset, 4, L) then exit;
      if L > 4 then
        AOffset := ATiffHeaderOffset + L
      else
        inc(AOffset, 4);
      if not GetExifIntValue(AOffset, 4, val) then exit;
      AOffset := ATiffHeaderOffset + val;
      Result := true;
      exit;
    end;
    inc(AOffset, 2 + 2 + 4 + 4);
  end;
end;


procedure TMainForm.HexEditorClick(Sender: TObject);
begin
  GotoOffset(FHexEditor.SelStart);
end;

(*
procedure TMainForm.HexEditorKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  sel: TKHexEditorSelection;
begin
  case Key of
    VK_LEFT  : dec(FCurrOffset);
    VK_RIGHT : inc(FCurrOffset);
    VK_UP    : dec(FCurrOffset, HexEditor.LineSize);
    VK_DOWN  : inc(FCurrOffset, HexEditor.LineSize);
    VK_HOME  : if (Shift = [ssCtrl]) then
                 FCurrOffset := 0 else
                 FCurrOffset := (FCurrOffset div HexEditor.LineSize) * HexEditor.LineSize;
    VK_END   : if (Shift = [ssCtrl]) then
                 FCurrOffset := FBufferSize-1 else
                 FCurrOffset := succ(FCurrOffset div HexEditor.LineSize) * HexEditor.lineSize - 1;
    VK_NEXT  : begin
                 if (Shift = [ssCtrl]) then
                   inc(FCurrOffset, HexEditor.LineSize * HexEditor.LineCount)
                 else
                   inc(FCurrOffset, HexEditor.LineSize * HexEditor.GetClientHeightChars);
                 while (FCurrOffset >= FBufferSize) do
                   dec(FCurrOffset, HexEditor.LineSize);
               end;
    VK_PRIOR : if (Shift = [ssCtrl]) then
                 FCurrOffset := FCurrOffset mod HexEditor.LineSize
               else
               begin
                 dec(FCurrOffset, HexEditor.LineSize * HexEditor.GetClientHeightChars);
                 while (FCurrOffset < 0) do
                   inc(FCurrOffset, HexEditor.LineSize);
               end;
    else
               exit;
  end;
  if FCurrOffset < 0 then FCurrOffset := 0;
  if FCurrOffset >= FBufferSize then FCurrOffset := FBufferSize - 1;
  sel.Index := FCurrOffset;
  sel.Digit := 0;
  HexEditor.SelStart := sel;
  HexEditorClick(nil);
  if not HexEditor.CaretInView then
    HexEditor.ExecuteCommand(ecScrollCenter);
   // THexEditorOpener(HexEditor).ScrollTo(HexEditor.SelToPoint(HexEditor.SelStart, HexEditor.EditArea), false, true);

  // Don't process these keys any more!
  Key := 0;
end;
*)

procedure TMainForm.MainPageControlChange(Sender: TObject);
begin
  AcImgFit.Enabled := MainPageControl.ActivePage = PgImage;
end;

procedure TMainForm.MRUMenuManagerRecentFile(Sender: TObject;
  const AFileName: string);
begin
  LoadFile(AFileName);
end;

procedure TMainForm.LoadFile(const AFileName: String);
var
  crs: TCursor;
begin
  Statusbar.Panels[PANEL_ENDIAN].Text := '';
  Statusbar.Panels[PANEL_OFFSET].Text := '';
  Statusbar.Panels[PANEL_MSG].Text := '';

  if AFileName = '' then begin
    ShowMessage('No file selected.');
    exit;
  end;
  if not FileExists(AFileName) then begin
    ShowMessage('File "' + AFilename + '" does not exist.');
    exit;
  end;

  FFilename := AFilename;
  FMRUMenuManager.AddToRecent(AFileName);
  Caption := Format('Exif Spy - "%s"', [FFilename]);
  AcFileReload.Enabled := true;

  crs := Screen.Cursor;
  Screen.Cursor := crHourglass;
  try
    FBuffer := nil;
    FHexEditor.LoadFromFile(aFileName);
    FBuffer := PBytes(FHexEditor.DataStorage.Memory);
    FBufferSize := FHexEditor.DataSize;
    FCurrOffset := 0;
    HexEditorClick(nil);

    if ScanIFDs then
      UpdateIFDs;
    UpdateMarkers;
    ClearAnalysis;

    FreeAndNil(FImgInfo);
    if FLoadFpExif then begin
      FImgInfo := TImgInfo.Create;
      FImgInfo.LoadFromFile(AFileName);
      Populate_fpExifGrids;
    end;

    Image.Picture.LoadFromFile(AFileName);
    Image.Width := FWidth;
    Image.Height := FHeight;
    AcImgFitExecute(nil);

  finally
    Screen.Cursor := crs;
  end;
end;

(*
// AKind = 0  --> dExif
// AKind = 1  --> dExif thumbnail
// AKind = 2  --> IPTC
procedure TMainForm.Populate_dExifGrid(AKind: Integer);
var
  tagCount: Integer;
  t: TTagEntry;
  i, j: Integer;
  grid: TStringGrid;
  ok: Boolean;
begin
  ok := false;
  case AKind of
    0: begin
         grid := dExif_TagsGrid;
         ok := (FImgData <> nil) and FImgData.HasExif;
         if ok then
           tagCount := FImgData.ExifObj.FITagCount;
       end;
    1: begin
         grid := dExif_ThumbTagsGrid;
         ok := (FImgData <> nil) and FImgData.HasExif;
         if ok then
           tagCount := FImgData.ExifObj.FIThumbCount;
       end;
    2: begin
         grid := IPTC_TagsGrid;
         ok := (FImgData <> nil) and FImgData.HasIPTC;
         if ok then
           tagCount := FImgData.IPTCObj.Count;
       end;
    else
       raise Exception.Create('Populate_dExifGrid: AKind unknown.');
  end;
  grid.ColCount := 16;

  if ok then begin
    grid.RowCount := tagCount + grid.FixedRows;
    for i:=0 to tagCount-1 do begin
      case AKind of
        0: t := FImgData.ExifObj.FITagArray[i];
        1: t := FImgData.ExifObj.FIThumbArray[i];
        2: t := FImgData.IPTCObj.ITagArray[i];
        else raise Exception.Create('Populate_dExifGrid: AKind unknown.');
      end;
      j := grid.FixedRows + i;
      with grid do begin
        Cells[ 0, j] := IntToStr(i);
        Cells[ 1, j] := IntToStr(t.TID);
        Cells[ 2, j] := IntToStr(t.TType);
        cells[ 3, j] := IntToStr(t.ICode);
        Cells[ 4, j] := Format('%d ($%.4x)', [t.Tag, t.Tag]);
        Cells[ 5, j] := t.Name;
        Cells[ 6, j] := t.Desc;
        Cells[ 7, j] := t.Code;
        Cells[ 8, j] := t.Data;
        Cells[ 9, j] := t.Raw;
        Cells[10, j] := IntToStr(t.PRaw);
        Cells[11, j] := t.FormatS;
        Cells[12, j] := IntToStr(t.Size);
        Cells[13, j] := Format('$%.8x', [PtrInt(@t.CallBack)]);
        Cells[14, j] := IntToStr(t.id);
        Cells[15, j] := IntToStr(t.parentid);
      end;
    end;
  end else
  begin
    grid.RowCount := grid.FixedRows + 1;
    grid.Rows[grid.FixedRows].Clear;
    StatusMsg('No EXIF data found.');
  end;

  with grid do begin
    Cells[ 1, 0] := 'TID';
    Cells[ 2, 0] := 'TType';
    Cells[ 3, 0] := 'TCode';
    Cells[ 4, 0] := 'Tag';
    Cells[ 5, 0] := 'Name';
    Cells[ 6, 0] := 'Desc';
    Cells[ 7, 0] := 'Code';
    Cells[ 8, 0] := 'Data';
    Cells[ 9, 0] := 'Raw';
    Cells[10, 0] := 'PRaw';
    Cells[11, 0] := 'FormatS';
    Cells[12, 0] := 'Size';
    Cells[13, 0] := 'CallBack';
    Cells[14, 0] := 'id';
    Cells[15, 0] := 'parentid';
    ColWidths[0] := 40;
    ColWidths[4] := 100;
    ColWidths[5] := 200;
    ColWidths[6] := 200;
  end;
end;
*)


function BytesToStr(B: fpeGlobal.TBytes; MaxLen: Integer): String;
var
  i, n: Integer;
  suffix: String = '';
begin
  Result := '';
  n := Length(B);
  if n = 0 then
    exit;
  Result := Format('%.2x', [B[0]]);
  if n > MaxLen then
  begin
    n := MaxLen;
    suffix := '...';
  end;
  for i := 1 to n-1 do
    Result := Format('%s %.2x', [Result, B[i]]);
  Result := Result + suffix;
end;


procedure TMainForm.Populate_fpExifGrids;
var
  i, row, w: Integer;
  lTag: TTag;
  suffix: string;
begin
  if FImgInfo.HasExif then begin
    fpExifGridPage.TabVisible := true;

    //FImageOrientation := FImgInfo.ExifData.ImgOrientation;
    FImgInfo.ExifData.ExportOptions := FImgInfo.ExifData.ExportOptions + [eoTruncateBinary];
    ExifGrid.RowCount := FImgInfo.ExifData.TagCount + 1;
    ExifGrid.ColCount := 10;
    ExifGrid.Cells[0, 0] := 'Tag ID';
    ExifGrid.Cells[1, 0] := 'Tag Group';
    ExifGrid.Cells[2, 0] := 'Tag';
    ExifGrid.Cells[3, 0] := 'Name';
    ExifGrid.Cells[4, 0] := 'Description';
    ExifGrid.Cells[5, 0] := 'Tag type';
    ExifGrid.Cells[6, 0] := 'Count';
    ExifGrid.Cells[7, 0] := 'Endian';
    ExifGrid.Cells[8, 0] := 'Value';
    ExifGrid.Cells[9, 0] := 'Raw data';

    ExifGrid.FixedCols := 0;
    for i := 0 to FImgInfo.ExifData.TagCount-1 do begin
      row := i+1;
      lTag := FImgInfo.ExifData.TagByIndex[i];

      if lTag is TMakerNoteStringTag then
        suffix := ':' + IntToStr(TMakerNoteStringTag(lTag).Index)
      else if lTag is TMakerNoteIntegerTag then
        suffix := ':' + IntToStr(TMakerNoteIntegerTag(lTag).Index)
      else if lTag is TMakerNoteFloatTag then
        suffix := ':' + IntToStr(TMakerNoteFloatTag(lTag).Index)
      else
        suffix := '';

      if lTag is TVersionTag then
        TVersionTag(lTag).Separator := '.';

      ExifGrid.Cells[0, row] := Format('%0:d ($%0:4x)', [lTag.TagIDRec.Tag]);
      ExifGrid.Cells[1, row] := NiceGroupNames[lTag.Group];
      ExifGrid.Cells[2, row] := Format('$%.04x:$%.04x%s', [lTag.TagIDRec.Parent, lTag.TagIDRec.Tag, suffix]);
      ExifGrid.Cells[3, row] := lTag.Name;
      ExifGrid.Cells[4, row] := lTag.Description;
      ExifGrid.Cells[5, row] := GetEnumName(TypeInfo(TTagType), integer(lTag.TagType));
      ExifGrid.Cells[6, row] := IntToStr(lTag.Count);
      ExifGrid.Cells[7, row] := IfThen(lTag.BigEndian, 'BE', 'LE');
      ExifGrid.Cells[8, row] := lTag.AsString;
      ExifGrid.Cells[9, row] := BytesToStr(lTag.RawData, 16);
    end;

    for i:=0 to ExifGrid.ColCount-1 do begin
      w := ExifGrid.Canvas.TextWidth(ExifGrid.Cells[i, 0]);
      for row := 1 to ExifGrid.RowCount-1 do
        w := Max(w, ExifGrid.Canvas.TextWidth(ExifGrid.Cells[i, row]));
      ExifGrid.ColWidths[i] := w + 4*varCellPadding;
    end;
  end else
    fpExifGridPage.TabVisible := false;

  if FImgInfo.HasIptc then begin
    IPTCGridPage.TabVisible := true;
    IPTCGrid.RowCount := FImgInfo.IptcData.TagCount + 1;
    IPTCGrid.ColCount := 7;
    IPTCGrid.Cells[0, 0] := 'Tag ID';
    IPTCGrid.Cells[1, 0] := 'Tag';
    IPTCGrid.Cells[2, 0] := 'Name';
    IPTCGrid.Cells[3, 0] := 'Description';
    IPTCGrid.Cells[4, 0] := 'Tag type';
    IPTCGrid.Cells[5, 0] := 'Count';
    IPTCGrid.Cells[6, 0] := 'Value';
    IPTCGrid.FixedCols := 0;
    for i := 0 to FImgInfo.IptcData.TagCount-1 do begin
      row := i + 1;
      lTag := FImgInfo.IptcData.TagByIndex[i];
      IPTCGrid.Cells[0, row] := Format('%0:d ($%0:4x)', [lTag.TagIDRec.Tag]);
      IPTCGrid.Cells[1, row] := Format('$%.04x:$%.04x%s', [lTag.TagIDRec.Parent, lTag.TagIDRec.Tag, suffix]);
      IPTCGrid.Cells[2, row] := lTag.Name;
      IPTCGrid.Cells[3, row] := lTag.Description;
      IPTCGrid.Cells[4, row] := GetEnumName(TypeInfo(TTagType), integer(lTag.TagType));
      IPTCGrid.Cells[5, row] := IntToStr(lTag.Count);
      IPTCGrid.Cells[6, row] := lTag.AsString;
    end;

    for i:=0 to IPTCGrid.ColCount-1 do begin
      w := IPTCGrid.Canvas.TextWidth(IPTCGrid.Cells[i, 0]);
      for row := 1 to IPTCGrid.RowCount-1 do
        w := Max(w, IPTCGrid.Canvas.TextWidth(IPTCGrid.Cells[i, row]));
      IPTCGrid.ColWidths[i] := w + 4*varCellPadding;
    end;
  end else
    IPTCGridPage.TabVisible := false;
end;

procedure TMainForm.Populate_ValueGrid;
type
  TRational = record num, denom: DWord; end;
const
  MAX_LEN = 32;
var
  buf: array[0..1023] of Byte;
  w: word absolute buf;
  dw: DWord absolute buf;
  qw: QWord absolute buf;
  dbl: double absolute buf;
  sng: single absolute buf;
//  rat: TRational absolute buf;
  rat: TRational;
  idx: Integer;
  i, j: Integer;
  s: String = '';
  sw: WideString = '';
  ls: SizeInt;
  pw: PWideChar;
  pa: PAnsiChar;
begin
  idx := FCurrOffset;

  i := ValueGrid.RowCount;
  j := ValueGrid.ColCount;

  ValueGrid.Cells[1, ROW_INDEX] := IntToStr(idx);

  // Byte, ShortInt
  if (FBuffer <> nil) and (idx >= 0) and (idx <= FBufferSize - SizeOf(byte)) then
  begin
    ValueGrid.Cells[1, ROW_BITS] := IntToBin(FBuffer^[idx], 8);
    ValueGrid.Cells[2, ROW_BITS] := Format('%d ... %d (%d)', [idx, idx, SizeOf(byte)]);
    ValueGrid.Cells[1, ROW_BYTE] := IntToStr(FBuffer^[idx]);
    ValueGrid.Cells[2, ROW_BYTE] := ValueGrid.Cells[2, ROW_BITS];
    ValueGrid.Cells[1, ROW_SHORTINT] := IntToStr(ShortInt(FBuffer^[idx]));
    ValueGrid.Cells[2, ROW_SHORTINT] := ValueGrid.Cells[2, ROW_BITS];
  end
  else begin
    ValueGrid.Cells[1, ROW_BYTE] := '';
    ValueGrid.Cells[2, ROW_BYTE] := '';
    ValueGrid.Cells[1, ROW_SHORTINT] := '';
    ValueGrid.Cells[2, ROW_SHORTINT] := '';
  end;

  // Word, SmallInt
  if (FBuffer <> nil) and (idx >= 0) and (idx <= FBufferSize - SizeOf(word)) then begin
    buf[0] := FBuffer^[idx];
    buf[1] := FBuffer^[idx+1];
    ValueGrid.Cells[1, ROW_WORD] := IntToStr(LEToN(w));
    ValueGrid.Cells[2, ROW_WORD] := Format('%d ... %d (%d)', [idx, idx+SizeOf(Word)-1, SizeOf(Word)]);
    ValueGrid.Cells[1, ROW_SMALLINT] := IntToStr(SmallInt(LEToN(w)));
    ValueGrid.Cells[2, ROW_SMALLINT] := ValueGrid.Cells[2, ROW_WORD];
    ValueGrid.Cells[1, ROW_WORD_BE] := IntToStr(BEToN(w));
    ValueGrid.Cells[2, ROW_WORD_BE] := Format('%d ... %d (%d)', [idx, idx+SizeOf(Word)-1, SizeOf(Word)]);
    ValueGrid.Cells[1, ROW_SMALLINT_BE] := IntToStr(SmallInt(BEToN(w)));
    ValueGrid.Cells[2, ROW_SMALLINT_BE] := ValueGrid.Cells[2, ROW_WORD];
  end else begin
    ValueGrid.Cells[1, ROW_WORD] := '';
    ValueGrid.Cells[2, ROW_WORD] := '';
    ValueGrid.Cells[1, ROW_SMALLINT] := '';
    ValueGrid.Cells[2, ROW_SMALLINT] := '';
    ValueGrid.Cells[1, ROW_WORD_BE] := '';
    ValueGrid.Cells[2, ROW_WORD_BE] := '';
    ValueGrid.Cells[1, ROW_SMALLINT_BE] := '';
    ValueGrid.Cells[2, ROW_SMALLINT_BE] := '';
  end;

  // DWord, LongInt
  if (FBuffer <> nil) and (idx >= 0) and (idx <= FBufferSize - SizeOf(DWord)) then begin
    for i:=0 to SizeOf(DWord)-1 do
      buf[i] := FBuffer^[idx+i];
    ValueGrid.Cells[1, ROW_DWORD] := IntToStr(LEToN(dw));
    ValueGrid.Cells[2, ROW_DWORD] := Format('%d ... %d (%d)', [idx, idx+SizeOf(DWord)-1, SizeOf(DWord)]);
    ValueGrid.Cells[1, ROW_LONGINT] := IntToStr(LongInt(LEToN(dw)));
    ValueGrid.Cells[2, ROW_LONGINT] := ValueGrid.Cells[2, ROW_DWORD];
    ValueGrid.Cells[1, ROW_DWORD_BE] := IntToStr(BEToN(dw));
    ValueGrid.Cells[2, ROW_DWORD_BE] := Format('%d ... %d (%d)', [idx, idx+SizeOf(DWord)-1, Sizeof(DWord)]);
    ValueGrid.Cells[1, ROW_LONGINT_BE] := IntToStr(LongInt(BEToN(dw)));
    ValueGrid.Cells[2, ROW_LONGINT_BE] := ValueGrid.Cells[2, ROW_DWORD];
  end else begin
    ValueGrid.Cells[1, ROW_DWORD] := '';
    ValueGrid.Cells[2, ROW_DWORD] := '';
    ValueGrid.Cells[1, ROW_LONGINT] := '';
    ValueGrid.Cells[2, ROW_LONGINT] := '';
    ValueGrid.Cells[1, ROW_DWORD_BE] := '';
    ValueGrid.Cells[2, ROW_DWORD_BE] := '';
    ValueGrid.Cells[1, ROW_LONGINT_BE] := '';
    ValueGrid.Cells[2, ROW_LONGINT_BE] := '';
  end;

  // Rational
  if (FBuffer <> nil) and (idx >= 0) and (idx <= FBufferSize - SizeOf(TRational)) then begin
    Move(FBuffer^[idx], rat, SizeOf(TRational));
    ValueGrid.Cells[1, ROW_RATIONAL64] := Format('%d/%d', [Int64(rat.num), Int64(rat.denom)]);
    ValueGrid.Cells[2, ROW_RATIONAL64] := Format('%d ... %d (%d)', [idx, idx + Sizeof(TRational)-1, SizeOf(TRational)]);
    ValueGrid.Cells[1, ROW_RATIONAL64_BE] := Format('%d/%d', [BEtoN(LongInt(rat.num)), BEtoN(LongInt(rat.denom))]);
    ValueGrid.Cells[2, ROW_RATIONAL64_BE] := Format('%d ... %d (%d)', [idx, idx + Sizeof(TRational)-1, SizeOf(TRational)]);
  end else begin
    ValueGrid.Cells[1, ROW_RATIONAL64] := '';
    ValueGrid.Cells[2, ROW_RATIONAL64] := '';
    ValueGrid.Cells[1, ROW_RATIONAL64_BE] := '';
    ValueGrid.Cells[2, ROW_RATIONAL64_BE] := '';
  end;

  // QWord, Int64
  if (FBuffer <> nil) and (idx >= 0) and (idx <= FBufferSize - SizeOf(QWord)) then begin
    for i:=0 to SizeOf(QWord)-1 do
      buf[i] := FBuffer^[idx+i];
    ValueGrid.Cells[1, ROW_QWORD] := Format('%d', [qw]);
    ValueGrid.Cells[2, ROW_QWORD] := Format('%d ... %d (%d)', [idx, idx+SizeOf(QWord)-1, SizeOf(QWord)]);
    ValueGrid.Cells[1, ROW_INT64] := Format('%d', [Int64(qw)]);
    ValueGrid.Cells[2, ROW_INT64] := ValueGrid.Cells[2, ROW_QWORD];
    ValueGrid.Cells[1, ROW_QWORD_BE] := Format('%d', [BEToN(qw)]);
    ValueGrid.Cells[2, ROW_QWORD_BE] := Format('%d ... %d (%d)', [idx, idx+SizeOf(QWord)-1, SizeOf(QWord)]);
    ValueGrid.Cells[1, ROW_INT64_BE] := Format('%d', [Int64(BEToN(qw))]);
    ValueGrid.Cells[2, ROW_INT64_BE] := ValueGrid.Cells[2, ROW_QWORD];
  end else begin
    ValueGrid.Cells[1, ROW_QWORD] := '';
    ValueGrid.Cells[2, ROW_QWORD] := '';
    ValueGrid.Cells[1, ROW_INT64] := '';
    ValueGrid.Cells[2, ROW_INT64] := '';
    ValueGrid.Cells[1, ROW_QWORD_BE] := '';
    ValueGrid.Cells[2, ROW_QWORD_BE] := '';
    ValueGrid.Cells[1, ROW_INT64_BE] := '';
    ValueGrid.Cells[2, ROW_INT64_BE] := '';
  end;

  // Single
  if (FBuffer <> nil) and (idx >= 0) and (idx <= FBufferSize - SizeOf(single)) then begin
    for i:=0 to SizeOf(single)-1 do buf[i] := FBuffer^[idx+i];
    ValueGrid.Cells[1, ROW_SINGLE] := Format('%f', [sng]);
    ValueGrid.Cells[2, ROW_SINGLE] := Format('%d ... %d (%d)', [idx, idx+SizeOf(Single)-1, SizeOf(Single)]);
  end else begin
    ValueGrid.Cells[1, ROW_SINGLE] := '';
    ValueGrid.Cells[2, ROW_SINGLE] := '';
  end;

  // Double
  if (FBuffer <> nil) and (idx >= 0) and (idx <= FBufferSize - SizeOf(double)) then begin
    for i:=0 to SizeOf(double)-1 do buf[i] := FBuffer^[idx+i];
    ValueGrid.Cells[1, ROW_DOUBLE] := Format('%f', [dbl]);
    ValueGrid.Cells[2, ROW_DOUBLE] := Format('%d ... %d (%d)', [idx, idx+SizeOf(Double)-1, SizeOf(Double)]);
  end else begin
    ValueGrid.Cells[1, ROW_DOUBLE] := '';
    ValueGrid.Cells[2, ROW_DOUBLE] := '';
  end;

  // AnsiString
  if (FBuffer <> nil) and (idx >= 0) and (idx < FBufferSize) then begin
    ls := Min(FBuffer^[idx], FBufferSize - idx - 1);
    SetLength(s, ls);
    i := idx + 1;
    j := 0;
    while (i < FBufferSize) and (j < Length(s)) do begin
      inc(j);
      s[j] := char(FBuffer^[i]);
      inc(i);
    end;
    SetLength(s, j);
    ValueGrid.Cells[1, ROW_ANSISTRING] := s;
    ValueGrid.Cells[2, ROW_ANSISTRING] := Format('%d ... %d (%d)', [idx, idx + ls * SizeOf(char), ls * SizeOf(char) + 1]);
  end else begin
    ValueGrid.Cells[1, ROW_ANSISTRING] := '';
    ValueGrid.Cells[2, ROW_ANSISTRING] := '';
  end;

  // PAnsiChar
  // Avoid buffer overrun
  if (FBuffer <> nil) and (idx >= 0) and (idx < FBufferSize) then begin
    pa := PAnsiChar(@FBuffer^[idx]);
    ls := 0;
    while (pa^ <> #0) and (idx < FBufferSize) and (ls < MAX_LEN) do //pa - @FBuffer[0] < FBufferSize) do
    begin
      inc(pa);
      inc(ls);
    end;
    SetLength(s, ls);
    if ls = MAX_LEN then s := s + '...';
    Move(FBuffer^[idx], s[1], ls);
    ValueGrid.Cells[1, ROW_PANSICHAR] := s;
    ValueGrid.Cells[2, ROW_PANSICHAR] := Format('%d ... %d (%d)', [idx, idx + ls - 1, ls]);
  end else begin
    ValueGrid.Cells[1, ROW_PANSICHAR] := '';
    ValueGrid.Cells[2, ROW_PANSICHAR] := '';
  end;

  // WideString
  if (FBuffer <> nil) and (idx >= 0) and (idx < FBufferSize) then begin
    ls := Min(FBuffer^[idx], (FBufferSize - idx - 1) div SizeOf(WideChar));
    if ls > MAX_LEN then ls := MAX_LEN;
    SetLength(sw, ls);
    j := 0;
    i := idx + 2;
    while (i < FBufferSize-1) and (j < Length(sw)) do begin
      buf[0] := FBuffer^[i];
      buf[1] := FBuffer^[i+1];
      inc(i, SizeOf(WideChar));
      inc(j);
      sw[j] := WideChar(w);
    end;
    SetLength(sw, j);
    ValueGrid.Cells[1, ROW_WIDESTRING] := UTF8Encode(sw);
    ValueGrid.Cells[2, ROW_WIDESTRING] := Format('%d ... %d (%d)', [idx, idx + (ls+1)*SizeOf(wideChar) -1, (ls+1)*SizeOf(WideChar)]);
  end else begin
    ValueGrid.Cells[1, ROW_WIDESTRING] := '';
    ValueGrid.Cells[2, ROW_WIDESTRING] := '';
  end;

  // PWideChar
  // Avoid buffer overrun
  if (FBuffer <> nil) and (idx >= 0) and (idx < FBufferSize) then begin
    pw := PWideChar(@FBuffer^[idx]);
    ls := 0;
    while (pw^ <> #0) and (pw - @FBuffer^[0] < FBufferSize-1) and (ls < MAX_LEN) do
    begin
      inc(pw);
      inc(ls);
    end;
    s := {%H-}WideCharLenToString(PWideChar(@FBuffer^[idx]), ls);
    if ls = MAX_LEN then s := s + '...';
    ValueGrid.Cells[1, ROW_PWIDECHAR] := s;
    ValueGrid.Cells[2, ROW_PWIDECHAR] := Format('%d ... %d', [idx, idx + ls * SizeOf(widechar) - 1, ls * Sizeof(widechar)]);
  end else begin
    ValueGrid.Cells[1, ROW_PWIDECHAR] := '';
    ValueGrid.Cells[2, ROW_PWIDECHAR] := '';
  end;
end;


procedure TMainForm.PopupGotoImageResourceBlock(Sender: TObject);
var
  id: Integer;
  offs: Int64;
  s: String;
begin
  if not (Sender is TMenuItem) then
    exit;

  s := copy(TMenuItem(Sender).Caption, 1, 5);
  id := StrToInt(s);
  offs := TMenuItem(Sender).Tag;
  GotoOffset(offs);
  DisplayAdobeImageResource(offs, id);
end;


procedure TMainForm.ReadArgs;
var
  i: Integer;
  arg: String;
begin
  for i:= 1 to ParamCount do begin
    arg := lowercase(ParamStr(i));
    if (arg[1] = '+') or (arg[1] = '-') then
    begin
      if arg = '-fpexif' then
        FLoadFPExif := false
      else if arg = '+fpexif' then
        FLoadFPExif := true;
    end else
      Loadfile(ParamStr(i));
  end;
end;

procedure TMainForm.ReadFromIni;
var
  ini: TCustomIniFile;
  W, H, L, T: Integer;
  Rct: TRect;
begin
  ini := TMemIniFile.Create(CalcIniName);
  try
    Rct := Screen.DesktopRect;
    W := ini.ReadInteger('MainForm', 'Width', Width);
    H := ini.ReadInteger('MainForm', 'Height', Height);
    L := ini.ReadInteger('MainForm', 'Left', Left);
    T := ini.ReadInteger('MainForm', 'Top', Top);
    if W > Rct.Right - Rct.Left then W := Rct.Right - Rct.Left;
    if L + W > Rct.Right then L := Rct.Right - W;
    if L < Rct.Left then L := Rct.Left;
    if H > Rct.Bottom - Rct.Top then H := Rct.Bottom - Rct.Top;
    if T + H > Rct.Bottom then T := Rct.Bottom - H;
    if T < Rct.Top then T := Rct.Top;
    SetBounds(L, T, W, H);

    HexPanel.Width := ini.ReadInteger('MainForm', 'HexPanelWidth', HexPanel.Width);
    MainPageControl.PageIndex := ini.ReadInteger('MainForm', 'MainPageControl', 0);
    HexPageControl.PageIndex := ini.ReadInteger('MainForm', 'HexPageControl', 0);
    fpExifPageControl.PageIndex := ini.ReadInteger('MainForm', 'fpExifPageControl', 0);

    FLoadFPExif := Ini.ReadBool('Configuration', 'Load fpExit', FLoadFPExif);
    AcCfgUseFPExif.Checked := FLoadFPExif;

  finally
    ini.Free;
  end;
end;

function TMainForm.ScanIFDs: Boolean;
var
  tiffHeaderStart: Int64;

  // p is at the start of an IFD or SubIFD.
  procedure ScanIFD(p: Int64);
  var
    n: word;
    i: Integer;
    TagID: Word;
    val: DWord;
    tagType: Word;
  begin
    if FBuffer = nil then
      exit;

    if p > High(FBuffer^) then
      exit;

    // The first 16-bit value is the count of directory entries
    n := PWord(@FBuffer^[p])^;
    if FMotorolaOrder then n := BEToN(n);
    inc(p, 2);

    // Read every directory entry
    for i:=0 to n-1 do begin
      TagID := PWord(@FBuffer^[p])^;
      if FMotorolaOrder then TagID := BEToN(TagID);
      inc(p, 2);  // --> go to Type field
      tagType := PWord(@FBuffer^[p])^;
      inc(p, 2);  // --> go to Size field
      inc(p, 4);  // --> go to Value field
      // Some defective files have TagID=0 and tagType=0 --> skip
      if (TagID = 0) and (tagType = 0) then
      begin
        inc(p, 4);
        Continue;
      end;
      // Read the data value assigned to the tag
      val := PDWord(@FBuffer^[p])^;
      if FMotorolaOrder then val := BEToN(val);
      if TagID = TAG_EXIF_OFFSET then begin
        IFDList[INDEX_EXIF] := val + tiffHeaderStart;
        ScanIFD(IFDList[INDEX_EXIF]);
      end else
      if TagID = TAG_GPS_OFFSET then begin
        IFDList[INDEX_GPS] := val + tiffHeaderStart;
        ScanIFD(IFDList[INDEX_GPS]);
      end else
      if TagID = TAG_INTEROP_OFFSET then begin
        IFDList[INDEX_INTEROP] := val + tiffHeaderStart;
        ScanIFD(IFDList[INDEX_INTEROP]);
      end;
      inc(p, 4)  // --> go to next tag
    end;
  end;

var
  p: Int64;
  n: word;
  offs: DWord;
begin
  Result := false;
  FillChar(IFDList[0], SizeOf(IFDList), $FF);

  tiffHeaderStart := FindTiffHeader;
  if tiffHeaderStart = -1 then
    exit;             // Exit if there is no TIFF header.

  FMotorolaOrder := (PByte(@FBuffer^[tiffHeaderStart])^ = ord('M')) and
                    (PByte(@FBuffer^[tiffHeaderStart+1])^ = ord('M'));

  offs := PWord(@FBuffer^[tiffHeaderStart+4])^;

  IFDList[0] := tiffHeaderStart + offs;
  ScanIFD(IFDList[0]);

  // Find IFD1
  p := IFDList[0];
  n := PWord(@FBuffer^[p])^;
  if FMotorolaOrder then n := BEToN(n);
  inc(p, 2 + n*12);
  offs := PDWord(@FBuffer^[p])^;
  if FMotorolaOrder then
    offs := BEToN(offs);
  if (offs = 0) or (offs > FBufferSize) then
    IFDList[Index_IFD1] := -1  // there is no IFD1
  else
    IFDList[INDEX_IFD1] := offs + tiffHeaderStart;

  Result := true;
end;

procedure TMainForm.StatusMsg(const AMsg: String);
begin
  Statusbar.Panels[PANEL_MSG].Text := AMsg;
  Statusbar.Refresh;
end;

procedure TMainForm.TagsGridPrepareCanvas(sender: TObject; aCol, aRow: Integer;
  aState: TGridDrawState);
var
  ts: TTextStyle;
  grid: TStringGrid;
begin
  grid := TStringGrid(Sender);
  ts := grid.Canvas.TextStyle;
  case ACol of
    0: ts.Alignment := taRightJustify;
    else exit;
  end;
  grid.Canvas.TextStyle := ts;
end;

procedure TMainForm.TbGotoAPP1ArrowClick(Sender: TObject);
begin
  UpdateIFDs;
end;

procedure TMainForm.TbGotoIFD(Sender: TObject);
var
  p: Int64;
  TiffHeaderOffs: Int64;
  ok: Boolean;

  function GetIFDIndex(AComponent: TComponent): PtrInt;
  begin
    Result := AComponent.Tag - (AcGotoTIFFHeader.Tag + 1);
  end;

begin
  p := FindMarker(MARKER_APP1);
  if p = -1 then begin
    StatusMsg('APP1 marker not found.');
    exit;
  end;

  // APP1 marker
  inc(p, 2 + 2 + Length('EXIF'#0#0));

  // TIFF header
  TiffHeaderOffs := p;
  inc(p, 8);  // Size of TIFF header

  p := IFDList[GetIFDIndex(TComponent(Sender))];
  if p = -1 then
  begin
    StatusMsg(TAction(Sender).Caption + ' does not exit.');
    exit;
  end;

  GotoOffset(p);

  FCurrIFDIndex := GetIFDIndex(TComponent(Sender));
  case FCurrIFDIndex of
    INDEX_IFD0    : ok := DisplayIFD(p, TiffHeaderOffs, TAG_PRIMARY, 'IFD0 (Image file directory 0)');
    INDEX_EXIF    : ok := DisplayIFD(p, TIFFHeaderOffs, TAG_EXIF_OFFSET, 'EXIF SubIFD (Image file subdirectory)');
    INDEX_INTEROP : ok := DisplayIFD(p, TiffHeaderOffs, TAG_INTEROP_OFFSET, 'Interoperability SubIFD (Image file subdirectory)');
    INDEX_GPS     : ok := DisplayIFD(p, TiffHeaderOffs, TAG_GPS_OFFSET, 'GPS SubIFD (Image file subdirectory)');
    INDEX_IFD1    : ok := DisplayIFD(p, TiffHeaderOffs, TAG_THUMBNAIL, 'IFD1 (Image file directory 1 - thumbnail)');
    else            ok := true;
  end;
  if not ok then
    StatusMsg('ERROR');

  (*
  // IFD0
  if TComponent(Sender).Tag = 1001 then begin
    GotoOffset(p);
    if not DisplayIFD(p, TiffHeaderOffs, 'IFD0 (Image file directory 0)') then
      Statusbar.SimpleText := 'ERROR';
    exit;
  end else
  // IFD1
  if TComponent(Sender).Tag = 1002 then begin
    GotoOffset(p);
    if not GotoNextIFD(p) then begin
      Statusbar.SimpleText := 'No IFD1';
      exit;
    end;
    GotoOffset(p);
    if not DisplayIFD(p, TiffHeaderOffs, 'IFD1 (Image file directory 1)') then
      Statusbar.SimpleText := 'ERROR';
    exit;
  end else
  // EXIF SubIFD
  if TComponent(Sender).Tag = 1003 then begin
    GotoOffset(p);
    if not GotoSubIFD(TAG_EXIF_OFFSET, p, TiffHeaderOffs) then begin
      Statusbar.SimpleText := 'No EXIF SubIFD';
      exit;
    end;
    GotoOffset(p);
    if not DisplayIFD(p, TIFFHeaderOffs, 'EXIF SubIFD (Image file subdirectory)') then
      Statusbar.SimpleText := 'ERROR';
    exit;
  end else
  // GPS SubIFD
  if TComponent(Sender).Tag = 1004 then begin
    GotoOffset(p);
    if not GotoSubIFD(TAG_GPS_OFFSET, p, TiffHeaderOffs) then begin
      Statusbar.SimpleText := 'No GPS SubIFD';
      exit;
    end;
    GotoOffset(p);
    if not DisplayIFD(p, TIFFHeaderOffs, 'GPS SubIFD (Image file subdirectory)') then
      Statusbar.SimpleText := 'ERROR';
    exit;
  end else
  // Interoperability SubIFD
  if TComponent(Sender).Tag = 1005 then begin
    GotoOffset(p);
    if not GotoSubIFD(TAG_INTEROP_OFFSET, p, TiffHeaderOffs) then begin
      Statusbar.SimpleText := 'No Interoperability SubIFD';
      exit;
    end;
    GotoOffset(p);
    if not DisplayIFD(p, TIFFHeaderOffs, 'Interoperability SubIFD (Image file subdirectory)') then
      Statusbar.SimpleText := 'ERROR';
    exit;
  end;
  *)
end;

procedure TMainForm.TbGotoMarker(Sender: TObject);
var
  m: Byte;
  p: Int64;
  ok: Boolean;
begin
  if      Sender = TbGotoSOI  then
    m := MARKER_SOI
  else if Sender = TbGotoEOI  then
    m := MARKER_EOI
  else if Sender = TbGotoAPP0 then
    m := MARKER_APP0
  else if Sender = TbGotoAPP1 then
    m := MARKER_APP1
  else if Sender = TbGotoAPP2 then
    m := MARKER_APP2
  else if Sender = TbGotoAPP13 then
    m := MARKER_APP13
  else if Sender = TbGotoDAC then
    m := MARKER_DAC
  else if Sender = TbGotoDHT then
    m := MARKER_DHT
  else if Sender = TbGotoDQT then
    m := MARKER_DQT
  else if Sender = TbGotoJPG then
    m := MARKER_JPG
  else if Sender = TbGotoSOF0 then
    m := MARKER_SOF0
  else if Sender = TbGotoSOF1 then
    m := MARKER_SOF1
  else if Sender = TbGotoSOF2 then
    m := MARKER_SOF2
  else if Sender = TbGotoSOF3 then
    m := MARKER_SOF3
  else if Sender = TbGotoSOF5 then
    m := MARKER_SOF5
  else if Sender = TbGotoSOF6 then
    m := MARKER_SOF6
  else if Sender = TbGotoSOF7 then
    m := MARKER_SOF7
  else if Sender = TbGotoSOF9 then
    m := MARKER_SOF9
  else if Sender = TbGotoSOF10 then
    m := MARKER_SOF10
  else if Sender = TbGotoSOF11 then
    m := MARKER_SOF11
  else if Sender = TbGotoSOF13 then
    m := MARKER_SOF12
  else if Sender = TbGotoSOS then
    m := MARKER_SOS
  else if Sender = TbGotoCOM then
    m := MARKER_COM
  else
    raise Exception.Create('Marker unknown');

  p := FindMarker(m);
  if p >= 0 then begin
    ok := DisplayMarker(p);
    if not ok then
      StatusMsg('ERROR');
  end else
    StatusMsg('Marker not found.');
end;

procedure TMainForm.TbGotoTIFFHeaderClick(Sender: TObject);
var
  p: Int64;
begin
  p := FindTIFFHeader;
//  p := FindMarker(MARKER_APP1);
  if p = -1 then
    StatusMsg('TIFF header not found.')
  else begin
//    inc(p, 2 + 2 + Length('EXIF'#0#0));
    GotoOffset(p);
    DisplayTiffHeader(p);
  end;
end;

procedure TMainForm.TbNextSegmentClick(Sender: TObject);
var
  p: Int64;
begin
  p := FindNextMarker;

  if p >= 0 then begin
    GotoOffset(p);
    if not DisplayMarker(p) then
      StatusMsg('ERROR');
  end else
    StatusMsg('Marker not found.');
end;

procedure TMainForm.UpdateIFDs;
var
  i: Integer;
  ac: TAction;
  startTag: PtrInt;
  endTag: PtrInt;
begin
  startTag := AcGotoTiffHeader.Tag + 1;
  endtag := startTag + High(IFDList);
  for i:=0 to ActionList.ActionCount-1 do begin
    ac := TAction(ActionList[i]);
    if (ac.Tag >= startTag) and (ac.Tag <= endTag) then
      ac.Enabled := IFDList[ac.Tag - startTag] > -1;
  end;
end;

procedure TMainForm.DisableAllBtns;
var
  i: Integer;
  tb: TToolButton;
begin
  for i:=0 to HexToolbar.ButtonCount-1 do begin
    tb := HexToolbar.Buttons[i];
    if tb.Tag >= $C0 then tb.Enabled := false;
  end;
  AcGotoXMP.Enabled := false;
end;

function TMainForm.FindSegmentBtn(AMarker: Word): TToolButton;
var
  i: Integer;
  tb: TToolButton;
begin
  for i:=0 to HexToolbar.ButtonCount-1 do begin
    tb := HexToolbar.Buttons[i];
    if tb.Tag = AMarker then begin
      Result := tb;
      exit;
    end;
  end;
  Result := nil;
end;

procedure TMainForm.UpdateMarkers;
var
  i: Integer;
  tb: TToolbutton;
  p: PByte;
  p0: PByte;
  pw: PWord;
  len: Integer;
begin
  DisableAllBtns;
  TbNextSegment.Enabled := FBuffer^[FCurrOffset] = $FF;

  p := @FBuffer[0];
  p0 := p;
  if p^ <> $FF then
    exit;
  inc(p);
  if p^ <> MARKER_SOI then
    exit;
  tb := FindSegmentBtn(MARKER_SOI);
  if tb <> nil then tb.Enabled := true;
  inc(p);
  i:= 0;
  while true do begin
    inc(i);
    if p - p0 >= FBufferSize then
      exit;

    // Some files do not write correct segment size and fill the space to the
    // next segment by zeros.
    if not (p^ in [$FF, 0]) then
      exit;

    while (p^ = $FF) or (p^ = 0) do begin
      inc(p);
      if p - p0 >= FBufferSize then
        exit;
    end;

    tb := FindSegmentBtn(p^);
    if tb <> nil then tb.Enabled := true;

    if (p^ = MARKER_APP1) then
    begin
      if StrComp(PChar(p+3), PChar(XMP_KEY)) = 0 then
        AcGotoXMP.Enabled := true;
    end;

    if p^ = MARKER_APP13 then
      BuildAPP13Menu(PtrInt(p - p0 - 1));

    if p^ = MARKER_SOS then
      break;

    inc(p);
    if p - p0 >= FBufferSize-1 then
      exit;

    pw := PWord(p);
    len := BEToN(pw^);
    inc(p, len);
  end;

  while true do begin
    if p - p0 >= FBufferSize-1 then
      exit;
    if p^ = $FF then begin
      inc(p);
      if p^ = MARKER_EOI then begin
        tb := FindSegmentBtn(MARKER_EOI);
        if tb <> nil then tb.Enabled := true;
        exit;
      end;
    end;
    inc(p);
  end;
end;
(*


  for i:=0 to HexToolbar.ButtonCount-1 do begin
    tb := HexToolbar.Buttons[i];
    case tb.Tag of
      MARKER_SOI : tb.Enabled := FindMarker(MARKER_SOI)   <> -1;
      MARKER_APP0 : tb.Enabled := FindMarker(MARKER_APP0)  <> -1;
      MARKER_APP1  : tb.Enabled := FindMarker(MARKER_APP1)  <> -1;
      MARKER_APP2  : tb.Enabled := FindMarker(MARKER_APP2)  <> -1;
      MARKER_APP13 : tb.Enabled := FindMarker(MARKER_APP13) <> -1;
      MARKER_COM   : tb.Enabled := FindMarker(MARKER_COM)   <> -1;
      MARKER_SOS   : tb.Enabled := FindMarker(Marker_SOS)   <> -1;
      MARKER_EOI   : tb.Enabled := FindMarker(Marker_EOI)   <> -1;
      MARKER_SOF0  : tb.Enabled := FindMarker(MARKER_SOF0)  <> -1;
      'SOF1'  : tb.Enabled := FindMarker(MARKER_SOF1)  <> -1;
      'SOF2'  : tb.Enabled := FindMarker(Marker_SOF2)  <> -1;
      'SOF3'  : tb.Enabled := FindMarker(Marker_SOF3)  <> -1;
      'DHT'   : tb.Enabled := FindMarker(MARKER_DHT)   <> -1;
      'SOF5'  : tb.Enabled := FindMarker(MARKER_SOF5)  <> -1;
      'SOF6'  : tb.Enabled := FindMarker(MARKER_SOF6)  <> -1;
      'SOF7'  : tb.Enabled := FindMarker(MARKER_SOF7)  <> -1;
      'JPG'   : tb.Enabled := FindMarker(MARKER_JPG)   <> -1;
      'SOF9'  : tb.Enabled := FindMarker(MARKER_SOF9)  <> -1;
      'SOF10' : tb.Enabled := FindMarker(MARKER_SOF10) <> -1;
      'SOF11' : tb.Enabled := FindMarker(MARKER_SOF11) <> -1;
      'SOF13' : tb.Enabled := FindMarker(MARKER_SOF13) <> -1;
      'SOF14' : tb.Enabled := FindMarker(MARKER_SOF14) <> -1;
      'SOF15' : tb.Enabled := FindMarker(MARKER_SOF15) <> -1;
      'DAC'   : tb.Enabled := FindMarker(MARKER_DAC)   <> -1;
      'DQT'   : tb.Enabled := FindMarker(MARKER_DQT)   <> -1;
    end;
  end;
  TbNextSegment.Enabled := FBuffer^[FCurrOffset] = $FF;
end;
*)

procedure TMainForm.UpdateStatusbar;
begin
  if FCurrOffset > -1 then
    Statusbar.Panels[PANEL_OFFSET].Text := Format('HexViewer offset: %d ($%x)', [FCurrOffset, FCurrOffset])
  else
    Statusbar.Panels[PANEL_OFFSET].Text := '';
end;


procedure TMainForm.ValueGridClick(Sender: TObject);
var
  n: Integer;
begin
  n := GetValueGridDataSize;
  if n > 0 then
    FHexEditor.SelCount := n;
end;


procedure TMainForm.WriteToIni;
var
  ini: TCustomIniFile;
begin
  ini := TMemIniFile.Create(CalcIniName);
  try
    ini.WriteInteger('MainForm', 'Left', Left);
    ini.Writeinteger('MainForm', 'Top', Top);
    ini.WriteInteger('MainForm', 'Width', Width);
    ini.WriteInteger('MainForm', 'Height', Height);
    ini.WriteInteger('MainForm', 'HexPanelWidth', HexPanel.Width);
    ini.WriteInteger('MainForm', 'HexPageControl', HexPageControl.PageIndex);
    ini.WriteInteger('MainForm', 'MainPageControl', MainPageControl.PageIndex);
    ini.WriteInteger('MainForm', 'fpExifPageControl', fpExifPageControl.PageIndex);

    ini.WriteBool('Configuration', 'Load fpExif', FLoadFPExif);
  finally
    ini.Free;
  end;
end;


end.

