unit JKModernUI.Colors;

interface

uses
  Graphics, JKModernUI.Message;

function GetModernStrongColor(ATipo: TModernMessageType): TColor;
function GetModernLightColor(ATipo: TModernMessageType): TColor;

implementation

function GetModernStrongColor(ATipo: TModernMessageType): TColor;
begin
  case ATipo of
    jk_mtPrimary: Result := $00C3883B; // Matches primary bell icon #3B88C3
    jk_mtSuccess: Result := $00548719; // Bootstrap #198754
    jk_mtWarning: Result := $0007C1FF; // Bootstrap #ffc107
    jk_mtDanger: Result := $004535DC;  // Bootstrap #dc3545
    jk_mtInfo: Result := $00C3883B;    // Matches current info icon #3B88C3
  else
    Result := $00C3883B;
  end;
end;

function GetModernLightColor(ATipo: TModernMessageType): TColor;
begin
  case ATipo of
    jk_mtPrimary: Result := $00FED4B6; // Slightly darker blue #b6d4fe
    jk_mtSuccess: Result := $00DDE7D1; // Bootstrap #d1e7dd
    jk_mtWarning: Result := $00CDF3FF; // Bootstrap #fff3cd
    jk_mtDanger: Result := $00DAD7F8;  // Bootstrap #f8d7da
    jk_mtInfo: Result := $00FFE2CE;    // Blue close to primary #cee2ff
  else
    Result := $00FED4B6;
  end;
end;

end.
