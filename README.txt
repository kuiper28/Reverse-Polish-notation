Nume: Dinica Ion-Robert
Tema1: IOCLA

 Pentru realizarea acestei teme am folosit urmatorele label-uri:
 - lungime
 - bucla
 - spatiu
 - scade
 - aduna
 - inmulteste
 - imparte
 - neaga
 - neaga1
 - pune
 - pune1
 - contor_neg

 Label-ul "lungime" este label-ul in care este determinata lungimea
 expresiei. Astfel, citesc caracter cu caracter pana la intalnirea
 "null terminator-ului". La final, lungimea expresiei este salvata
 in registrul ecx. Tot in acest label voi pune expresia "expr"
 in registrul edi. 

 Label-ul "bucla" are rol in parsarea expresiei fiind locul
 in care verific tipul caracterului si ceea ce va urma sa fac
 dupa citirea acestuia si mutarea lui in registrul bl.De asemeanea,
 este locul in care ma intorc, la sfarsit, pentru a afisa rezultatul
 final.

 Label-ul "spatiu" verifica faptul ca am citit caracterul "spatiu", 
 incrementand registrul edi, in care este salvata expresia, si
 decrementand registrul ecx. La finalul label-ului incrementez
 registrul edi, decrementez registrul ecx si, daca este cazul, ma
 intorc in label-ul "bucla".

 Label-ul "scade" scoate ultimele doua cifre sau numere adaugate pe stiva
 si le scade, iar apoi rezultatul obtinut este pus ,din nou, pe stiva.De
 asemenea, in cazul in care dupa caracterul '-' urmeaza o cifra ma voi duce
 in label-ul "contor_neg" care imi spune faptul ca nu mai vorbim de scadere,
 ci de o cifra sau un numar negativa. La finalul label-ului incrementez
 registrul edi, decrementez registrul ecx si, daca este cazul, ma
 intorc in label-ul "bucla".
 
 Label-ul "aduna" scoate ultimele doua cifre sau numere adaugate pe stiva
 si le aduna, iar apoi rezultatul obtinut este pus ,din nou, pe stiva.
 La finalul label-ului incrementez registrul edi, decrementez registrul
 ecx si, daca este cazul, ma intorc in label-ul "bucla".

 Label-ul "inmulteste" scoate ultimele doua cifre sau numere adaugate pe stiva
 si le inmulteste, iar apoi rezultatul obtinut este pus ,din nou, pe stiva.
 La finalul label-ului incrementez registrul edi, decrementez registrul
 ecx si, daca este cazul, ma intorc in label-ul "bucla". 
 
 Label-ul "imparte" scoate ultimele doua cifre sau numere adaugate pe stiva
 si le imparte, iar apoi rezultatul obtinut este pus ,din nou, pe stiva.
 La finalul label-ului incrementez registrul edi, decrementez registrul
 ecx si, daca este cazul, ma intorc in label-ul "bucla".

 Label- ul "neaga" neaga cifra care va urma sa fie pusa pe stiva.
 La finalul label-ului incrementez registrul edi, decrementez registrul
 ecx si, daca este cazul, ma intorc in label-ul "bucla".

 Label-ul "neaga1" este analog label-ului "neaga" , dar in acest caz nu
 mai vorbim de cifre, ci de numere.

 Label-ul "pune" este label-ul in care o cifra este pusa pe stiva.
 La inceput fac conversia de la codul ascii la o cifra ("sub bl, 30h"),
 apoi extind registrul bl la ebx, verific daca mai urmeaza cifra dupa 
 caracterul curent. In cazul afirmativ merg in label-ul pune2, altfel
 verific daca cifra data este negativa caz in care ma duc la label-ul
 "nega". La final pun cifra pe stiva , incrementez registrul edi
 decrementez registrul ecx si, daca este cazul, ma intorc in
 label-ul "bucla".


 Label-ul "pune1" este analog label-ului pune doar ca in acest caz
 vorbim de numere, nu de cifre. Astfel realizez "formarea" numarului
 prin secventa urmamtoare de cod:
   "mov edx,10    
    imul edx
    inc edi
    dec ecx
    mov bl, byte [edi]
    sub bl, 30h
    movsx ebx,bl
    add eax,ebx
    cmp byte [edi+1], '0'
    jge pune1".
 Apoi verific daca numarul format este negativ, in caz afirmativ
 ma duc in label-ul "neaga1", altfel pun numarul pe stiva, incremantez
 registrul edi, decrementez registrul ecx si, daca este cazul, ma
 intorc in label-ul "bucla".