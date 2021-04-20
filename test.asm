; таймер
.macro nmi_delay frames
        lda #frames
        sta nmi_counter         ; Store the desired frame count.
:       lda nmi_counter         ; In a loop, keep checking the frame count.
        bne :-                          ; Loop until it's decremented to 0.
.endmacro

.segment "INESHDR"
	.byt "NES",$1A
	.byt 1 				; 1 x 16kB PRG block.
	.byt 1 				; 1 x 8kB CHR block.
	.byt 1
	.byt 1

.segment "VECTORS"
	.addr nmi_isr, reset, irq_isr

.segment "ZEROPAGE"
    nmi_counter: .res 1 ; выделить 1 байт памяти в zero page для счетчика
    timer: .res 1
    heroXCoordinate: .res 1 ; координата x
    heroYCoordinate: .res 1 ; координата y
    buttons: .res 1 ; кнопочки
    lifes: .res 1 ; жизни
    mapLoByte: .res 1
    mapHiByte: .res 1
    scroolX: .res 1
    heroDirection: .res 1 ; 00 left 01 right
.segment "BSS"

.segment "RODATA"

palette_data:
  .byt $09,$0A,$0C,$0D,  $22,$29,$38,$3C,  $21,$1C,$29,$07,  $22,$02,$38,$3C   ;;background
  .byt $32,$29,$1A,$0F,  $32,$36,$17,$0F,  $32,$30,$21,$0F,  $32,$27,$17,$0F   ;;sprite palette

map_level_1_1_page_1:
  ;     1,   2 ,  3,   4,  5,   6,   7,    8,  9,   10,  11,  12,  13,  14,  15,  16,  17,  18,  19,  20,  21,  22,  23,  24,  25,  26,  27,  28, 29,   30,  31,  32
  .byt $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05 ; 1
  .byt $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05 ; 2
  .byt $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05 ; 3
  .byt $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05 ; 4
  .byt $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05 ; 5
  .byt $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05 ; 6
  .byt $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05 ; 7
  .byt $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05 ; 8
map_level_1_2_page_1:
  .byt $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05 ; 9
  .byt $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05 ; 10
  .byt $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05 ; 11
  .byt $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05 ; 12
  .byt $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05 ; 13
  .byt $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05 ; 14
  .byt $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05 ; 15
  .byt $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05 ; 16
map_level_1_3_page_1:
  .byt $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05 ; 17
  .byt $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05 ; 18
  .byt $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05 ; 19
  .byt $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05 ; 20
  .byt $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05 ; 21
  .byt $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05 ; 22
  .byt $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05 ; 23
  .byt $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05 ; 24
map_level_1_4_page_1:
  .byt $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02 ; 25
  .byt $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01 ; 26
  .byt $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01 ; 27
  .byt $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01 ; 28
  .byt $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01 ; 29
  .byt $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01 ; 30
  .byt $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01 ; 31
  .byt $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01 ; 32

attributeTableLevel1Page1:
    ;   1    2    3    4    5    6    7    8
  .byt $00, $00, $00, $00, $00, $00, $00, $00 ; !
  .byt $00, $00, $00, $00, $00, $00, $00, $00 ; 2
  .byt $00, $00, $00, $00, $00, $00, $00, $00 ; 3
  .byt $00, $00, $00, $00, $00, $00, $00, $00 ; 4
  .byt $00, $00, $00, $00, $00, $00, $00, $00 ; 5
  .byt $00, $00, $00, $00, $00, $00, $00, $00 ; 6
  .byt $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA ; 8
  .byt $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA ; 8

hello_habr:
  .byt $00, $01, $02

hello_habr_x:
  .byt $0C, $0D, $0E

lifesBytes:
  .byt $00, $08, $10, $17
; =====	Main code ==============================================================

.segment "CODE"

BUTTON_A      = 1 << 7
BUTTON_B      = 1 << 6
BUTTON_SELECT = 1 << 5
BUTTON_START  = 1 << 4
BUTTON_UP     = 1 << 3
BUTTON_DOWN   = 1 << 2
BUTTON_LEFT   = 1 << 1
BUTTON_RIGHT  = 1 << 0

.proc nmi_isr
        dec nmi_counter
        rti
.endproc

.proc irq_isr
        rti
