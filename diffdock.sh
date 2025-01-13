#!/bin/bash

# Script: diffdock.sh - Run inference using local files as input
# Usage: ./diffdock.sh [receptor].pdb [ligand].sdf

protein_file=$1
ligand_file=$2

protein_bytes=`grep -E ^ATOM $protein_file | sed -z 's/\n/\\\n/g'`
ligand_bytes=`sed -z 's/\n/\\\n/g' $ligand_file`
ligand_format=`basename $ligand_file | awk -F. '{print $NF}'`

echo "{
\"ligand\": \"${ligand_bytes}\",
\"ligand_file_type\": \"${ligand_format}\",
\"protein\": \"${protein_bytes}\",
\"num_poses\": 10,
\"time_divisions\": 20,
\"steps\": 18,
\"save_trajectory\": false,
\"is_staged\": false
}" > diffdock.json

curl --header "Content-Type: application/json" \
   --request POST \
   --data @diffdock.json \
   --output_bash output.json \
   http://localhost:8000/molecular-docking/diffdock/generate
