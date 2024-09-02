#!/bin/bash
#SBATCH --job-name=binf-work	  # Name of the job
#SBATCH -p short                        # Who to bill for the job
#SBATCH --mem 16G                         # How much memory
#SBATCH -t 1-00:00:00                        # How long
#SBATCH -N 1
#SBATCH -c 8
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=aitken.n@northeastern.edu
# Define the project name

mkdir -p ../P1432_fastqs

PROJECT_NAME="P1432"

# List of dataset IDs to download
DATASET_IDS=(
    "ds.2b76511ed03343379d6c951145caed8b"
    "ds.4a36313ef80d4b93a3338e60aa0695c7"
    "ds.d9f04a638df2456da0f10f82f6c7b5c2"
    "ds.497a2d0e01734f67b3f5158c3487c0c9"
    "ds.391a70d8cd7a49e9b472ffed5f16dd46"
    "ds.52c2219134cc4676b342f80bdb31c2f1"
    "ds.7cb670d6abc344eeaa23a7de72968114"
    "ds.583d7af61e0b41768ac1c0ee0f9196d6"
    "ds.4be64440436e4900a5f32ff532cfbbfb"
    "ds.f449b38f02034fdf919782e555ef6ff7"
    "ds.3cacc05ea9b0431585b3577227df0b9e"
    "ds.e8551294aa234748957c20aa9b78cc74"
    "ds.68329945817344ef9c81280af0d55cee"
    "ds.e244459c0f0f42038e5dd7717529c48c"
    "ds.f450b548ebf04b67b884ba1ed1044bc4"
    "ds.78184520346d4eb6a4185e2de4eb2749"
    "ds.d0aae5455c0e4d3f9044af01a5c520ea"
    "ds.b7b0dc3ea0124f3a8fdf6c8090f49dd7"
    "ds.2cbb0e3f2e534ec886d7745aeff3bfe2"
    "ds.23f734bbcf1a4022ba62bffe5f1b4c2b"
    "ds.9a0519de3b7e4b66848b0b02d69f18c0"
    "ds.14af346025c04333a55a7050f873d40a"
    "ds.399ffa46baa54fab91569bf6baa2eb0f"
    "ds.87d76925712e44e8bf41327271b97516"
    "ds.b6220380ebfb4c2f941d9653a6c50c56"
    "ds.7f0203a9c7074590a46c3b35588bf0f6"
    "ds.e1e2109802bc487290f7883ac16dc2cc"
    "ds.8d6d9cd2c64d4ff2a037735646b7cd4b"
    "ds.a507c27048c344ef9ae0a8b763af80fd"
    "ds.eb7e2f417a32471b8b73f7056083ee29"
    "ds.fd23cff789a04b8288eeeec2d73d06d0"
    "ds.4ab13bdeba0a4ac99dcc57a1c9343ba7"
    "ds.93470290eb014cf389db6193d2cf2273"
    "ds.ca39518c7eea486ca5d07f13882ee84f"
    "ds.cd1e8d2962b0465985cab1f13db54627"
    "ds.683adea4412e4a349add635f1ddda9f2"
    "ds.57f2afca7f6045679b6e62f5bca5b681"
    "ds.efb28e9f5a244ed9b85fad2d5c857b55"
    "ds.d4b68b9e1de044418a66b75a8bce2b89"
    "ds.540078753f93437da3e40cd0b1488f41"
    "ds.c349504672ed4b8397ad620ab875ad39"
    "ds.f983af40bdd14595869d7f4d1346b0da"
    "ds.46a99acdf6524bc2a47782a9f86e1805"
    "ds.90ccd6bee78a4cf384a4b66fa3e270eb"
    "ds.b80f4c0f6f2d402cae2d13f75768a0b6"
    "ds.a8da7c6da42145729c237fe32d22961b"
    "ds.c82dbeb270c542ecabe60a54a2611d12"
    "ds.ba9484ba50e94e06a69239734a46f3a6"
)

# Create output directory
OUTPUT_DIR="../P1432_fastqs"
mkdir -p $OUTPUT_DIR

# Loop through dataset IDs and download each one
for DATASET_ID in "${DATASET_IDS[@]}"; do
    echo "Downloading dataset $DATASET_ID..."
    bs download dataset --id $DATASET_ID --output $OUTPUT_DIR
done

echo "Download complete. All datasets are saved in $OUTPUT_DIR."