.endproc

.proc reset

	sei
	ldx #0
	stx $2000		; обнуляем память
	stx $2001		; выключаем рендер
	stx $4010	; отключаем DMC
	dex 				; X = $FF
	txs					; Стэк равен = $FF
:	bit $2002
	bpl :-

LoadPalettes:
  lda $2002
  lda #$3F
  sta $2006             ; говорим ppu что нам необходим адрес 3F00 здесь храниться палитра
  lda #$00
  sta $2006             ; Сначала старший байт записываем 3F потом младший 00 при записи этот адрес будет автоматически увеличиваться

  ldx #$00              ; X = 0
LoadPalettesLoop:
  lda palette_data, x
  sta $2007             ; записываем в ppu по факту в адрес 3F00
  inx                   ; X = X + 1
  cpx #$20
  bne LoadPalettesLoop

changeBank:
  lda #%10010000 ;enable NMI, sprites from Pattern 0, background from Pattern 1
  sta $2000

LoadBackgroundPage1:
  lda $2002             ; read PPU status to reset the high/low latch
  lda #$20
  sta $2006             ; write the high byte of $2000 address
  lda #$00
  sta $2006             ; write the low byte of $2000 address

  ldx #00
backgroundLoopLevel1Part1Page1:
  lda map_level_1_1_page_1, x
  sta $2007
  inx
  bne backgroundLoopLevel1Part1Page1

  ldx #00
backgroundLoopLevel1Part2Page1:
  lda map_level_1_2_page_1, x
  sta $2007
  inx
  bne backgroundLoopLevel1Part2Page1

  ldx #00
backgroundLoopLevel1Part3Page1:
  lda map_level_1_3_page_1, x
  sta $2007
  inx
  bne backgroundLoopLevel1Part3Page1

  ldx #00
backgroundLoopLevel1Part4Page1:
  lda map_level_1_4_page_1, x
  sta $2007
  inx
  bne backgroundLoopLevel1Part4Page1

LoadAttributePage1:
  lda $2002
  lda #$23
  sta $2006
  lda #$C0
  sta $2006

  ldx #00
AttributePage1Loop:
  lda attributeTableLevel1Page1, x
  sta $2007
  inx
  cpx #66
  bne AttributePage1Loop


enableRender:
  lda #%00011000
  sta $2001

setheroVariables:
  lda #100
  sta heroXCoordinate
  lda #$00
  sta buttons
  lda #100
  sta heroYCoordinate
  lda #04
  sta lifes
  lda #00
  sta scroolX

fixScroll:
   ldx #00
   stx $2005
   stx $2005


mainLoop:
;  ldx scroolX
;  inx
;  stx scroolX

readJoyPad:
  ldx  #$00
  lda  #$01
  sta  $4016
  lda  #$00
  sta  $4016

  ldy #$08 ; счетчик для цикла
readJoyCycle:
  lda $4016,x
  lsr
  ror $14,x
  dey
  bne readJoyCycle

handleJoyState:
  ldx $14
  cpx #%10000000 ; right
  beq walkHeroRight
  cpx #%01000000 ; left
  beq walkHeroLeft
  cpx #%00100000 ;down
  beq walkHeroDown
  cpx #%00010000
  beq walkHeroUp
  cpx #%00001000
  beq startButton
  cpx #%00000100
  beq selectButton
  cpx #%00000010
  beq heroFire
  cpx #%00000001
  beq heroJump
  cpx #%10100000 ; down and right
  beq walkHeroDownAndRight
  cpx #%01100000 ; down and left
  beq walkHeroDownAndLeft
  cpx #%00000011
  beq walkHeroRightAndUp
  bne drawHeroStay


heroStay:
  jmp drawHeroStay

walkHeroRight:
  lda #01
  sta heroDirection
  inc heroXCoordinate
  jmp drawHeroRight

walkHeroLeft:
  lda #00
  sta heroDirection
  dec heroXCoordinate
  jmp drawHeroLeft

walkHeroUp:
  dec heroYCoordinate
  jmp drawHeroUp

walkHeroDown:
  inc heroYCoordinate
  jmp drawHeroDown

walkHeroRightAndUp:
  inc heroXCoordinate
  dec heroYCoordinate
  jmp drawHeroWalkRightAndUp

