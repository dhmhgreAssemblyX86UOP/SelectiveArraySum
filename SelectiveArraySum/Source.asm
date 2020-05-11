TITLE Selective Array Summation
INCLUDE Irvine32.inc



.data
array SDWORD 10,60,20,33,72,89,45,65,72,18
sample SDWORD 50
sum SDWORD 0
message BYTE "The result is :",0
ArraySize = LENGTHOF array

.code
;int SelectiveSummation(int *array, int sample, int *sum){
;	int index = 0;
;	while( index < ArraySize ){
;		if( array[index] <= sample )
;		{
;			sum += array[index];
;		}
;		index++;
;	}
;}
SelectiveSummation PROC
	; prologue
	push ebp
	mov ebp,esp
	sub esp,4
	mov SDWORD PTR [ebp-4], 0
	push edi
	push esi
	push ebx

	; main body

	; while loop initialization
	mov esi, [ebp-4]
	mov edi, [ebp+8]
	mov eax, 0
	jmp CND

	; while loop body
LP:	
	 mov ebx, [edi+esi*4]
	 cmp ebx, [ebp+12]					; evaluate the condition array[index] <= sample
	 jg L1
	 add eax,ebx						; sum += array[index];
L1:  inc esi
     mov [ebp-4],esi
CND: cmp esi, ArraySize
	 jl LP

	;epilogue
	pop ebx
	pop esi
	pop edi
	mov esp,ebp
	pop ebp
	ret 12
SelectiveSummation ENDP

main PROC
    push OFFSET sum 
	push sample
	push OFFSET array
	call SelectiveSummation  ;int SelectiveSummation(int *array, int sample, int *sum)
	mov edx, OFFSET message
	call WriteString
	call WriteInt
	exit
main ENDP
END main