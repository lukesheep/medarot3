INCLUDE "game/src/common/constants.asm"

SECTION "Shadow LCDC Register", WRAM0[$C469]
W_ShadowREG_LCDC:: ds 1

SECTION "Disable LCD", ROM0[$04C2]
DisableLCD::
  ldh a, [H_RegIE]
  ldh [$FF93], a
  res 0, a

.waitForVblank
  ldh a, [H_RegLY]
  cp $91
  jr nz, .waitForVblank

  ld a, [W_ShadowREG_LCDC]
  and $7F
  ldh [H_RegLCDC], a
  ldh a, [$FF93]
  ldh [H_RegIE], a
  ret

EnableLCD::
  ld a, [H_RegLCDC]
  or $80
  ld [H_RegLCDC], a
  ret
