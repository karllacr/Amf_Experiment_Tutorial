# Amf_Experiment_Tutorial

## Passo 1 : Verificar a versão do kernel

Para que o protocolo GTP consiga criar túneis de conexão é necessário o uso de um kernel linux específico. Para este experimento foi usado o **5.4.0-65-generic**. Verifique o seu kernel com o seguinte comando:

```
uname -r
```

Se seu kernel for o mesmo, ou seja, se seu kernel for **5.4.0-65-generic**, prossiga com os passos. Agora, se seu kernel for diferente siga os passos desse link: https://forum.free5gc.org/t/gtp5g-build-failed/57

## Passo 2: Instalação do GTP5G

Para instalar este módulo de kernel faça o seguint:

```
cd ~
git clone https://github.com/free5gc/gtp5g.git
cd gtp5g
make
sudo make install
```

Verifique sua instalação com 

```
lsmod | grep gtp
```

## Passo 3: Instalação do Free5g-compose

O free5gc-compose é uma instalação do core 5g de forma containerizada. Para conseguirmos realizá-la, faça o download do repositório contido neste link: https://github.com/free5gc/free5gc-compose e siga as suas instruções.


## Passo 4: Instalação e configuração do my5gRANTester

O my5gRANTester irá simular uma RAN 5G. Para instalá-lo faça o download do seguinte diretório contido neste link: https://github.com/my5G/free5gc-my5G-RANTester-docker. Depois vamos entrar no reposítorio e fazer alguma modificações nos arquivos de configuração.

**a)** No arquivo **docker-compose.yaml** mude a tag *version* para '2.2' e faça com que a tag *name* dentro de *networks* receba o nome da bridge docker que o free5gc-compose criou durante sua instalação. Por fim, salve o arquivo.
<br>
**b)** Dentro da pasta *config/*, apague todo o conteúdo do arquivo **tester.yaml**, cole o seguinte trecho e salve o arquivo:

```
gnodeb:
  controlif:
    ip: "tester.free5gc.org"
    port: 9487
  dataif:
    ip: "tester.free5gc.org"
    port: 2152
  plmnlist:
    mcc: "208"
    mnc: "93"
    tac: "000001"
    gnbid: "000001"
  slicesupportlist:
    sst: "01"
    sd: "010203"

ue:
  msin: "0000000003"
  key: "8baf473f2f8fd09487cccbd7097c6862"
  opc: "8e27b6af0e692e750f32667a3b14605d"
  amf: "8000"
  sqn: "0000000"
  dnn: "internet"
  hplmn:
    mcc: "208"
    mnc: "93"
  snssai:
    sst: 01
    sd: "010203"

amfif:
  ip: "amf.free5gc.org"
  port: 38412
```

**c)** Dentro da pasta *nf_tester/* altere o arquivo *Dockerfile*. Onde estiver escrito ```git clone --branch v1.0.0 https://github.com/my5G/my5G-RANTester.git \``` deve ser modficado para ```git clone https://github.com/my5G/my5G-RANTester.git```. Por fim, salve o arquivo.
