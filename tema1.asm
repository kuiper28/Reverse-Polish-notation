%include "io.inc"

%define MAX_INPUT_SIZE 4096
section .bss
	expr: resb MAX_INPUT_SIZE
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    push ebp 
    mov ebp, esp
    GET_STRING expr, MAX_INPUT_SIZE
    xor eax, eax

lungime: ; calculez lungimea unei secvente
    mov al, 0x00 ; pun "null terminator" in al
    mov edi, expr ; pun expresia in edi
    repne scasb
    sub edi, expr
    mov ecx,edi ; salvez lungimea expresiei in ecx
    mov edx, expr
    xor al, al
    xor edi, edi
    mov edi, expr ; pun in edi expresia data
    xor edx, edx
    
bucla: ; locul in care citesc un caracter si verific tipul acestuia 
    xor esi, esi 
    mov bl, byte [edi] ; mut in bl un caracter din edi
    cmp bl, '0'
    jge pune  
    cmp bl, ' '
    je spatiu
    cmp bl, '+'
    je aduna
    cmp bl, '-'
    je scade
    cmp bl, '*'
    je inmulteste
    cmp bl, '/'
    je imparte
    pop eax
    PRINT_DEC 4,eax ; acesta reprezinta rezultatul final
    pop ebp    
    ret
    
spatiu: ; label-ul pentru cazul in care caracterul este spatiu
    inc edi
    dec ecx
    cmp ecx, 0
    jg bucla
    
aduna: ; label-ul pentru cazul in care caracterul este '+'
    pop ebx
    pop eax
    add eax, ebx
    push eax
    inc edi
    dec ecx
    cmp ecx, 0
    jg bucla
    
scade: ; label-ul pentru cazul in care caracterul este '-'
    cmp byte [edi+1], '0' ; cazul in care nu vorbim de scadere, ci de semnul minus
    jge contor_neg
    pop ebx
    pop eax
    sub eax, ebx
    push eax
    inc edi
    dec ecx
    cmp ecx, 0
    jg bucla
    
inmulteste: ; label-ul pentru cazul in care caracterul este '*'
    pop ebx
    pop eax
    imul ebx
    push eax
    inc edi
    dec ecx
    cmp ecx, 0
    jg bucla
    
imparte: ; label-ul pentru cazul in care caracterul este '/'
    xor edx,edx
    pop ebx
    pop eax
    cdq
    idiv ebx
    push eax
    inc edi
    dec ecx
    cmp ecx, 0
    jg bucla
    
contor_neg: ; cazul pentru numere negative. In esi va fi contorizat
     ; faptul ca avem un minus urmat de o cifra,
     ; practic vorbim de cifre si numere negative.
     
    mov esi,1
    inc edi
    dec ecx
    mov bl, byte [edi] ; mut in bl noul caracter
    jmp pune
    
pune: ; label-ul in care se pune o cifra pe stiva
    sub bl, 30h ; fac conversia din ascii in cifra
    movsx ebx,bl ; extind registrul bl la ebx
    mov eax,ebx 
    cmp byte [edi + 1], '0' ; verific cazul in care avem numere, nu doar o cifra
    jge pune1
    cmp esi, 1 ; cazul in care am o cifra negativa
    je neaga
    push ebx ; pun cifra pe stiva
    xor ebx,ebx
    inc edi
    dec ecx
    cmp ecx, 0
    jg bucla
    
neaga: 
    neg ebx ; neg cifra
    push ebx ; pun cifra pe stiva
    xor ebx,ebx
    inc edi
    dec ecx
    cmp ecx, 0
    jg bucla
    
pune1: ; cazul in care avem numere pe care o sa le pun pe stiva
    xor edx,edx
    xor ebx,ebx
    mov edx,10    
    imul edx
    inc edi
    dec ecx
    mov bl, byte [edi]
    sub bl, 30h
    movsx ebx,bl
    add eax,ebx ; in eax se va afla numarul care va urma sa fie pus pe stiva
    cmp byte [edi+1], '0' ; verific daca mai sunt cifre
    jge pune1
    inc edi
    cmp esi,1 ; verific daca este vorba de un numar negativ
    je neaga1
    push eax ; pun numarul pe stiva
    xor ebx, ebx
    xor eax, eax
    xor edx, edx
    dec ecx
    cmp ecx, 0
    jg bucla
    
neaga1: 
    neg eax ; neg numarul pe care il pun pe stiva
    push eax ; pun numarul pe stiva
    xor ebx, ebx
    xor eax, eax
    xor edx, edx
    dec ecx
    cmp ecx, 0
    jg bucla