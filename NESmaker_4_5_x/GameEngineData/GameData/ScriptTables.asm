;; *************** ScriptTables.asm ***************
;; Script link export. Wednesday, April 15, 2026 1:00:33 AM
ScriptAddressLo:
	.db #<Script00, #<Script01, #<Script02, #<Script03, #<Script04, #<Script05, #<Script06, #<Script07, #<Script08, #<Script09
ScriptAddressHi:
	.db #>Script00, #>Script01, #>Script02, #>Script03, #>Script04, #>Script05, #>Script06, #>Script07, #>Script08, #>Script09

TargetScriptBank:
	.db #DATABANK1, #DATABANK1, #DATABANK1, #DATABANK1, #DATABANK1, #DATABANK1, #DATABANK1, #DATABANK1, #DATABANK1, #DATABANK1

;;=======================PRESSED=======================
DefinedInputs_Pressed:
	.db #%00000001, #%00001000, #%10000000, #%00010000, #%01000000, #%00100000, #%00001000

DefinedScriptGameStates_Pressed:
	.db #$00, #$01, #$00, #$00, #$00, #$00, #$03

DefinedTargetObjects_Pressed:
	.db #$00, #$00, #$00, #$00, #$00, #$00, #$00

DefinedTargetController_Pressed:
	.db #$00, #$00, #$00, #$00, #$00, #$00, #$00

TargetState_Pressed:
	.db #$00, #$00, #$00, #$00, #$00, #$00, #$00

DefinedTargetScripts_Pressed:
	.db #$06, #$07, #$08, #$08, #$08, #$08, #$07

;;=======================RELEASE=======================
DefinedInputs_Released:
	.db #%10000000, #%00100000, #%01000000, #%00010000, #%00100000, #%10000000, #%00010000, #%01000000

DefinedScriptGameStates_Released:
	.db #$00, #$00, #$00, #$00, #$00, #$00, #$00, #$00

DefinedTargetObjects_Released:
	.db #$00, #$00, #$00, #$00, #$00, #$00, #$00, #$00

DefinedTargetController_Released:
	.db #$00, #$00, #$00, #$00, #$00, #$00, #$00, #$00

TargetState_Released:
	.db #$00, #$00, #$00, #$00, #$00, #$00, #$00, #$00

DefinedTargetScripts_Released:
	.db #$05, #$05, #$05, #$05, #$09, #$09, #$09, #$09

;;=======================HOLD=======================
DefinedInputs_Held:
	.db #%10000000, #%00100000, #%01000000, #%00010000

DefinedScriptGameStates_Held:
	.db #$00, #$00, #$00, #$00

DefinedTargetObjects_Held:
	.db #$00, #$00, #$00, #$00

DefinedTargetController_Held:
	.db #$00, #$00, #$00, #$00

TargetState_Held:
	.db #$00, #$00, #$00, #$00

DefinedTargetScripts_Held:
	.db #$02, #$00, #$01, #$03

