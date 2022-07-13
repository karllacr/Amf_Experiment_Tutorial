# Amf_Experiment_Tutorial

## Passo 1 : Verificar a versão do kernel

Para que o protocolo GTP consiga criar túneis de conexão é necessário o uso de um kernel linux específico. Para este experimento foi usado o **5.4.0-65-generic**. Verifique o seu kernel com o seguinte comando:

```
uname -r
```

Se seu kernel for o mesmo, ou seja, se seu kernel for **5.4.0-65-generic**, ou alguma versão maior que 5.4-0-*-generic, prossiga com os passos. Agora, se seu kernel for diferente ou menos que 5.4 siga os passos desse link: https://forum.free5gc.org/t/gtp5g-build-failed/57

## Passo 2: Instalação Prometheus

Para instalar o Prometheus localmente, siga os passos demostrando no tutorial deste link: https://linoxide.com/how-to-install-prometheus-on-ubuntu/. Ele será usado posteriormente em nosso experimento.

## Passo 3: Instalação do GTP5G

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


## Passo 5: Instalação do my5gRANTester

O my5gRANTester irá simular uma RAN 5G. Para instalá-lo faça o download do seguinte diretório contido neste link: https://github.com/karllacr/free5gc-my5G-RANTester-docker. 
Entre no diretório que você acabou de clonar e dê o comando abaixo para buildar a imagem docker:

```
docker build -f nf_tester/Dockerfile --tag my5grantester:latest .
```
Antes de fazermos o tester rodar, precisamos configurar os dados do UE na interface gráfica.

## Passo 6: Acessando a WebUI e adicionando um UE:

Dentro do VSCode, exporte a porta 5000 e acesse seu localhost nesta porta. Use *admin* e *free5gc* como login e password, respectivamente.
Adicione um subscriber e verifique se os dados dele são exatamente iguais ao dados contidos no arquivo **tester.yaml**
Apoś dar criar o UE, feche a página e retorne ao VSCode.

## Passo 6: Inicializar e testar o RAN Tester

Retorne a pasta do my5gRANTester e de dentro dela dê o seguinte comando para iniciar o container:

```
docker-compose up -d
```
Cheque se algum container com o nome *my5grantester* foi inicializado e está com o status *Up*:

```
docker ps -a
```
E depois acesse o container com o comando:

```
docker exec -it my5grantester /bin/bash
```

Para se certificar de que o experimento está funcionando de forma correta, precisamos verificar se o túnel do UE foi iniciado e se conseguimos pingar na internet através deste túnel que foi criado.
Assim, uma vez dentro do container use o comando abaixo para chegar as interfaces de rede e a existência do túnel:

```
ip addr
```
Se entre a lista existir uma interface chamada **uetun1** significa que o túnel foi estabelecido.
Agora, faça um ping atráves do túnel com:

```
ping -I uetun1 8.8.8.8
```
Se o ping funcionar e conseguir enviar pacotes via túnel, então o nosso experimento funcionou :D

## Passo 7: Estabelecendo mais de um túnel de UE:

Em nossos teste será necessário gerar certas cargas e estresses na AMF e para isso precisamos subir e cadastrar mais de um equipamento de usuário (UE). Para isso, precisamos alterar um paramêtro no arquivo **docker-compose.yaml** dentro da pasta do *my5grantester/*.
No local em que estiver escrito ```command: ./app ue``` mude para ```command: ./app load-test -n x``` onde x é o valor de UE's que você deseja subir.

## Passo 8: Docker Stat Exporter

Para exportamos as métricas dos container iremos usar o *docker-stat-exporter* que realiza o scrape de métricas diversas associadas ao comando docker stat, nativo do Docker. Para instalar use o seguinte comando:

```
docker run -d --restart=always -p 9487:9487 -v /var/run/docker.sock:/var/run/docker.sock wywywywy/docker_stats_exporter:latest
```
Ele expõe o serviço na porta 9487 e esse serviço deve ser declarado como um job no arquivo de configuração do Prometheus.





