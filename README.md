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

#### a) No arquivo **docker-compose.yaml** mude a tag ***version** para '2.2'
