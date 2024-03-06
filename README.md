# RivIA - IDS baseado em IA

![Build](https://img.shields.io/badge/Feito%20com%3A-Python%203.10-green)
![Build](https://img.shields.io/badge/JDK%2011-blue)
![Build](https://img.shields.io/badge/Bash-red)
![Build](https://img.shields.io/badge/CICFlowMeter-21219c)

> Sistema de Detecção de Intrusão baseado em Machine Learning

Tabela de Conteúdos
------------
* [Descrição](#descrição)
* [Instalação](#instalação)
* [Como usar](#como-usar)
  * [Via PCAP](#via-pcap)
  * [Via Interface de Rede](#via-interface-de-rede)
* [Armazenamento das detecções](#armazenamento-das-detecções)
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
[//]: # (Alterar Usuario e Senha do Database do banco de dados MongoDB no arquivo Analisador.py)

Para executar o módulo, basta digitar `./modulo.sh` e ele irá permitir a execução em 2 modos: Interface de Rede ou PCAP.

### Via Interface de Rede:

Na detecção via interface de rede, o módulo irá capturar todo o tráfego da interface desejada pelo usuário, e em seguida, realizar a detecção com base nos PCAPs gerados a partir da ferramenta **tcpdump** (em intervalos de 1 minuto).

Para selecionar este modo, basta escolher a opção 1 e pressionar **Enter**. Em seguida, basta fornecer a interface de rede que será monitorada. Exemplo: `eth0`

### Via Pcap

No modo PCAP, o módulo realiza as detecções com base em um arquivo PCAP fornecido pelo usuário.

Para selecionar este modo, basta escolher a opção 2 e pressionar **Enter**. Em seguida, forneça o caminho relativo do PCAP que se deseja analisar. Exemplo: `./trafego_03.pcap`


Armazenamento das detecções
-----------

Todas as detecções feitas são armazenadas no banco de dados MongoDB (em Cloud), contendo as seguintes informações:
- ID da ameaça
- Classificação da ameaça
- IP de origem
- Porta de origem
- IP de destino
- Porta de destino
- Timestamp do fluxo (data/horário que o pacote foi capturado)
- Timestamp da análise (data/horário que o módulo fez a análise)

Para que o programa consiga conectar corretamente com o MongoDB, deve-se configurar o arquivo <i>*mongo_login.conf*</i>


NÃO é recomendado executar o programa com sudo por questões de segurança.

OBS2: É NECESSÁRIO existir 4 pastas nomeada: "pcap", "csv", "logs" e "tmp".

-------------

<hr>

Créditos ao usuário iPAS pela ferramenta desenvolvida utilizando TCPDump e CICFlowMeter, e também ao usuário ahlashkari por disponibilizar a ferramenta CICFlowMeter.

Link do repositório do trabalho do iPAS: https://github.com/iPAS/TCPDUMP_and_CICFlowMeter

Link do repositório da ferramenta CICFlowMeter: https://github.com/ahlashkari/CICFlowMeter
