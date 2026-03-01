FROM python:3.9-slim

# WORKDIR /app

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/streamlit/streamlit-example.git .

# Install Pixi.sh tool for installation of Streamlit and dependencies
RUN curl -sSL https://install.pixi.sh | sh

RUN pixi install streamlit scikit-learn joblib pandas numpy
RUN pixi shell

EXPOSE 8501

HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health

ENTRYPOINT ["streamlit", "run", "app/app.py", "--server.port=8501", "--server.address=0.0.0.0"]
