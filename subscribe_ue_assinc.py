import sys
import requests
import json
import time
import asyncio
from concurrent.futures import ThreadPoolExecutor


qtd_ue = int(sys.argv[1])
max_subscribing =int(sys.argv[2])

def request(i):
    with open('../Amf_Experiment_Tutorial/base.json') as f:
        data_ue = json.load(f)

    formatted_number = str(i).zfill(10)
    plmn_e_ue = "imsi-20893" + formatted_number
    data_ue["ueId"] = plmn_e_ue
    #print(data_ue)

    header = {"Token" : "admin", "Content-Type" : "application/json"}
    r = requests.post('http://localhost:5000/api/subscriber/'+plmn_e_ue+'/20893',  data = json.dumps(data_ue), headers=header )
    time.sleep(5)
    print('UE ' + plmn_e_ue + ' SUBSCRIBED!' )


async def start_async_process():
    with ThreadPoolExecutor(max_workers=max_subscribing) as executor:
        loop = asyncio.get_event_loop()
        tasks = [
            loop.run_in_executor(executor,request,i)
            for i in range(1, qtd_ue+1)
                ]
        for response in await asyncio.gather(*tasks):
            pass

if __name__ == "__main__":
    loop = asyncio.get_event_loop()
    future = asyncio.ensure_future(start_async_process())
    loop.run_until_complete(future)
