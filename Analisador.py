#!/usr/bin/env python
# coding: utf-8

# Imports

import pandas as pd
import numpy as np
import pickle
import sys
import os
import re
from sklearn.ensemble import RandomForestClassifier
from pymongo.mongo_client import MongoClient
from pymongo.server_api import ServerApi
from datetime import datetime
from pytz import timezone

# Carregar o csv
features = pd.read_csv(sys.argv[1], low_memory=False)
print("+++ CSV carregado!\n")
arq_pcap = sys.argv[1].split('/')[-1]

modo_classificacao = 0 #0 = binario | 1 = multi

if sys.argv[2] == '1':
	modo_classificacao = 1
	print("-| Multi-Classificacao |-")
else:
	print("-| Classificacao Binaria |-")

#Corrigindo linha repetida do cabecalho
for i in range(len(features["Flow ID"])):
    if features.loc[i, "Flow ID"] == "Flow ID":
    	features.drop(i,inplace=True)
features.reset_index(inplace=True, drop=True)


if features.shape[0] == 0:
    print("--- Nenhum fluxo foi encontrado!\n")
    quit()

# Abrir o arquivo e ler o conteúdo
with open('mongo_login.conf', 'r') as f:
    config = f.read()

# Encontrar e extrair o valor entre as aspas para usuário e senha
user = re.search(r'Usuario:"([^"]+)"', config).group(1)
password = re.search(r'Senha:"([^"]+)"', config).group(1)
link = re.search(r'Link_Conexao:"([^"]+)"', config).group(1)
database = re.search(r'Nome_Database:"([^"]+)"', config).group(1)

# Conexão do banco de dados
uri = f"mongodb+srv://{user}:{password}{link}"
client = MongoClient(uri, server_api=ServerApi('1'))
db = client[database]
collection = db[arq_pcap]

if modo_classificacao == 0: #Classificaçãoo binaria
	classes = ("Benigno", "Ataque")
elif modo_classificacao == 1: #Classificação Multipla
	classes = ("Benigno", "DoS", "PortScan", "DDoS", "FTP-Brute", "SSH-Brute", "Web Attack", "BotNet")


# Salvando os dados de timestamp do fluxo

time = features['Timestamp']
src_ip = features['Src IP']
src_prt = features['Src Port']
dst_ip = features['Dst IP']
dst_prt = features['Dst Port']

# Selecaionando os atributos para analise

features = features[['Bwd Packet Length Min', 'Subflow Fwd Bytes', 'Total Length of Fwd Packet', 'Fwd Packet Length Mean',
     'Bwd Packet Length Std', 'Flow IAT Min', 'Fwd IAT Min', 'Flow IAT Mean', 'Flow Duration', 'Flow IAT Std',
     'Active Min', 'Active Mean', 'Bwd IAT Mean', 'Fwd IAT Mean', 'ACK Flag Count', 'Fwd PSH Flags', 'SYN Flag Count',
     'Fwd Packets/s', 'Bwd Init Win Bytes', 'Bwd Packets/s', 'FWD Init Win Bytes', 'PSH Flag Count',
     'Average Packet Size']]

# Corrigindo dados errados ou faltantes
    
features[features == np.inf] = np.nan
if features.isnull().values.any() == "True":
    features.fillna(features.mean(), inplace=True)

# Transformando dataframe das features em array

features1 = np.array(features)

# Carregando o modelo a ser usado
cwd = os.getcwd()
if modo_classificacao == 0:
	rf = pickle.load(open(cwd + "/modeloRF_binario.sav", 'rb'))
if modo_classificacao == 1:
	rf = pickle.load(open(cwd + "/modeloRF_multi.sav", 'rb'))

# Realizando as predicoes

print("+++ Realizando predicoes ...\n")

predictions = rf.predict(features1)

# Gravando os resultados no MongoDB

fuso = timezone('America/Sao_Paulo')
length = len(predictions)
for i in range(length):
	if predictions[i] != 0:
	    date = datetime.now()
	    timestamp = date.astimezone(fuso).strftime('%d/%m/%Y %T')
	    time[i] = datetime.strptime(time[i], "%d/%m/%Y %I:%M:%S %p").strftime('%d/%m/%Y %T')
	    doc = {
		"id_classe": int(predictions[i]),
		"nome_classe": classes[predictions[i]],
		"ip_origem": src_ip[i],
		"porta_origem": src_prt[i],
		"ip_destino": dst_ip[i],
		"porta_destino": dst_prt[i],
		"timestamp_fluxo": time[i],
		"timestamp_analise": timestamp,
		"arquivo_referencia": arq_pcap
	    }
	    collection.insert_one(doc)

print(" === Analise concluida! ===\n")
