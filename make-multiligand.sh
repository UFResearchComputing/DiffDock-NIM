#!/bin/bash

# Script: make-multiligand.sh
# Usage: ./make-multiligand.sh [Ligand1_CCD_ID] [Ligand2_CCD_ID] ...
# Example: ./make-multiligand.sh COM Q4H QPK R4W SIN

ligand_files=""

for lig in $*
do
    ligand_file=${lig}.sdf
    echo "Download ligand file:${ligand_file}"
    curl -o $ligand_file "https://files.rcsb.org/ligands/download/${lig}_ideal.sdf"
    ligand_files="${ligand_files} ${ligand_file}"
done

# Combine ligand files into a single SDF file
cat $ligand_files > multi_ligands.sdf
