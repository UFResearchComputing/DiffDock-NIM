import json
import os
import shutil

def dump_one(folder, ligand_positions, position_confidence):
    os.makedirs(folder, exist_ok=True)

    for i, c in enumerate(position_confidence):
        with open('%s/rank%02d_confidence_%0.2f.sdf' % (folder, i+1, c), 'w') as f:
            f.write(ligand_positions[i])

shutil.rmtree('output', ignore_errors=True)
os.makedirs('output', exist_ok=True)

with open('output.json') as f:
    data = json.load(f)

if type(data['status']) == str:
    dump_one('output', data['ligand_positions'], data['position_confidence'])
else:
    for i in range(len(data['status'])):
        dump_one('output/ligand%d' % (i+1), data['ligand_positions'][i], data['position_confidence'][i])
