#!/bin/bash
#SBATCH --job-name=binf-work        # Name of the job
#SBATCH -p short                    # Partition to submit to
#SBATCH --mem 16G                   # Memory allocation
#SBATCH -t 1-00:00:00               # Time limit (1 day)
#SBATCH -N 1                        # Number of nodes
#SBATCH -c 8                        # Number of CPU cores
#SBATCH --mail-type=END,FAIL        # Email notifications
#SBATCH --mail-user=aitken.n@northeastern.edu  # Email address



# Define the input and output FASTQ file paths
#!/bin/bash

# Define the source and target folders
SOURCE_FOLDER="../P1432_trimmomatic_output"  # Replace with the path to your source folder containing .fastq.gz files
TARGET_FOLDER="../P1432_fastq_unzipped"  # Replace with the path to your target folder where unzipped files will be saved

# Create the target folder if it doesn't exist
mkdir -p "$TARGET_FOLDER"

# Loop through all .fastq.gz files in the source folder
for file in "$SOURCE_FOLDER"/*.fastq.gz; do
    # Extract the base name of the file (remove path and extension)
    base_name=$(basename "$file" .gz)

    # Unzip the file to the target folder
    gunzip -c "$file" > "$TARGET_FOLDER/$base_name"

    echo "Unzipped: $file to $TARGET_FOLDER/$base_name"
done

echo "All files have been unzipped to $TARGET_FOLDER."
