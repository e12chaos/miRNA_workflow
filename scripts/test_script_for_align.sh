#!/bin/bash
# Define the path to the reference genome
# REFERENCE_GENOME="Rattus_norvegicus.mRatBN7.2.cdna.all.fa"

# # Index the reference genome using Bowtie
bowtie-build $REFERENCE_GENOME reference_genome_bowtie

# Testing mapper.pl
mapper.pl test.fastq -e -j -m -h -p reference_genome_bowtie -s test_collapsed.fa -t test_mapped