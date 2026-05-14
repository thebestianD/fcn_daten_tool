FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN jupyter trust fcn_datentool_app.ipynb

EXPOSE 7860

CMD ["voila", "fcn_datentool_app.ipynb",
     "--port=7860",
     "--no-browser",
     "--Voila.ip=0.0.0.0",
     "--MappingKernelManager.cull_interval=60",
     "--MappingKernelManager.cull_idle_timeout=600"]
