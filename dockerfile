##############################################################
#  Build the docker image:
#    docker build -t roop-unleashed .
#
# Build from GitHub:
#    docker build --build-arg GIT_REPO=https://github.com/TechTailor32/roop-unleashed.git -t roop-unleashed .
#
#
# Set port to 4000
#   docker run -p 4000:80 roop-unleashed
#
###############################################################

# Use an official Python runtime as a parent image
FROM python:3.10.13

#Set Environment variables
ENV GIT_REPO https://github.com/TechTailor32/roop-unleashed.git
ENV NAME ROOP

# Set the working directory in the container
WORKDIR /roop-unleashed

# Copy the current directory contents into the container at /app
# COPY . /roop-unleashed
#  clone repository instead

RUN apt-get update && apt-get install -y git
RUN git clone ${GIT_REPO} /roop-unleashed

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Run app.py when the container launches
CMD ["python", "run.py"]
