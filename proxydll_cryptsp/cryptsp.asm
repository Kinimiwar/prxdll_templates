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

EXPORT STDCALL, CheckSignatureInFile, 1
EXPORT STDCALL, CryptAcquireContextA, 2
EXPORT STDCALL, CryptAcquireContextW, 3
EXPORT STDCALL, CryptContextAddRef, 4
EXPORT STDCALL, CryptCreateHash, 5
EXPORT STDCALL, CryptDecrypt, 6
EXPORT STDCALL, CryptDeriveKey, 7
EXPORT STDCALL, CryptDestroyHash, 8
EXPORT STDCALL, CryptDestroyKey, 9
EXPORT STDCALL, CryptDuplicateHash, 10
EXPORT STDCALL, CryptDuplicateKey, 11
EXPORT STDCALL, CryptEncrypt, 12
EXPORT STDCALL, CryptEnumProviderTypesA, 13
EXPORT STDCALL, CryptEnumProviderTypesW, 14
EXPORT STDCALL, CryptEnumProvidersA, 15
EXPORT STDCALL, CryptEnumProvidersW, 16
EXPORT STDCALL, CryptExportKey, 17
EXPORT STDCALL, CryptGenKey, 18
EXPORT STDCALL, CryptGenRandom, 19
EXPORT STDCALL, CryptGetDefaultProviderA, 20
EXPORT STDCALL, CryptGetDefaultProviderW, 21
EXPORT STDCALL, CryptGetHashParam, 22
EXPORT STDCALL, CryptGetKeyParam, 23
EXPORT STDCALL, CryptGetProvParam, 24
EXPORT STDCALL, CryptGetUserKey, 25
EXPORT STDCALL, CryptHashData, 26
EXPORT STDCALL, CryptHashSessionKey, 27
EXPORT STDCALL, CryptImportKey, 28
EXPORT STDCALL, CryptReleaseContext, 29
EXPORT STDCALL, CryptSetHashParam, 30
EXPORT STDCALL, CryptSetKeyParam, 31
EXPORT STDCALL, CryptSetProvParam, 32
EXPORT STDCALL, CryptSetProviderA, 33
EXPORT STDCALL, CryptSetProviderExA, 34
EXPORT STDCALL, CryptSetProviderExW, 35
EXPORT STDCALL, CryptSetProviderW, 36
EXPORT STDCALL, CryptSignHashA, 37
EXPORT STDCALL, CryptSignHashW, 38
EXPORT STDCALL, CryptVerifySignatureA, 39
EXPORT STDCALL, CryptVerifySignatureW, 40
EXPORT STDCALL, SystemFunction035, 41

SEH_handler PROC
        ; empty handler
        ret
SEH_handler ENDP

END
