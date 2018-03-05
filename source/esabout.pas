unit esAbout;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, IpHtml, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls;

type

  { TAboutForm }

  TAboutForm = class(TForm)
    Button1: TButton;
    IconImage: TImage;
    HtmlPanel: TIpHtmlPanel;
    LblTitle: TLabel;
    LblCopyright: TLabel;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure HtmlPanelHotClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  AboutForm: TAboutForm;

implementation

{$R *.lfm}

uses
  resource, versiontypes, versionresource, LCLIntf;

const
  LE = LineEnding;

  HTMLStr =
    '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> '+ LE +
    '<html xmlns="http://www.w3.org/1999/xhtml">'+LE+
    '<head>' + LE +
    '  <meta http-equiv="content-type" content="text/html; charset=UTF-8">' + LE +
    '  <style type="text/css">' + LE +
    '    body {background-color:ffffff;}' + LE +
    '    h3{color:003366;}' + LE +
    '    li{font-size:9pt}' + LE +
    '  </style>' + LE +
    '<body>' + LE +
    '  <h3>Compiler and libaries:</h3>' + LE +
    '  <ul>'+ LE +
    '    <li><a href="www.freepascal.org">Free Pascal</a></li>' + LE +
    '    <li><a href="www.lazarus.freepascal.org">Lazarus</a></li>' + LE +
    '    <li><a href="http://sourceforge.net/p/lazarus-ccr/svn/HEAD/tree/components/kcontrols/">KControls</a></li>' + LE +
    '  </ul>' + LE +
    '  <h3>Icons:</h3>' + LE +
    '  <ul>' + LE +
    '    <li><a href="https://icons8.com/icon/">icons8</a></li>' + LE +
    '  </ul>' + LE +
    '</body>' + LE +
    '</html>';


function ResourceVersionInfo: String;
var
  Stream: TResourceStream;
  vr: TVersionResource;
  fi: TVersionFixedInfo;
begin
  Result := '';
  try
    { This raises an exception if version info has not been incorporated into the
      binary (Lazarus Project -> Project Options -> Version Info -> Version numbering). }
    Stream:= TResourceStream.CreateFromID(HINSTANCE, 1, PChar(RT_VERSION));
    try
      vr := TVersionResource.Create;
      try
        vr.SetCustomRawDataStream(Stream);
        fi := vr.FixedInfo;
        Result := Format('v%d.%d.%d', [fi.FileVersion[0], fi.FileVersion[1], fi.FileVersion[2]]);
        {
        Result := 'Version ' + IntToStr(fi.FileVersion[0]) + '.' + IntToStr(fi.FileVersion[1]) +
                  ' release ' + IntToStr(fi.FileVersion[2]) + ' build ' + IntToStr(fi.FileVersion[3]);
                  }
        vr.SetCustomRawDataStream(nil)
      finally
        vr.Free
      end;
    finally
      Stream.Free
    end;
  except
  end;
end;


{ TAboutForm }

procedure TAboutForm.FormCreate(Sender: TObject);
begin
  HTMLPanel.SetHtmlFromStr(HTMLStr);
  IconImage.Picture.Icon := Application.Icon;
  IconImage.Picture.Icon.Current := 2;
  LblTitle.Caption := 'EXIF Spy ' + ResourceVersionInfo;
end;

procedure TAboutForm.HtmlPanelHotClick(Sender: TObject);
begin
  OpenURL(HTMLPanel.HotURL);
end;

end.

