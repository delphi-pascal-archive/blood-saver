{
/S mode normal �cran de veille
/s aper�u
/p xxxxx preview dans la petite fen�tre + handle de la preview
/c:xxxxx config + handle de la fen�tre "propri�t� d'affichage"?????!!!!
}


program BloodSaver;

uses
  Forms, Graphics, SysUtils, Windows,
  Main in 'Main.pas' {MainForm},
  Config in 'Config.pas' {ConfigForm};

type
 TScreenMode=(scrNormal, scrApercu, scrPreview,scrConfig); // Type d'affichage demand� par Windows

var
 ScreenMode: TScreenMode;
 PreviewHandle: HWND;  // Handle de la fen�tre de pr�visualisation (dans l'image de l'ordinateur !)

{$E SCR}
{$R *.res}

begin
 SetWindowLong(Application.Handle, GWL_EXSTYLE, WS_EX_TOOLWINDOW); // On cache application dans barre des t�ches
 Application.Title := ''; // Pas de titre

 SetPriorityClass(GetCurrentProcess, HIGH_PRIORITY_CLASS); // Priorit� haute (pour aller plus vite)

 if hPrevInst = 0 // Handle preview instance = 0 s' il n' y pas d' instance du programme !!!
  then
   begin
    Application.Initialize;

    case (paramStr(1) + ' ')[2] of
     'S' : ScreenMode := scrNormal;
     's' : ScreenMode := scrApercu;  // Selon le param�tre recu on d�finit ScreenMode
     'p' : ScreenMode := scrPreview;
     'c' : ScreenMode := scrConfig;
  else ScreenMode := scrNormal;  // Si pas de param�tres, affichage normal
 end;

 if not (ScreenMode = scrConfig) // Si pas affichage de configuration
  then
   begin
    ShowWindow(FindWindow('Shell_TrayWnd', nil), SW_HIDE);  // On cache la barre des t�ches
  Application.CreateForm(TMainForm, MainForm);  // On cr�e la fiche principale

    if ScreenMode = scrPreview
     then begin
     // Si il n'y a pas le handle de la petite fenetre de preview, on quitte
      ShowWindow(FindWindow('Shell_TrayWnd', nil), SW_RESTORE);
      if ParamCount < 2
       then Application.Terminate;

  // On place notre fen�tre comme enfant du preview :
   PreviewHandle :=StrToInt(ParamStr(2));
   MainForm.ParentWindow := PreviewHandle;
  // La fen�tre de propri�t� fera le Close de MainForm quand elle n' en aura plus besoin ...
   end
   else
   MainForm.Cursor:= -1; // On cache le curseur !

  // On agrandit la fen�tre, soit tout l'�cran, soit dans la fen�tre preview
  MainForm.WindowState:=WSMaximized;
 end
  else begin
   ShowWindow(FindWindow('Shell_TrayWnd', nil), SW_RESTORE); // On remet barre des t�ches
  Application.CreateForm(TConfigForm, ConfigForm);   // On affiche la fiche de configuration
  end;

  Application.Run;   // On lance l'application

  ShowWindow(FindWindow('Shell_TrayWnd', nil), SW_RESTORE); // On remet la barre des t�ches
 end;
end.
