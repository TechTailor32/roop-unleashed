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
ENV APPNAME run.py

# Set the working directory in the container
WORKDIR ${WORKINGFOLDER}

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    libgl1-mesa-glx  ## Add this line to install the OpenGL libraries

#  clone repository
RUN git clone ${GIT_REPO} /${WORKINGFOLDER}

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Run appname when the container launches
CMD ["python", ${APPNAME}]
