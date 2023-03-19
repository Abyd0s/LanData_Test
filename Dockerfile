# app/Dockerfile
# Version: 2022.11.16

# BaseImage hasznalata
FROM python:3.8.10

# Mappaszerkezet kialakitasa
RUN mkdir $HOME/landata && chmod -R 777 $HOME/landata

# Munkakonyvtar beallitasa
WORKDIR $HOME/landata

# Szukseges dependenciak letoltese, meglevo csomagok updatelese
RUN apt-get update && apt-get install -y \
    build-essential \
    software-properties-common \
    git \
    && rm -rf /var/lib/apt/lists/*

# GitRepo klonozasa a munkakonyvtarba
RUN git clone https://gitlab.com/Mr_Kaplan/landata.git .

# Python packagek feltelepitese
RUN pip3 install -r requirements.txt

# Jogosultsagok beallitasa
RUN chmod a+x setup.sh
CMD ["setup.sh"]

# Image futtatasakor "ide lepunk be(entrypoint)", tehat ahogy elindul a kontener ez fut le
ENTRYPOINT ["streamlit", "run", "dashboard.py", "--server.port=8501", "--server.address=0.0.0.0"]
