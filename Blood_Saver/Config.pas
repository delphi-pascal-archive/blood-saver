unit Config;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, IniFiles, ExtCtrls;

type
  TConfigForm = class(TForm)
    ConfigGrpBox: TGroupBox;
    NbBlood: TLabel;
    NbBloodEdit: TSpinEdit;
    Grav: TLabel;
    GravEdit: TComboBox;
    Blood: TLabel;
    BloodEdit: TComboBox;
    SepBevel1: TBevel;
    Speed: TLabel;
    SpeedEdit: TComboBox;
    Length: TLabel;
    LengthEdit: TComboBox;
    Size: TLabel;
    SizeEdit: TComboBox;
    ApplyBtn: TButton;
    CloseBtn: TButton;
    procedure FormCreate(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ApplyBtnClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    procedure GetConfig;
    procedure SetConfig;
  end;

var
  ConfigForm: TConfigForm;

implementation

{$R *.dfm}

procedure TConfigForm.GetConfig;
begin
 with TIniFile.Create(ExtractFilePath(Application.ExeName) + 'BloodSaver.ini') do
  begin
   NbBloodEdit.Value := ReadInteger('BloodOptions', 'NbBlood', 20);
   GravEdit.ItemIndex := ReadInteger('BloodOptions', 'Gravity', 0);
   BloodEdit.ItemIndex := ReadInteger('BloodOptions', 'Color', 0);  // On récupère tout
   SpeedEdit.ItemIndex := ReadInteger('BloodOptions', 'Speed', 1);
   LengthEdit.ItemIndex := ReadInteger('BloodOptions', 'Length', 1);
   SizeEdit.ItemIndex := ReadInteger('BloodOptions', 'Size', 1);
  end;
end;

procedure TConfigForm.SetConfig;
begin
 with TIniFile.Create(ExtractFilePath(Application.ExeName) + 'BloodSaver.ini') do
  begin
   WriteInteger('BloodOptions', 'NbBlood', NbBloodEdit.Value);
   WriteInteger('BloodOptions', 'Gravity', GravEdit.ItemIndex);
   WriteInteger('BloodOptions', 'Color', BloodEdit.ItemIndex);  // On écrit tout
   WriteInteger('BloodOptions', 'Speed', SpeedEdit.ItemIndex);
   WriteInteger('BloodOptions', 'Length', LengthEdit.ItemIndex);
   WriteInteger('BloodOptions', 'Size', SizeEdit.ItemIndex);
  end;
end;

procedure TConfigForm.FormCreate(Sender: TObject);
begin
 DoubleBuffered := True; // On evite les scintillements
 ConfigGrpBox.DoubleBuffered := True;
end;

procedure TConfigForm.CloseBtnClick(Sender: TObject);
begin
 Application.Terminate; // On quitte
end;

procedure TConfigForm.FormShow(Sender: TObject);
begin
 GetConfig; // On prend les infos
end;

procedure TConfigForm.ApplyBtnClick(Sender: TObject);
begin
 SetConfig; // On applique et on quitte
 Application.Terminate;
end;

end.
