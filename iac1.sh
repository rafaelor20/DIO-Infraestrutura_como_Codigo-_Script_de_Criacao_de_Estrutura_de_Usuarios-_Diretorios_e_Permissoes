#!/bin/bash

echo "Criando grupos e fazendo as devidas configurações..."

mkdir /publico
chmod 777 /publico

read -p "Quantos grupos devem ser criados?" quant_grupos
contador = 0

while [contador < quant_grupos]; do
    read -p "Nome do grupo:" nome_diretório
    mkdir /$nome_diretório
    nome_grupo = ${nome_diretório^^}
    groupadd GRP_$nome_grupo
    chown root:GRP_$nome_grupo /nome_diretório
    chmod 770 /$nome_diretório
    contador = contador + 1
done

echo "Criando usuários..."

read -p "Quantos usuários devem ser criados?" quant_usuários
contador = 0

while [contador < quant_usuários]; do
    read -p "Nome do usuário:" nome_usuário
    nome_usuário = ${nome_usuário^}
    read -p "Qual a senha deste usuário?" senha_usuário
    read -p "Qual o grupo deste usuário?" grupo_usuário
    nome_grupo = ${grupo_usuário^^}

    useradd $nome_usuário -m -s /bin/bash -p $(openssl passwd -crypt $senha_usuário) -G GRP_$nome_grupo

    contador = contador + 1
done

echo "Fim....."