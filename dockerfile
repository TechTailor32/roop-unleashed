##############################################################
#  Build the docker image:
#    docker build -t roop-unleashed .
#
# Set port to 4000 - only use if not using docker-compose.yml
#   docker run -p 4000:80 roop-unleashed
#
###############################################################

# Use an official Python runtime as a parent image
FROM python:3.10.13

#Set Environment variables - change to fit your requirements
ENV GIT_REPO https://github.com/TechTailor32/roop-unleashed.git
ENV NAME ROOP
ENV WORKINGFOLDER /roop-unleashed
##  3 choices:  colab (changes to run on Kaggle), cuda (if you have nvidia GPU), cpu (if you have cpu only)
##  config_colab.yaml or config_cuda.yaml or config_cpu.yaml
ENV CONFIGFILE config_cuda.yaml   

# Set the working directory in the container
WORKDIR ${WORKINGFOLDER}

# Install system dependencies for git
RUN apt-get update && apt-get install -y git 

#  clone repository
RUN git clone ${GIT_REPO} /${WORKINGFOLDER}
RUN mv /${WORKINGFOLDER}/${CONFIGFILE} /${WORKINGFOLDER}/config.yaml

# Install any needed dependencies and packages specified in requirements.txt
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    ffmpeg 
RUN pip install --no-cache-dir -r requirements.txt

# Run appname when the container launches - change the run.py to your own app.py
CMD ["python", "run.py"]
