unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, ShockwaveFlashObjects_TLB, FileCtrl;

type
  TForm1 = class(TForm)
    flash1: TShockwaveFlash;
    Button1: TButton;
    FLB1: TFileListBox;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
var s:string;
p:array[0..30] of char;
begin
flash1.Stop;
getcurrentdirectory(30,p);
s:=string(p);
flash1.Movie:=flb1.FileName;
flash1.
flash1.Play;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
p:array[0..30] of char;
begin
getcurrentdirectory(30,p);
flb1.Directory:=string(p)+'\swf';
//listbox1.Items.Add('');
end;

end.
