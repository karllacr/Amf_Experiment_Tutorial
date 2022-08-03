import sys
import requests
import json
import time


qtd_ue = int(sys.argv[1])

with open('Amf_Experiment_Tutorial/base.json') as f:
  data_ue = json.load(f)
 

for i in range(1, qtd_ue+1):
    formatted_number = str(i).zfill(10)
    plmn_e_ue = "imsi-20893" + formatted_number
    data_ue["ueId"] = plmn_e_ue
    #print(data_ue)

    header = {"Token" : "admin", "Content-Type" : "application/json"}
    r = requests.post('http://localhost:5000/api/subscriber/'+plmn_e_ue+'/20893',  data = json.dumps(data_ue), headers=header )
    time.sleep(5)
    print('UE ' + plmn_e_ue + ' SUBSCRIBED!' )
