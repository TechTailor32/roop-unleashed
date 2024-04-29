##############################################################
#  Build the docker image:
#    docker build -t roop-unleashed .
#
# Build from GitHub:
#    docker build --build-arg GIT_REPO=https://github.com/TechTailor32/roop-unleashed.git -t roop-unleashed .
ENV GIT_REPO https://github.com/TechTailor32/roop-unleashed.git
#
#
# Set port to 4000
#   docker run -p 4000:80 roop-unleashed
#
###############################################################

# Use an official Python runtime as a parent image
FROM python:3.10.13

# Set the working directory in the container
WORKDIR /roop-unleashed

# Copy the current directory contents into the container at /app
# COPY . /roop-unleashed
#  clone repository instead

RUN apt-get update && apt-get install -y git
RUN git clone ${GIT_REPO} /roop-unleashed

# Install any needed packages specified in requirements.txt
#RUN pip uninstall -y gradio
#RUN python3 -m pip install --upgrade pip
#RUN pip install numpy
#RUN pip install gradio==3.28.2
#RUN pip install opencv-python
#RUN pip install onnx
#RUN pip install insightface
#RUN pip install psutil
#RUN pip install torch
#RUN pip install torchvision
#RUN pip install onnxruntime
#RUN pip install tqdm
#RUN pip install ftfy
#RUN pip install regex
#RUN pip install pyvirtualcam

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Make port 80 available to the world outside this container
EXPOSE 80

# Define environment variable
ENV NAME ROOP

# Run app.py when the container launches
CMD ["python", "run.py"]
