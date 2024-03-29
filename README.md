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
  * [Via Interface de Rede](#via-interface-de-rede)
  * [Via PCAP](#via-pcap)
* [Armazenamento das detecções](#armazenamento-das-detecções)
* [Corrigindo Erros](#corrigindo-erros)
  * [Erro: _Permission Denied_](#erro-permission-denied)
  * [Erro: _java.lang.UnsatisfiedLinkError_](#erro-javalangunsatisfiedlinkerror)
* [Créditos](#créditos)
* [Observações](#observações)



Descrição
------------

RivIA se trata de um módulo de deteção de ataques ciberneticos em rede que faz uso de Inteligência Artificial (Machine Learning - ML) para detecção de atividades maliciosas. Este software foi desenvolvido majoritariamente nas linguagens Python, Java e Bash, junto com bilibiotecas de codigo aberto.


Atenção
----------
Este software está sendo desenvolvido para sistemas Linux por enquanto. Posteriormente será adaptado ao sistema Windows também.


Instalação
------------

Para baixar o RivIA, temos 2 opções:
- Baixar com **git**: `git clone https://github.com/aminmismail/RivIA-IDS.git`
- Baixar arquivo **ZIP**: [Clique aqui para baixar](https://github.com/aminmismail/RivIA-IDS/archive/master.zip)

Após terminar de baixar, conceda permissão de execução para o arquivo `install.sh` utilizando o comando `chmod +x install.sh` e execute-o (caso necessário, execute-o com **sudo**). 

O script irá instalar as dependências necessárias para poder executar o software, assim como conceder as permissões necessárias para os arquivos.

Como Usar
------------

Para que o software funcione corretamente, recomenda-se utilizar:
- Python 3.10+
- JDK 11

Para verificar as versões do Python e do JDK, use os comandos: `python3 --version` e `java --verion`
Certifique-se de utilizar `python3` e não apenas `python` para checar a versão

Para executar o módulo, basta digitar `./modulo.sh` e ele irá permitir a execução em 2 modos: Interface de Rede ou PCAP.
O software permite também a escolha entre 2 maneiras de classificação: Binária ou Múltipla.

### Via Interface de Rede:

Na detecção via interface de rede, o módulo irá capturar todo o tráfego da interface desejada pelo usuário, e em seguida, realizar a detecção com base nos PCAPs gerados a partir da ferramenta **tcpdump** (em intervalos de 1 minuto).

Para selecionar este modo, basta escolher a opção 1 e pressionar **Enter**. Escolha então o modo de classificação. Em seguida, basta fornecer a interface de rede que será monitorada. Exemplo: `eth0`

### Via PCAP:

No modo PCAP, o módulo realiza as detecções com base em um arquivo PCAP fornecido pelo usuário.

Para selecionar este modo, basta escolher a opção 2 e pressionar **Enter**. Escolha então o modo de classificação. Em seguida, forneça o caminho relativo do PCAP que se deseja analisar. Exemplo: `./trafego_03.pcap`


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

Para que o programa consiga conectar corretamente com o MongoDB, deve-se configurar o arquivo <i>*mongo_login.conf*</i>, alterando o Usuário, a Senha, o Link de Conexão da Database e o nome da Database correspondentes às credenciais da Database desejada. (**ATENÇÃO:** O login da database podem ser diferentes do login da plataforma MongoDB).
Caso necessário, visite o site: <a>https://www.mongodb.com/docs/manual/reference/connection-string/</a> para mais ajuda.


Corrigindo Erros
-------------

Durante o desenvolvimento do software, foram encontrados alguns erros, demonstrados a seguir.

### Erro: _Permission Denied_

Em alguns casos, quando utilizando algum sistema que tenha o __Apparmor__, é possível que o software não execute corretamente por questões de segurança.
Para corrigir, adicione a seguinte linha no arquivo `/etc/apparmor.d/usr.sbin.tcpdump`:

```
/usr/sbin/tcpdump {
  ...
  # for -z
  /**/* ixr,      # <-- me adicione!
  ...
}
```

Caso o arquivo `/etc/apparmor.d/usr.sbin.tcpdump` não exista, então adicione a linha no arquivo `/etc/apparmor.d/usr.bin.tcpdump`

Então, reinicie o serviço: `sudo service apparmor restart`


### Erro: _java.lang.UnsatisfiedLinkError_

Este erro ocorre caso a biblioteca *libpcap-dev* não tenha sido instalada corretamente.
Aparecerá então o seguinte erro:

    Exception in thread "main" java.lang.UnsatisfiedLinkError: com.slytechs.library.NativeLibrary.dlopen(Ljava/lang/String;)J
            at com.slytechs.library.NativeLibrary.dlopen(Native Method)
            at com.slytechs.library.NativeLibrary.<init>(Unknown Source)
            at com.slytechs.library.JNILibrary.<init>(Unknown Source)
            at com.slytechs.library.JNILibrary.loadLibrary(Unknown Source)
            at com.slytechs.library.JNILibrary.register(Unknown Source)
            at com.slytechs.library.JNILibrary.register(Unknown Source)
            at com.slytechs.library.JNILibrary.register(Unknown Source)
            at org.jnetpcap.Pcap.<clinit>(Unknown Source)
            at cic.cs.unb.ca.jnetpcap.PacketReader.config(PacketReader.java:58)
            at cic.cs.unb.ca.jnetpcap.PacketReader.<init>(PacketReader.java:52)
            at cic.cs.unb.ca.ifm.CICFlowMeter.main(CICFlowMeter.java:93)

Para corrigir, basta instalar a biblioteca utilizando o comando: `sudo apt install libpcap-dev`


Créditos
-------------

Créditos ao usuário *iPAS* pela ferramenta desenvolvida utilizando TCPDump e CICFlowMeter, e também ao usuário *ahlashkari* por disponibilizar a ferramenta CICFlowMeter

Link do repositório do trabalho do iPAS: https://github.com/iPAS/TCPDUMP_and_CICFlowMeter

Link do repositório da ferramenta CICFlowMeter: https://github.com/ahlashkari/CICFlowMeter



Observações
-------------

- É NECESSÁRIO existir 4 pastas nomeadas: "pcap", "csv", "logs" e "tmp"
- NÃO é recomendado executar o programa com `sudo`




