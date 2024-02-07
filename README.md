# Machine_Learning-IDS
Desenvolvimento de um módulo de detecção de ataques (IDS) utilizando Machine Learning, junto com TCPDump e CICFlowMeter.

<hr>

A maneira que o módulo funciona para capturar os pacotes é utilizando a ferramenta TCPDump, passando tais PCAPs pela ferramenta CICFlowMeter e os transformnado em arquivos 'comma separated values' (.csv) que serão usados como entrada de dados para o módulo realizar a análise.

É possível realizar análise de fluxo de rede de 2 maneiras: <br>
1 - Arquivo PCAP existente; <br>
2 - Análise do tráfego de rede em tempo real. <br>

Após as análises e classificações feitas, o módulo é capaz de armazenar todas ameaças detectadas no banco de dados MongoDB (Cloud), guardando as seguintes informações: <br>
-> ID da ameaça <br>
-> Classificação da ameaça <br>
-> IP de origem <br>
-> Porta de origem <b>
-> Ip de destino <br>
-> Porta de destino <br>
-> Timestamp do fluxo (data/horário que o pacote foi capturado) <br>
-> Timestamp da análise (data/horário que o módulo fez a análise) <br> 

<hr>

Créditos ao usuário iPAS pela ferramenta desenvolvida utilizando TCPDump e CICFlowMeter, e também ao usuário ahlashkari por disponibilizar a ferramenta CICFlowMeter.<br>
Link do repositório do trabalho do iPAS: https://github.com/iPAS/TCPDUMP_and_CICFlowMeter <br>
Link do repositório da ferramenta CICFlowMeter: https://github.com/ahlashkari/CICFlowMeter <br>
