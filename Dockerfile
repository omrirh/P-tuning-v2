# Base image with CUDA support
FROM nvidia/cuda:11.3.1-cudnn8-runtime-ubuntu20.04

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    python3 \
    python3-pip \
    python3-dev \
    curl

# Set the working directory
WORKDIR /P-tuning-v2

# Copy the repository into the container
COPY . .

# Create the 'checkpoints' directory and set the correct permissions
RUN mkdir -p checkpoints && chmod -R 777 checkpoints

# Install Python dependencies from requirements.txt
RUN pip3 install -r requirements.txt

# Ensure proper permissions on the working directory
RUN chmod -R 777 /P-tuning-v2

# Run the main script
CMD ["/bin/bash", "-c", "${RUN_SCRIPT:-run_script/run_rte_roberta.sh}"]