walkHeroDownAndLeft:
  lda #00
  sta heroDirection
  dec heroXCoordinate
  inc heroYCoordinate
  jmp drawHeroDownLeft

walkHeroDownAndRight:
  lda #01
  sta heroDirection
  inc heroXCoordinate
  inc heroYCoordinate
  jmp drawHeroDownRight

heroFire:
  jmp drawHeroFire

heroJump:
  jmp drawHeroJump

selectButton:
  jmp selectButtonState

startButton:
  jmp startButtonState

drawHeroRight:
drawHeroLeft:
drawHeroUp:
drawHeroDown:
drawHeroFire:
drawHeroJump:
selectButtonState:
startButtonState:
drawHeroWalkRightAndUp:
drawHeroDownLeft:
drawHeroDownRight:


drawHeroStay:
  lda heroYCoordinate
  sta $2004
  lda #05
  sta $2004
  lda #%00010110
  sta $2004
  lda heroXCoordinate
  sta $2004

  lda heroYCoordinate ; #101
  adc #01
  sta $2004
  lda #05
  sta $2004
  lda #%00010110
  sta $2004
  lda heroXCoordinate; #106
  adc #06
  sta $2004

  lda heroYCoordinate
  adc #10
  sta $2004
  lda #06
  sta $2004
  lda #%00010101
  sta $2004
  lda heroXCoordinate;#97
  sbc #03
  sta $2004

  lda heroYCoordinate; #110
  adc #10
  sta $2004
  lda #06
  sta $2004
  lda #%01010101
  sta $2004
  lda heroXCoordinate
  adc #11
  sta $2004

  lda heroYCoordinate;#100
  sta $2004
  lda $00
  sta $2004
  lda #%00010111
  sta $2004
  lda heroXCoordinate;#100
  sta $2004

  lda heroYCoordinate; #100
  sta $2004
  lda #01
  sta $2004
  lda #%00010111
  sta $2004
  lda heroXCoordinate;#108
  adc #08
  sta $2004


  lda heroYCoordinate;#108
  adc #08
  sta $2004
  lda #16
  sta $2004
  lda #%00010111
  sta $2004
  lda heroXCoordinate; #100
  sta $2004

  lda heroYCoordinate;  #108
  adc #08
  sta $2004
  lda #17
  sta $2004
  lda #%00010111
  sta $2004
  lda heroXCoordinate; #108
  adc #08
  sta $2004

  lda heroYCoordinate; #108
  adc #08
  sta $2004
  lda #16
  sta $2004
  lda #%01010111
  sta $2004
  lda heroXCoordinate; #108
  adc #08
  sta $2004

  lda heroYCoordinate; #116
  adc #16
  sta $2004
  lda #32
  sta $2004
  lda #%00010111
  sta $2004
  lda heroXCoordinate
  sta $2004

  lda heroYCoordinate
  adc #16
  sta $2004
  lda #32
  sta $2004
  lda #%01010111
  sta $2004
  lda heroXCoordinate
  adc #08
  sta $2004

drawLifes:

  ldx lifes
lifeLoop:
  lda #10
  sta $2004
  lda #06
  sta $2004
  lda #%00010111
  sta $2004
  lda lifesBytes, x
  adc #10
  sta $2004
  dex
  bne lifeLoop
;
;  lda heroYCoordinate
;  sta $2004
;  lda #01
;  sta $2004
;  lda #%00010111
;  sta $2004
;  lda heroXCoordinate
;  adc #$07
;  sta $2004
;
;  lda heroYCoordinate
;  adc #$07
;  sta $2004
;  lda $02
;  sta $2004
;  lda #%00010111
;  sta $2004
;  lda heroXCoordinate
;  sta $2004
;
;  lda heroYCoordinate
;  adc #$07
;  sta $2004
;  lda #03
;  sta $2004
;  lda #%00010111
;  sta $2004
;  lda heroXCoordinate
;  adc #$07
;  sta $2004
;
  nmi_delay 4
  jmp mainLoop

.endproc



; =====	CHR-ROM Pattern Tables =================================================

; ----- Pattern Table 0 --------------------------------------------------------

.segment "PATTERN0"

	.incbin "t8.chr"

.segment "PATTERN1"

	
