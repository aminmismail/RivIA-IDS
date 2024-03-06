# RivIA - IDS baseado em IA

![Build](https://img.shields.io/badge/Feito%20com-Python%203.10-green)
![Build](https://img.shields.io/badge/Java%2011-blue)
![Build](https://img.shields.io/badge/Bash-red)

> Sistema de Detecção de Intrusão baseado em Machine Learning

Tabela de Conteúdos
------------
* [Descrição](#descrição)
* [Instalação](#instalação)
* [Como usar](#como-usar)
  * [Via PCAP](#via-pcap)
  * [Via Interface de Rede](#via-interface-de-rede)
* [Corrigindo Erros](#corrigindo-erros)


Descrição
------------

RivIA se trata de um módulo de deteção de ataques ciberneticos em rede que faz uso de Inteligência Artificial (Machine Learning - ML) para detecção de atividades maliciosas. Este software foi desenvolvido majoritariamente nas linguagens Python, Java e Bash, junto com bilibiotecas de codigo aberto.


Instalação
------------

Para baixar o RivIA, temos 2 opções:
- Baixar com **git**: `git clone https://github.com/aminmismail/RivIA-IDS.git`
- Baixar arquivo **ZIP**: [Clique aqui para baixar](https://github.com/aminmismail/RivIA-IDS/archive/master.zip)

Após terminar de baixar, conceda permissão de execução para o arquivo `install.sh` utilizando o comando `chmod +x install.sh` e execute-o (caso necessário, execute-o com **sudo**). O script irá instalar as dependências necessárias para poder executar o software, assim como conceder as permissões necessárias para os arquivos.

Como Usar
------------

Para que o software funcione corretamente, recomenda-se utilizar:
- Python 3.10+
- JDK 11

### Via Pcap


	
### Via Interface de Rede:



Primeiramente, instale as bibliotecas necessárias, utilizando o comando: pip3 install -r requirements.txt
Em seguida, instale a biblioteca libpcap-dev com o comando: sudo apt install libpcap-dev

Os testes utilizando o módulo foram feitos utilizando:
- Openjdk 11.0.21 2023-10-17
- Python 3.10

Antes de iniciar o programa, é necessário configurar o Usuário e a Senha do Database do bando de dados MongoDB. Isso é possível ser feito através da edição do arquivo Analisador.py.

Execute o programa principal (menu) com o comando: ./modulo.sh
Em seguida, escolha a opcao desejada, sendo 1 para capturar tráfego via interface da rede, ou 2 para analisar um arquivo PCAP.

Para utilizar o módulo capturando o tráfego de rede, é necessário passar apenas a interface desejada (ex: eth0)
								
Para utilizar o módulo para apenas um arquivo pcap, basta passar o arquivo a ser analisado (ex: ./trafego_03.pcap)

Não é recomendado executar o programa com sudo.

OBS: Lembre-se de dar as permissoes corretas para os arquivos caso necessário.
OBS2: É NECESSÁRIO existir uma pasta nomeada "pcap" no diretorio, assim como outras chamadas "csv", "logs" e "tmp".

--------------------------

Desenvolvimento de um módulo de detecção de ataques (IDS) utilizando Machine Learning, junto com TCPDump e CICFlowMeter.

<hr>

A maneira que o módulo funciona para capturar os pacotes é utilizando a ferramenta TCPDump, passando tais PCAPs pela ferramenta CICFlowMeter e os transformnado em arquivos 'comma separated values' (.csv) que serão usados como entrada de dados para o módulo realizar a análise.

É possível realizar análise de fluxo de rede de 2 maneiras: <br>
1 - Análise do tráfego de rede em tempo real; <br>
2 - Arquivo PCAP existente; <br>

Após as análises e classificações feitas, o módulo é capaz de armazenar todas ameaças detectadas no banco de dados MongoDB (Cloud), guardando as seguintes informações: <br>
-> ID da ameaça <br>
-> Classificação da ameaça <br>
-> IP de origem <br>
-> Porta de origem <br>
-> Ip de destino <br>
-> Porta de destino <br>
-> Timestamp do fluxo (data/horário que o pacote foi capturado) <br>
-> Timestamp da análise (data/horário que o módulo fez a análise) <br> 

<hr>

Créditos ao usuário iPAS pela ferramenta desenvolvida utilizando TCPDump e CICFlowMeter, e também ao usuário ahlashkari por disponibilizar a ferramenta CICFlowMeter.<br>
Link do repositório do trabalho do iPAS: https://github.com/iPAS/TCPDUMP_and_CICFlowMeter <br>
Link do repositório da ferramenta CICFlowMeter: https://github.com/ahlashkari/CICFlowMeter <br>
