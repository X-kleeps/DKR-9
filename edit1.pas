unit edit1;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  DBCtrls;

type

  { TfEdit1 }

  TfEdit1 = class(TForm)
    bCancel1: TBitBtn;
    bSave1: TBitBtn;
    Pol1ComboBox: TComboBox;
    Class1ComboBox: TComboBox;
    Fio1Edit: TEdit;
    Telefon1Edit: TEdit;
    Fio1Label: TLabel;
    Telefon1Label: TLabel;
    Pol1Label: TLabel;
    Class1Label: TLabel;
  private

  public

  end;

var
  fEdit1: TfEdit1;

implementation

{$R *.lfm}

{ TfEdit1 }

end.

