unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, WMPLib_TLB, StdCtrls;

type
  TForm1 = class(TForm)
    wmp1: TWindowsMediaPlayer;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
wmp1.Width:=500;
//wmp1.URL:='C:\Users\Public\Music\Sample Music\Kalimba.mp3';
//wmp1.URL:='C:\Users\user\Pictures\Ivan Tsarevich i Seryy Volk 2.2013.720p.BluRay.x264-LEONARDO_[scarabey.org].mkv_snapshot_00.14.06_[2014.07.07_10.36.19].jpg';
wmp1.URL:='D:\films\Vikings\Vikings.S01E01.rus.LostFilm.TV.avi';
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
wmp1.close;
end;

end.
