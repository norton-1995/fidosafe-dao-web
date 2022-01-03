import subprocess
import json
import sys

DAO_ADDRESS = ''
NWK = 'main'
#se
#dev

if NWK in ['main', 'dev']:
    SIGNER = 'prod_signer'
    CLAIMERS_FILENAME = 'claimers01012022.json'
else:
    SIGNER = 'norton'
    CLAIMERS_FILENAME = 'claimers.test.json'

# Don't forget to clean existing claimers
# After running the script, don't forget to move the control to DAO

claimers = json.load(open(CLAIMERS_FILENAME, 'r'))
pack_counter = 0
pack_packet = {"claimItems": []}
PACK_SIZE = 60

print(len(claimers))

while len(claimers) > 0:
    existing_claimers = json.load(open('existing_claimers.json', 'r'))
    claimer = claimers.pop()
    packet_item = {"balance": claimer['balance'], "claimAddress": claimer['id']}
    if claimer['id'] in existing_claimers:
        print("Item already sent: {}".format(claimer['id']))
        print("Remaining: {}".format(len(claimers)))
    else:
        pack_packet['claimItems'].append(packet_item)
        pack_counter += 1
    if len(claimers) == 0 or pack_counter >= PACK_SIZE:

        subprocess.run(['tondev', 'contract', 'run', '../../contracts/FidosafeDAO.abi.json', 'addClaimers','-n', NWK, '-s', SIGNER, '--address',
                         DAO_ADDRESS, '-i', json.dumps(pack_packet)],
                        shell=True, check=True)

        for item in pack_packet['claimItems']:
            existing_claimers.append(item['claimAddress'])
        f = open('existing_claimers.json', 'w')
        f.write(json.dumps(existing_claimers))
        f.close()
        print("Remaining: {}".format(len(claimers)))
        print("Pack size: {}".format(len(json.dumps(pack_packet))))
        pack_counter = 0
        pack_packet = {"claimItems": []}


