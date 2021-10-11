{
/S mode normal écran de veille
/s aperçu
/p xxxxx preview dans la petite fenêtre + handle de la preview
/c:xxxxx config + handle de la fenêtre "propriété d'affichage"?????!!!!
}


program BloodSaver;

uses
  Forms, Graphics, SysUtils, Windows,
  Main in 'Main.pas' {MainForm},
  Config in 'Config.pas' {ConfigForm};

type
 TScreenMode=(scrNormal, scrApercu, scrPreview,scrConfig); // Type d'affichage demandé par Windows

var
 ScreenMode: TScreenMode;
 PreviewHandle: HWND;  // Handle de la fenêtre de prévisualisation (dans l'image de l'ordinateur !)

{$E SCR}
{$R *.res}

begin
 SetWindowLong(Application.Handle, GWL_EXSTYLE, WS_EX_TOOLWINDOW); // On cache application dans barre des tâches
 Application.Title := ''; // Pas de titre

 SetPriorityClass(GetCurrentProcess, HIGH_PRIORITY_CLASS); // Priorité haute (pour aller plus vite)

 if hPrevInst = 0 // Handle preview instance = 0 s' il n' y pas d' instance du programme !!!
  then
   begin
    Application.Initialize;

    case (paramStr(1) + ' ')[2] of
     'S' : ScreenMode := scrNormal;
     's' : ScreenMode := scrApercu;  // Selon le paramètre recu on définit ScreenMode
     'p' : ScreenMode := scrPreview;
     'c' : ScreenMode := scrConfig;
  else ScreenMode := scrNormal;  // Si pas de paramètres, affichage normal
 end;

 if not (ScreenMode = scrConfig) // Si pas affichage de configuration
  then
   begin
    ShowWindow(FindWindow('Shell_TrayWnd', nil), SW_HIDE);  // On cache la barre des tâches
  Application.CreateForm(TMainForm, MainForm);  // On crée la fiche principale

    if ScreenMode = scrPreview
     then begin
     // Si il n'y a pas le handle de la petite fenetre de preview, on quitte
      ShowWindow(FindWindow('Shell_TrayWnd', nil), SW_RESTORE);
      if ParamCount < 2
       then Application.Terminate;

  // On place notre fenêtre comme enfant du preview :
   PreviewHandle :=StrToInt(ParamStr(2));
   MainForm.ParentWindow := PreviewHandle;
  // La fenêtre de propriété fera le Close de MainForm quand elle n' en aura plus besoin ...
   end
   else
   MainForm.Cursor:= -1; // On cache le curseur !

  // On agrandit la fenêtre, soit tout l'écran, soit dans la fenêtre preview
  MainForm.WindowState:=WSMaximized;
 end
  else begin
   ShowWindow(FindWindow('Shell_TrayWnd', nil), SW_RESTORE); // On remet barre des tâches
  Application.CreateForm(TConfigForm, ConfigForm);   // On affiche la fiche de configuration
  end;

  Application.Run;   // On lance l'application

  ShowWindow(FindWindow('Shell_TrayWnd', nil), SW_RESTORE); // On remet la barre des tâches
 end;
end.
