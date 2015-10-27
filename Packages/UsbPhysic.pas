unit UsbPhysic;

interface

function Init(sUser: PAnsiChar; sRegCode: PAnsiChar): Integer; stdcall;
  external 'libux.dll';
function GetUSBPhysicInfo(idiskIndex: Integer; iInfoType: Integer;
  pHddInfo_OUT: PAnsiChar): Integer; stdcall; external 'libux.dll';

implementation

end.
