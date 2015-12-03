.model small
.386
.stack 512
.data
     modo db ?
     CADENA1 DB 'ENSAMBLADOR'
     CADENA2 DB 'ENSAMBLADOR'
     CADENA3 DB '?'
     MENSAJE1 DB 'SON IGUALES$'
     MENSAJE2 DB 'SON DIFERENTES$'
     num db 0
     cont db 1
.CODE
BEGIN PROC FAR
     MOV AX,@DATA
     MOV DS,AX
     MOV ES,AX ; para manejo de cadenas
     CALL LIMPIO ;llamado para limpiar la pantalla
     CALL CURSOR ; llamado para ubicar el cursor
     CLD

     MOV CX,11 ;la cantidad de la que se va a hacer ciclo
     ;          en el CX

                    ;se pasa al DI y al SI las cadenas
     LEA SI,CADENA1
     LEA DI,CADENA2

     REPE CMPSB  ; se va a repetir comparando las dos cadenas 
     ;que se encuentra en el SI Y DI

     JNE FIN   ; si es así, se salta al procedimiento fin

     LEA DX,MENSAJE1

     CALL MOSTRAR

     JMP SALIR


    ; procedimiento FIN
 FIN: LEA DX,MENSAJE2
     CALL MOSTRAR
     MOV num,Cl
     add num,30h
     MOV AH,02H
     MOV Dh,num
     INT 21H
     
     ;procedimiento SALIR
 SALIR: MOV AX,4C00H
         INT 21H

    BEGIN ENDP

         ;procedimiento de limpiar pantalla
    LIMPIO PROC NEAR
     MOV AX,0600H ; aquí había un error, andaba apuntando al AL 
     MOV BX,1700H
     MOV CX,00
     MOV DX,184FH
     INT 10H
     RET
    LIMPIO ENDP


;procedimiento para ubicar el cursor 
    CURSOR PROC NEAR
     MOV AH,02H
     MOV BH,00 ; ubico el cursor
     MOV DX,0506H
     INT 10H
     RET
    CURSOR ENDP


;procedimiento para mostrar algo en pantalla
    MOSTRAR PROC NEAR
     MOV AH,09H
     INT 21H
     RET
    MOSTRAR ENDP
    END
