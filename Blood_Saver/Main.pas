unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, IniFiles;

type
  TConfig=record
   CfNbBlood, CfColor: Integer;
   CfLength, CfSize, CfSpeed, CfGravity: Single;
  end;

  TBlood=record
   X, Y, DX, DY, V: Single;
   Size: Integer;
   Color: TColor;
  end;

type
  TMainForm = class(TForm)
    BloodTimer: TTimer;
    Img: TImage;
    procedure FormCreate(Sender: TObject);
    procedure BloodTimerTimer(Sender: TObject);
    procedure ImgClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    procedure GetConfig;
    procedure CreateBlood(X, Y: Integer);
    function IsBloodOut: Boolean;
  end;

var
  MainForm: TMainForm;
  Config: TConfig;
  MaxBlood: Integer;
  Blood: array of TBlood;

implementation

{$R *.dfm}

procedure TMainForm.GetConfig; // On récupère les infos de configuration
Var
 A, B, C, D: Integer; // Variables temporaires
begin
 with TIniFile.Create(ExtractFilePath(Application.ExeName) + 'BloodSaver.ini') do
  begin
   Config.CfNbBlood := ReadInteger('BloodOptions', 'NbBlood', 20); // Nombre de gouttes
   A := ReadInteger('BloodOptions', 'Gravity', 0); // Type de gravité
   case A of
    0: Config.CfGravity := 1;   // Terrestre
    1: Config.CfGravity := 0.18;// Lunaire
    2: Config.CfGravity := 1.7; // Forte
    3: Config.CfGravity := 0.3; // Faible
    4: Config.CfGravity := 0;   // Nulle
   end;
   Config.CfColor := ReadInteger('BloodOptions', 'Color', 0); // Couleur ... traitée plus tard
   B := ReadInteger('BloodOptions', 'Speed', 1); // Vitesse
   case B of
    0: Config.CfSpeed := 0.5; // Faible
    1: Config.CfSpeed := 1;   // Normale
    2: Config.CfSpeed := 2;   // Haute
   end;
   C := ReadInteger('BloodOptions', 'Length', 1);  // Portée
   case C of
    0: Config.CfLength := 0.5; // Faible
    1: Config.CfLength := 1;   // Normale
    2: Config.CfLength := 2;   // Haute
   end;
   D := ReadInteger('BloodOptions', 'Size', 1); // Taille
   case D of
    0: Config.CfSize := 1; // Faible
    1: Config.CfSize := 2; // Normale
    2: Config.CfSize := 3; // Haute
   end;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
 // OPTIONS
 GetConfig; // on récupère les infos

 DoubleBuffered := True; // Evite scintillements
 randomize;   // moteur de nombres aléatoires
 MaxBlood := Config.CfNbBlood; // Nombre de gouttes
 SetLength(Blood, MaxBlood); // On fixe la taille de l'array des gouttes
 CreateBlood(random(Width), random(Height)); // On crée les gouttes !
end;

function TMainForm.IsBloodOut: Boolean; // Vérifie si les gouttes sont toutes OFF
Var
 I: Integer;
begin
 Result := True; // par défaut OUI
 for I := 0 to MaxBlood - 1 do
   begin
    if PtInRect(ClientRect, Point(Round(Blood[I].X), Round(Blood[I].Y))) then
     begin         // Si une seule goutte est dans le rectangle visible, on met False et on quitte
      Result := False;
      Exit;
     end;
   end;
end;

procedure TMainForm.CreateBlood(X, Y: Integer);  // On crée le sang
Var
 I: Integer;
begin
 for I := 0 to MaxBlood - 1 do
   begin
    Blood[I].X := X; // Voilà ... en dehors du With sinon confusion avec X de Blood et X de la fonction
    Blood[I].Y := Y;
    with Blood[I] do
     begin
      DX := (random(12) - 6) * Config.CfLength; // Calcul de la portée X
      DY := (random(12) - 6) * Config.CfLength; // Calcul de la portée Y
      V := (random(2) + 1) * Config.CfSpeed; // Calcul de la vitesse
      Size := Round((random(3) + 2) * Config.cfSize);  // Calcul de la taille

      case Config.CfColor of   // Selon la couleur
       0: Color := rgb(random(76) + 180, 0, 0);
       1: Color := rgb(0, random(76) + 180, 0);
       2: Color := rgb(0, 0, random(76) + 180); // Diverses couleurs obtenues ...
       3: Color := rgb(random(76) + 180, random(76) + 180, random(76) + 180);
       4: Color := rgb(random(256), random(256), random(256));
      end;
    end;
   end;
end;

procedure TMainForm.BloodTimerTimer(Sender: TObject);
Var
 I: Integer;
begin
 BitBlt(Img.Canvas.Handle, 0, 0, Width, Height, Img.Canvas.Handle, 0, 0, BLACKNESS);
 if IsBloodOut then CreateBlood(random(Width), random(Height));
 // On remplit de noir !
 for I := 0 to MaxBlood - 1 do // Pour chaque goutte
  begin
   Blood[I].X := Blood[I].X + (Blood[I].DX * Blood[I].V); // On calcule l'évolution de sa position
   Blood[I].Y := Blood[I].Y + (Blood[I].DY * Blood[I].V);
   Blood[I].DY := Blood[I].DY + Config.CfGravity; // On fixe la gravité
   Img.Canvas.Brush.Color := Blood[I].Color;
   Img.Canvas.Pen.Color := Blood[I].Color;  // On fixe sa couleur comme couleur canevas
   Img.Canvas.Ellipse(Round(Blood[I].X) - Blood[I].Size div 2, Round(Blood[I].Y) - Blood[I].Size div 2, Round(Blood[I].X) + Blood[I].Size div 2, Round(Blood[I].Y) + Blood[I].Size div 2);
    // On dessine une ellipse !!
  end;
end;

procedure TMainForm.ImgClick(Sender: TObject);
begin
 Application.Terminate; // On quitte
end;

end.
