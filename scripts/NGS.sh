#!/bin/bash
qsub -l h_rt=72:00:00,mem=15G -P KSU-GEN-RESERVED ~/scripts/hw3.sh
