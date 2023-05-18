unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, SQLDB, SQLite3Conn, Forms, Controls, Graphics, Dialogs,
  StdCtrls, Grids, DBGrids, DBCtrls, edit, edit1;

type
  Contacts = record
    Name: string[100];
    Telephon: string[20];
    Pol: string[20];
    Note: string[20];
  end; //record

type

  { TfMain }

  TfMain = class(TForm)
    SortButton: TButton;
    OnDbButton: TButton;
    AddBut: TButton;
    ButtonPoisk: TButton;
    ButtonDel: TButton;
    ViborPoisk: TComboBox;
    EditID1: TEdit;
    refBut: TButton;
    DBG: TDBGrid;
    DataSource1: TDataSource;
    SQLite3Connection1: TSQLite3Connection;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    procedure AddBDClick(Sender: TObject);
    procedure AddButClick(Sender: TObject);
    procedure bAddClick(Sender: TObject);
    procedure SortButtonClick(Sender: TObject);
    procedure OnDbButtonClick(Sender: TObject);
    procedure ButtonDelClick(Sender: TObject);
    procedure ButtonPoiskClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure OpenClick(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;
  adres: string; //адрес, откуда запущена программа

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.AddBDClick(Sender: TObject);
  begin
  SQLite3Connection1.DatabaseName :='D:\lazarus\Projeckts\DKR - 9\school.db'; // указывает путь к базе
  SQLite3Connection1.CharSet := 'UTF8'; // указываем рабочую кодировку
  SQLite3Connection1.Transaction := SQLTransaction1; // указываем менеджер транзакций
  try  // пробуем подключится к базе
    SQLite3Connection1.Open;
    SQLTransaction1.Active := True;
    ShowMessage('Подключен');
  except   // если не удалось то выводим сообщение о ошибке
    ShowMessage('Ошибка подключения к базе!');
  end;
end;

procedure TfMain.AddButClick(Sender: TObject);
begin
fEdit1.Fio1Edit.Text:= '';
fEdit1.Edit2.Text:= '';
fEdit1.ComboBox1.Text:= '';
fEdit1.ComboBox2.Text:= '';
fEdit1.ShowModal;

  if (fEdit1.Fio1Edit.text= '') or (fEdit1.Edit2.text= '') then exit;
  //если пользователь не нажал "Сохранить" - выходим:
  if fEdit1.ModalResult <> mrOk then exit

else
begin
SQLQuery1.Close;  // выключаем компонент
SQLQuery1.SQL.Text := 'insert into school (ФИО,Номер_телефона,Пол,Класс) values(:u,:i,:j,:h);';  // добавляем sql запрос для добавления данных
SQLQuery1.ParamByName('u').AsString :=fEdit1.Fio1Edit.text;
SQLQuery1.ParamByName('i').AsString :=fEdit1.Edit2.text;
SQLQuery1.ParamByName('j').AsString :=fEdit1.ComboBox1.text;
SQLQuery1.ParamByName('h').AsString :=fEdit1.ComboBox2.text;
SQLQuery1.ExecSQL; // выполняем запрос
SQLTransaction1.Commit; //подтверждаем изменения в базе
//////////////////////////////
SQLite3Connection1.DatabaseName :='D:\lazarus\Projeckts\DKR - 9\school.db'; // указывает путь к базе
SQLite3Connection1.CharSet := 'UTF8'; // указываем рабочую кодировку
SQLite3Connection1.Transaction := SQLTransaction1; // указываем менеджер транзакций
try  // пробуем подключится к базе
SQLite3Connection1.Open;
SQLTransaction1.Active := True;
except   // если не удалось то выводим сообщение о ошибке
ShowMessage('Ошибка подключения к базе!');
end;
SQLQuery1.Close;
SQLQuery1.SQL.Text:='select * from school';
SQLQuery1.Open;
end;
end;

procedure TfMain.bAddClick(Sender: TObject);
begin
  fEdit.ShowModal;
end;

procedure TfMain.SortButtonClick(Sender: TObject);
begin
SQLQuery1.ApplyUpdates;
SQLTransaction1.Commit;
SQLQuery1.open
end;

procedure TfMain.OnDbButtonClick(Sender: TObject);
begin
  SQLite3Connection1.DatabaseName :='D:\lazarus\Projeckts\DKR - 9\school.db'; // указывает путь к базе
SQLite3Connection1.CharSet := 'UTF8'; // указываем рабочую кодировку
SQLite3Connection1.Transaction := SQLTransaction1; // указываем менеджер транзакций
try  // пробуем подключится к базе
  SQLite3Connection1.Open;
  SQLTransaction1.Active := True;
except   // если не удалось то выводим сообщение о ошибке
  ShowMessage('Ошибка подключения к базе!');
end;
SQLQuery1.Close;
SQLQuery1.SQL.Text:='select * from school';
SQLQuery1.Open;
end;

procedure TfMain.ButtonDelClick(Sender: TObject);
begin
SQLQuery1.Delete; // удаляем запись
SQLQuery1.ApplyUpdates;
SQLTransaction1.Commit;
SQLQuery1.open;
end;

procedure TfMain.ButtonPoiskClick(Sender: TObject);
begin
SQLQuery1.Locate(ViborPoisk.Text,EditID1.Text,[loCaseInsensitive, loPartialKey]);
end;

procedure TfMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
SQLQuery1.ApplyUpdates;
SQLTransaction1.Commit;
//if SQLQuery1.Active = True then
//begin
//  if MessageDlg('Подтверждение', 'Вы действительно хотите выйти?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
//  begin
//    SQLQuery1.ApplyUpdates;
//    SQLTransaction1.Commit;
//    exit;
//  end
//else
//   Action:=caNone;
// end;
end;

procedure TfMain.FormCreate(Sender: TObject);
begin
SQLite3Connection1.DatabaseName :='D:\lazarus\Projeckts\DKR - 9\school.db'; // указывает путь к базе
SQLite3Connection1.CharSet := 'UTF8'; // указываем рабочую кодировку
SQLite3Connection1.Transaction := SQLTransaction1; // указываем менеджер транзакций
try  // пробуем подключится к базе
  SQLite3Connection1.Open;
  SQLTransaction1.Active := True;
except   // если не удалось то выводим сообщение о ошибке
  ShowMessage('Ошибка подключения к базе!');
end;
SQLQuery1.Close;
SQLQuery1.SQL.Text:='select * from school';
SQLQuery1.Open;
end;

procedure TfMain.OpenClick(Sender: TObject);
begin
  SQLQuery1.Close;
  SQLQuery1.SQL.Text:='select * from school';
  SQLQuery1.Open;
end;



end.

