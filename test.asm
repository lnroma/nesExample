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
	.byt 0
	.byt 0

.segment "VECTORS"
	.addr nmi_isr, reset, irq_isr

.segment "ZEROPAGE"
    nmi_counter: .res 1 ; выделить 1 байт памяти в zero page для счетчика
    timer: .res 1
    herroXCoordinate: .res 1 ; координата x
    herroYCoordinate: .res 1 ; координата y
    buttons: .res 1 ; кнопочки
.segment "BSS"

.segment "RODATA"

palette_data:
  .byt $32,$29,$1A,$0F,  $32,$36,$17,$0F,  $32,$30,$21,$0F,  $32,$27,$17,$0F   ;;background palette
  .byt $22,$1C,$15,$14,  $22,$02,$38,$3C,  $22,$1C,$15,$14,  $22,$02,$38,$3C   ;;sprite palette

hello_habr:
  .byt $00, $01, $02

hello_habr_x:
  .byt $0C, $0D, $0E

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

LoadBackground:
  lda $2002             ; read PPU status to reset the high/low latch
  lda #$20
  sta $2006             ; write the high byte of $2000 address
  lda #$00
  sta $2006             ; write the low byte of $2000 address

  ldy #00
backgroundMainLoop:
  ldx #$00
backgroundLoop:
  lda #$24
  sta $2007
  cpx #$FF
  inx
  bne backgroundLoop
  iny
  cpy #04
  bne backgroundMainLoop

enableRender:
  lda #%00011000
  sta $2001

setHerroVariables:
  lda #100
  sta herroXCoordinate
  lda #$00
  sta buttons
  lda #100
  sta herroYCoordinate


mainLoop:

readJoyPad:
  lda  #$01
  sta  $4016
  lda  #$00
  sta  $4016

ReadA:
  LDA $4016       ; Кнопка A
  AND #%00000001
  bne walkHeroRight
  beq ReadB

ReadB:
  LDA $4016       ; Кнопка B
  AND #%00000001
  bne walkHeroLeft
  beq ReadSelect

ReadSelect:
  LDA $4016       ; Кнопка SELECT
  AND #%00000001
  bne walkHeroLeft
  beq ReadStart

ReadStart:
  LDA $4016       ; Кнопка START
  AND #%00000001
  bne walkHeroLeft
  beq ReadUp

ReadUp:
  LDA $4016       ; Крестовина вверх
  AND #%00000001
  bne walkHeroUp
  beq ReadDown

ReadDown:
  LDA $4016       ; Крестовина вниз
  AND #%00000001
  bne walkHeroDown
  beq ReadLeft

ReadLeft:
  LDA $4016       ; Крестовина влево
  AND #%00000001
  bne walkHeroLeft
  beq ReadRight

ReadRight:
  LDA $4016       ; Крестовина влево
  AND #%00000001
  bne walkHeroRight
  beq heroStay


heroStay:
 jmp drawHero

walkHeroRight:
  inc herroXCoordinate
  jmp drawHero

walkHeroLeft:
  dec herroXCoordinate
  jmp drawHero

walkHeroUp:
  dec herroYCoordinate
  jmp drawHero

walkHeroDown:
  inc herroYCoordinate
  jmp drawHero

drawHero:
  lda herroYCoordinate
  sta $2004
  lda $00
  sta $2004
  lda #%00010111
  sta $2004
  lda herroXCoordinate
  sta $2004

  lda herroYCoordinate
  sta $2004
  lda #01
  sta $2004
  lda #%00010111
  sta $2004
  lda herroXCoordinate
  adc #$07
  sta $2004

  lda herroYCoordinate
  adc #$07
  sta $2004
  lda $02
  sta $2004
  lda #%00010111
  sta $2004
  lda herroXCoordinate
  sta $2004

  lda herroYCoordinate
  adc #$07
  sta $2004
  lda #03
  sta $2004
  lda #%00010111
  sta $2004
  lda herroXCoordinate
  adc #$07
  sta $2004

  nmi_delay 4
  jmp mainLoop

.endproc



; =====	CHR-ROM Pattern Tables =================================================

; ----- Pattern Table 0 --------------------------------------------------------

.segment "PATTERN0"

	.incbin "m2.chr"

.segment "PATTERN1"

	
