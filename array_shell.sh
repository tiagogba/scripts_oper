#!/bin/bash

#Teste de array simples

array_var=(1 2 3 4 5 6)
#Valores a serem guardados
#Pode ser definido alphanumerico como index do array
array_var[0]="teste0"
array_var[1]="teste1"
array_var[2]="teste2"
array_var[3]="teste3"
array_var[4]="teste4"
array_var[5]="teste5"

echo "###############################################"
echo ""
#Acessando todo o array
echo "acessando todo o array"
echo ${array_var[*]}
echo ""

#Acessando apenas alguma unidade do array
echo "Acessando apenas alguma unidade do array"
echo ${array_var[1]}
echo ""

#Listar o comprimento do array
echo "Listar comprimento do array"
echo ${#array_var[*]}
echo ""

#Modo ordinario do array
echo "Lista de modo ordenada"
echo ${!array_var[*]}
echo ""


#############################################
#Direto no term
#Muito util

declare -A teste
teste=([bosta1]=valor1 [valor2]=valor2)
echo ${teste[bosta1]} #ou
echo ${teste[*]}


