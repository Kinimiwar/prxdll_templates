IFNDEF x64
        .MODEL FLAT
        .SAFESEH SEH_handler
ENDIF

.CODE

IFNDEF x64
        proxydll_find_function PROTO STDCALL, arg1:WORD
ELSE
        EXTERN proxydll_find_function:PROC
ENDIF

EXPORT32 MACRO langtype:REQ, procname:REQ, ordinal:REQ
    .ERRE ordinal

    IFNDEF x64
        procname PROC langtype
            INVOKE proxydll_find_function, ordinal
            jmp dword ptr eax
        procname ENDP
    ENDIF
ENDM

EXPORT64 MACRO procname:REQ, ordinal:REQ
    .ERRE ordinal

    IFDEF x64
        procname PROC
                push rcx
                push rdx
                push r8
                push r9
                sub rsp, 28h
                mov rcx, ordinal
                call proxydll_find_function
                add rsp, 28h
                pop r9
                pop r8
                pop rdx
                pop rcx
                jmp qword ptr rax
        procname ENDP
    ENDIF
ENDM

EXPORT MACRO langtype:REQ, procname:REQ, ordinal1:REQ, ordinal2
    EXPORT32 langtype, procname, ordinal1
    
    IFB <ordinal2>
        EXPORT64 procname, ordinal1
    ELSE
        EXPORT64 procname, ordinal2
    ENDIF
ENDM

EXPORT STDCALL, RevertToOldImplementation, 1
EXPORT STDCALL, D3D10CompileEffectFromMemory, 2
EXPORT STDCALL, D3D10CompileShader, 3
EXPORT STDCALL, D3D10CreateBlob, 4
EXPORT STDCALL, D3D10CreateDevice, 5
EXPORT STDCALL, D3D10CreateDeviceAndSwapChain, 6
EXPORT STDCALL, D3D10CreateEffectFromMemory, 7
EXPORT STDCALL, D3D10CreateEffectPoolFromMemory, 8
EXPORT STDCALL, D3D10CreateStateBlock, 9
EXPORT STDCALL, D3D10DisassembleEffect, 10
EXPORT STDCALL, D3D10DisassembleShader, 11
EXPORT STDCALL, D3D10GetGeometryShaderProfile, 12
EXPORT STDCALL, D3D10GetInputAndOutputSignatureBlob, 13
EXPORT STDCALL, D3D10GetInputSignatureBlob, 14
EXPORT STDCALL, D3D10GetOutputSignatureBlob, 15
EXPORT STDCALL, D3D10GetPixelShaderProfile, 16
EXPORT STDCALL, D3D10GetShaderDebugInfo, 17
EXPORT STDCALL, D3D10GetVersion, 18
EXPORT STDCALL, D3D10GetVertexShaderProfile, 19
EXPORT STDCALL, D3D10PreprocessShader, 20
EXPORT STDCALL, D3D10ReflectShader, 21
EXPORT STDCALL, D3D10RegisterLayers, 22
EXPORT STDCALL, D3D10StateBlockMaskDifference, 23
EXPORT STDCALL, D3D10StateBlockMaskDisableAll, 24
EXPORT STDCALL, D3D10StateBlockMaskDisableCapture, 25
EXPORT STDCALL, D3D10StateBlockMaskEnableAll, 26
EXPORT STDCALL, D3D10StateBlockMaskEnableCapture, 27
EXPORT STDCALL, D3D10StateBlockMaskGetSetting, 28
EXPORT STDCALL, D3D10StateBlockMaskIntersect, 29
EXPORT STDCALL, D3D10StateBlockMaskUnion, 30

SEH_handler PROC
        ; empty handler
        ret
SEH_handler ENDP

END
