unit HddPhysic;

interface

function Init(sUser: PAnsiChar; sRegCode: PAnsiChar): Integer; stdcall;
  external 'libhx.dll';
function GetPhysicInfo(idiskIndex: Integer; iInfoType: Integer;
  pHddInfo_OUT: PAnsiChar): Integer; stdcall; external 'libhx.dll';

implementation

end.
