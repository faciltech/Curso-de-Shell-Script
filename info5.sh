#!/bin/bash

########################################
## Autor: Eduardo Amaral
## Email - eduardo4maral@protonmail.com
## Descrição: Este script verifica em no google sobre uma pessoa especifica
## Uso: ./info.sh
## Atualização: 27/11/2024
########################################
echo -e "\033[33;1m#############################################################\033[m"
echo -e "\033[33;1m### Autor: Eduardo Amaral                                 ###\033[m"
echo -e "\033[33;1m### Email - eduardo4maral@protonmail.com                  ###\033[m"
echo -e "\033[33;1m### Uso: ./info.sh                                        ###\033[m"
echo -e "\033[33;1m### Atualização: 27/11/2024                               ###\033[m"
echo -e "\033[33;1m#############################################################\033[m"

if ! command -v lynx > /dev/null; then
    echo
    echo -e "\033[31;1mErro: lynx não está instalado. Instale-o para continuar.\033[m"
    echo "Comando: sudo apt install lynx -y"
    exit 1
fi


# Função para buscar links no Google
google_search() {
    read -p "Digite o termo de busca: " SEARCH_TERM
    while true;
    do
	echo "========================================================================"
        echo "Escolha o tipo de arquivo para buscar:"
        echo "1. PDF"
        echo "2. DOC/DOCX"
        echo "3. PPT/PPTX"
        echo "4. XLS/XLSX"
        echo "5. TXT"
        echo -n "6. Qualquer tipo: "
	read -r FILE_TYPE_OPTION
	echo "=========================================================================="
    	# Determinar o tipo de arquivo com base na escolha
    	case $FILE_TYPE_OPTION in
	        1) FILE_TYPE="pdf" ;;
	        2) FILE_TYPE="doc" ;;
	        3) FILE_TYPE="ppt" ;;
	        4) FILE_TYPE="xls" ;;
	        5) FILE_TYPE="txt" ;;
	        6) FILE_TYPE="" ;;
	        *)
	           echo -e "\033[31;1mOpção inválida. Tente novamente.\033[m"
           	exit 1
           	;;
    	esac

    # Construir a URL de busca
    	if [ -z "$FILE_TYPE" ]; then
        	SEARCH_URL="https://www.google.com/search?q=intext:%22${SEARCH_TERM// /+}%22"
    	else
        	SEARCH_URL="https://www.google.com/search?q=intext:%22${SEARCH_TERM// /+}%22+filetype:${FILE_TYPE}"
    	fi

    	echo -e "\033[32;1mBuscando links da pesquisa no Google...\033[m"
    # Fazer o request com o LYNX e processar os links
    	lynx -dump "$SEARCH_URL" | grep -E "\.${FILE_TYPE}" | sort -u | grep -Eo "q=(http|https):.*${FILE_TYPE}" | sed 's/q=//g'
    done
}

# Início do script
echo
echo "Bem-vindo ao script de busca no Google por tipos de arquivo."
google_search


